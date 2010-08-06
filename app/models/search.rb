class Search
  attr_accessor :q, :category_id, :municipality_id

  def initialize(params = {})
    @conditions = []
    @parameters = {}

    if params
      params.each_pair do |attr, value|
        if attr.match(/_id/) && value.present?
          instance_variable_set "@#{attr}", value.to_i
        else
          instance_variable_set "@#{attr}", value
        end
      end
    end
  end

  def results(options)
    if @q.present?
      @conditions << "problems.description LIKE :q"
      @parameters[:q] = "%#{@q}%"
    end

    if @category_id.present?
      @conditions << "problems.category_id = :category_id"
      @parameters[:category_id] = @category_id
    end

    if @municipality_id.present?
      @conditions << "problems.municipality_id = :municipality_id"
      @parameters[:municipality_id] = @municipality_id
    end

    Problem.paginate :per_page => options[:per_page], :page => options[:page], :conditions => [@conditions.join(" AND "), @parameters], :order => "id DESC"
  end
end
