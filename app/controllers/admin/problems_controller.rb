class Admin::ProblemsController < ApplicationController

  # Filters
  before_filter :verify_admin

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  # Layout
  layout "admin"

  def index
    @problems = Problem.find(:all, :include => [:category, :municipality, :user])
  end

  def create
    create! do |success, failure|
      flash[:notice] = "Problem was successfully created"
      success.html { redirect_to admin_problems_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Problem was successfully updated"
      success.html { redirect_to admin_problems_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_problems_url }
    end
  end
end
