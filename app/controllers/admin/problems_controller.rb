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
    create! do |success, failure|
      success.html { redirect_to admin_problems_url, :notice => "Problem was successfully created" }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to admin_problems_url, :notice => "Problem was successfully updated"}
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_problems_url }
    end
  end

  def sent
    Problem.send_problems!
    redirect_to admin_problems_path, :notice => "Problems were successfullly sent to municipalities"
  end
end
