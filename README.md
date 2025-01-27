# README

Simple app for creating Magic the Gathering decks.

code highlights:
- stimulus controller with datatables with filtering
- view components for datatables
- simple MTG API client to get card data
- CommonController - a way to create new controllers with minimal configuration
- PathGenerator PORO - a helper to create url based on a passed object (for DRY purposes)

## How to run the application

This project uses **Rails 7.2**, **Ruby 3.4** and **Postgresql**.

1. **Clone the repository:**
    ```sh
    git clone https://github.com/MateuszJanosik/mtg_decks.git
    cd mtg_decks
    ```

2. **Install dependencies:**
    ```sh
    bundle install
    ```

3. **Install RMagick dependencies:**
    On macOS:
    ```sh
    brew install imagemagick
    ```
    On Ubuntu:
    ```sh
    sudo apt-get install imagemagick libmagickwand-dev
    ```

4. **Install Redis:**
    On macOS:
    ```sh
    brew install redis
    ```
    On Ubuntu:
    ```sh
    sudo apt-get install redis-server
    ```

5. **Set up the database:**
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```
    When you run db:seed it downloads MTG card data from the API and creates cards with images in the database, so it may take a minute.
    
    The seed file also creates two sample user profiles:
    - Admin user: `admin@example.com` with password `password`
    - Player user: `player@example.com` with password `password`

6. **Start Redis server:**
    ```sh
    redis-server
    ```

7. **Start Sidekiq:**
    ```sh
    bundle exec sidekiq
    ```

8. **Run the Rails server:**
    ```sh
    rails server
    ```

9. **Open your browser and navigate to:**
    ```
    http://localhost:3000
    ```
