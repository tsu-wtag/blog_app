class UsersController < ApplicationController
  # Ensure the user is logged in before they can view their profile
  before_action :authenticate_user!

  def show
    # Set the user to the current logged-in user
    @user = current_user
  end
end
