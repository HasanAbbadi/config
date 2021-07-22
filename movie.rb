require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'cli/ui'

print "Search: "
input = gets
if (input.chomp === ":q") then abort("exit") end
search_query = input.gsub(" ", "+")
search_url = "https://s3.dotcima.com/?s=" + search_query

CLI::UI::StdoutRouter.enable
CLI::UI.frame_style = :bracket

url = ""  
titles_dict = {}
links_dict = {}

CLI::UI::Spinner.spin('Fetching...') do |spinner|
  url = URI.open("#{search_url}")
  response = Nokogiri::HTML(url)
  num = 0
  response.css("div.title").each do |title|
    titles_dict[num] = title.text.strip
    num += 2
  end
  
  num = 1
  links = response.css("div > a").each do |link|
    titles_dict[num] = link['href']
    num += 2
  end
end

mything = ""

i = 0
CLI::UI::Prompt.ask('Pick a movie/show:') do |handler|
  while i < titles_dict.length
    handler.option("#{titles_dict[i]}") {|selection| mything = titles_dict.values.select {|x| x.include? selection }}
    i += 2
  end
end

myKey = ""

titles_dict.each do |key, value|
  if value == mything[0] then
    myKey = key
  end
end

myUrl = titles_dict[myKey + 3]

url = URI.open("#{myUrl}")
response = Nokogiri::HTML(url)
myTitle =  response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.title.h1.m-0").text
myRating = response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.supSpan.mt-2 > span").text
myCategory = response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.supSpan.mt-2 > span:nth-child(1) > a").text
mySynopsis = response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.streamDesc.mt-2 > p").text.strip

CLI::UI::Frame.open("#{myCategory}", frame_style: :box, timing: false) do
  CLI::UI::Frame.open('Title:', color: :green, timing: false) {puts "#{myTitle}"}
  CLI::UI::Frame.open('Rating:', color: :yellow, timing: false) {puts "#{myRating} / 10"}
  CLI::UI::Frame.open('Synopsis:', color: :magenta, timing: false) {puts "#{mySynopsis}"}
end

myEp = {}
i = 0

seasons = {}
CLI::UI::Spinner.spin('Fetching...') do |spinner|
  num = 0
  response.css(".quality").each do |title|
    seasons[num] = title.text.strip
    num += 2
  end
  
  num = 1
  links = response.css("#allBlocks > div > div > a").each do |link|
    seasons[num] = link['href']
    num += 2
  end
end

mything = ""
myKey = ""

if myUrl.include? "series" then
  main_title = response.css(".h4").text
  CLI::UI::Frame.open("#{main_title}", color: :green, timing:false) {
    i = 0
    CLI::UI::Prompt.ask('Pick a season:') do |handler|
      while i < seasons.length
        handler.option("#{seasons[i]}") {|selection| mything = seasons.values.select {|x| x.include? selection }}
        i += 2
      end
    end
  
  seasons.each do |key, value|
    if value == mything[0] then
      myKey = key
    end
  end
  
    }
end

season = myUrl
if myUrl.include? "series" then season = seasons[myKey.to_i + 1] end

url = URI.open("#{season}")
response = Nokogiri::HTML(url)

if season.include? "season" then
  i = 0
  response.css(".quality").each do |ep|
    myEp[i] = ep.text.strip
    i += 2
  end
  i = 1
  response.css("#allBlocks > div > div > a").each do |link|
    myEp[i] = link['href']
    i += 2
  end

  i = 0
  main_title = response.css(".h4").text
  CLI::UI::Frame.open("#{main_title}", color: :cyan, timing:false) {
    CLI::UI::Prompt.ask("Pick an episode") do |handler|
      while i < myEp.length 
        handler.option("#{myEp[i]}") {|selection| mything = myEp.values.select {|x| x.include? selection }}
        i += 2
      end
    end

    myEp.each do |key, value|
      if value == mything[0] then
        myKey = key
      end
    end
    epURL = myEp[myKey + 1]

    url = URI.open("#{epURL}")
    response = Nokogiri::HTML(url)
  }
end

myServers_dict = {}
i = 0

CLI::UI::Spinner.spin('Loading Servers') do
  response.css("body > div.streamBox > div > div.position-relative > div.wServers > a").each do |server|
    myServers_dict[i] = server['data-href'].gsub("embed-", "")
    i += 1
  end
end

myServers_names = {}
i = 0

while i < myServers_dict.length do
  server_name = URI.parse(myServers_dict.values[i]).host
  myServers_names[i] = server_name.gsub("www.", "").split(".")[0]
  i += 1 
end

myServer = ""
i = 0
CLI::UI::Prompt.ask('Pick a server:') do |handler|
  while i < myServers_names.length
    handler.option("#{myServers_names[i]}") {|selection| myServer = myServers_dict.values.select {|x| x.include?(selection)}[0]}
    i += 1
  end
end

# dynamically scraping
require 'watir'
require 'webdrivers'

url = URI.open("#{myServer}")
response = Nokogiri::HTML(url)

link = ''
if myServer.include? "youdbox"
  video = response.css("#embedlinks > div > div > div.box.visible > div > textarea").text
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  CLI::UI::Spinner.spin('Scraping using a headless browser (this can take up to a minute).') do
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto "#{video}"
    browser.wait
    link = browser.element(id: 'vjsplayer_html5_api').html.split("\"")[9]
    browser.close
  end
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  puts "#{(ending - starting).to_s[0..4]}s Elapsed!"
else
  puts "#{myServer}"
end

CLI::UI::Spinner.spin('Playing in mpv...') do
  system "mpv '#{link}'"
end

#-- ✔️  TV Series-
#TODO All the Other servers
#TODO word? character? wrap for synopsis
#TODO check if one can change the quality
