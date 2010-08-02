class WelcomeController < ApplicationController

  def index
    @problems = Problem.find :all, :order => "id DESC", :limit => 5, :include => [:category, :municipality]
  end
end
