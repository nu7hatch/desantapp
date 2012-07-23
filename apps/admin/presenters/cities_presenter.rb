module Desant
  module Admin
    # Public: Fetches paginated list of referring websites.
    class CitiesPresenter < Struct.new(:page)
      # Public: Default operation. Returns list of cities with number 
      # of users from there.
      def call
        { :cities => mapped_cities, :total_count => total_count }
      end

      # Public: Returns cities related data formatted for d3's
      # mercator graph.
      def mercator_data
        data = nearby_cities.inject({}) do |res, x|
          res[x.city] = x.attributes.pick('lat', 'lon', 'users_count')
          res
        end

        { :total_count => total_count, :data => data }
      end

      # Public: Returns list of re-mapped signup attributes.
      def mapped_cities
        sn = 0

        ordered_cities.page(page).map do |x|
          current = ((page || 1).to_i - 1)
          id = current * Kaminari.config.default_per_page + (sn += 1)
          x.attributes.pick(*columns_to_show).merge('id' => id)
        end
      end

      # Public: Returns list of grouped nearby cities with number
      # of users from there.
      def nearby_cities
        @nearby_cities ||= Signup.nearby_cities
      end

      # Public: Returns total count of the cities.
      def total_count
        @total_count ||= cities.count.keys.size
      end

      # Public: Returns list of cities ordered by the number of
      # users from there.
      def ordered_cities
        cities.order('users_count DESC')
      end

      # Public: Raw list of cities.
      def cities
        @cities ||= Signup.cities
      end

      # Internal: List of columns to be loaded and displayed.
      def columns_to_show
        %w(city country users_count)
      end
    end
  end
end
