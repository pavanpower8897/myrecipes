require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "pavan",email: "pavanpower8897@gmail.com")
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
end