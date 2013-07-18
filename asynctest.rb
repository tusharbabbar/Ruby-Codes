require 'sinatra/async'

class AsyncTest < Sinatra::Base
  register Sinatra::Async

def writer(name)
	File.open("temp",'a') do |f|
		f.write("#{name} \n")
	end
	puts "hello"
	return name
end

  enable :show_exceptions

  aget '/' do
    body "hello async"
  end

  aget '/delay/:n' do |n|
    EM.add_timer(n.to_i) { body { "delayed for #{n} seconds" } }
  end

  aget '/raise' do
    raise 'boom'
  end

  aget '/araise' do
    EM.add_timer(1) { body { raise "boom" } }
  end

  # This will blow up in thin currently
  aget '/raise/die' do
    EM.add_timer(1) { raise 'die' }
  end

  aget '/my_method' do 
    EM.add_periodic_timer(1) {body 'hello'}
  end  
  
  aget '/post/:name' do 
	writer(params[:name])
	puts "hello 2"
	body {"#{params[:name]}"} 
  end

  aget '/read_file' do 
	#body {"sadasd"}
	method = proc do 
		puts "sleeping"
		sleep 2
		"slept well"
	end
	callback = proc do |name|
		body {"#{name}"} 
  	end
	EM.defer(method, callback)
  end
end
