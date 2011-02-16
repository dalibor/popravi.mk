module ProblemsHelper

  def get_month_names
    months = []

    t('date.month_names')[1..-1].each_with_index do |month, index|
      months << [month, index + 1]
    end

    months
  end
end
