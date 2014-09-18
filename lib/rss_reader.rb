require 'open-uri'

class RSSReader

  def self.fetch_rss(rss_url)
    open(rss_url).read
  end

end
