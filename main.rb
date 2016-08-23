#The Application takes an url of a website and search for the rss feed link DONE
#The Application takes the rss feed link and extract the tittle and the body and store them in objects
#The Application takes the objects and extract each words and count how many each word are used
#The Application takes the data and create a chart based on the results

require_relative 'feed_url'
require_relative 'extractor'
require_relative 'count'



var  = checker("vox.com")
doc  = get_body(var)
rss  = find_rss(doc)
feed = check_content(rss)
file = parser(feed)
path = words(file)
json(path, file)
