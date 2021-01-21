require "json"
require "digest"
require "openssl"
require "base64"

#Luncher , Configure , Create Key File

puts "<$> Created By Special_Esmit"
puts "<$> Yuma_SFT Secure File Transfer :)\n"
puts "\n\n<^> Creating Key ...."
cipher = OpenSSL::Cipher.new('aes256')
key = cipher.random_key
f = File.new("Key.pem",'w')
f.write(key)
f.close
puts "<^> Key Created !\n"
puts "<^> Creating Your Hash and Saving Data ...."
r1 = rand.to_s
r2 = rand.to_s
random_hash = Digest::MD5.hexdigest(Base64.encode64(r1+key+r2))
puts "<^> Your Key With Random integer Created xD"
jdata = {"Hash"=>random_hash,"Save_Files"=>0,"Send_Files"=>0}.to_json
sj = File.new("Data.json",'w')
sj.write(jdata)
sj.close
puts "\n<^> Data Saved ! By :)"
system("mkdir Files")
system("chmod 700 Data.json")
system("chmod 700 Key.pem")
