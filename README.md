# Rails-Engine

  Rails Engine is a Turing solo project meant to teach us how to expose an API with data meant to be consumed by a front end API.

## Setup

### Prerequisites

This project requires the use of `Ruby 2.5.3` and `Rails 5.2.4.3`,
and `PostgreSQL` as the database.

### Local Setup

To setup locally, follow these instructions:
  * __Fork & Clone Repo__
    * Fork this repo to your own GitHub account.
    * Create a new directory locally or `cd` into whichever directory you wish to clone down to.
    * Enter `git clone git@github.com:<<YOUR GITHUB USERNAME>>/Rails-Engine.git`
  * __Install Gems__
    * Run `bundle install` to install all gems in the Gemfile
  * __Set Up Local Database and Migrations__
    * Run `rake db:{drop,create,migrate,seed}`

## Running the tests

Run the command `bundle exec rspec` in the terminal.  You should see all passing tests.
