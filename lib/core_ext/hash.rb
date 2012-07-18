module CoreExt
  module Hash
    # Public: Returns new hash composed only from specified keys.
    #
    # keys - An Array of keys to be picked up.
    #
    # Returns new hash.
    def pick(*keys)
      {}.tap do |result|
        keys.each { |k| result[k] = self[k] }
      end
    end
  end
end

class Hash
  include CoreExt::Hash
end
