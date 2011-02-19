class ProblemsByStatus
  include Generators::Simple

  def first_column
    'Status'
  end

  private
    def fetch_data
      Problem.find(:all,
                   :select => 'problems.status AS name,
                               COUNT(problems.status) AS amount',
                   :group => 'problems.status'
                   )
    end
end
