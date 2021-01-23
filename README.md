# Yuma_SFT

New Version :

	* Fixed Bug
	* Add Other File For Control and etc. (See in the protocol)

Secure Sharing Your File

Yuma_SFT Protocol V1

File Sharing With Security !

Note : For Sharing Folder , Create Key and Send Key For Target !

Platform : Linux (Tested On Arch Linux)

_____________________________________________________________________

Running : 

yuma.conf File :

	IP = Server IP | Default is localhost
	Port = Server Port | Default is 15556
	Accept_All = Accepted All Request From All ! | Default is 'No'
	File_DB = File Data Base (Folder , Example : 'My_Data/') | Defautl is 'Files_DB'
	Key_File = Your Key File For Save And Send File | Default is Creating in the 'luncher.rb' File
	Data = Your Data ( Hash,Send_File,Save_File ) | Default is Creating in the 'luncher.rb' File
	Log_File = Log File ( This is Not Good xD ) | Default is '/var/log/yuma.log'
	Tr_Key = Target Key For Save File in Your Server ( For Decrypting File in Server ) | Default is Key_File (Yes xD)
	Send_File_Encrypting = For Encrypting With Your Key_File | Default is Yes

Step 1 : 'ruby luncher.rb' For Create Key and Your Random Hash !

Server : 

	'ruby Sv_Yuma.rb' For Running Server !
  
Client : 

	File 'Yuma.rb' Created For Send And Dump File !
  
	Send : 'ruby Yuma.rb -sf File_Address File_Name(Saved to Target DB) ip port' | '-sf' , '-fs' , '--send_file' For Send File

Dump Saved File :
  
	Dump : (in the Server) 'ruby Yuma.rb -df Filename' | '-df' , '-fd' , '--dump_file' For Dump File

_____________________________________________________________________

