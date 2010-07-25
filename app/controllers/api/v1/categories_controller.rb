class Api::V1::CategoriesController < ApplicationController

  def index
    categories = Category.find(:all, :select => "id, name", :order => "position ASC")

    @categories = []
    categories.each { |category| @categories << {:id => category.id, :name => category.name} }

    respond_to do |format|
      format.json { render :json => @categories.to_json }
    end
  end
end
