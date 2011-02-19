class ProblemsByCategory
  include Generators::Simple

  def first_column
    'Category'
  end

  private
    def fetch_data
      Problem.find(:all,
                   :select => 'categories.name AS name,
                               COUNT(problems.category_id) AS amount',
                   :joins => :category,
                   :group => 'categories.id'
                   )
    end
end
