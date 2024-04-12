# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe(Service::Downloader) do
  let(:service) { described_class.new }

  describe "download_links" do
    before do
      stub_request(:get, "https://smashingmagazine.com/files/wallpapers/mar-18/peaceful-wave/nocal/mar-18-peaceful-wave-nocal-640x480.png")
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent" => "Ruby",
          },
        )
        .to_return(
          status: 200,
          body: File.read("#{File.dirname(__FILE__)}/../fixtures/mar-18-peaceful-wave-nocal-640x480.png"),
          headers: {
            "Content-Length" => 136114,
            "Content-Type" => "image/png",
          },
        )
    end

    let(:links) do
      [
        "https://smashingmagazine.com/files/wallpapers/mar-18/peaceful-wave/nocal/mar-18-peaceful-wave-nocal-640x480.png",
      ]
    end

    let(:expected_downloaded_file_name) { "mar-18-peaceful-wave-nocal-640x480.png" }

    it "success" do
      current_downloaded_file_name = nil
      service.download_links(links) { |downloaded_file_name| current_downloaded_file_name = downloaded_file_name }

      expect(current_downloaded_file_name).to(eq(expected_downloaded_file_name))
    end
  end
end
