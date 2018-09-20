# Adventurer's League Log

A computerized log sheet for DnD 5e's Adventurer's League

## Getting Started

Install dependencies with `bundler`

```sh
$ bundle install
```

Ensure postgres is installed, and a `postgres/postgres` superuser is created. You may also need development libraries on Linux.

```sh
$ sudo apt-get update
$ sudo apt-get install libpq-dev
```

Copy `.env.example` as `.env`

```sh
$ cp ./.env.example .env
```

Create database, run migrations and seed data.

```sh
$ bundle exec rake db:create db:migrate
$ bundle exec phil_columns seed
$ bundle exec rake adventure_catalog:load
$ bundle exec rake adventure_catalog:clean_dupes
```

Configure secret key for [devise]().

1. Run `bundle exec rake secret`
1. Copy output to `.env` in `SECRET_KEY_BASE=`

## Run

```sh
bundle exec rails s
```

## Tests

The specs require `chromedriver`.

- On mac, install via homebrew using `brew cask install chromedriver`.
- On linux, install via `apt-get install chromedriver`.

To run the specs using headless chrome (default) use

```sh
$ bundle exec rake spec
```

To run the specs (and view/debug them) using desktop chrome use

```sh
$ CAPYBARA_GUI=1 bundle exec rake spec
```