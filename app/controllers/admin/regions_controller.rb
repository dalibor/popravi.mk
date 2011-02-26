class Admin::RegionsController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @regions = Region.includes(:country).
                      paginate :all, :per_page => 10, :page => params[:page]
  end
end
