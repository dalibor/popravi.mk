class Admin::ProblemsController < Admin::BaseController

  inherit_resources
  respond_to :html

  def index
    @problems = Problem.includes([:category, :municipality, :user]).
                        filter(params[:filter]).
                        ordered.
                        paginate(:per_page => 10, :page => params[:page])
  end

  def create
    @problem = Problem.new(params[:problem], without_protection: true)
    create!
  end

  def update
    @problem = Problem.find(params[:id])

    if @problem.update_attributes(params[:problem], :without_protection => true)
      flash[:notice] = "Problem was successfully updated"
      redirect_to admin_problem_url(@problem)
    else
      render :edit
    end
  end

  def sent
    Problem.send_problems!
    redirect_to admin_problems_path,
      :notice => "Problems were successfullly sent to municipalities"
  end
end
