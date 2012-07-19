require 'csv'

class Array
  # Public: Converts array of hashes to csv format.
  #
  # options     - A Hash with conversion settings.
  # csv_options - A Hash with csv builder options.
  #
  # Usage
  #
  #   list = [{:foo => 1, :bar => 2}, {:foo => 3, :bar => 4}]
  #   list.to_csv # => "foo,bar\n1,2\n3,4\n"
  #   list.to_csv(:headers => false) # => "1,2\n3,4\n"
  #
  # Returns a string with csv data.
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
