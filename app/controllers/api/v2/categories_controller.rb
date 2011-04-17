class Api::V2::CategoriesController < Api::V2::BaseController

  def index
    categories = Category.find(:all, :select => "id, name", :order => "position ASC")

    @categories = []
    categories.each { |category| 
      @categories << {:id => category.id, :name => category.name} }

    render_json(@categories)
  end
end
