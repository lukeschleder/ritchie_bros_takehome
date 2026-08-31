# Ritchie Bros Asset List

Take-home for Ritchie Bros. Pull auction listings from their marketplace API and show them in a list.

Each card has the description, image, location, event name, and a readable date. If the item is in the US we show city, state, and country. Anywhere else it's just city and country.

There's also pagination (stretch goal). Scroll to the bottom, get 20 more.

## Layout

Pretty standard:

- `AssetRepository` hits the API
- `AssetBloc` owns the list and loading state
- the screen / cards just render whatever the bloc already has. Cards are dumb on purpose — they take strings, they don't format locations or dates.

Location formatting lives on the `Asset` model. That's the one bit of actual business logic and it's what the tests cover.

## from / size

The search endpoint is a POST. You send `from` (where to start) and `size` (how many, we always use 20).

First request is `from: 0`. After that `from` is just however many items we already have, so 20, then 40, etc. The API only ever gives you one page. The bloc concatenates them so the UI has the whole list.

## Pagination

Scroll near the bottom and we request the next page. The screen only does that when you're actually scrolling down, nothing is already loading, and we haven't already asked for this "visit" to the bottom. After a fetch starts we wait until you scroll back up a bit before we allow another one, so you get one page per trip to the end. A spinner sits under the last card while that request is in flight.

The bloc appends the new 20 onto `state.assets`. `from` for the next call is just `assets.length`.

## Run

```bash
flutter pub get
flutter run
flutter test
```
