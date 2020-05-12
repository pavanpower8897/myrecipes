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
    assert_select 'a[href=?]', recipe_path(@rec1), text: @rec1.name
    assert_select 'a[href=?]', recipe_path(@rec2), text: @rec2.name
  end

  test "should give recipes show page" do
    get recipe_path(@rec1)
    assert_response :success
  end

  test "should show recipe details" do
    get recipe_path(@rec1)
    assert_template 'recipes/show'
    assert_match @rec1.name.capitalize, response.body
    assert_match @rec1.description, response.body
    assert_match @chef.chefname, response.body
    assert_select "a[href=?]", edit_recipe_path(@rec1), text: "Edit this recipe"
    assert_select "a[href=?]", recipe_path(@rec1), text: "Delete this recipe"
    assert_select "a[href=?]", recipes_path, text: "Return to recipes listing"
  end

  test "create  new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Chicke salad"
    description_of_recipe = "Add 2litres of water and 1kg chicken and boil them"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submissions" do
      get new_recipe_path
      assert_template 'recipes/new'
      assert_no_difference 'Recipe.count' do\
        post recipes_path, params: { recipe: {name: " ", description: "  "}  }
      end
      assert_template 'recipes/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
  end

end
