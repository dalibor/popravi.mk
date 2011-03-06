class User::ProblemsController < User::BaseController

  def index
    @problems = current_user.problems.
      order("id DESC").
      includes([:municipality, :category]).
      paginate :per_page => 10, :page => params[:page]
    @potentially_reported_problems = current_user.potentially_reported_problems
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem            = Problem.find(params[:id])
    @problem.attributes = params[:problem]
    @problem.user       = current_user

    if @problem.save
      flash[:notice] = t('problems.flash.update.success')
      redirect_to @problem
    else
      render :action => :new
    end
  end

  # TODO: deprecate, by default assign problems to this user
  def take_ownership
    problems = Problem.find(params[:problem_ids].keys)
    current_user.take_ownership_of_problems(problems)
    redirect_to user_problems_url
  end
end
