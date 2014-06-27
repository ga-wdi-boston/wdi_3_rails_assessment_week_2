# Week 3 Comprehensive Assessment

Fork this repository, update this file to include your answers, and submit a pull request. You may refer to any notes, past projects, or external resources you want. The questions do not have to be completed in order.

### Models

1. I'm creating an app to keep track of bunnies. I already have a `bunnies` table, but I want to create a migration to add a "weight" column to it. What command should I run in my terminal to get started?

rails generate migration AddWeightToBunnies weight:integer
(score 1 of 1)


2. I just realized I misspelled the "weight" column in my migration, but I already ran `rake db:migrate`. What should I do to fix this? (give exact steps and/or commands to run)

If the migration in error is the latest:
  rake db:rollback
  rails generate migration AddWeightToBunnies weight:integer

If the migration in error is several migrations ago:
  rails generate migration ChangeBunnyWeight <incorrectcolumnName>:integer, <weight>:integer
(1.5 of 2 or 0.75, score: 1.75 of 2)


3. My app has a `Bunny` model, and I want to find bunnies whose `color` attribute is `'white'`, sorted by their `name` attribute. What code should I write to do that?

In app/controllers/bunny_controller.rb:
  @bunnies = Bunny.where('color = ?', params[:color]).order(:name)
(score 2.75 of 3)



4. Now I want to find the specific bunny whose name is `'George'` (names are unique, so there should be only one).

In app/controllers/bunny_controller.rb:
  @bunny = Bunny.where('name = ?', params[:name])
  OR
  @bunny = Bunny.where('name = ?', 'George')
(score 2.75 of 4, this returns a collection with 1 element, not an instance. Should have used Bunny.findBy(name: 'George'))


5. I want to make sure nobunny, er, I mean nobody, can create a bunny without a name. What code should I add to my `Bunny` model to validate this?

class Bunny
  ...
 validates :name, presence: true
end
(score 3.75 of 5, should have indicated that Bunny subclasses ActiveRecord::Base)



### Controllers

1. My app is telling me there's an error in the `BunniesController`. What directory and filename should I look in?

app/controllers/bunnies_controller.rb
(score 1 of 1)



2. I'm in the `show` action of my `BunniesController` and I have the ID of a specific bunny in `params[:id]`. What line should I type to find the bunny with the correct ID, and assign it to a variable that my view can access?

@bunny = Bunny.find(params[:id])
OR
bunny = Bunny.find(params:id)
@view = {
  bunny: bunny,
  ...other view variables...
}
(score 2 of 2)


3. I tried to update a bunny with the code `bunny.update(params[:bunny])`, but it gave me a "forbidden attributes error". Why is it telling me this, and what should I do (broadly speaking, no exact code needed) to fix the problem?

The app is failing because that parameter has not been permitted on the model.
The fix is to create a method (private) to use strong parameters (require, permit) to filter the allowable parameters.
(score 3 of 3)


4. When I create or update a bunny in my controller, how can I find out whether the bunny saved successfully?

Test if the instance methods #save() or #update() have returned a value that resolves to true.
(score 4 of 4)


5. Assuming my bunny saved successfully, what code should I write to redirect the user to the "show" page for the bunny, with a flash message indicating success?

render :show
(score 4 of 5, redirect_to bunny_path(@bunny))



### Routes/Views

1. What line should I add to `config/routes.rb` to create a complete set of RESTful routes for a "bunnies" resource?

resources :bunnies
(score 1 of 1)



2. My app is telling me there's an error in the "show" view for bunnies. What directory and filename would that be located in?

app/views/bunnies/show.html.erb
(score 2 of 2)



3. I'm in the `index.html.erb` view and I've assigned a variable `@bunnies` to a collection of all my bunnies. What HTML/ERB code should I write to create an unordered list that shows each bunny's `name` attribute?

# app/views/bunnies/index.html.erb
<ul>
<%= render partial: 'bunny', collection: @bunnies %>
</ul>

# app/views/bunnies/_bunny.html.erb
Name: <%= bunny.name %>
(score 3 of 3, but could have done this without a partial)


4. In one of my views, I want to create a link to the "show" path for a specific bunny that I have stored in the variable `bunny`. `rake routes` tells me that I have a standard `bunny_path` helper available. How do I create this link?

link_to 'Show', bunny_path(bunny)
(score 4 of 4)



5. I've created a view partial called `_form.html.erb` and I want to render this partial into my "new" view. What HTML/ERB code should I write to do this?

render 'form'[, ...any variable assignments to pass to the partial...]
(score 5 of 5)
