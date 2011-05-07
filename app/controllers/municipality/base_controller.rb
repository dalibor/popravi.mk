class Municipality::BaseController < ApplicationController

  # Layout
  layout "municipality"

  private
    def load_municipality
      @municipality = Municipality.find_by_slug(params[:municipality_id] || params[:id])
    end
end
