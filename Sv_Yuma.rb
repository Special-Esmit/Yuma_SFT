require "./YumaLib.rb"
require "socket"
def serv(ip='localhost',port=15556)
	s = TCPServer.new(ip,port.to_i)
	puts "<^> Server is Run ![IP:#{ip} | Port:#{port}]"
	loop{
		c = s.accept
		puts "<^> New Request From  #{c.peeraddr[2]} | #{c.peeraddr[1]}"
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
serv
