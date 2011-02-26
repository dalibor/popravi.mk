class MunicipalitiesController < ApplicationController

  def index
    @municipalities = Municipality.order('problems_count DESC').limit(10).
                      paginate :per_page => 20, :page => params[:page]
    @post = Post.published.ordered.first
  end

  def show
    @municipality = Municipality.find_by_slug(params[:id])
    @problems = @municipality.problems.search(params)
    @total_problems = @municipality.problems.count
  end
end
