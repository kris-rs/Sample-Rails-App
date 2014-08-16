require 'spec_helper'

describe "UserPages" do
  subject {page}
  
  # Testing the show user page
  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.name)}
  	it { should have_content(user.email) }
  end

  describe "signup page" do
  	# The line below is possible because we have
  	# predefined user in spec/factories.rb
  	
    before {visit signup_path}

    it {should have_content 'Sign up'}
    it {should have_title(full_title 'Sign up')}
  end

  # Testing sign up page -> creating a new user and not 
  # creating a new user
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up')}
    it {should have_title('Sign up')}
  end

  describe "signup" do
    before {visit signup_path}

    let(:submit) {"Create my account"}
    let(:error_messages) {
          ["Email is invalid", 
           "Password is too short (minimum is 6 characters)"]
        }

    describe "with invalid information" do
      it "should not create a user" do
        # This line basically says expect the User.count not to
        # change when the button submit(Create my account) is clicked
        # it is equivallent to:
        # --------------------
        # initial = User.count
        # click_button submit
        # final = User.count
        # expect(initial) to eq final
        # --------------------
        expect {click_button submit}.not_to change(User, :count)
      end 

      it "should have appropriate error message content" do
        click_button submit

        error_messages.each {|message| expect(page).to have_content message}
      end
    end

    describe "with valid info" do
      before do
        fill_in "Name",         with: "Examle User"
        fill_in "Email",        with: "mail@example.com"
        fill_in "Password",     with: "qwerty"
        fill_in "Confirmation", with: "qwerty"
      end

      it "should create a user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end
    end
  end
end
