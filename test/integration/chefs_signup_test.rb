require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get signup page" do
  	get signup_path
  	assert_response :success
  end

  test "reject the invalid  signup" do
   get signup_path
   assert_no_difference 'Chef.count' do
   	post chefs_path, params: {chef: {chefname: "",email: "", password:"password",password_confirmation: ""} }
   end
   assert_template 'chefs/new'
   assert_select 'h2.panel-title'
   assert_select 'div.panel-body'
  end
  test "accept the valid signup" do
  	 get signup_path
     assert_difference 'Chef.count', 1 do
   	 post chefs_path, params: {chef: {chefname: "power",email: "pavanpower@gmail.com", 
   	 	password:"password",password_confirmation: "password"} }
   	 	follow_redirect!
   	    assert_template 'chefs/show'
   	    assert_not flash.empty?
     end

  end	 
end
