FROM node:22-bookworm

# Branche ou tag de Pétrolette à construire
ARG PETROLETTE_REF=master
RUN git clone --depth 1 --branch ${PETROLETTE_REF} https://framagit.org/yphil/petrolette /petrolette
WORKDIR /petrolette
RUN npm install && npm install --no-save wrangler && npm run build:edge

ENV TZ=Europe/Paris WRANGLER_SEND_METRICS=false CI=true
EXPOSE 8788

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS http://localhost:8788/__health || exit 1

CMD ["npx", "wrangler", "dev", "--config", "edge/wrangler.jsonc", "--ip", "0.0.0.0", "--port", "8788"]
