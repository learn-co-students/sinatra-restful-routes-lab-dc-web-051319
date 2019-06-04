class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  post "/recipes" do
    name = params["name"]
    ingredients = params["ingredients"]
    cook_time = params["cook_time"]
    recipe = Recipe.create(name: name,ingredients: ingredients, cook_time: cook_time)
    redirect "/recipes/#{recipe.id}"
  end

  get "/recipes/:id/edit" do
    id = params["id"]
    @recipe = Recipe.find(id)
    erb :edit
  end

  get "/recipes/:id" do
    id = params["id"]
    @recipe = Recipe.find(id)
    erb :show
  end

  delete "/recipes/:id" do
    id = params["id"]
    recipe = Recipe.find(id)
    recipe.delete
    redirect "/recipes"
  end

  patch "/recipes/:id" do
    id = params["id"]
    name = params["name"]
    ingredients = params["ingredients"]
    cook_time = params["cook_time"]
    recipe = Recipe.find(id)
    recipe.update(name: name,ingredients: ingredients,cook_time: cook_time)
    redirect "/recipes/#{recipe.id}"
  end

end
