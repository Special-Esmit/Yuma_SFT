#Created By Special_Esmit

require "socket"
require "openssl"
require "base64"
require "digest"
require "json"

$my_data = JSON.parse(File.read("Data.json"))

#Encrypting Function For Send File
def send_file_enc(fil,name,tip,tport)
	begin
		fil = File.read(fil)
		puts "IP : #{tip} | Port : #{tport}"
		ha = $my_data["Hash"]
		st = name + "|" + ha + "?" + fil
		puts st
		cipher = OpenSSL::Cipher.new('aes256')
		cipher.encrypt
		cipher.key = File.read "Key.pem"
		enc = cipher.update(st) + cipher.final
		enc = Base64.encode64(enc)
		so = TCPSocket.open(tip.to_s,tport.to_i)
		so.send(enc,0)
		so.close
		puts "<^> File Sended"
	rescue
		puts "<!> Error"
	end
end

#Decrypting Function For Save File
def decrypting(req)
	begin
		cipher = OpenSSL::Cipher.new('aes256')
		cipher.decrypt
		cipher.key = File.read("Key.pem")
		dec = cipher.update(Base64.decode64(req)) + cipher.final
		puts "Live"
		req = dec
		co = req.index("?")
		data = req[0...co].split("|")
		req = req[co+1...]
		puts "<^> File Name : #{data[0]}"
		puts "<^> User Hash : #{data[1]}"
		puts "<^> Data Length : #{req.length}"
		print("\n<^> Save File ?(y,n) : ") ; dm = gets.chomp
		if dm == "y"
			cipher2 = OpenSSL::Cipher.new('aes256')
			fname = Digest::MD5.hexdigest(Base64.encode64(rand.to_s + data[0] + rand.to_s))
			cipher2.encrypt
			ky = cipher.random_key
			cipher2.key = File.read("Key.pem")
			enc = cipher2.update(req) + cipher2.final
			fi = File.new("Files/"+fname+".enc","w")
			fi.write(enc)
			fi.close
			r = JSON.parse(File.read("Files/Files_db.json"))
			r[data[0]] = fname + ".enc"
			f = File.new("Files/Files_db.json",'w') ; f.write(r.to_json) ; f.close
			puts "<^> File Saved "
		else
			ptus "<^> Closed !"
		end
	rescue
		puts "<!> Error !"
	end
end

#Dump File (Saved Files)
def dump_file(file_name,dr)
	puts "<^> Target File_Name : #{file_name}"
	rf = JSON.parse(File.read("Files/Files_db.json"))
	if rf[file_name]
		cipher = OpenSSL::Cipher.new('aes256')
		cipher.decrypt
		cipher.key = File.read("Key.pem")
		data = File.read("Files/" + rf[file_name])
		dec = cipher.update(data) + cipher.final
		print("<^> Enter Directory For Save File : ")
		f = File.new(dr + rf.key(rf[file_name]),'w')
		f.write(dec)
		f.close()
		puts "\n\n<^> File Saved to " + dr + rf.key(rf[file_name])
	else
		puts "<^> File Not Found !"
	end
end

