require 'open-uri'
require 'nokogiri'
require 'openssl'
require 'logger'

 log = Logger.new('dict.log')
 #proxy_uri = URI.parse("http://192.168.2.7:8989") ## :proxy_http_basic_authentication => [proxy_uri, "", ""],:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE,
 f = File.open("dict_result",'w')
 #iter = "abcdefghijklmnopqrstuvwxyz"
 #iter = iter.split("")
 #puts iter
 iter = File.open('list','r').read.split("\n")
iter.each do |x|
		puts x
		begin	
			doc = Nokogiri::XML(open("https://search.itunes.apple.com/WebObjects/MZSearchHints.woa/wa/hints?q=#{x}&cc=us&clientApplication=Software&media=software","Host"=> "search.itunes.apple.com","User-Agent"=> "iTunes/11.0.4 (Windows; Microsoft Windows 7 x64 Ultimate Edition Service Pack 1 (Build 7601)) AppleWebKit/536.30.1","Cookie"=> "X-JS-SP-TOKEN=nsFsg+dIPGHHGTls0epOww==;                   
                      X-JS-TIMESTAMP=1371824549; groupingPillToken=1_iphone;    
                      mzf_in=380270; mzf_odc=NK1;                               
                      xp_ci=3z1iMRv9z3iJz56VzAfmzB8HCDPwU;                      
                      s_vi=[CS]v1|28CDD47A85012F04-4000010E6032523C[CE];        
                      itspod=38;                                                
                      ns-mzf-inst=39-127-80-144-135-8015-380270-38-nk11; Pod=38;
                      mz_at0-272829902=AwQAAAECAAGttAAAAABRwvQ6AImUITXG+dqK8ZSPZ
                      7VcG9Z/g6k=; mz_at_ssl-272829902=AwUAAAECAAGttAAAAABRwvQ61
                      ktJlxc9CuVPS4C+xOm5kMPkVRk=; X-Dsid=272829902; s_ppv=itune
                      s%252011%2520-%2520welcome%2520screen%2520%2528us%2529%2C1
                      00%2C100%2C540%2C; s_invisit_n2_us=0;                     
                      s_membership=1%3Ait11;                                    
                      s_pathLength=itunes.welcomescreen%3D1%2C;                 
                      s_pv=itunes%2011%20-%20welcome%20screen%20%28us%29;       
                      s_vnum_n2_us=0%7C1","X-Apple-Tz"=> "19800","Referer"=> "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewGrouping?cc=us&id=38","Accept-Language"=> "en-us, en;q=0.50","X-Apple-Store-Front"=> "143441-1,17","Accept-Encoding"=> "xml","Connection"=> "close","Proxy-Connection"=> "close","Cache-Control"=> "no-cache").read)
			puts doc
			array = doc.xpath('//dict/array/dict/string')
			f.write("listing for #{x}\n")			
			array.each_slice(2) do |a|
				puts "here"
				f.write("\t #{a[0].to_s}\n")
			end
		rescue Timeout::Error,Errno::ECONNRESET => e
			log.error(e.inspect.to_s + "#{x}")
			
		end
		
end


