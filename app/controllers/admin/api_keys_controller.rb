class Admin::ApiKeysController < Admin::BaseController

  # Inherited Resources
  inherit_resources

  # Respond type
  respond_to :html

  def index
    @api_keys = ApiKey.paginate :all, :order => "name ASC",
                                :per_page => 10, :page => params[:page]
  end
end
