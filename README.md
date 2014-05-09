# Week 3 Comprehensive Assessment

Fork this repository, update this file to include your answers, and submit a pull request. You may refer to any notes, past projects, or external resources you want. The questions do not have to be completed in order.

* The primary resource that I want to keep track of in my app is "bunnies". What line should I put in `config/routes.rb` to create a complete set of RESTful routes for this resource?

  resources :bunnies


* I want to create a migration to add a "weight" column to my bunnies table. What should I run on the command line to get started?

  rails g migration AddPoundsToBunnies


* I just realized I misspelled the "weight" column in my migration, but I already ran `rake db:migrate`. What should I do to fix this? (give exact steps and/or commands to run)

  rake db:rollback
  >> edit the file located in db/migrate with correctly spelled "weight"
  rake db:migrate


* My app has a `Bunny` model, and I want to find bunnies whose `color` attribute is `'brown'`. What code should I write to do that?

  Bunny.where(color: 'brown')


* Now I want to find `'white'` bunnies instead of brown ones, and I want to sort them by their `name` attribute.

  Bunny.order(:name).where(color: 'white')


* Now I want to find the specific bunny whose name is `'George'` (names are unique, so there should be only one).

  Bunny.where(name: 'George')


* I want to make sure nobunny, er, I mean nobody, can submit a bunny without a name. What code should I add to my `Bunny` model to validate the presence of a name?

  validates :name, presence: true


* My app is telling me there's an error in the `BunniesController`. What directory and filename should I look in?

  app/controllers/bunnies_controller.rb


* Now there's a problem in the "show" view for bunnies. What directory and filename would that be located in?

  app/views/bunnies/show.html.erb


* I'm in the `show` action of my `BunniesController` and I have the ID of a specific bunny in `params[:id]`. What line should I type to find the bunny with the correct ID, and assign it to a variable that my view can access?

  @bunny = Bunny.find(params[:id])


* I tried to update a bunny with the code `bunny.update(params[:bunny])`, but it gave me a "forbidden attributes error". Why is it telling me this, and what should I do (broadly speaking, no exact code needed) to fix the problem?

  You need a method to receive/accept parameters so they can be passed in to the update action.
  Typically, this is done as a private method..

  def bunny_params
    params.require(:bunny).permit(:name, :weight, :etc)
  end

  Use a local variable to find the bunny that needs updating...
  Then you can run the update method on that bunny..  bunny.update(bunny_params)


* When I create or update a bunny in my controller, how can I find out whether the bunny saved successfully? What method should I call on my `bunny` variable, or what return value should I check?

  bunny.persisted?
  => true

  (I have a hard time remembering this one.. persisted, new_record)


* I'm in the `index.html.erb` view and I've assigned a variable `@bunnies` to a collection of all my bunnies. What HTML/ERB code should I write to create an unordered list that shows each bunny's `name` attribute?

  <ul>
  <% @bunnies.each do |bunny| %>
    <li> <%= bunny.name %> </li>
  <% end %>
  </ul>



* In one of my views, I want to create a link to the "show" path for a specific bunny that I have stored in the variable `bunny`. `rake routes` tells me that I have a standard `bunny_path` helper available. How do I create this link?

  <%= link_to bunny.name, bunny_path %>


* I've created a view partial called `_form.html.erb` and I want to render this partial into my "new" view. What HTML/ERB code should I write to do this?

  <%= render 'form' %>

