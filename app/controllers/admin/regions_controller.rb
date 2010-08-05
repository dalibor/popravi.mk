class Admin::RegionsController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def index
    @regions = Region.find :all, :include => :country
  end

  def create
    create! do |success, failure|
      flash[:notice] = "Region was successfully created"
      success.html { redirect_to admin_regions_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Region was successfully updated"
      success.html { redirect_to admin_regions_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_regions_url }
    end
  end
end
