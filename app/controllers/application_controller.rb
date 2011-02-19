class ApplicationController < ActionController::Base
  protect_from_forgery

  class AccessDenied < StandardError; end
  # Rescuers
  rescue_from AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to new_session_path(:user)
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if params[:controller] == "devise/sessions" || params[:controller] == "confirmations"
        user_problems_path
      elsif params[:controller] == "devise/registrations" && params[:action] == "update"
        edit_user_registration_path
        #if current_user.problems_count == 0 && current_user.has_potentially_reported_problems?
          #ownership_problems_path
        #else
          #new_user_session_path
        #end
      else
        super
      end
    end
  end

  private
  def verify_admin
    raise AccessDenied unless current_user && current_user.is_admin?
  end
end
