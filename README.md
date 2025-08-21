## Reflexion: Docker Hub Veröffentlichung

**Namensräume:**  
Das Format `<username>/<repository>` verhindert Namenskonflikte im globalen Namespace und macht die Herkunft eines Images eindeutig. Ohne Namensräume könnten mehrere verschiedene Images gleich heißen (z. B. `my-react-app`), was Vertrauen, Nachvollziehbarkeit und Wartbarkeit erschweren würde.

**Tag vs. Build:**  
`docker build -t neuer-name .` baut ein Image **aus dem Dockerfile** und vergibt dabei einen Tag.  
`docker tag alter-name neuer-name` erstellt **kein neues Build und keine Kopie**; es weist dem **gleichen Image** (gleiche IMAGE ID) nur einen **zusätzlichen Namen/Tag** zu.

**Versionierung:**  
Bei einem kleinen Bugfix erhöhe ich den Patch-Level (z. B. von `1.0.0` auf `1.0.1`). Für neue, abwärtskompatible Features: Minor (`1.1.0`). Für Breaking Changes: Major (`2.0.0`). Saubere Versionierung ist wichtig für Reproduzierbarkeit, Rollbacks und klare Kommunikation in Team und CI/CD.

**Öffentlich vs. Privat:**  
Ein privates Repository ist sinnvoll für interne Services, proprietäre Software, vertrauliche Vorab-Releases oder wenn nur bestimmte Deploy-Pipelines/Teams Zugriff erhalten sollen.

**Docker Hub Repository:**  
`https://hub.docker.com/r/thor88/my-react-app`
