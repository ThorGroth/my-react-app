# ---- Stage 1: Builder ----
FROM node:lts-alpine AS builder
WORKDIR /app

# nur Abhängigkeitsdateien kopieren -> optimaler Layer-Cache
COPY package*.json ./
RUN npm ci

# restlichen Quellcode kopieren und builden
COPY . .
RUN npm run build

# ---- Stage 2: Runtime (Nginx) ----
FROM nginx:alpine AS runtime

# eigene Nginx-Konfiguration (SPA + /healthz)
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Build-Artefakte in das Webroot des Nginx kopieren
COPY --from=builder /app/dist /usr/share/nginx/html

# Für HEALTHCHECK ein schlankes Tool installieren
RUN apk add --no-cache curl

# Healthcheck: prüft, ob Nginx antwortet
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost/healthz || exit 1

EXPOSE 80
# CMD von nginx:alpine startet bereits Nginx im Vordergrund
