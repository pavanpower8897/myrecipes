require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com")
  	@rec1  = @chef.recipes.create!(name: "chicken", description: "With biryani")
  	@rec2 = @chef.recipes.create!(name: "vegetables", description: "with vegetables")
  end
  test "should give recipes index page" do
  	get recipes_path
  	assert_response :success
  end

  test "should get recipes listing" do
  	get recipes_path
  	assert_template 'recipes/index'
  	assert_match @rec1.name, response.body
  	assert_match @rec2.name, response.body
  end
end
