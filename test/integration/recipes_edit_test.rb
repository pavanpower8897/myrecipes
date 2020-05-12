require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

def setup
	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com")
  	@rec1  = @chef.recipes.create!(name: "chicken", description: "With biryani")
end
test "succefully  update a valid recipe submission" do
	get edit_recipe_path(@rec1)
	assert_template 'recipes/edit'
	name_of_recipe = "Chicke salad"
    description_of_recipe = "Add 2litres of water and 1kg chicken and boil them"
    patch recipe_path(@rec1), params: {recipe: {name: name_of_recipe,description: description_of_recipe } }
    follow_redirect!
    @rec1.reload
    assert_not flash.empty?
    assert_match name_of_recipe.capitalize, @rec1.name
    assert_match description_of_recipe, @rec1.description

   
end
test "reject an invalid recipe submission" do
	get edit_recipe_path(@rec1)
	assert_template 'recipes/edit'
    patch recipe_path(@rec1), params: {recipe: {name: "",description: "" } }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
end

end
