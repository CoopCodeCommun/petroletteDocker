# petroletteDocker

This project builds [Pétrolette](https://framagit.org/yphil/petrolette) in a Docker environment, ready to use for self-hosting.

Since v1.8.0, Pétrolette is an Edge app (Cloudflare Worker). This image runs it locally with Wrangler's Worker runtime (`wrangler dev`): no Cloudflare account is needed.

## Tools used
 - Docker / Docker Compose
 - Traefik reverse proxy with Let's Encrypt SSL (optional)

## Run locally

```bash
docker compose up -d --build
```

Then open http://localhost:8010.

The container exposes port `8788` and has a healthcheck on `/__health` (`docker compose ps` shows its status).

## Run on a server behind Traefik

In `docker-compose.yml`:
1. Remove the `ports` section.
2. Uncomment the `networks` and `labels` sections, and adapt the network name and cert resolver to your Traefik setup.
3. Set the `DOMAIN` variable (in a `.env` file next to `docker-compose.yml`, e.g. `DOMAIN=news.example.com`).
4. Run `docker compose up -d --build`.

HTTPS is recommended: feeds are stored in the browser and synchronized through RemoteStorage (OAuth round-trip to the instance). Nothing is stored server-side, so no volume is needed.

## Already got a reverse proxy?

Keep the `ports` section and point your reverse proxy to port `8010` on the host.

## Update

The source is cloned at build time. To get the latest version, rebuild without cache:

```bash
docker compose build --no-cache && docker compose up -d
```

To build a specific branch or tag, pass `PETROLETTE_REF`:

```bash
docker compose build --no-cache --build-arg PETROLETTE_REF=<branch-or-tag>
```

## Caveats

- `wrangler dev` is a development runtime. It works fine for self-hosting, but upstream only targets Cloudflare deployment (`npm run deploy:edge`), so a future release may require changes here.
- Logs are verbose (`STREAM: ...` lines for each feed); this is harmless.

## Credits

- Software Repository: https://framagit.org/yphil/petrolette (consider donating)
