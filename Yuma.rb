require "./YumaLib.rb"

puts "<$> Created By Special_Esmit"
puts "<$> Yuma_SFT Secure File Transfer\n\n"

begin
	sc = ARGV[0].downcase
rescue
	puts "<^> Please Give Me Arg !!!"
end
if sc == "" or sc == " " 
	puts "<^> Please Give Me Arg !!!"
else
	if sc == "-df" or sc == "-fd" or sc == "--dump_file"
		dump_file(ARGV[1],ARGV[2])
	elsif sc == "-sf" or sc == "-fs" or sc == "--send_file"
		send_file_enc(ARGV[1],ARGV[2],ARGV[3],ARGV[4])
	end
end
