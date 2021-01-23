require "./YumaLib.rb"
require "socket"

def serv(ip=$yuma_config["IP"],port=$yuma_config["Port"])
	s = TCPServer.new(ip,port.to_i)
	puts "<^> Server is Run ![ IP:#{ip} | Port:#{port} ]"
	if $yuma_config["Accept_All"].downcase == "yes"
		puts "<^> Accpet_All is On !"
		loop{
			Thread.start(s.accept) do |c|
				puts "\n<^> New Request From  #{c.peeraddr[0]} | #{c.peeraddr[1]}"
				sv_log(c.peeraddr.to_s)
				rea = c.read
				decrypting(rea)
				c.close

			end
		}
	
	else
		loop{
			c = s.accept
			puts "<^> New Request From  #{c.peeraddr[0]} | #{c.peeraddr[1]}"
			print("<^> Accpet ?(y,n): ") ; x = gets.chomp
			if x == "y"
				rea = c.read
				decrypting(rea)
				c.close
			else
				c.cend("<^> Sorry Your File Not Accepted !",0)
				c.close
			end
		}
	end
end
serv
