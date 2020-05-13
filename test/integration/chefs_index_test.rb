require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
  	 	@chef1 = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com",
      password: "password", password_confirmation: "password")
  	 	@chef2 = Chef.create!(chefname: "kumar",email: "intinagu@gmail.com",
  	 	 password: "password1",password_confirmation: "password1")
  	@rec1  = @chef1.recipes.create!(name: "chicken", description: "With biryani")
  	@rec2 = @chef2.recipes.create!(name: "vegetables", description: "with vegetables")
  end

  test "should get all chefs list" do
  	get chefs_path
  	assert_template 'chefs/index'
  	assert_select 'a[href=?]', chef_path(@chef1), text: @chef1.chefname.capitalize
    assert_select 'a[href=?]', chef_path(@chef2), text: @chef2.chefname.capitalize
  end
end
