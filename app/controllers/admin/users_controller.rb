class Admin::UsersController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def index
    @users = User.paginate :all, :order => "created_at DESC",
                           :per_page => 10, :page => params[:page]
  end

  def create
    create! do |success, failure|
      flash[:notice] = "User was successfully created"
      success.html { redirect_to admin_users_url }
    end
  end

  def update
    if params[:user].present? && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
    update! do |success, failure|
      flash[:notice] = "User was successfully updated"
      success.html { redirect_to admin_users_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_users_url }
    end
  end
end
