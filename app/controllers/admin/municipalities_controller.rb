class Admin::MunicipalitiesController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def index
    @municipalities = Municipality.find :all, :include => :region
  end

  def create
    create! do |success, failure|
      success.html { redirect_to admin_municipalities_url }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to admin_municipalities_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_municipalities_url }
    end
  end
end
