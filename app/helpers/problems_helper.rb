module ProblemsHelper
  extend ActiveSupport::Memoizable

  def get_month_names
    months = []

    t('date.month_names')[1..-1].each_with_index do |month, index|
      months << [month, index + 1]
    end

    months
  end

  def advanced_search
    params[:c].present? || params[:m].present? || params[:month].present? || 
      params[:year].present? || params[:s].present?
  end
  memoize :advanced_search
end
