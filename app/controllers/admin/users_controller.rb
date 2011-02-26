class Admin::UsersController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @users = User.includes(:municipality).
                  filter(params[:filter]).
                  order("created_at DESC").
                  paginate :all, :per_page => 10, :page => params[:page]
  end

  def update
    if params[:user].present? && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
    update!
  end
end
