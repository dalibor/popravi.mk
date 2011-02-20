class Admin::BaseController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Layout
  layout "admin"
end
