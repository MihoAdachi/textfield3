class Youtube < ActiveResource::Base
  # attr_accessible :title, :body

  self.site = "http://gdata.youtube.com"

  class Format
    include ActiveResource::Formats::JsonFormat
    def decode(json)
      super(json.gsub("$","_"))
    end
  end

  self.format = Format.new

  def self.videos(search_word)
    self.find(:one, from: "/feeds/api/videos", params: { q: search_word , :"max-results" => 3, alt: "json"} )
  end
end
