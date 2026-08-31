# ritchie_bros_takehome

Ritchie Bros Asset List

A base Flutter project used for pairing scenarios.

## Getting Started

The following is a take home exercise. Please limit your time spent on this to 2 hours. Use any modern tools, testing frameworks and resources available to you and be prepared to discuss your solutions and make additional changes during the interview process.

Implement fetching search results data from the following API and render a list of assets. Show the asset in a list with the assetDescription, image (imageUrl), location (using locationCountry, locationState and locationCity), eventAdvertisedName and formatted eventStartDate. The location should show in the format City, State, Country (in the USA) and the format City, Country (outside the USA).

curl -i -X POST -H 'Content-Type: application/json' -d '{"from": 0, "size": 20}' https://api.marketplace.ritchiebros.com/marketplace-listings-service/v1/api/search

Stretch goal: If you have time implement paginating the results so the user sees more results as they scroll (the from and size parameters can be used to accomplish this).
