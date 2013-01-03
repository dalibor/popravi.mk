class Municipality::ProblemsController < Municipality::BaseController
  before_filter :load_municipality

  def index
    @problems = @municipality.problems.search(params)
    @post = @municipality.posts.published.ordered.first
    @total_problems = @municipality.problems.count

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end
end
