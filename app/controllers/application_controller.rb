class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public' #folder to be used
    set :views, 'app/views' #setting the view for this page
  end

  #recipes index page
  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  #form to create a new recipe
  get '/recipes/new' do
    erb :new
  end

  #getting a recipe by it's id
  get '/recipes/:id' do
    id = params['id']
    @recipe = Recipe.find_by_id(id)

    erb :show
  end

   #creating a new recipe and adding to index
   post '/recipes' do
    @recipe = Recipe.create(params)

    redirect to "/recipes/#{@recipe.id}"
  end

  #get the edit page
  get '/recipes/:id/edit' do
    id = params[:id]

    @recipe = Recipe.find(id)

    erb :edit
  end

  #to edit an existing recipe
  patch '/recipes/:id/edit' do
    recipe_id = params['id']

    @recipe = Recipe.find(recipe_id)

    recipe_name = params['name']
    ingredients = params['ingredients']
    cook_time = params['cook_time']

    @recipe.update(name: recipe_name, ingredients: ingredients, cook_time: cook_time)

    redirect "recipes/#{@recipe.id}"
  end

  #delete an existing recipe
  delete '/recipes/:id' do

    id = params[:id]
    @recipe = Recipe.find(id)

    @recipe.destroy

    redirect '/recipes'
  end

end
