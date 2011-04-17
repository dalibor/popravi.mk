class Api::V2::SessionsController < ApplicationController

  # TODO: spec
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.valid_password?(params[:password])
      session[:user_id] = user.id

      respond_to do |format|
        format.json { render :json => {:status => "ok"}.to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => {:status => "error", 
                       :message => "Невалиден email или лозинка"}.to_json }
      end
    end
  end
end
