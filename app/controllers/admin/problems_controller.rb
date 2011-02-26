class Admin::ProblemsController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @problems = Problem.includes([:category, :municipality, :user]).
                        filter(params[:filter]).
                        order("id DESC").
                        paginate(:per_page => 10, :page => params[:page])
  end

  def create
    @problem = Problem.new(params[:problem])
    @problem.official_notes = params[:problem][:official_notes] if params[:problem]
    create!
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.official_notes = params[:problem][:official_notes] if params[:problem]
    update!
  end

  def sent
    Problem.send_problems!
    redirect_to admin_problems_path,
      :notice => "Problems were successfullly sent to municipalities"
  end
end
