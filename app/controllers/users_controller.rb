class UsersController < ApplicationController
  # Show user: note the params[:id]
  # Also note the diagram in the beginning of
  # Chapter 7 - sign up: show works because
  # it is a predefined RESTful resource in rails
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  # This is called when a user submits a sign up form
  def create
    # params[:user] gets passed to the users controller from
    # whatever info was put into the form as a hash
    # e.g:
    # "user" => {name => sth, :email => sth} etc
    # The hash keys come from the name attributes of the input
    # fields
    @user = User.new(user_params) # Not the final implementation

    if @user.save
      # We omit the user url because rails is smart and redirects
      # to show page
      flash[:success] = "Welcome to the Sample App"
       redirect_to @user 
    else
      # If we fail we reload the page I guess
      render 'new'
    end
  end

  private 

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end
end
