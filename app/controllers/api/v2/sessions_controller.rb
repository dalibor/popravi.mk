class Api::V2::SessionsController < Api::V2::BaseController

  def create
    user = User.find_by_email(params[:email])

    if user && user.valid_password?(params[:password])
      session[:user_id] = user.id

      render_json({ :status => "ok", :municipality_id => user.municipality_id})
    else
      render_json({ :status => "error", :message => "Невалиден email или лозинка" })
    end
  end
end
