class Admin::WelcomeController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Layout
  layout "admin"

  def index
  end
end
