class ProblemsController < ApplicationController

  before_filter :authenticate_user!, :only => [:my, :ownership, :take_ownership, :update]

  def index
    @problems = Problem.search(params)
    @municipalities = Municipality.top(10)
    @categories     = Category.top(10)
    @total_problems = Problem.count

    respond_to do |format|
      format.html { render :action => 'index' }
      format.rss  { render :layout => false   }
    end
  end

  def take_ownership
    problems = Problem.find(params[:problem_ids].keys)
    current_user.take_ownership_of_problems(problems)
    redirect_to my_problems_url
  end

  def my
    @problems = current_user.problems.
      order("id DESC").
      includes([:municipality, :category]).
      paginate :per_page => 10, :page => params[:page]
    @potentially_reported_problems = current_user.potentially_reported_problems
  end

  def new
    @problem = Problem.new
  end

  def show
    @problem = Problem.find(params[:id])
    @comments = @problem.comments.find :all, :order => "created_at ASC", :include => :user
    @comment = Comment.new
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.new(params[:problem])
    @problem.user = current_user if user_signed_in? # assign current_user if user is logged in

    if (user_signed_in? || verify_recaptcha(:model => @problem, :message => "Грешка со reCAPTCHA")) && @problem.save
      flash[:notice] = 'Проблемот е успешно пријавен.'
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
      flash[:notice] = 'Проблемот е успешно изменет.'
      redirect_to @problem
    else
      render :action => :new
    end
  end
end
