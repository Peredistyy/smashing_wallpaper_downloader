# frozen_string_literal: true

require "./lib/helper/calendar"

module Service
  module Scraper
    class Smashingmagazine
      URL = "https://www.smashingmagazine.com"

      def links(year, month, resolution)
        response = connection.get(prepare_uri(year, month))

        links =
          Nokogiri::HTML(response.body)
            .css("a")
            .select { |tag| tag.text == resolution }
            .map { |tag| tag["href"] }

        no_calendar_filter(links)
      end

      private

      def no_calendar_filter(links)
        links.select { |link| link.include?("/nocal/") }
      end

      def prepare_uri(year, month)
        current_month = DateTime.new(year.to_i, month.to_i, 1, 0, 0, 0)
        prev_month = current_month.prev_month

        month_in_word = calendar_helper.month_in_word(current_month.month.to_i)
        month = calendar_helper.month_with_front_zero(prev_month.month.to_i)

        "/#{prev_month.year}/#{month}/desktop-wallpaper-calendars-#{month_in_word}-#{year}/"
      end

      def calendar_helper
        @calendar_helper ||= Helper::Calendar.new
      end

      def connection
        @connection ||= Faraday.new(url: URL) do |faraday|
          faraday.request(:url_encoded)
          faraday.adapter(Faraday.default_adapter)
        end
      end
    end
  end
end
