class RecipesController < ApplicationController
	
	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end
    def create
    	@chef = Chef.first
    	@recipe = @chef.recipes.build(recipe_params)
        if @recipe.save
        	flash[:notice] = "Recipe is succesfully created"
        	redirect_to recipe_path(@recipe)
        else
        	render 'new'
        end
    	
    end


    private

     def recipe_params
     	params.require(:recipe).permit(:name,:description)
     end
end