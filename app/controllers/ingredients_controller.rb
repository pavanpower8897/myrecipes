class IngredientsController < ApplicationController
  before_action :set_ingredients, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]

	def create
		@ingredient = Ingredient.new(ingredient_params)
		if @ingredient.save
			flash[:success] = "Ingredient was successfully created"
			redirect_to ingredient_path(@ingredient)
		else
			render 'new'
		end
	end

	def new
		@ingredient = Ingredient.new
	end

	def show
		@ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
	end

	def index
		@ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
	end

	def update
		if @ingredient.update(ingredient_params)
			flash[:success] = "Ingredient was successfully updated"
			redirect_to @ingredient
		else
			render 'edit'
		end
	end

	def edit
	end	
    private
    def ingredient_params
    	params.require(:ingredient).permit(:name)
    end
	def set_ingredients
		@ingredient = Ingredient.find(params[:id])
	end
    def require_admin
    	if !logged_in? || (logged_in? && !current_chef.admin?)
    		flash[:danger] = "Only admin can perfom that action"
    		redirect_to ingredients_path
    	else
    	end
    end
end