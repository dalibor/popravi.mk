class Admin::CategoriesController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def index
    @categories = Category.paginate :all, :order => "position ASC",
                                    :per_page => 10, :page => params[:page]
  end

  def create
    create! do |success, failure|
      flash[:notice] = "Category was successfully created"
      success.html { redirect_to admin_categories_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Category was successfully updated"
      success.html { redirect_to admin_categories_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_categories_url }
    end
  end

  def move_down
    @category = Category.find(params[:id])
    @category.move_lower
    flash[:notice] = 'Category was successfully moved lower.'
    redirect_to admin_categories_url
  end

  def move_up
    @category = Category.find(params[:id])
    @category.move_higher
    flash[:notice] = 'Category was successfully moved higher.'
    redirect_to admin_categories_url
  end
end
