# The Collectionist technical assignment

This project is a technical test for a job interview at The Collecionist.

The subject can be seen in the root directory './subject.pdf'

## Run the project 

Requirements :
- ruby 3.1.2
- rails 7
- bundle

Steps:
- `bundle install` to install the required gems
- `rails db:migrate` to setup the database schema
- `rails db:seed` to populate the database with few records

- `rails s` to run the webserver
-  visit localhost:3000/shops/1/business_hours' 

## Explanation on models and code 

The Shop model is associated with BusinessHour with a on-to-many relation.
The reason is a shop may have different business hours, depending on the season, holidays..
yet it is not implemented 

The BusinessHour model store the data as a string which will be parsed as a JSON
This allows easy modification on the format or data stored, like timezone

## language support

I use Geocoder for user localisation and then set the I18n locale to the user country.
By default or if invalid result, it is set to english.

French, English and Polish are supported for the moment


## Improvements

The BusinessHour validations rule are not strict enough.
The regex checks only if the hours is a number but an invalid input like "28:70" would be considered valid

The erb view is ugly




