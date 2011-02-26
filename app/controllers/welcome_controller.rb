class WelcomeController < ApplicationController

  def index
    @problems = Problem.ordered.includes([:category, :municipality]).limit(5)
    @municipalities = Municipality.order('problems_count DESC').limit(10)
    @post = Post.published.ordered.first
  end
end
