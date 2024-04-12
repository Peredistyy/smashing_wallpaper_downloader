# frozen_string_literal: true

module Helper
  class Calendar
    MONTHS = [
      "january",
      "february",
      "march",
      "april",
      "may",
      "june",
      "july",
      "august",
      "september",
      "october",
      "november",
      "december",
    ].freeze

    def month_in_word(month_in_number)
      word = MONTHS.at(month_in_number - 1)

      raise ArgumentError, "Wrong month number." if word.nil?

      word
    end

    def month_with_front_zero(month_number)
      month_number < 10 ? "0#{month_number}" : month_number.to_s
    end
  end
end
