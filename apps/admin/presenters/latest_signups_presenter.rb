module Airstrip
  module Admin
    # Public: Fetches paginated list of latest signup entries.
    class LatestSignupsPresenter < Struct.new(:page)
      # Public: Default operation.
      #
      # page - An Integer page number.
      #
      # Returns list of latest signups.
      def call
        signups.map { |x| x.attributes.pick(*columns_to_show) }
      end

      # Public: Raw list of latest signups.
      def signups
        @signups ||= Signup.latest.page(page)
      end

      # Internal: List of columns to be loaded and displayed.
      def columns_to_show
        %w(id email ip_address referrer created_at)
      end
    end
  end
end
