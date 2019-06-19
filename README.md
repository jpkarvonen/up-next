# README

[Up Next](https://up-next-bloc-assignment.herokuapp.com/) is an application I developed for the Take-Home Assignment portion of Bloc.io's final certification.


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

To complete this assignment, I chose to utilize Rails 5 for front and backends, and, essentially, build according to MVC architectural patterns. But rather than building out a database and creating my own models, I use the Movie Database API as the "M" component of MVC. I chose Rails because I am quite comfortable with the framework -- and I enjoy it! And MVC architecture provided a simple path forward to the solution.

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

I also had an issue with assets pipeline not working properly in Heroku so my images in `assets/images` would not load. I resolved this by adding `config.assets.compile = true` to `config/environments/production.rb`

I still have a persisting issue with the assets pipeline. I use the following code, utilizing jquery, in my show views (both Tv and Movie) so that reviews over 600 characters long are truncated and can be expanded by clicking "Read More":

```
<% if review["content"].length > 600 %>
  <%= truncate(review["content"], length: 600) %>
  <%= link_to '...Read more', '', class: "read-more-#{review["id"]}" %>
    <script>
      $('.read-more-<%= review["id"] %>').on('click', function(e) {
        e.preventDefault()
        $(this).parent().html('<%= escape_javascript review["content"] %>')
      })
    </script>
<% else %>
  <%= review["content"] %>
<% end %>
```

I added `//= require jquery` to `config/javascripts/application.js` to make the above code work properly in development (it still does what it is supposed to do locally). But in production, clicking "Read More"  fails to expand a truncated review. With more time, I would work to resolve this.

With more time, I would also do the following:
* Create a search controller so I don't have to repeat the logic used in Tv and Movie controller search methods (not a huge issue given the small application size, but this would help if I were to add features in the future)
* Add features for users (user model, sign up in and out, user roles, profile page, ability to write review and create a list of favorite shows/movies)
* Autocomplete search
* Similar items list in Tv and Movie show pages
* Actor controller with similar methods to Tv and Movie controllers
* Truncate pagination
* Improve UI/UX for mobile
