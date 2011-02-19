module Generators::Simple

  def initialize
    @data = fetch_data
  end

  def records
    @row_names ||= @data
  end

  def to_csv
    @csv = FasterCSV.generate do |csv|
      csv << [nil, 'Amount']
      records.each do |record|
        csv << [record.name, record.amount]
      end
    end

    @csv
  end

  def to_json
    headers = [['string', first_column], ['number', 'Amount']]

    rows = []
    records.each do |record|
      rows << [record.name.to_s, record.amount.to_i]
    end

    {:headers => headers, :rows => rows}.to_json
  end
end
