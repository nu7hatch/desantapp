module Airstrip
  module Admin
    # Public: Fetches paginated list of referring websites.
    class CountriesPresenter < Struct.new(:page)
      # Public: Default operation. Returns list of countries with number 
      # of users from there.
      def call
        { :countries => mapped_countries, :total_count => total_count }
      end

      # Public: Returns countries related data formatted for d3's
      # mercator graph.
      def mercator_data
        data = countries.all.inject({}) do |res, x| 
          res[x.country] = x.users_count
          res
        end
        
        { :total_count => total_count, :data => data }
      end

      # Public: Returns list of re-mapped signup attributes.
      def mapped_countries
        sn = 0

        ordered_countries.page(page).map do |x|
          current = ((page || 1).to_i - 1)
          id = current * Kaminari.config.default_per_page + (sn += 1)
          x.attributes.pick(*columns_to_show).merge('id' => id)
        end
      end

      # Public: Returns total count of the countries.
      def total_count
        @total_count ||= countries.count.keys.size
      end

      # Public: Returns list of countries ordered by the number of
      # users from there.
      def ordered_countries
        countries.order('users_count DESC')
      end

      # Public: Raw list of countries.
      def countries
        @countries ||= Signup.countries
      end

      # Internal: List of columns to be loaded and displayed.
      def columns_to_show
        %w(country users_count)
      end
    end
  end
end
