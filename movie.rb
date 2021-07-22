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
  url = URI.open(search_url)
  response = Nokogiri::HTML(url)
  num = 0
  response.css("div.title").each do |title|
    titles_dict[num] = title.text.strip
    num += 1
  end
  
  num = 0
  links = response.css("div > a").each do |link|
    links_dict[num] = link['href']
    num += 1
  end
end

mydict = {}
i = 0
CLI::UI::Prompt.ask('Pick a movie/show:') do |handler|
  while i < titles_dict.length
    handler.option("#{titles_dict[i]}") {|selection| mydict[i] = links_dict[i - 1]}
    i += 1
  end
end

url = URI.open("#{mydict.values[0]}")
response = Nokogiri::HTML(url)
myTitle =  response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.title.h1.m-0").text
myRating = response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.supSpan.mt-2 > span:nth-child(5)").text
myCategory = response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.supSpan.mt-2 > span:nth-child(1) > a").text
mySynopsis = response.css("body > div.streamHeaderInner.py-5 > div > div > div.col-xl-10 > div.streamDesc.mt-2 > p").text.strip

CLI::UI::Frame.open("#{myCategory}", frame_style: :box, timing: false) do
  CLI::UI::Frame.open('Title:', color: :green, timing: false) {puts "#{myTitle}"}
  CLI::UI::Frame.open('Rating:', color: :yellow, timing: false) {puts "#{myRating} / 10"}
  CLI::UI::Frame.open('Synopsis:', color: :magenta, timing: false) {puts "#{mySynopsis}"}
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
  puts "#{(ending - starting).to_s[0..2]}s Elapsed!"
end

CLI::UI::Spinner.spin('Playing in mpv...') do
  system "mpv '#{link}'"
end
