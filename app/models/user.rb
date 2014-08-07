class User < ActiveRecord::Base
	# Callback in order to save a lowercase user email to the db
	before_save {self.email = email.downcase}

	validates :name, presence: true, length: {maximum: 50}
	# This has one weakness - tests like foo@bar..com pass
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
					  uniqueness: {case_sensitive: false}
	# The uniqueness attribute could just be: uniqueness: true
	# if we don't want to test for case sensitivity
	# 
	
	# Presence of password and confirmation are automatically
	# validated with this. It is essential that there is a 
	# password_digest column in the database!
	has_secure_password

	# Validate password length
	validates :password, length: {minimum: 6}



end
