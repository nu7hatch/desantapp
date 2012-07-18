module Airstrip
  module Admin
    # Public: Fetches paginated list of referring websites.
    class ReferersPresenter < Struct.new(:page)
      # Public: Default operation. Returns list of referring websites 
      # with number of brought users.
      def call
        { :referers => mapped_referers, :total_count => total_count }
      end

      # Public: Returns list of re-mapped signup attributes.
      def mapped_referers
        sn = 0

        ordered_referers.page(page).map do |x|
          current = ((page || 1).to_i - 1)
          id = current * Kaminari.config.default_per_page + (sn += 1)
          x.attributes.pick(*columns_to_show).merge('id' => id)
        end
      end

      # Public: Returns total count of refering websites.
      def total_count
        @total_count ||= referers.count.keys.size
      end

      # Public: Returns list of referers ordered by the number of
      # brought users.
      def ordered_referers
        referers.order('users_count DESC')
      end

      # Public: Raw list of referers.
      def referers
        @signups ||= Signup.referers
      end

      # Internal: List of columns to be loaded and displayed.
      def columns_to_show
        %w(url users_count)
      end
    end
  end
end
