class ApplicationController < ActionController::Base
  include Pundit

  # Rescue Pundit authorization errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

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
