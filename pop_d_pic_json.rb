require 'json'
lists = []

(0..7).each do |i|
	x = %x[ls "POP_D_PIC/#{i}"]
	lists << x.split("\n")
end
	
lists.each_with_index do |l,i|
	l.shuffle!
	a = l[0..7]
	b = l[8..19]
	c = l[20..35]
	d = l[36..55]
	lists[i] = [a,b,c,d]
end
lists[7].pop
feed= []
cat = []
randletters = "aeiourtsdmn"
main_level = 0
sub_level = 0
lists.each_with_index do |list,i|
	cat_id = i
	cat_data = []
	list.each do |l|
 		images = []
		puts l.class
		l.each_with_index do |m,n|
			m = m.downcase
			split = m.index("_")
			if split == nil then split = 0 end
			b = m.gsub("_","")
			puts b
			#sleep .01
			b = b.gsub(".jpg","")
			puts b
			#sleep 1
			if b.length < 12 
			x = 12-b.length
			b = b + randletters[0..(x-1)]
			end
			key = b
			puts key
			level = sub_level
			hash = {:answer=>m.downcase.gsub("_","").gsub(".jpg",""),:answer_keys=>key,:sub_level=>level,:split_after=>split.to_s,:url=>"http://backend.xingaad.com/lqz/image?name=#{ m.gsub(".jpg","")}"}
			images << hash
			sub_level +=1
		end
		hash = {:main_level=>main_level,:images=>images}
		cat_data << hash
		main_level +=1
	end
	hash = {:cat_id=>cat_id,:cat_data=>cat_data}	
	feed << hash 
end
hash = {:feed=>feed}
hash  = hash.to_json

puts hash

File.open('newest.json','w').write(hash)
