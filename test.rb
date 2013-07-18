require 'sinatra/async'
require 'mysql2'
#require 'active_record'

#$x = ActiveRecord::Base.establish_connection(
#:adapter => "mysql2",
#:host => "localhost",
#:user=> "tushar",
#:password => "samael321",
#:database => "Chat_test")

#class User < ActiveRecord::Base
#end
#class Connection < ActiveRecord::Base
#end

class Chat_test < Sinatra::Base
	register Sinatra::Async

con =  Mysql2::Client.new(:host=>"localhost",:user=>"tushar",:password=>"samael321",:database=>"Chat_test")

aget '/connect/:name' do
	name = params[:name]
	con.query("delete from connections where user1 = \"#{name}\" or user2 =\"#{name}\"")
	con.query("insert into users (name) values (\"#{name}\");")
	#Connection.where(:user1=>name).delete_all
        #Connection.where(:user2=>name).delete_all
	#user = User.create(:name => "#{name}")
	#puts user[:name]
	#puts "here"
	connect = nil
	meth = proc do 
		time = 0
		until time > 5
			puts "over here"
			#connect = Connection.where(:user1=>name).to_a
			#puts connect.length
			connect = con.query("select user2 from connections where user1 = \"#{name}\";").to_a.first 
			break if connect
			sleep 0.5
			time +=0.5
		end
	#puts "here2"
	#puts "#{name}"
	#User.destroy_all(:name=>name)
	con.query("delete from users where name=\"#{name}\";")  
	end
	callback = proc do 
			if connect.length == 0
				body { "sorry! All users busy in system!"}
			else 
				body { "\"connect_to\":\"#{connect}\""}
			end
	end
#	begin
	EM.defer( meth,callback)
#	rescue Exception => e
#		con.query("delete from users where name=\"#{name}\";")
#		puts e.message
#		puts e.backtrace.inspect
#		body { "Error : 500 \n Message : Internal Server array." }
#	else
#	$x.disconnect!
	#after do
 	 # ActiveRecord::Base.connection.close	
	#end
#	end
	
end	

end


#after do
 # ActiveRecord::Base.connection.close
#end
