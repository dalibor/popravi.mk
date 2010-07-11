class ProblemsController < ApplicationController

  before_filter :authenticate_user!, :only => [:ownership, :take_ownership, :update]

  def index
    conditions = []
    parameters = {}
    joins = []

    if params[:q].present?
      conditions << "problems.description LIKE :q"
      parameters[:q] = "%#{params[:q]}%"
    end

    if params[:category].present?
      conditions << "categories.id = :category"
      parameters[:category] = params[:category]
      joins << :category
    end

    @problems = Problem.paginate :per_page => 10, :page => params[:page], :conditions => [conditions.join(" AND "), parameters], :joins => joins
  end

  def ownership
    @problems = current_user.potentially_reported_problems
  end

  def take_ownership
    problems = Problem.find(params[:problem_ids].keys)
    current_user.take_ownership_of_problems(problems)
    redirect_to my_problems_url
  end

  def my
    @problems = current_user.problems.paginate :per_page => 10, :page => params[:page]
    render :action => :index
  end

  def new
    @problem = Problem.new
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.new(params[:problem])

    @problem.user = current_user if user_signed_in? # assign current_user if user is logged in

    if @problem.save
      flash[:notice] = 'Problem was successfully reported.'
      redirect_to @problem
    else
      render :action => :new
    end
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.attributes = params[:problem]

    @problem.user = current_user

    if @problem.save
      flash[:notice] = 'Problem report was successfully updated.'
      redirect_to @problem
    else
      render :action => :new
    end
  end
end
