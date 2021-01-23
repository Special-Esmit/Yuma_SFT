require "json"
require "digest"
require "openssl"
require "base64"
require "./YumaLib.rb"

#Luncher , Configure , Create Key File

puts "<$> Created By Special_Esmit"
puts "<$> Yuma_SFT Secure File Transfer :)\n"
puts "\n\n<^> Creating Key ...."
cipher = OpenSSL::Cipher.new('aes256')
key = cipher.random_key
f = File.new($yuma_config["Key_File"],'w')
f.write(key)
f.close
puts "<^> Key Created !\n"
puts "<^> Creating Your Hash and Saving Data ...."
r1 = rand.to_s
r2 = rand.to_s
random_hash = Digest::MD5.hexdigest(Base64.encode64(r1+key+r2))
puts "<^> Your Hash Created xD"
jdata = {"Hash"=>random_hash,"Save_Files"=>0,"Send_Files"=>0}.to_json
sj = File.new($yuma_config['Data'],'w')
sj.write(jdata)
sj.close
sg = $yuma_config["File_DB"]
system("mkdir " + sg)
system("chmod 700 " + $yuma_config['Data'])
system("chmod 700 " + $yuma_config["Key_File"])
system("echo '{}' > " + $yuma_config['File_DB'] + "Files_db.json")
system("echo '{}' > " + $yuma_config['Data'])
puts "\n<^> Data Saved ! By :)"
