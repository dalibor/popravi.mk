class Municipality::WelcomeController < Municipality::BaseController

  def index
    @municipality = Municipality.find_by_slug(params[:id])
    @problems = @municipality.problems.search(params)
    @post = @municipality.posts.published.ordered.first
    @total_problems = @municipality.problems.count

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end
end
