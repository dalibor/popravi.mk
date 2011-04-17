class ApplicationController < ActionController::Base
  protect_from_forgery

  class AccessDenied < StandardError; end
  # Rescuers
  rescue_from AccessDenied do |exception|
    sign_out_and_redirect(current_user) if current_user
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

  def render_problem_show
    @comments = @problem.comments.
                        includes([{:user => :municipality}, [:commentable => :municipality]]).
                        order("created_at ASC")
    @comment  = Comment.new
    render 'problems/show'
  end
end
