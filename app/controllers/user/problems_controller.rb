class User::ProblemsController < User::BaseController

  def index
    @problems = current_user.problems.ordered.
                             includes([:municipality, :category]).
                             paginate :per_page => 10, :page => params[:page]
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
end
