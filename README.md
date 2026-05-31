# Nomadikas — A private selection

A bespoke villa proposal page across Greece, Portugal, Spain and Indonesia.

**Live preview**: see GitHub Pages settings for the active URL.

Static HTML — no build step. Open `index.html` directly or serve the folder.

## Pages

- `index.html` — Countries overview with Leaflet map + 4 country cards
- `greece.html` — Beachfront Villa Zakynthos
- `portugal.html` — Casa Noor + Estate Fonte das Perdizes
- `spain.html` — Santa Prima + Es Bec d'Aguila (Menorca)
- `indonesia.html` — Estate Nihi Watu (Sumba)

## Features

- Indonesia-style photo modal with per-photo captions, pagination dots, keyboard nav
- Hover-reveal experience-card slider (Swiper, 3 desktop / 1 mobile / infinite)
- Favourites tray (localStorage) — saves across page navigation, "Email to Darina" via mailto:
- Ken Burns on country heros
- Lucide icons inline via CDN

## Stack

- Static HTML + Tailwind via CDN
- Swiper 11 (CDN), Leaflet 1.9 (CDN), Lucide (CDN)
- Brand fonts: Amiri / Josefin Sans / Montserrat via Google Fonts

## Deploying / updating the live page

Live page: **https://nomadikas-private-selection.vercel.app**

To pull the latest version from GitHub and replace the live page, run the
deploy script — no arguments needed, it already targets that project:

```bash
bash scripts/deploy.sh
```

On a fresh machine or agent (clones, installs Vercel CLI, then deploys):

```bash
curl -fsSL https://raw.githubusercontent.com/vincentbraakman-glitch/nomadikas-private-selection/main/scripts/deploy.sh -o deploy.sh
bash deploy.sh
```

It deploys to the existing `nomadikas-private-selection` project, so it
overwrites the previous build instead of creating a second page. Set
`VERCEL_TOKEN` for non-interactive auth and `VERCEL_SCOPE` if the project
lives under a team. See `scripts/deploy.sh` for full detail.
