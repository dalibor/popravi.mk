class Api::V2::MunicipalitiesController < Api::V2::BaseController

  def index
    municipalities = Municipality.find(:all, :select => "id, name", :order => "name ASC")

    @municipalities = []
    municipalities.each { |municipality|
      @municipalities << {:id => municipality.id, :name => municipality.name} }

    render_json(@municipalities)
  end
end
