# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe(Helper::Calendar) do
  let(:helper) { described_class.new }

  describe "month_in_word" do
    let(:number) { Faker::Number.between(from: 1, to: 12) }

    it "success" do
      expect(helper.month_in_word(number)).to(eq(Helper::Calendar::MONTHS[number - 1]))
    end

    it "fail" do
      expect { helper.month_in_word(13) }.to(raise_error(ArgumentError, "Wrong month number."))
    end
  end

  describe "month_with_front_zero" do
    it "success (need add front zero)" do
      expect(helper.month_with_front_zero(1)).to(eq("01"))
    end

    it "success (without front zero)" do
      expect(helper.month_with_front_zero(11)).to(eq("11"))
    end
  end
end
