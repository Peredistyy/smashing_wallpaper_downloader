# frozen_string_literal: true

module Service
  class Downloader
    DIR_NAME = "wallpapers"

    def download_links(links)
      create_dir
      links.each do |link|
        downloaded_file_name = download_link(link)
        yield(downloaded_file_name) if block_given?
      end
    end

    private

    def download_link(link)
      file_name = link.split("/").last
      File.open("#{DIR_NAME}/#{file_name}", "wb") do |file|
        URI.parse(link).open { |uri| file.write(uri.read) }
      end

      file_name
    end

    def create_dir
      Dir.mkdir(DIR_NAME) unless Dir.exist?(DIR_NAME)
    end
  end
end
