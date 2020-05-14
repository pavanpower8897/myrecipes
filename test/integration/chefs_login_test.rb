require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  test "invalid login should be rejected" do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: {session: {email: "", password: ""} }
  	assert_template 'sessions/new'
  	assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]" , logout_path, count: 0
  	get root_path
  	assert flash.empty?
  end
  test "valid login should be accepted" do
  	@chef = Chef.create!(chefname: "pavan", email: "pavanpower@gmail.com",
  	 password: "powerstar", password_confirmation: "powerstar")
  	@recipe = @chef.recipes.create!(name: "chicken kurma", description: "Its very easy to do in kitchen with kitchen and kurma")
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: {session: {email: "pavanpower@gmail.com" , password: "powerstar"} }
  	follow_redirect!
  	assert_template  'chefs/show'
  	assert_not flash.empty?
    assert_select 'a[href=?]', recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]" , logout_path
    assert_select "a[href=?]", chef_path(@chef)
    assert_select "a[href=?]" , edit_chef_path(@chef)
  end
end
