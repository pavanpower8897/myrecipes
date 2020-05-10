require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

def setup
	@recipe = Recipe.new(name: "vegetable", description: "A good vegetable")
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
