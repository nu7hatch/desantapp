require 'csv'

class Array
  def to_csv(options = {}, csv_options = {})
    return '' if empty?

    options = { :headers => true }.merge(options)
    columns = first.to_hash.keys.sort
    
    return '' if columns.empty?

    CSV.generate(csv_options) do |csv|
      csv << columns if !!options[:headers]
      each { |item| csv << columns.map { |column| item[column] } }
    end
  end
end
