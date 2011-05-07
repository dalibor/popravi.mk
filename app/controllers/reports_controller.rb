class ReportsController < ApplicationController

  def show
    prepare_report(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @report.to_json }
    end
  end

  private
    def prepare_report(id)
      case params[:id]
      when 'category'
        @title = t('charts.category_title')
        @report = ProblemsByCategory.new
      when 'municipality'
        @title = t('charts.municipality_title')
        @report = ProblemsByMunicipality.new
      when 'status'
        @title = t('charts.status_title')
        @report = ProblemsByStatus.new
      else
        raise "Invalid type #{params[:id]}".to_yaml
      end
    end
end
