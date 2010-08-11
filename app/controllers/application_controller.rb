# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  class AccessDenied < StandardError; end
  # Rescuers
  rescue_from AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to new_session_path(:user)
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      my_problems_path
      #if current_user.problems_count == 0 && current_user.has_potentially_reported_problems?
        #ownership_problems_path
      #else
        #new_user_session_path
      #end
    else
      super
    end
  end

  private
  def verify_admin
    raise AccessDenied unless current_user && current_user.is_admin?
  end
end
