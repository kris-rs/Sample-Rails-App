require 'spec_helper'

describe User do
  	# Run this before every test
  	before {@user = User.new(name: "Example User", email: "user@example.com",
  		password: "foobar", password_confirmation: "foobar")}
	# Tell RSpec that it refers to @user
	subject {@user}
	# These two don't do anything important but they ensure that
	# the constructions user.name and user.email are valid
	# This tests whether a given object responds to a method or
	# attribute. In this case @user should respond to
	# user.name and @ user should respond to user.email
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	# User should also respond to password_digest
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	# Respond to authenticate method
	it {should respond_to(:authenticate)}

	# Testing for validity of user objects
	it { should be_valid }

	# This test sets the name to a blank name
	# and then checks whether that is valid.
	# In essence the idea behind this is to test whether
	# we are checking if an attribute is valid or not.
	# If it {should_not be_valid} fails in the case when
	# @user.name == " " => we are not checking => the test fails
	describe "when name is not present" do
		before { @user.name = " "}
		it { should_not be_valid}
	end
	# Test for email
	describe "when email is not present" do
		before {@user.email = " "}
		it {should_not be_valid}
	end

	# Test for length
	describe "when name is too long" do
		before {@user.name = "a" * 51}
		it { should_not be_valid}
	end

	# Email address format validation
	# Invalid:
	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
				foo@bar_baz.com foo@bar+baz.com]
				addresses.each do |invalid_address|
					@user.email = invalid_address
					expect(@user).not_to be_valid
			end
		end
	end
	# Valid:
	describe "when email format is valid" do
		it "should be valid" do 
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	# Testing uniqueness of emails:
	# We need to actually save something to database for this
	# test to be usable.
	describe "when email address already taken" do
		# Create a duplication of current user object and save it
		# => the current user defined at the start of the spec
		# will now be invalid
		before do
			user_with_same_email = @user.dup
			# Tese for case insensitivity
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it {should_not be_valid}
	end

	# Test case for validation of password presence:
	describe "when password is not present" do
		before do
			@user = User.new(name: "Example User", email: "user@example.com",
				password: " ", password_confirmation: " ")
		end
		it {should_not be_valid}
	end

	# Test for password missmatch
	describe "when password doesn't match confirmation" do
		before {@user.password_confirmation = "mismatch"}
		it {should_not be_valid}
	end

	# Authentication tests:
	describe "return value of authenticate method" do
		# Save the user to the db
		before {@user.save}
		# Assign the user to found_user
		let(:found_user) {User.find_by(email: @user.email)}

		describe "with valid password" do
			it {should eq found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) {found_user.authenticate("invalid")}

			it { should_not eq user_for_invalid_password}
			# Specify is the same as it but it is used
			# when it would sound unnatural in a context
			specify {expect(user_for_invalid_password).to be_false}
		end
	end

	describe "password too short" do
		before {@user.password = @user.password_confirmation = "a" * 5}
		it {should be_invalid}
	end
end
