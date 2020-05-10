require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

def setup
	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com")
	@recipe = @chef.recipes.build(name: "vegetable", description: "A good vegetable")
end
test "Recipe without chef_id should be invalid" do
	@recipe.chef_id = nil
	assert_not @recipe.valid?
end
test "Recipe should be valid" do
	assert @recipe.valid?
end

test "Recipename should be present" do
	@recipe.name = " "
	assert_not @recipe.valid?
end

test "description should be present" do 
	@recipe.description = " "
	assert_not @recipe.valid?
end

test "description should not be lessthan 5 characters" do
	@recipe.description ="abc"
	assert_not @recipe.valid?
end

test "description should not be greaterthan 500 characters" do
	@recipe.description = "a"*501
	assert_not @recipe.valid? 
end
end
