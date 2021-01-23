# Yuma_SFT
Secure Sharing Your File

Yuma_SFT Protocol (Beta Version)

File Sharing With Security !

Note : For Sharing Folder , Create Key and Send Key For Target !

Platform : Linux (Tested On Arch Linux)

_____________________________________________________________________

Running : 

yuma.conf File :
	IP = Server IP | Defualt is 

Step 1 : 'ruby luncher.rb' For Create Key and Your Random Hash !

Server : 

	'ruby Sv_Yuma.rb' For Running Server !
  
Client : 

	File 'Yuma.rb' Created For Send And Dump File !
  
	*Send : 'ruby Yuma.rb -sf File_Address File_Name(Saved to Target DB) ip port' | '-sf' , '-fs' , '--send_file' For Send File
  
	*Dump : (in the Server) 'ruby Yuma.rb -df Filename' | '-df' , '-fd' , '--dump_file' For Dump File

_____________________________________________________________________

This Project Have Update !

# File Encrypted And Saved To Server Database ! For This, We Are Created dump_file !!!

# Client And Server Use With a Key ! (Global Key xD)
