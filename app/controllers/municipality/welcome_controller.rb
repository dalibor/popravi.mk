class Municipality::WelcomeController < Municipality::BaseController
  before_filter :load_municipality

  def index
    @problems = @municipality.problems.ordered.last(5)
    @post = @municipality.posts.published.ordered.first
  end
end
