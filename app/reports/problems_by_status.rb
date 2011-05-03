class ProblemsByStatus
  include Generators::Simple

  def first_column
    'Status'
  end

  private
    def fetch_data
      problems = Problem.find(:all,
                   :select => 'problems.status AS name,
                               COUNT(problems.status) AS amount',
                   :group => 'problems.status'
                   )

      problems.each{|problem| problem.name = I18n.t("problems.statuses.#{problem.name}")}
    end
end
