require 'json'
require 'open-uri'

rows = File.open("programmes.csv").readlines

count = 0

rows.slice(1, rows.length).each do |row|
  disk_reference = row.split(",").first
  url            = "http://search.bbcsnippets.co.uk/api/search?disk_reference=#{disk_reference}"
  raw_response   = open(url)
  data           = JSON.parse(raw_response.read)

  if !data["results"].empty? && (data["results"][0]["pips_programme"].nil? || data["results"][0]["pips_programme"]["pid"].nil?)
    count += 1
    puts disk_reference
  elsif !data["results"].empty?
    puts data["results"][0]["pips_programme"]["pid"]
  end

end

p count