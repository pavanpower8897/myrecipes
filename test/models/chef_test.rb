require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "pavan",email: "pavanpower8897@gmail.com", 
			password: "password", password_confirmation: "password")
	end

	test "chef should be valid" do
		assert @chef.valid?
	end
	test "chefname should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end
	
	test "chefname should be lessthan 30 characters" do
		@chef.chefname = "a"*31
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email should be lessthan 255 characters" do
		@chef.email = "a"*250 + "@gmail.com"
		assert_not @chef.valid?
	end

	test "email should be in valid format" do
	 valid_emails = %w[pavan@example.com pavan@gmail.com p.kumar@yahoo.com]
	 valid_emails.each do |valids|
	 	@chef.email = valids
	 	assert @chef.valid?, "#{valids.inspect} should be valid"
	 end
	end

	test "reject emails with invalid format" do
		invalid_emails = %w[pavanexample.com pavan@gmailcom pavan@yahoocom]
		invalid_emails.each do |invalids|
			@chef.email = invalids
			assert_not @chef.valid?
		end
	end

	test "email should be unique and case insensitve" do
		@duplicate_chef  = @chef.dup
		@duplicate_chef.email = @chef.email.upcase
		@chef.save
		assert_not @duplicate_chef.valid?
	end
     
    test "email should be lowercase before hitting the db" do
    	@dup_email = "Pavan@gmail.com"
    	@chef.email = @dup_email
    	@chef.save
    	assert_equal @dup_email.downcase, @chef.reload.email
    end
    test "password should be present" do
    	@chef.password=" " 
    	@chef.password_confirmation = " "
    	assert_not @chef.valid?
    end

    test "password should be atleast 5 characters" do
    	@chef.password = "a"*3
    	@chef.password_confirmation = "a"*3
    	assert_not @chef.valid?
    end	
    
    test "password and password_confirmation should be same" do
    	@chef.password = "a"*6
    	@chef.password_confirmation = "a"*7
    	assert_not @chef.save
    end

    test "associated recipes should be deleted" do
    	@chef.save
    	@chef.recipes.create!(name: "chicken", description: "Add water and chicken to bowl")
    	assert_difference 'Recipe.count', -1 do
    		@chef.destroy
    	end
    end

end