Rails Engine

Introduction --

This project is a Rails API app that provides data in json format related to an ecommerce marketplace site and responds to different queries and requests.
This app was build using Rails 5.2.1.

The Rails Engine project is part of the back end engineering curriculum at the Turing School for Software and Design. Information related to this project can be found here: http://backend.turing.io/module3/projects/rails_engine

Setup --

You can run this app on your machine by following the instructions below :

- `git clone git@github.com:clairebvs/rails_engine.git`

After cloning the project to your machine, navigate to that folder and run `bundle install` and `bundle update`

You can set up Postgres now by running : `rake db:{drop,create,migrate}`

Then you can seed the database with the following command :
`rake import:all`

You can check our test suite by running : `rspec`

Finally you can take a look at our app content by running : `rails s`
