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
    [:c, :m, :month, :year, :s].detect{ |key| params[key].present? }
  end
end
