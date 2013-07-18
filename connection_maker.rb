require 'mysql2'

con =  Mysql2::Client.new(:host=>"localhost",:user=>"tushar",:password=>"samael321",:database=>"Chat_test")

#def make_conn  
	until false
		x = con.query("select name from users;").to_a
		if x.length < 2
			#puts "here\n"
			sleep 0.5
			next
		else
			puts x
			#puts "over here\n"
			user1 = x.sample
			#puts user1["name"]
			#puts user1.class
			puts x.class
			x = x - [user1]
			user2 = x.sample
			puts "connection formed between #{user1["name"]} and #{user2["name"]}"
			con.query("insert into connections (user1 , user2) values (\"#{user1["name"]}\",\"#{user2["name"]}\");")
			con.query("insert into connections (user1 , user2) values (\"#{user2["name"]}\",\"#{user1["name"]}\");")
			con.query("delete from users where name=\"#{user1["name"]}\" or name = \"#{user2["name"]}\"")
		end
	end
	
#end
	
#make_conn
