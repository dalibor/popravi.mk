class WelcomeController < ApplicationController

  def index
    @problems = Problem.with_photo
  end
end
