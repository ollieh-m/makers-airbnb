[![Coverage Status](https://coveralls.io/repos/github/ollieh-m/makers-airbnb/badge.svg?branch=master)](https://coveralls.io/github/ollieh-m/makers-airbnb?branch=master)
# MakersBnB
Live like you were dying, party like someone else had to clean it up. 
No, seriously, someone else has to clean it up.  --MakersBnB

##Photos of the application
![alt tag](http://i.imgur.com/0xeHqma.png)
Main page
![alt tag](http://i.imgur.com/BmNlSio.png)
User page
![alt tag](http://i.imgur.com/y69d171.png)
Request page
![alt tag](http://i.imgur.com/D7quca0.png)
Calendar

## Heroku deployment
[makersbnb123](http://makersbnb123.herokuapp.com/spaces)

## Collaborators
Chris K, Lexi, Letian, Ollie

## Installation
1. Clone the repo from https://github.com/ollieh-m/makers-airbnb.
2. Open terminal and navigate into the repo directory.
3. Make sure you have [downloaded and installed PostgreSQL](http://www.postgresql.org/download/).
4. Run `bundle install`.
5. Create the database for the application by running `createdb makersbnb_development` in your terminal.
6. Run `rake db:auto_migrate RACK_ENV=development`.
7. Run `rackup`
8. The application will be running at http://localhost:9292.
9. Embrace the chaos that is renting your own place to strangers.

## Features
1. Any signed-up user can list a new space.
2. Users can list multiple spaces.
3. Users are able to name their space, provide a short description of the space, and a price per night.
4. Users are to offer a range of dates where their space is available through a calendar
5. Any signed-up user can request to hire any space for one night, and this can be approved or denied by the user that owns that space.
6. Nights for which a space has already been booked are notavailable for users to book that space.
7. Until a user has confirmed a booking request, that space can still be booked for that night.
