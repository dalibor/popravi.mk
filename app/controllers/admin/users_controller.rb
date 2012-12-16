class Admin::UsersController < Admin::BaseController

  inherit_resources
  respond_to :html

  def index
    @users = User.ordered.includes(:municipality).filter(params[:filter]).
                  paginate :per_page => 10, :page => params[:page]
  end


  def create
    @user = User.new(params[:user], without_protection: true)
    create!
  end

  def update
    clean_password_attributes_unless_set

    @user = User.find(params[:id])

    if @user.update_attributes(params[:user], :without_protection => true)
      flash[:notice] = "User was successfully updated"
      redirect_to admin_user_url(@user)
    else
      render :edit
    end
  end

  private
  def clean_password_attributes_unless_set
    if params[:user].present? && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
  end
end
