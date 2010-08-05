class Admin::CountriesController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def create
    create! do |success, failure|
      flash[:notice] = "Country was successfully created"
      success.html { redirect_to admin_countries_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Country was successfully updated"
      success.html { redirect_to admin_countries_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_countries_url }
    end
  end
end
