#require 'sinatra'
require 'sinatra/async'

class AsyncTest < Sinatra::Base
  register Sinatra::Async
aget '/hello' do
	big_job = lambda {sleep 10}
	result = lambda { 'Hello!' }
	EM.defer big_job, result
end

aget '/bye' do 
	'bye bye'
end
end

