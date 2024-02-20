Class extends _CLI

property files : Collection

Class constructor($controller : 4D:C1709.Class)
	
	Super:C1705("lipo"; $controller)
	
	This:C1470.reset()
	
Function reset() : cs:C1710.Lipo
	
	This:C1470.files:=[]
	
	return This:C1470
	
Function terminate()
	
	This:C1470.controller.terminate()
	
Function onResponse($files : Collection; $parameters : Collection)
	
	//find complete
	
	This:C1470.files.combine($files)
	
	var $srcFolder; $dstFolder : 4D:C1709.Folder
	
	$srcFolder:=$parameters.at(0)
	$dstFolder:=$parameters.at(1)
	
	$dstFolder.create()
	
	$srcFolder.copyTo($dstFolder; fk overwrite:K87:5)
	
	var $src; $dst : 4D:C1709.File
	
	var $arch : Text
	$arch:=$parameters.at(2)
	
	$options:=New collection:C1472
	
	$srcPath:=Split string:C1554($srcFolder.parent.path; "/"; sk ignore empty strings:K86:1)
	
	For each ($src; $files)
		
		$pathComponents:=Split string:C1554($src.path; "/"; sk ignore empty strings:K86:1)
		
		$dst:=$dstFolder.file($pathComponents.slice($srcPath.length).join("/"))
		
		$options.push(New object:C1471("src"; $src; "dst"; $dst; "arch"; $arch))
		
	End for each 
	
	This:C1470.thin($options)
	
Function thin($option : Variant)->$this : cs:C1710.Lipo
	
	$this:=This:C1470
	
	var $commands; $options : Collection
	$commands:=New collection:C1472
	
	Case of 
		: (Value type:C1509($option)=Is object:K8:27)
			$options:=New collection:C1472($option)
		: (Value type:C1509($option)=Is collection:K8:32)
			$options:=$option
	End case 
	
	For each ($option; $options)
		
		Case of 
			: (OB Instance of:C1731($option.src; 4D:C1709.File)) && (OB Instance of:C1731($option.dst; 4D:C1709.File))
				
				$input:=File:C1566($option.src.platformPath; fk platform path:K87:2)
				$output:=File:C1566($option.dst.platformPath; fk platform path:K87:2)
				
				$output.parent.create()
				
				$command:=This:C1470.escape(This:C1470.executablePath)
				$command:=$command+" "+This:C1470.escape($input.path)
				Case of 
					: (Value type:C1509($option.arch)=Is text:K8:3) && ($option.arch#"")
						$command:=$command+" -thin "+This:C1470.escape($option.arch)
					Else 
						$command:=$command+" -thin arm64"
				End case 
				$command:=$command+" -output "+This:C1470.escape($output.path)
				$commands.push($command)
				
			: (OB Instance of:C1731($option.src; 4D:C1709.Folder)) && (OB Instance of:C1731($option.dst; 4D:C1709.Folder))
				
				$find:=cs:C1710._Find.new(cs:C1710._Find_Controller)
				$find.controller.bind(This:C1470; $option.src; $option.dst; $option.arch)
				$find.findExecutables($option.src)
				
		End case 
	End for each 
	
	This:C1470.controller.execute($commands)