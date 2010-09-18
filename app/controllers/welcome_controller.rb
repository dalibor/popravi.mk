class WelcomeController < ApplicationController

  def index
    @problems = Problem.find :all, :include => [:category, :municipality], :order => "id DESC", :limit => 5
    @post = Post.published.first
  end
end
