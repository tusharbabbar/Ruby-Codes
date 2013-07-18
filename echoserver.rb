require 'eventmachine'

module EchoServer
	def post_init
		puts "someone got here!!!"
	end
		
	def receive_data data
		send_data ">>>yousent: #{data}"
		close_connection if data =~ /quit/i
	end
	
	def unbind 
		puts "-- someone disconnected from server!"
	end
end

EventMachine.run {
		EventMachine.start_server "127.0.0.1", 8081, EchoServer
	}
