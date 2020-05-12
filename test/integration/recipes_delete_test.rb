require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
  	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com")
  	@rec1  = @chef.recipes.create!(name: "chicken", description: "With biryani")
  end

  test "succefully deleted recipe" do
  	 get recipe_path(@rec1)
  	 assert_template 'recipes/show'
  	 assert_select "a[href=?]", recipe_path(@rec1), text: "Delete this recipe"
  	 assert_difference 'Recipe.count', -1 do
  	 delete recipe_path(@rec1)
  	 end
  	 assert_redirected_to recipes_path
  	 assert_not flash.empty?
  end
end
