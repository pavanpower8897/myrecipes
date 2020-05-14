require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
 def setup
 	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com",
        password: "password", password_confirmation: "password")
  	@rec1  = @chef.recipes.create!(name: "chicken", description: "With biryani")
 end

 test "succesfully updated a valid chef" do
 	sign_in_as(@chef, "password")
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef) , params:{chef: {chefname: "nageswararao",email: "intinagu80@gmail.com"} }
 	assert_redirected_to @chef
 	assert_not flash.empty?
 	@chef.reload
 	assert_match @chef.chefname, "nageswararao"
    assert_match @chef.email, "intinagu80@gmail.com"
 end
 test "rejected invalid chef submission" do
 	sign_in_as(@chef, "password")
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef) , params:{chef: {chefname: @chef.chefname,email: " "} }
 	assert_template 'chefs/edit'
 	assert_select 'h2.panel-title'
    assert_select 'div.panel-body'	
end

end
