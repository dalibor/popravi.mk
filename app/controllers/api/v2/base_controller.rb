class Api::V2::BaseController < ApplicationController

  before_filter :require_api_key
  # enable when too much spam on an API key that you cannot disable
  # before_filter :require_user 

  private
    def render_json(hash)
      respond_to do |format|
        format.json { render :json => hash.to_json }
      end
    end

    def require_user
      unless (@user = User.find_by_id(session[:user_id]))
        render_json({ :status => "access_denied" })
      end
    end

    def require_moderator
      unless (@editor = User.find_by_id(session[:user_id]))
        render_json({ :status => "access_denied" })
      end
    end

    def user_from_session
      if session[:user_id].present?
        User.find(session[:user_id]) 
      else
        nil
      end
    end

    def require_api_key
      @api_key = ApiKey.find_by_key(params[:api_key])
      render_json({ :status => "api_key" }) unless @api_key
    end
end
