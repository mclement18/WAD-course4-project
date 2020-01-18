# Project outline
For this course project, you will need to download the source code for a Rails application and extend it with the functionality outlined below. In order to do this, you will need to apply what you've learnt throughout this course.

The application is a tips forum, called `Pro Tips` , that allows developers to register and share short bits of advice with each other, and then comment on the tips others have created. The application basics have been completed, such as the core routes, views, controller actions and models. The application has been styled using the [Bootstrap CSS library](https://getbootstrap.com/docs/4.0/getting-started/introduction/), and the files for this library have been included as `.scss` and `.js` files in the appropriate places within the `app/assets/` folder. There is plenty still to do to make the application suitable for a production deployment however. And that's your aim for this project: to put all of the pieces in place necessary to make this a working application for real developers.

# Downloading the project source code
The source code for the project is attached as a `.zip` file to the resources tab of this unit.
Download this file and extract it to an appropriate location on your development machine, such as within `~/projects/` . The source code includes an initial git repository in order to track your changes. Make sure that the application starts up by running the following commands in the project root; these should be everything that's needed to get the application running:

```shell
cd pro_tips
bin/bundle install # install all required gems
bin/bundle exec rails db:migrate # create the development and test databases
bin/bundle exec rails db:seed # inserts the seed data to the development database
bin/bundle exec rails test # runs all of the unit tests for the application
bin/bundle exec rails server # starts the rails server
```

You will then be able open the application at http://localhost:3000/

Once you have completed the project tasks below, push your source code to your own new repository on GitHub and then submit the the URL for the GitHub repo.

# Project tasks
In addition to the tasks outlined below, it's also important to demonstrate the following general principles of software development and will form part of your final grade:
* Good source control management with git.
* Good code reuse through refactoring.
* Good code formatting throughout a project codebase.

## A note on automated tests
In this course, there has been very little explicit mention of automated tests. As such, writing automated tests _does not_ form part of the grading for the project submission. However, writing automated tests is good practice in web development, and might help solve some of the tasks listed below. As such, use your discretion to write automated tests if you feel that they will help you complete the project. There is no expectation to extend the application test suite.

## Project tasks
Work through the following checklist in order to complete the `Pro Tips` application. The tasks have been organized into related sections, and the tasks get progressively more challenging in each section. Use the tasks that you've completed in the My Bucket List and Animal Farm applications for reference. _Don't forget to regularly commit to git._

### Ruby and refactoring
* Make use of an appropriate conditional in order to adjust the `ApplicationHelper#pluralize_tips` and
`ApplicationHelper#pluralize_comments` methods so that the returned Strings are correctly pluralized e.g. 1 _comment_, 2 comments; 1 _tip_, 4 tips.
* Format the “joined date" on `users#show` to use “time ago”, and adjust the text so that the format will be “Has been a member of Pro Tips for ”
* Format the dates on `tips#show` to be in the format “2 Jun 2001 at 14:35” ( “date short-month year at hour:minute” )
* Extract all of the inline Strings in `ApplicationHelper#default_avatar` as Ruby constants at the top of the `ApplicationHelper` module. Reference these new constants within the `#default_avatar` method.
* Adjust the `ApplicationHelper#default_avatar` method to use a case statement. (Leave the _guard clause_, `if user.name.present?` , unchanged for this task)
* Move the initial guard clause in the `ApplicationHelper#default_avatar` ( `if user.name.present?` ) away from the nested conditional, so that there is no longer any conditional nesting. *Ensure that the behaviour of the `ApplicationHelper#default_avatar` method does not change!*

### Ruby on Rails
* Add seed data that will seed at least two Tips with two Comments _each_ from two _different_ Users. The Tips and Users can be ones already in the seed data, or additional ones.
* Introduce at _least_ two _ActiveRecord_ scopes to replace the inline ActiveRecord usages in `tips#index` and `home#index` .
* _Introduce paging_ on the `tips#index` action and view using the `kaminari` gem. Display eight Tips per page.
* _Introduce paging_ on the `users#index` action and view using the `kaminari` gem. Display six Users per page.
* Make use of the `config/locales/en.yml` locale file as the _text source_ for the items in the `app/views/application/_anonymous_user_header.html.erb` partial.
* Make use of the `config/locales/en.yml` locale file as the _text source_ for the phrases on the `app/views/home/index.html.erb` view.
* Make use of the `config/locales/en.yml` locale file as the _text source_ for the labels in the `app/views/tips/_form.html.erb` Tip form.
* Make use of the `config/locales/en.yml` locale file as the _text source_ for the labels in the `app/views/users/edit.html.erb` User form.
* Add a second translation file to the application. Use whichever second language you feel most comfortable with. (Use Google Translate to get approximate translations for a second language if necessary)
* Add a mechanism that selects the locale for a request based on a URI parameter.
* Adjust the language links in the footer to allow a user to select their preferred language. The language choice should represent the locales that exist in the application.

### Authentication and authorization
* Implement an authentication mechanism that includes sign up, log in, and log out using has_secure_password and the session Hash. Define short custom routes for log in, sign up, and log out.
* Add a `role` attribute to the User model. The role can be either ‘registered’ or ‘admin’. (There will be a third implicit role, `anonymous` , for Users who have not logged in)
* There are three header partials, `app/views/application/_anonymous_user_header.html.erb` , `app/views/application/_registered_user_header.html.erb` , and `app/views/application/_admin_user_header.html.erb` . The header should be chosen and displayed based on the role of the current user. The headers need to include the
following links:
  * Anonymous user header: `login` , `signup` .
  * Registered user header: `logout` , `account/tips#index` .
  * Admin user header: `logout` , `account/tips#index` , `users#index` .
* Implement authorization rules for the three roles, `anonymous` , `registered` , and `admin` , as follows. The `rails routes` command is useful reference here for the different routes in the application.
  * Anonymous User can access
    * Homepage ( `root` )
    * Log in ( `sessions#new` )
    * Log out ( `sessions#destroy` )
    * Sign up ( `users#new` , `users#create` )
    * Tips search ( `tips#index` )
    * Tips show ( `tips#show` )
    * User show ( `users#show` )
  * Registered Users can access everything that Anonymous User can access plus
    * Create tip ( `tips#new` , `tips#create` )
    * Create comments ( `comments#create` )
    * Edit tips owned by the User ( `tips#edit` , `tips#update` )
    * Delete tips owned by the User ( `tips#destroy` )
    * Account ( `account#edit` , `account#update` )
    * Account tips ( `account/tips#index` )
  * Admin Users can access everything that Registered User can access plus
    * Users index ( `users#index` )
    * Edit users ( `users#edit` , `users#update` )
    * Delete users ( `users#destroy` )
* The views already include buttons for creating, editing and deleting resources. These buttons should be displayed _conditionally_ based on the _current user's role_ as follows. *Bear in mind that Anonymous Users will never be able to see buttons on views that they cannot access according to the access rules above.*
  * An Anonymous User should be shown
    * No create, edit or delete buttons
  * An Authenticated User should be shown
    * Create buttons, plus edit and delete buttons for tips that they own.
  * An Admin User should be shown
    * All create, edit and delete buttons

### Fine tuning, images, and AJAX
* Adjust the `account/tips#index` controller action so that only the _current user’s_ tips are retrieve using ActiveRecord.
* Remove the User select in `app/views/tips/_form.html.erb` and _assign the current user_ to the new Tip in the `tips#create` controller action.
* Implement `comments#create` so that the _current user is assigned_ to the new Comment.
* Allow users to upload their own avatars, using the `carrierwave` gem.
* Use one of the static default avatar images as the default avatar for Users that have not uploaded a custom image.
* Implement the Delete button in `app/views/application/_users_card.html.erb` to call `users#destroy` as a DELETE method and remotely via AJAX. _Update the view dynamically_ to re􀂀ect the deleted User using JavaScript and rails-ujs.
* Implement the Delete button in `app/views/application/_editable_tip_card.html.erb` to call `tips#destroy` as a DELETE method and remotely via AJAX. _Update the view dynamically_ to re􀂀ect the deleted User using JavaScript and rails-ujs.
* Make the tip comments in `app/views/tips/show.html.erb` submit via AJAX. _Update the view dynamically_ to include the new comment using JavaScript and rails-ujs.

### Deployment
* Change the database configuration for production in the application to use a PostgreSQL database server instead of SQLite.
* Deploy the application as a new Heroku application.
* Configure AWS S3 to handle image uploads for User avatars.
* Update the README.md file to include the full Heroku URL that your application is deployed to.
