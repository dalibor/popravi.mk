class ProblemsController < ApplicationController

  def index
    @problems       = Problem.search(params)
    @categories     = Category.top(10)
    @total_problems = Problem.count

    respond_to do |format|
      format.html { render :action => 'index' }
      format.rss  { render :layout => false   }
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

    if (user_signed_in? || verify_recaptcha(:model => @problem, :message => "Грешка со reCAPTCHA")) && @problem.save
      flash[:notice] = 'Проблемот е успешно пријавен.'
      redirect_to @problem
    else
      render :action => :new
    end
  end
end
