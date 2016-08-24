require 'feedjira'

def parser(url)

  if url.to_s.include?("www")
    url
  else
    base = url.to_s.split("//").last
    url =  "http://www.#{base}"
  end

  feed = Feedjira::Feed.fetch_and_parse url
  entries = feed.entries

   entries.each do |entry|
    doc   = Nokogiri::HTML(entry.content)
    @text = doc.xpath("//text()").to_s
    end
    @textarray = @text.split(" ")
    @stopwords = []
    f = File.open("stopwords.txt")
    f.each_line {|l| @stopwords << l.chomp}
    words = @textarray.reject {|e| @stopwords.include? e}

  begin
    fname = url.to_s.split(".")[1]
    Dir.mkdir(fname.upcase) unless Dir.exists?(fname.upcase)
    file  = File.open(fname, "w+")
    file.write(words)
  rescue IOError => e
    #some error occur, dir not writable etc.
  ensure
    file.close unless file.nil?
  end

  return fname
end
