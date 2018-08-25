README
======

Install postgres first. Create user and database for shell login user.

Save `.env.example` as `.env`

SET UP COMMANDS
---------------

`sudo apt-get update`

`sudo apt-get install libpq-dev`

`bundle install`

`bundle exec rake db:create db:migrate`

`bundle exec phil_columns seed`

`bundle exec rake adventure_catalog:load`

`bundle exec rake adventure_catalog:clean_dupes`

DEVISE

`bundle exec rake secret` and copy output to `.env` in `SECRET_KEY_BASE=`

TESTS

`bundle exec rspec`

SERVER

`bundle exec rails s`
