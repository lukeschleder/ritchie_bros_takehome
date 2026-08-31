# Ritchie Bros Asset List

Flutter take-home: fetch marketplace assets and show them in a list.

## What it does

The app asks the Ritchie Bros API for equipment listings, then shows each one as a card:

- description
- photo
- location
- event name
- date

USA listings show **City, State, Country**. Everywhere else shows **City, Country**.

Scroll to the bottom and it loads 20 more.

## How it is put together

Think of three jobs:

1. **Repository** — talks to the internet. It POSTs to the search API.
2. **Bloc** — holds the list in memory and decides when to load more.
3. **Screen / cards** — draws what the bloc already knows. Cards do not format data. They just display strings.

```
Screen  →  Bloc  →  Repository  →  API
                ←  list of assets
```

### The API request

The API wants two numbers:

- `from` — skip this many items
- `size` — how many to bring back (always 20)

First load: `{ "from": 0, "size": 20 }`  
Next load: `{ "from": 20, "size": 20 }`  
Then 40, 60, and so on.

`from` is just “how many items we already have.”

The bloc **keeps the full list**. The API only ever returns one page. Each new page gets appended:

`old list + new 20 = bigger list`

## Pagination (the tricky part)

Loading more sounds simple: “user hits the bottom, fetch 20 more.”

That naive version loaded many pages at once. Two reasons:

1. **Scroll events fire a lot.** While one request was in flight, every extra scroll tick queued another fetch. When the first page came back, those queued fetches all ran. 20 jumped to 180.
2. **Staying at the bottom.** After new rows were inserted, the list was still at the bottom, so it immediately asked for another page.

What we do now:

- Only fetch if the user is actually scrolling down.
- Only one request at a time.
- After we ask for a page, **disarm**. Do not ask again until the user scrolls back up (more than 200px from the bottom), then down again.

So one trip to the bottom = one extra page. A spinner under the last card shows while that page loads.

## Location

That rule lives on the `Asset` model, not in the widget.

- Country is USA / US / United States → include state
- Anything else → city and country only

Tests cover those cases.

## Run it

```bash
flutter pub get
flutter run
flutter test
```
