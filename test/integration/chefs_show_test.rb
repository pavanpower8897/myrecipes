require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
  	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com",
      password: "password", password_confirmation: "password")
  	@rec1  = @chef.recipes.create!(name: "chicken", description: "With biryani")
  	@rec2 = @chef.recipes.create!(name: "vegetables", description: "with vegetables")
  end

  test "should show chefs recipes" do
  	get chef_path(@chef)
  	assert_template 'chefs/show'
  	assert_select 'a[href=?]', recipe_path(@rec1), text: @rec1.name
    assert_select 'a[href=?]', recipe_path(@rec2), text: @rec2.name
    assert_match @chef.chefname, response.body
    assert_match @rec1.description, response.body
    assert_match @rec2.description, response.body
  end

end
