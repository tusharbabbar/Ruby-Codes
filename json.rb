require 'json'
x = %x[ls ~/Desktop/backuplogo750updated/].split("\n")

x.shuffle!
x.each_with_index do |m,i|
	x[i]=m.gsub(".jpg","")
end
feed = []
randletters = "aeiourtsdmn"
i=3
x.each_slice(10) do |a|
	images = []
	puts a.class
	a.each_with_index do |m,n|
		split = m.index("_")
		if split == nil then split = 0 end
		b = m.downcase.gsub("_","")
		if b.length < 12 
			x = 12-b.length
			b = b + randletters[0..(x-1)]
		end
		key = b
		level = i*10 +  n
		hash = {:answer=>m.downcase.gsub("_",""),:answer_keys=>key,:sub_level=>level,:split_after=>split.to_s,:url=>"http://backend.xingaad.com/lqz/image?name=#{m}"}
		images << hash
	end
	hash = {:main_level=>i,:images=>images}
	feed << hash
	i = i+1
end

hash = {:feed => feed}
puts hash.to_json

File.open("lqz_levels.json",'w').write(hash.to_json)
