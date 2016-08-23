require "httparty"
require 'nokogiri'
require 'open-uri'

def checker(url)
  unless url.include?("http://")
    url = "http://#{url}"
  end
  response = HTTParty.get(url)
  if response.code == 200
   url
  else
    response.code
  end
end

def get_body(url)
 doc = Nokogiri::HTML(open(url))
end

def find_rss(doc)
  rss = []
  doc.xpath('//link/@href | //a/@href | //link[@type="application/rss+xml"]//@href').each do |node|
    if node.text.include?("rss") || node.text.include?("feed")
      rss << node.text
    end
  end
  return rss.first
end

def check_content(rss)
 response = HTTParty.get(rss)
 if response.headers["content-type"].split(";").first == "application/xml"
   rss
 else
  puts "#{response.headers["content-type"]} is not supported"
 end
end
