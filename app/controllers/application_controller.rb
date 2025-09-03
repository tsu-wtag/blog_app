class ApplicationController < ActionController::Base
  include Pundit

  # Rescue Pundit authorization errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    if !user_signed_in?
      flash[:alert] = "Login first to perform this action."
    else
      flash[:alert] = "You are not authorized to perform this action."
    end
    redirect_to root_path
  end
end
