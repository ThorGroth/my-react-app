/**
 * Multi-Stage Build
 *
 * Hauptvorteil:
 * Schlankes, sicheres End-Image. Build-Werkzeuge (Node, Vite, devDependencies)
 * bleiben in der Builder-Stage; zur Laufzeit ist nur ein minimaler Webserver
 * mit statischen Dateien nötig. Außerdem schnellere Builds durch besseres Layer-Caching.
 *
 * Warum kein node_modules im finalen Image?
 * node_modules wird nur zum Bauen benötigt. Multi-Stage kopiert ausschließlich
 * das Build-Ergebnis (dist/) in die Runtime-Stage. Damit landen Abhängigkeiten
 * und Tooling nicht im finalen Nginx-Image.
 *
 * Docker-Layer-Caching:
 * Zuerst COPY package*.json → npm ci. Solange sich package*.json/package-lock.json
 * nicht ändern, bleibt dieser Layer gecached. Der spätere COPY . . invalidiert
 * nur den Teil mit Quellcode, nicht aber die Abhängigkeitsinstallation.
 */

/**
 * Rolle des Webservers und der Anwendung
 *
 * 4) Was ist im finalen Image?
 *    Nur das Build-Ergebnis (statische Dateien aus dist/).
 *    Kein kompletter Quellcode, keine Build-Abhängigkeiten.
 *    In der ersten Stage existiert alles (Quellcode, devDependencies) zum Bauen.
 *
 * 5) Rolle Nginx & SPA-Konfiguration:
 *    Nginx dient als schlanker HTTP-Server für statische Assets.
 *    Bei SPAs müssen nicht gefundene Pfade auf index.html umgeleitet werden (try_files),
 *    damit der Client-Router (React Router) die Route rendert.
 *
 * 6) Warum nicht npm run dev im Container?
 *    Das ist ein Entwicklungsserver (Hot Reload, Debugging), nicht optimiert/sicher für Produktion.
 *    Produktionsbetrieb nutzt vorgebaute, minifizierte, statische Dateien hinter einem robusten Webserver.
 */

/**
 * Containerisierung und Betrieb
 *
 * 7) Hauptvorteile gegenüber „lokalem Build ohne Container“:
 *    - Portabilität/Reproduzierbarkeit: Gleiche Laufzeitumgebung überall (CI, Server, lokal).
 *    - Isolation/Sicherheit: App läuft isoliert mit minimalem Runtime-Footprint (Nginx),
 *      kein Node im Produktiv-Container nötig.
 *    - Bonus: Schnelles Rollback/Deployment via Image-Tags; leichter horizontal zu skalieren.
 *
 * Funktion des HEALTHCHECK & Bedeutung für Orchestrierung:
 *    HEALTHCHECK meldet dem Docker-Daemon (und damit Swarm/K8s) den Zustand des Containers.
 *    Orchestratoren können so unhealthy Instanzen neustarten, aus dem Load Balancer nehmen oder neu verteilen.
 */

/**
 * .gitignore vs .dockerignore
 *
 * 9) Vergleich:
 *    - .gitignore beeinflusst, was in Git eingecheckt wird (Versionierung/Repo-Inhalt).
 *    - .dockerignore beeinflusst, was in den Docker Build-Kontext gelangt (Performance, Sicherheit, Image-Größe).
 *      Beide Listen ähneln sich oft, dienen aber unterschiedlichen Zwecken.
 */
