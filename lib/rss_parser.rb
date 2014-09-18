require 'rss'

class RSSParser

  def self.parse(rss_content)
    RSS::Parser.parse(rss_content)
  end

end
