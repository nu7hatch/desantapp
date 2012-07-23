module Desant
  module Admin
    # Public: Fetches paginated list of latest signup entries.
    class LatestSignupsPresenter < Struct.new(:page)
      # Public: Default operation. Returns list of latest signups.
      def call
        { :signups => mapped_signups, :total_count => total_count }
      end

      # Public: Returns list of re-mapped signup attributes.
      def mapped_signups
        signups = page ? self.signups.page(page) : self.signups
        signups.map { |x| x.attributes.pick(*columns_to_show) }
      end

      # Public: Returns total count of users signed up.
      def total_count
        @total_count ||= Signup.count
      end

      # Public: Raw list of latest signups.
      def signups
        @signups ||= Signup.latest
      end

      # Internal: List of columns to be loaded and displayed.
      def columns_to_show
        %w(id email ip_address referer city country created_at)
      end
    end
  end
end
