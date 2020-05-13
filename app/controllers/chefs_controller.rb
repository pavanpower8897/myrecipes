class ChefsController < ApplicationController
	

	def new
		@chef = Chef.new
	end

	def create
		@chef = Chef.new(set_params)
		if @chef.save
			flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App"
			redirect_to chef_path(@chef)
		else
		render 'new'
	    end
	end
	def show
		@chef = Chef.find(params[:id])
		@recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
	end

	def edit
		@chef = Chef.find(params[:id])
	end

	def update
		@chef = Chef.find(params[:id])
		if @chef.update(set_params)
			flash[:success] = "Your account was updated successfully"
			redirect_to @chef
		else
			render 'edit'
		end
	end

	def index
		@chefs = Chef.paginate(page: params[:page], per_page: 1)
	end


	private
	def set_params
		params.require(:chef).permit(:chefname,:email,:password,:password_confirmation)
	end
end