class ProblemsByMunicipality
  include Generators::Simple

  def first_column
    'Municipality'
  end

  private
    def fetch_data
      Problem.find(:all,
                   :select => 'municipalities.name AS name,
                               COUNT(problems.municipality_id) AS amount',
                   :joins => :municipality,
                   :group => 'municipalities.id'
                   )
    end
end
