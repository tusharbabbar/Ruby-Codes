require 'open-uri'
require 'json'
file = File.open("temp",'r')
name = file.first.gsub("\n","")
x = file.read.split("\n")
out = File.open("#{name}",'w')

x.each do |y|
	json = JSON.parse(open("https://gdata.youtube.com/feeds/api/users/#{y}?v=2.0&alt=json").read)
	count = json["entry"]["yt$statistics"]["subscriberCount"]
	id = json["entry"]["author"].first["yt$userId"]["$t"]
	url = json["entry"]["media$thumbnail"]["url"]
	title = json["entry"]["yt$username"]["$t"]
	string = count+"|"+id+"|"+url+"|"+title+"\n"
	out.write(string)
end

