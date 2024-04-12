# frozen_string_literal: true

require_relative "../../spec_helper"

RSpec.describe(Service::Scraper::Smashingmagazine) do
  let(:service) { described_class.new }

  describe "links" do
    before do
      stub_request(:get, "https://www.smashingmagazine.com/2018/02/desktop-wallpaper-calendars-march-2018/")
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent" => "Faraday v2.9.0",
          },
        )
        .to_return(
          status: 200,
          body: File.read("#{File.dirname(__FILE__)}/../../fixtures/smashingmagazine.html"),
          headers: {
            "Content-Type" => "text/html; charset=UTF-8",
          },
        )
    end

    let(:expected_links) do
      [
        "https://smashingmagazine.com/files/wallpapers/mar-18/peaceful-wave/nocal/mar-18-peaceful-wave-nocal-640x480.png",
        "https://smashingmagazine.com/files/wallpapers/mar-18/starman/nocal/mar-18-starman-nocal-640x480.jpg",
        "https://smashingmagazine.com/files/wallpapers/mar-18/galaxy-glimpse/nocal/mar-18-galaxy-glimpse-nocal-640x480.jpg",
        "https://smashingmagazine.com/files/wallpapers/mar-18/underexplored/nocal/mar-18-underexplored-nocal-640x480.png",
        "https://smashingmagazine.com/files/wallpapers/mar-18/imagine/nocal/mar-18-imagine-nocal-640x480.jpg",
        "https://smashingmagazine.com/files/wallpapers/mar-18/passport/nocal/mar-18-passport-nocal-640x480.png",
        "https://smashingmagazine.com/files/wallpapers/mar-18/the-unknown/nocal/mar-18-the-unknown-nocal-640x480.jpg",
        "https://smashingmagazine.com/files/wallpapers/mar-18/live-to-the-fullest/nocal/mar-18-live-to-the-fullest-nocal-640x480.png",
      ]
    end

    it "success" do
      expect(service.links("2018", "03", "640x480")).to(eq(expected_links))
    end
  end
end
