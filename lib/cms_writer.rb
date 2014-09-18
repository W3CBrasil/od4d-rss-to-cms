require 'htmlentities'
require 'pg'

class CMSWriter

  def initialize
    @conn = PG.connect(
        :host => 'localhost',
        :dbname => 'od4d',
        :user => 'od4d',
        :password => 'od4dpass')
  end

  def write(rss_item)
    add_post(rss_item.title, rss_item.dc_creator, rss_item.pubDate.iso8601, rss_item.content_encoded)
  end

  private
  def add_post(title, author, pub_date, content)
    query = "
      INSERT INTO posts (title, author, pub_date, content)
      VALUES ('#{title}','#{author}', '#{pub_date}', '#{@conn.escape_string(content)}')
    "
    @conn.exec(query)
  end

end
