class MunicipalitiesController < ApplicationController

  def index
    @municipalities = Municipality.order('problems_count DESC').limit(10).
                      paginate :per_page => 20, :page => params[:page]
    @post = Post.published.ordered.first
  end

  def show
    redirect_to root_path
  end
end
