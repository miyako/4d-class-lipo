Class extends _Form

property targetFolder : 4D:C1709.Folder

Class constructor
	
	Super:C1705()
	
	This:C1470.targetFolder:=Folder:C1567(fk desktop folder:K87:19)
	
	$window:=Open form window:C675("Lipo")
	DIALOG:C40("Lipo"; This:C1470; *)
	
Function onLoad()
	
	Form:C1466.Lipo:=cs:C1710.Lipo.new(cs:C1710._LipoUI_Controller)
	
	Form:C1466.toggleButtons().isProcessing(False:C215)
	
Function onUnload()
	
	Form:C1466.Lipo.terminate()
	
Function thin($src : Object)
	
	OBJECT SET ENABLED:C1123(*; "Thin"; False:C215)
	
	Form:C1466.isProcessing(True:C214)
	
	This:C1470.Lipo.reset()
	
	For each ($arch; ["x86_64"; "arm64"])
		$path:=This:C1470.targetFolder.path+$arch
		$dst:=OB Class:C1730($src).new($path)
		$options:={src: $src; dst: $dst; arch: $arch}
		This:C1470.Lipo.thin($options)
	End for each 
	
	return Form:C1466
	
Function isProcessing($flag : Boolean)
	
	OBJECT SET VISIBLE:C603(*; "Progress"; $flag)
	OBJECT SET ENABLED:C1123(*; "Stop"; $flag)
	
	Form:C1466.progress:=0
	
	return Form:C1466
	
Function abort()
	
	Form:C1466.isProcessing(False:C215).toggleButtons().Lipo.terminate()
	
Function toggleButtons()
	
	Case of 
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.File)) && (Form:C1466.source.exists)
			
			OBJECT SET ENABLED:C1123(*; "Thin"; True:C214)
			
		: (OB Instance of:C1731(Form:C1466.source; 4D:C1709.Folder)) && (Form:C1466.source.exists)
			
			OBJECT SET ENABLED:C1123(*; "Thin"; True:C214)
			
		Else 
			
			OBJECT SET ENABLED:C1123(*; "Thin"; False:C215)
			
	End case 
	
	return Form:C1466
	
Function onSourceDragOver()
	
	$path:=Get file from pasteboard:C976(1)
	
	If ($path#"") && ((Test path name:C476($path)=Is a document:K24:1) || (Test path name:C476($path)=Is a folder:K24:2))
		$0:=0
	Else 
		$0:=-1
	End if 
	
Function onSourceDrop()
	
	$path:=Get file from pasteboard:C976(1)
	
	var $class : 4D:C1709.Class
	
	Case of 
		: (Test path name:C476($path)=Is a document:K24:1)
			$class:=4D:C1709.File
		: (Test path name:C476($path)=Is a folder:K24:2)
			$class:=4D:C1709.Folder
	End case 
	
	If ($class#Null:C1517)
		
		Form:C1466.source:=$class.new($path; fk platform path:K87:2)
		
		If (Is macOS:C1572)
			Form:C1466.sourceIcon:=Form:C1466.source.getIcon()
		Else 
			$icon:=Form:C1466.source.getIcon(256)
			Form:C1466.sourceIcon:=$icon
		End if 
		
	End if 
	
	return Form:C1466