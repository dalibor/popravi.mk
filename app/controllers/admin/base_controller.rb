class Admin::BaseController < ApplicationController

  before_filter :verify_admin
  layout "admin"

  private
  def verify_admin
    raise AccessDenied unless (current_user && current_user.is_admin?)
  end
end
