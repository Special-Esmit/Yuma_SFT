# Created By Special_Esmit

require "socket"
require "openssl"
require "base64"
require "digest"
require "json"

# Read Config Function , For Reading And Return Datas
def rd_config()
	r = File.readlines("yuma.conf")
	datas = {}
	for i in r
		i = i.chomp
		if i[0...4] == "IP: "
			datas["IP"] = i[4...20]

		elsif i[0...6] == "Port: "
			datas["Port"] = i[6...20]
		elsif i[0...12] == "Accept_All: "
			datas["Accept_All"] = i[12...15]
		elsif i[0...9] == "File_DB: "
			datas["File_DB"] = i[9...3000]
		elsif i[0...10] == "Key_File: "
			datas["Key_File"] = i[10...3000]
		elsif i[0...6] == "Data: "
			datas["Data"] = i[6...3000]
		elsif i[0...10] == "Log_File: "
			datas["Log_File"] = i[10...3000]
		elsif i[0...8] == "Tr_Key: "
			datas["Tr_Key"] = i[8...2000]
		elsif i[0...22] == "Send_File_Encrypting: "
			datas["Send_File_Encrypting"] = i[22...3000]
		else
			next
		end
	end
		return datas
end

$yuma_config = rd_config() # This is Config , Settings And Configuration

begin
	$my_data = JSON.parse(File.read($yuma_config["Data"])) # Your Data (Hash , Save_Files , Send_Files)
rescue
	puts "<!> Data Read Error , Retarting ..."
end
# Encrypting Function For Send File
def send_file_enc(fil,name,tip,tport)
	begin
		fil = File.read(fil)
		puts "IP : #{tip} | Port : #{tport}"
		ha = $my_data["Hash"]
		st = name + "|" + ha + "?" + fil
		if $yuma_config["Send_File_Encrypting"].downcase == "yes"
			cipher = OpenSSL::Cipher.new('aes256')
			cipher.encrypt
			cipher.key = File.read $yuma_config["Key_File"]
			$enc = cipher.update(st) + cipher.final
			$enc = Base64.encode64($enc)
		else
			$enc = "no_enc"+ Base64.encode64(st)
		end
		so = TCPSocket.open(tip.to_s,tport.to_i)
		so.send($enc,0)
		so.close
		puts "<^> File Sended"
		sn_
	rescue
		puts "<!> Error"
	end
end

# Save Log ()
def sv_log(log,so)
	f = File.new($yuma_config["Log_File"],'a')
	f.write(log.to_s + so.to_s + "\n")
	f.close
end

# Decrypting Function For Save File
def decrypting(req)
	begin
		puts "____________________________________\n\n"
		if req[0...6] == "no_enc"
			req = req[6...]
			dec = Base64.decode64(req)
			$sy = dec
			puts "<*> File is None_Encrypting !"
		else
			cipher = OpenSSL::Cipher.new('aes256')
			cipher.decrypt
			cipher.key = File.read($yuma_config["Tr_Key"])
			dec = cipher.update(Base64.decode64(req)) + cipher.final
			$sy = dec
		end
		req = $sy
		co = req.index("?")
		data = req[0...co].split("|")
		req = req[co+1...]
		puts "<^> File Name : #{data[0]}"
		puts "<^> User Hash : #{data[1]}"
		puts "<^> Data Length : #{req.length}"
		if $yuma_config["Accept_All"].downcase == "yes"
			$dm = "y"
		else
			print("\n<^> Save File ?(y,n) : ") ; $dm = gets.chomp
		end
		
		if $dm == "y"
			cipher2 = OpenSSL::Cipher.new('aes256')
			fname = Digest::MD5.hexdigest(Base64.encode64(rand.to_s + data[0] + rand.to_s))
			data[0] = name_check(data[0])
			puts "<*> File Name (In Database) : #{data[0]}"
			cipher2.encrypt
			cipher2.key = File.read($yuma_config["Key_File"])
			enc = cipher2.update(req) + cipher2.final
			fi = File.new($yuma_config["File_DB"]+fname+".enc","w")
			fi.write(enc)
			fi.close
			r = JSON.parse(File.read($yuma_config["File_DB"]+"Files_db.json"))
			r[data[0]] = fname + ".enc"
			f = File.new($yuma_config["File_DB"]+"Files_db.json",'w') ; f.write(r.to_json) ; f.close
			puts "<^> File Saved\n____________________________________"
			sv_
		else
			ptus "<^> Closed !"
		end
	rescue
		puts "<!> Error !"
	end
	return data
end
# Aut Functions

def name_check(name)
	r = JSON.parse(File.read($yuma_config["File_DB"]+"Files_db.json"))
	if r[name.to_s]
		return name.to_s + "_" + rand.to_s.tr("0.","")
	else
		return name
	end
end

# _________________________________________________________________
def sv_()
	r = JSON.parse(File.read($yuma_config["Data"]))
	r["Save_Files"] += 1
	f = File.new($yuma_config["Data"],'w')
	f.write(r.to_json)
	f.close
end
def sn_()
	r = JSON.parse(File.read($yuma_config["Data"]))
	r["Send_Files"] += 1
	f = File.new($yuma_config["Data"],'w')
	f.write(r.to_json)
	f.close
end	
# _________________________________________________________________

# Dump File (Saved Files)
def dump_file(file_name,dr)
	puts "<^> Target File_Name : #{file_name}"
	rf = JSON.parse(File.read($yuma_config["File_DB"]+"Files_db.json"))
	if rf[file_name]
		cipher = OpenSSL::Cipher.new('aes256')
		cipher.decrypt
		cipher.key = File.read($yuma_config["Key_File"])
		data = File.read($yuma_config["File_DB"] + rf[file_name])
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

