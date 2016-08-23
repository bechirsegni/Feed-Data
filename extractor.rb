require 'rss'

def parser(url)
  rss = RSS::Parser.parse(url, false)
  case rss.feed_type
    when 'rss'
      begin
      object = rss.items.each { |item| item.description}
      rescue
      object = rss.items.each { |item| item.content}
    end
    when 'atom'
      begin
      object = rss.items.each { |item| item.description}
      rescue
      object = rss.items.each { |item| item.content}
      end
    end
    begin
      fname = url.split(".")[1]
      Dir.mkdir(fname.upcase) unless Dir.exists?(fname.upcase)
      file  = File.open(fname, "w+")
      file.write(object)
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file.nil?
    end

    return fname
end
