# README

Up Next is an application I developed for the Take-Home Assignment portion of Bloc.io's final certification.


## PROBLEM

The assignment is to create a TV show discovery web app utilizing the [Movie Database API](https://developers.themoviedb.org/3/getting-started).

My implementation of this application fulfills the following functional requirements:

1. When first loaded, there should be a list of popular TV shows and a search bar.
2. Upon searching for a TV show in the search bar, the user should see a list of shows whose title matches the search.
3. After clicking on a TV show, the user should be taken to a page with more information about that particular TV show.

My application fulfills the following technical requirements:

1. Create a full-stack application with a backend that communicates with the movie API.
2. The front-end should be intuitive to use
3. Accompany your code with a full test suite.
4. Deploy your site to a web host (e.g. on Amazon EC2, Heroku, Netlify, Google AppEngine, etc.).

My application also adds the following features:
1. Movies
2. Reviews
3. Pagination
4. Handles user entry errors


## SOLUTION

To complete this assignment, I chose to utilize Rails 5 for front and backends, and, essentially, build according to MVC architectural patterns. But rather than building out a database and creating my own models, I use the Movie Database API as the "M" component of MVC. I chose Rails because I am quite comfortable with it and enjoy using it. And MVC architecture provided a simple path forward to the solution.

I implemented two controllers, Tv and Movie, which include the following methods:
* `popular`
* `show`
* `search`

Per MVC guidelines, I have views corresponding to each method for each controller.

The controller methods make API calls via the `tmdb.rb`(the movie database) module. This choice allowed me to isolate my API calls to one place, keeping my code DRY and making debugging easier.

The 'tmdb' module wraps API calls in intuitively named methods that use [HTTParty](https://github.com/jnunemaker/httparty) class methods for HTTP get requests. The module methods also use json to parse the responses and serve the json objects to the respective controllers.

`tmdb.rb` is located in the `lib` folder which I autoload into the application. The `lib` folder is not loaded by default, so I added `config.autoload_paths << Rails.root.join('lib')` to `config/application.rb`. Everything in the module is wrapped in `class << self` so that I can use the `::` (unary) operator to access the methods anywhere I need them in the application, e.g. `::Tmdb.get_pop_tv`

I deployed the Up Next application on Heroku: https://up-next-bloc-assignment.herokuapp.com/

## CHALLENGES

Due to changes between Rails 4 and 5 (`secret.yml` file was replaced with `credentials.yml.enc`), I was not immediately sure how to securely store the API key as a global variable in 5. Through some research I learned that I could edit that file through the command line with the following command: `EDITOR="atom --wait" bin/rails credentials:edit` And I could then access my key with: `Rails.application.credentials.api[:key]` which is used in `tmdb.rb`. I also had to learn how to use the Rails master key in Heroku so my production code could also access the encrypted API key.
