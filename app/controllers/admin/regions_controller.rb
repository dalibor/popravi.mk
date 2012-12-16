class Admin::RegionsController < Admin::BaseController

  inherit_resources
  respond_to :html

  def index
    @regions = Region.includes(:country).
                      paginate :per_page => 10, :page => params[:page]
  end
end
