     require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
 def setup
 	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com",
        password: "password", password_confirmation: "password")
  	@rec1  = @chef.recipes.create!(name: "chicken", description: "With biryani")
  	@admin_user = Chef.create(chefname: "kumar", email: "inti@gmail.com",                                                          
  	 password: "password", password_confirmation:"password",admin: true)
  	@chef1 = Chef.create!(chefname: "nandhu", email: "nandhu@gmail.com",
        password: "password", password_confirmation: "password")
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

test "accept edit attempt by admin user" do
	sign_in_as(@admin_user, "password")
 	get edit_chef_path(@chef)
 	assert_template 'chefs/edit'
 	patch chef_path(@chef) , params:{chef: {chefname: "nageswararao",email: "intinagu80@gmail.com"} }
 	assert_redirected_to @chef
 	assert_not flash.empty?
 	@chef.reload
 	assert_match @chef.chefname, "nageswararao"
    assert_match @chef.email, "intinagu80@gmail.com"
end

test "redirect edit attempt by another non-admin-user" do
	sign_in_as(@chef1, "password")
 	patch chef_path(@chef) , params:{chef: {chefname: "nageswararao",email: "intinagu80@gmail.com"} }
 	assert_redirected_to chefs_path
 	assert_not flash.empty?
 	@chef.reload
 	assert_match @chef.chefname, "pavan"
    assert_match @chef.email, "pavanpower@gmail.com"
end

end
