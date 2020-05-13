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
	end


	private
	def set_params
		params.require(:chef).permit(:chefname,:email,:password,:password_confirmation)
	end
end