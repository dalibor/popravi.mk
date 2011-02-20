class Admin::BaseController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Layout
  layout "admin"

  private

    def verify_admin
      raise AccessDenied unless current_user && current_user.is_admin?
    end
end
