class Admin::ApiKeysController < Admin::BaseController

  inherit_resources
  respond_to :html

  def index
    @api_keys = ApiKey.ordered.paginate :per_page => 10, :page => params[:page]
  end
end
