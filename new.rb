json.each_with_index do |hash,i|
 images = hash["images"]
i = i+3
 %x[mkdir "#{i}"]
images.each do |image|
url = image["url"]
name = image["answer"]
File.open("#{i}/#{name}.jpg",'w') do |f|
f.write(open(url).read)
end
end
end

