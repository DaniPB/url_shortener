# README

# Url-Shortener

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

  - Install Docker
  * Using Docker for Development
  - Docker version 17.03.0-ce or higher
  - Docker Compose version 1.21.2 or higher

### Installing

A step by step series of examples that tell you how to get a development env running

  1. Set the environment variables with Figaro gem. Complete the variables preloaded in `config/application.yml`
  2. Add configuration files to config folder: `database.yml`
  3. Run `docker-compose run web bash` 

### Running the app

  - Run app in development mode `docker-compose up`

### Database Commands
  - Create a migration: `rake db:create_migration NAME=migration_name`
  - Run a migration: `rake db:migrate`

## Test Suite

  - Run `docker-compose run web rspec spec` for Ruby tests.

### Break down into end to end tests

## Built With

* [Ruby on Rails](https://github.com/rails/rails) - Framework used
* [PostgreSQL](https://github.com/ged/ruby-pg/) - Database

## Authors

* **Daniela Patiño**   - *Software developer* - [Daniela](https://github.com/DaniPB)
