class Moderator::ProblemsController < Moderator::BaseController
  before_filter :load_municipality
  before_filter :load_problem, :except => :index

  def index
    @problems = @municipality.problems.includes([:category, :municipality, :user]).
                        order("id DESC").
                        paginate(:per_page => 10, :page => params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if params[:problem]
      @problem.official_notes = params[:problem][:official_notes]
      @problem.status         = params[:problem][:status]
      @problem.last_editor    = current_user
    end

    if @problem.save
      redirect_to moderator_problem_path(@problem),
        :notice => "Problem was successfully updated."
    else
      render :edit
    end
  end

  def approve
    @problem.last_editor = current_user
    @problem.approve!
    redirect_to :back, :notice => 'Problem was successfully approved.'
  end

  def activate
    @problem.last_editor = current_user
    @problem.activate!
    redirect_to :back, :notice => 'Problem was successfully activated.'
  end

  def solve
    @problem.last_editor = current_user
    @problem.solve!
    redirect_to :back, :notice => 'Problem was successfully solved.'
  end

  def invalidate
    @problem.last_editor = current_user
    @problem.invalidate!
    redirect_to :back, :notice => 'Problem was successfully invalidated.'
  end

  private

    def load_municipality
      @municipality = current_user.municipality
    end

    def load_problem
      @problem = @municipality.problems.find(params[:id])
    end
end
