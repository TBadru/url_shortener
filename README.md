# URL Shortener

A modern URL shortener built with **Ruby on Rails**, featuring an **ActiveAdmin dashboard**, **click tracking**, and **Tailwind CSS** styling. Users can shorten URLs, set custom slugs and expiration dates, while admins monitor analytics via a colorful, interactive dashboard.

---

## Features

### User
- Shorten URLs (optionally set a custom slug)
- Set expiration dates
- Track click counts
- View recent clicks and referrer info
- Shareable short links

### Admin (ActiveAdmin)
- View top URLs by clicks
- Charts: clicks per day, top referrers
- Recent clicks table (IP, referrer, timestamp)
- Tailwind CSS styling with gradients and icons
- Interactive charts (Chartkick)

---

## Tech Stack

- **Ruby on Rails 8.x**
- **PostgreSQL** (or SQLite for development)
- **ActiveAdmin** (admin dashboard)
- **Tailwind CSS** (styling)
- **Chartkick & Groupdate** (charts)
- **Stimulus & Turbo Rails** (dynamic behavior)

---

## Setup

1. **Clone the repository**
    ```bash
    git clone https://github.com/TBadru/url_shortener.git
    cd url_shortener
    ```

2. **Install dependencies**
    ```bash
    bundle install
    yarn install
    ```

3. **Setup the database**
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed # optional, creates an initial admin user
    ```

4. **Run the Rails server**
    ```bash
    rails server
    ```

5. **Access the application**
    - User interface: [http://localhost:3000](http://localhost:3000)
    - Admin dashboard: [http://localhost:3000/admin](http://localhost:3000/admin)

    **Default Admin Credentials (if seeded):**
    - Email: `admin@example.com`
    - Password: `password`
