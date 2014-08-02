require 'spec_helper'

describe "StaticPages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  # Set the subject to page
  # This lets us replace expect(page).to have_content with
  # it {should have_content()} because we have already
  # specified what the subject is
  # 
  # I have left the other tests the way they are for comparison._
  subject {page}
  describe "Home page" do
    # This DRY-es out the RSpec tests ( Observe how the
    # other paths visit some path repetitevely and this one
    # does not)
    before {visit root_path}
    it {should have_content('Sample App')}
    it {should have_title('Home')}

  end
  

  describe "Help Page" do
  	it "should have the content 'Help" do
  	  visit help_path
  	  expect(page).to have_content('Help')
  	end

  	it "should have the right title" do
      visit help_path
      expect(page).to have_title("Help")
    end
  end

  describe "About page" do
  	it "Should have the content 'About us'" do
  	  visit about_path
  	  expect(page).to have_content('About Us')
  	end

  	it "should have the right title" do
      visit about_path
      expect(page).to have_title("About")
    end
  end  

  describe "Contact page" do
    it "Should have the right title" do
      visit contact_path
      expect(page).to have_title("Contact")
    end
  end

end
