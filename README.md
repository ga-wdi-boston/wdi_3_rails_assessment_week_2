# Week 3 Comprehensive Assessment

Fork this repository, update this file to include your answers, and submit a pull request. You may refer to any notes, past projects, or external resources you want. The questions do not have to be completed in order.

### Models

1. I'm creating an app to keep track of bunnies. I already have a `bunnies` table, but I want to create a migration to add a "weight" column to it. What command should I run in my terminal to get started?

rails g migration AddWeightToBunnies weight:integer


2. I just realized I misspelled the "weight" column in my migration, but I already ran `rake db:migrate`. What should I do to fix this? (give exact steps and/or commands to run)

- rake db:rollback
- navigate to the migration file under db/migrate
- manually change the spelling on the :weight column, then save the file (make sure weight is spelled properly in the migration class name as well. This can be manually changed in the file too.)
- rake db:migrate

3. My app has a `Bunny` model, and I want to find bunnies whose `color` attribute is `'white'`, sorted by their `name` attribute. What code should I write to do that?

Bunny.where(color: 'white').order(:name)

4. Now I want to find the specific bunny whose name is `'George'` (names are unique, so there should be only one).

Bunny.find_by_name('George')

5. I want to make sure nobunny, er, I mean nobody, can create a bunny without a name. What code should I add to my `Bunny` model to validate this?

validates :name, presence: true

### Controllers

1. My app is telling me there's an error in the `BunniesController`. What directory and filename should I look in?

app/controllers/bunnies_controller.rb


2. I'm in the `show` action of my `BunniesController` and I have the ID of a specific bunny in `params[:id]`. What line should I type to find the bunny with the correct ID, and assign it to a variable that my view can access?

@bunny = Bunny.find(params[:id])

3. I tried to update a bunny with the code `bunny.update(params[:bunny])`, but it gave me a "forbidden attributes error". Why is it telling me this, and what should I do (broadly speaking, no exact code needed) to fix the problem?

The app is returning this error because the bunny isn't being updated with the accepted attributes. I would assume there's a private method, most likely called bunny_params, that is defined in the controller. This method would define the exact parameters to be passed through that are required to update this bunny. I would then change the above code to:

bunny.update(bunny_params)

4. When I create or update a bunny in my controller, how can I find out whether the bunny saved successfully?

You can write an if loop that checks to see if the bunny has been successfully created/updated. If the loop returns a value of true (meaning the action completed successfully), redirect the user to a specific location (usually the index of all objects or the specific object's page) with a message letting the user know the action has been completed successfully. If the loop returns false, redirect the user back to the edit or new page (whichever they were on).

All of this can be defined in the update and create methods within the Bunnies Controller.


5. Assuming my bunny saved successfully, what code should I write to redirect the user to the "show" page for the bunny, with a flash message indicating success?

See answer for question 4.


### Routes/Views

1. What line should I add to `config/routes.rb` to create a complete set of RESTful routes for a "bunnies" resource?

resources :bunnies

2. My app is telling me there's an error in the "show" view for bunnies. What directory and filename would that be located in?

app/views/bunnies/show.html.erb (or app/views/bunnies/show.haml if using haml instead of erb)


3. I'm in the `index.html.erb` view and I've assigned a variable `@bunnies` to a collection of all my bunnies. What HTML/ERB code should I write to create an unordered list that shows each bunny's `name` attribute?

<ul>
<% @bunnies.each do |bunny| %>
  <li><%= bunny.name %></li>
<% end %>
</ul>


4. In one of my views, I want to create a link to the "show" path for a specific bunny that I have stored in the variable `bunny`. `rake routes` tells me that I have a standard `bunny_path` helper available. How do I create this link?

<%= link_to 'Check out this bunny', bunny_path(bunny) %>


5. I've created a view partial called `_form.html.erb` and I want to render this partial into my "new" view. What HTML/ERB code should I write to do this?

<%= render 'form', bunny: @bunny %>



