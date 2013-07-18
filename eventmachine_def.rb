require 'eventmachine'

 EM.run {
   df = EM::Protocols::HttpClient.request( :host=>"www.google.com", :request=>"/index.html" )

   df.callback {|response|
     puts response[:content]
     df.set_deferred_status :succeeded, response[:content]
   }

   df.callback {|string|
     puts "Succeeded: #{string}"
     EM.stop
   }

   df.errback {|response|
     puts "ERROR: #{response[:status]}"
     EM.stop
   }
 }
