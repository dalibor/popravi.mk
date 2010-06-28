class Admin::CategoriesController < ApplicationController

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
      success.html { redirect_to admin_categories_url }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to admin_categories_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_categories_url }
    end
  end
end
