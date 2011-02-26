class WelcomeController < ApplicationController

  def index
    @problems = Problem.ordered.includes([:category, :municipality]).limit(5)
    @post = Post.published.ordered.first
  end
end
