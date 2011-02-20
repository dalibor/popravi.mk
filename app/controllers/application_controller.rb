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
        if resource.is_admin?
          admin_root_path
        elsif resource.is_moderator?
          moderator_root_path
        else # user
          user_problems_path
        end
      elsif params[:controller] == "devise/registrations" && params[:action] == "update"
        edit_user_registration_path
      else
        super
      end
    end
  end
end
