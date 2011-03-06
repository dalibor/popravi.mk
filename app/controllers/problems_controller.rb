class ProblemsController < ApplicationController

  def index
    @problems       = Problem.search(params)
    @categories     = Category.order("problems_count DESC").limit(10)
    @total_problems = Problem.count

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @problem  = Problem.find(params[:id])
    @comments = @problem.comments.
                        includes([{:user => :municipality}, [:commentable => :municipality]]).
                        order("created_at ASC")
    @comment  = Comment.new
  end

  def new
    @problem = Problem.new
  end

  def create
    @problem      = Problem.new(params[:problem])
    @problem.user = current_user if user_signed_in? # assign current_user if user is logged in
    #@problem.user = current_user || User.find_by_email(params[:email])

    if (user_signed_in? || verify_recaptcha(:model => @problem, :message => "Грешка со reCAPTCHA")) && @problem.save
      flash[:notice] = t('problems.flash.create.success')
      redirect_to @problem
    else
      render :action => :new
    end
  end
end
