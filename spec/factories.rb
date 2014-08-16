FactoryGirl.define do
	factory :user do
		name 			 	  "Michael Hartl"
		email 			 	  "email@email.com"
		password         	  "qwerty"
		password_confirmation "qwerty"
	end
end