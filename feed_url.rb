require 'nokogiri'
require 'net/http'
require 'net/https'
require 'uri'

def rss_search(url)
  if url.include?("rss" || "xml" || "feed")
    url
  else
  if url.include?('http')
    url
  else
    url = "http://#{url}"
  end
  uri = URI(url)
  res = Net::HTTP.get_response(uri)

  case res
    when Net::HTTPSuccess then
      res
    when Net::HTTPRedirection then
      location = res['location']
      uri = uri + location
      res = Net::HTTP.get_response(uri)
    else
      res.value
  end

  @doc = Nokogiri::HTML(res.body)
  @rss = []
  @doc.xpath('//link/@href | //a/@href | //link[@type="application/rss+xml"]//@href').each do |node|
    if node.text.include?("rss")
      @rss << node.text
    else
      if  node.text.include?("feed")
        @rss << node.text
      end
    end
  end

  if @rss.count > 0
    @url_list = []
    @success_url = []
    @rss.each do |test|
      if  test.include?("http")
        url = URI(test)
        response = Net::HTTP.get_response(url)
        case response
          when Net::HTTPSuccess then
            if response['content-type'].include?("xml")
              @url_list <<  test
            end
          when Net::HTTPRedirection then
            location = res['location']
            url = url + location
            r = Net::HTTP.get_response(url)
            if r['content-type'].include?("xml")
              @url_list <<  test
            end
        end
      else
        @url_list <<  uri + test
        @url_list.each do |success|
          u = URI(success)
          re = Net::HTTP.get_response(u)
          case re
            when Net::HTTPSuccess then
              if re['content-type'].include?("xml")
                @success_url <<  success
              end
          end
        end
      end
    end
  end
  if @url_list || @success_url == true
    @final_url = @url_list.first || @success_url.first
  end
  @final_url
end
end
