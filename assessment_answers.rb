# # Week 3 Comprehensive Assessment

# Fork this repository, update this file to include your answers, and submit a pull request. You may refer to any notes, past projects, or external resources you want. The questions do not have to be completed in order.

# ### Models

# 1. I'm creating an app to keep track of bunnies. I already have a `bunnies` table, but I want to create a migration to add a "weight" column to it. What command should I run in my terminal to get started?
rails g migration AddBunnyWeight


# 2. I just realized I misspelled the "weight" column in my migration, but I already ran `rake db:migrate`. What should I do to fix this? (give exact steps and/or commands to run)
my answer:
rails g migration ChangeWeightSpelling
def up
change_table :bunnies do |t|
    t.remove :wieht
end
end

def down
    change_table :students do |t|
    t.integer :weight
end
save file
rake db:migrate

correct answer:
rake db:rollback
  **make the changes**
rake db:migrate



# 3. My app has a `Bunny` model, and I want to find bunnies whose `color` attribute is `'white'`, sorted by their `name` attribute. What code should I write to do that?
Bunny.where(color: 'white').order(:name)


# 4. Now I want to find the specific bunny whose name is `'George'` (names are unique, so there should be only one).
Bunny.find_by(name: 'George')


# 5. I want to make sure nobunny, er, I mean nobody, can create a bunny without a name. What code should I add to my `Bunny` model to validate this?
my answer
in the migration file under
def change_table bunnies do |t|
  t.text :name, null: false
end

correct:
class Bunny < ActiveRecord::Base
  validates :name, presence: true
end


# ### Controllers

# 1. My app is telling me there's an error in the `BunniesController`. What directory and filename should I look in?
app => controllers => BunniesController




# 2. I'm in the `show` action of my `BunniesController` and I have the ID of a specific bunny in `params[:id]`. What line should I type to find the bunny with the correct ID, and assign it to a variable that my view can access?
my answer
def show
  @bunny = Bunnies.find(params[:id])
end

correct: SINGULAR
def show
  @bunny = Bunny.find(params[:id])
end


# 3. I tried to update a bunny with the code `bunny.update(params[:bunny])`, but it gave me a "forbidden attributes error". Why is it telling me this, and what should I do (broadly speaking, no exact code needed) to fix the problem?

my answer:
you're trying to call the bunny by its key and not by any of its attributes. it's possible that there's a def bunny_params that permits only allowable attrs.
since bunny isn't one of them it throws this error. the best thing to do is call
the bunny you want by its :id anyhow.

correct:
trying to take parameters from a form and into the update method of a bunny and this would allow anyone submitting that form to change any attr of the bunny, even ones i don"'"t want people to be able to change directly.

this comes into play when creating a new bunny or updating a bunny

to fix this- create the strong params method (require(:bunny).permit(:attr_1, :attr_2))

# 4. When I create or update a bunny in my controller, how can I find out whether the bunny saved successfully?
check the network log
(also, you can go into psql and pull up the bunnies table to see the new bunny
  in the db directly)

correct:
you need to check the return value of the save or update method
if @bunny.save
  ...success...
else
  ... failure...
end

if @bunny.update
  ...success...
else
  ... failure...
end

this returns true/false




# 5. Assuming my bunny saved successfully, what code should I write to redirect the user to the "show" page for the bunny, with a flash message indicating success?
<p><%= link_to('Index'), index_bunny_path(@bunny) %></p>

This will bring the user to the full index page where the new bunny should appear

correct:

redirect_to bunny_path(@bunny) or redirect_to bunny_path(@bunny.id)
**the latter is preferred bc it assists rails in knowing to go to the show route

use redirect_to when this happening internally, use link_to when it's on the http page


# ### Routes/Views

# 1. What line should I add to `config/routes.rb` to create a complete set of RESTful routes for a "bunnies" resource?'
resources :bunnies

# 2. My app is telling me there's an error in the "show" view for bunnies. What directory and filename would that be located in?
app => views => bunnies => show.html.erb

# 3. I'm in the `index.html.erb` view and I've assigned a variable `@bunnies` to a collection of all my bunnies. What HTML/ERB code should I write to create an unordered list that shows each bunny's `name` attribute?
<ul> Bunnies
  <%
<%= render partial: "bunny", collection: @bunnies %>
</ul>

correct:
<ul> Bunnies
  <% @bunnies.each do |bunny| %>
    <li><%= bunny.name %></li>
  <% end %>
</ul>

# 4. In one of my views, I want to create a link to the "show" path for a specific bunny that I have stored in the variable `bunny`. `rake routes` tells me that I have a standard `bunny_path` helper available. How do I create this link?
<p><%= link_to('Show'), show_bunny_path(@bunny) %></p>

correct:
<p><%= link_to('Anything'), bunny_path(@bunny) %></p>
or<p><%= link_to('Anything'), bunny_path(@bunny.id) %></p>

# 5. I've created a view partial called `_form.html.erb` and I want to render this partial into my "new" view. What HTML/ERB code should I write to do this?
<h3>Create a new bunny </h3>

<p>
<%= render 'form', bunny: @bunny %>
</p>
