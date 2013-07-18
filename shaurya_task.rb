if !(ARGV.length == 1)
	puts "please enter the correct path for the directory!!!"
	puts "usage: ruby shaurya_task.rb <directory_absolute_path>"
	exit(0)
end


def dir_recurser(p,r)
	p = p.gsub("//","/")
        list = %x[ls -l "#{p}"].split("\n")
	list.delete(list.first)   
	list.each do |x|
                (r*4).times {print "-"}
                x = x.split(" ")
                type = x.first
                name = x.last
		puts x.last
                if type[0] == "d"
			dir_recurser((p+"/"+x.last),r+1)
		end
	end	
end

path = ARGV[0]
#puts path
if !(path[path.length-1]=="/")
	path = path+"/"
end

x = %x[if test -d "#{path}"; then echo 1; fi].to_i
if x ==1 then 
	puts path
	dir_recurser(path,1)
end

