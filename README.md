# README

simple app for creating Magic the Gathering decks.

code highlights:
- stimulus controller with datatables with filtering
- simple MTG API client to get card data
- CommonController - a way to create new controllers with minimal configuration
- PathGenerator PORO - a helper to create url based on a passed object (for DRY purposes)

important note: when you run db:seed it downloads MTG card data from the API and creates cards with images in the database, so it may take a minute.
