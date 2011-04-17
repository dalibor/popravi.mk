class Api::V2::BaseController < ApplicationController

  private
    def render_json(hash)
      respond_to do |format|
        format.json { render :json => hash.to_json }
      end
    end

    def require_moderator
      unless (@editor = User.find_by_id(session[:user_id]))
        render_json({ :status => "access_denied" })
      end
    end
end
