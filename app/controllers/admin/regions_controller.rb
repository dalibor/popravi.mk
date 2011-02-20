class Admin::RegionsController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @regions = Region.paginate :all, :include => :country,
                               :per_page => 10, :page => params[:page]
  end

  def create
    create! do |success, failure|
      flash[:notice] = "Region was successfully created"
      success.html { redirect_to admin_regions_url }
    end
  end

  def update
    update! do |success, failure|
      flash[:notice] = "Region was successfully updated"
      success.html { redirect_to admin_regions_url }
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to admin_regions_url }
    end
  end
end
