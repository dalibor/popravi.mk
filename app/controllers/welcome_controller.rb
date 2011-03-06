class WelcomeController < ApplicationController

  def index
    @problems = Problem.ordered.includes([:category, :municipality]).limit(5)
    @municipalities = Municipality.order('problems_count DESC').limit(5)
    @post = Post.published.ordered.first
    @problem = Problem.with_status('solved').order('solved_at DESC').first
  end
end
