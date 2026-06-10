# Updated private selection — for Darina

This is the updated **private selection** page, ready to ship.
Live preview (Vincent's copy): **https://nomadikas-private-selection-lac.vercel.app**

---

## What's new in this version

- **Italy added** — a new fifth country with three Puglia homes:
  - **Masseria Aureliana** — golden 16th-century masseria above the Adriatic at Carovigno
  - **Villa Maris** — clifftop villa at the southern tip of the Salento
  - **Masseria Pistola** — 1750 farmhouse on a 50-hectare wine estate in the Valle d'Itria
- A new **Puglia experiences slider** (boat day, cooking workshop, burrata workshop, Ostuni, Polignano, Alberobello, wine, olive oil)
- Updated counts everywhere: **five countries · nine homes**
- Italy added to the map and the shortlist registry

Everything else (Greece, Portugal, Spain, Indonesia) is unchanged.

---

## How to update your live page — pick one

### Option A · From the terminal (the fastest)

If you already deployed once with Vercel, this is two commands:

```bash
cd nomadikas-private-selection
npx vercel --prod
```

Vercel will ask which project to deploy to — pick your existing
`nomadikas-private-selection` project. It will overwrite the live page.

First time? Run `npx vercel login` once before that to authenticate.

### Option B · The all-in-one script

The project includes `scripts/deploy.sh` which does the same thing:

```bash
bash scripts/deploy.sh
```

It clones the latest version from GitHub and deploys it.

### Option C · I'd rather Vincent's team handles it

Just tell Vincent to deploy this to your project from his side — he has
the source on GitHub:
https://github.com/vincentbraakman-glitch/nomadikas-private-selection

---

## Want to preview before going live?

You can open `index.html` directly in a browser to see the whole thing offline.
Click around the countries and try the photo galleries — it all works without
a server because it's pure static HTML.

---

## Anything to ask Vincent?

- He's standing by if you want to tweak copy, swap a photo, or rename anything.
- Italy has two "alias" property names (Masseria Aureliana, Villa Maris) so
  guests can't Google around the page — leave those as-is.

Have a great showing.
