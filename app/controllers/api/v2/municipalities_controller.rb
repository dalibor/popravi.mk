class Api::V2::MunicipalitiesController < ApplicationController

  def index
    municipalities = Municipality.find(:all, :select => "id, name", :order => "name ASC")

    @municipalities = []
    municipalities.each { |municipality| @municipalities << {:id => municipality.id, :name => municipality.name} }

    respond_to do |format|
      format.json { render :json => @municipalities.to_json }
    end
  end
end
