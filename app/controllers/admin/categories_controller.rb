class Admin::CategoriesController < Admin::BaseController

  before_filter :load_category, :only => [:move_down, :move_up]
  inherit_resources
  respond_to :html

  def index
    @categories = Category.ordered.paginate :per_page => 10, :page => params[:page]
  end

  def move_down
    @category.move_lower
    flash[:notice] = 'Category was successfully moved lower.'
    redirect_to admin_categories_url
  end

  def move_up
    @category.move_higher
    flash[:notice] = 'Category was successfully moved higher.'
    redirect_to admin_categories_url
  end

  private
  def load_category
    @category = Category.find(params[:id])
  end
end
