class WelcomeController < ApplicationController

  def index
    @problems = Problem.with_photo
    @now = Time.now
    @posts = Post.published.for_month(@now.year, @now.month).paginate :per_page => 3, :page => params[:page]
  end
end
