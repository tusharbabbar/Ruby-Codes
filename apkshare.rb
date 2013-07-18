require 'sinatra'

files = ["C4dv3.98.apk","com.n0n3m4.gcc4droid_57.apk","rayman_jungle_run.apk"
]

get '/apk/' do
	"<a href=\"/apk/#{files[1]}\">GCC4Droid</a><p><\p><a href=\"/apk/#{files[2]}\">Rayman_game</a><p></p><a href=\"/apk/#{files[0]}\">C4Droid</a>"
end

get '/apk/:name' do
	send_file params[:name]
	redirect "/apk"
end 
