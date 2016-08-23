require 'json'

def words(file)
  frequency = Hash.new(0)
  input_file = File.open(file, 'r')
  output_file = File.open("#{file}frequency.txt", 'w')
  input_file.read.downcase.scan(/\b[a-z]{3,16}\b/) {|word| frequency[word] = frequency[word] + 1}
  frequency.keys.sort.each{|key| output_file.print key,' => ',frequency[key], "\n"}
  return frequency
end

def json(data, filename)
  sorted = data.sort_by {|_key, value| value}.reverse.to_h
  final_data = sorted.to_json
  File.open("#{filename}.json","w") do |f|
    f.write(final_data)
  end
end
