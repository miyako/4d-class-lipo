//%attributes = {"invisible":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	CALL WORKER:C1389(Current method name:C684; Current method name:C684; {})
	
Else 
	
	$lipo:=cs:C1710.Lipo.new(cs:C1710._Lipo_Controller)
	
	$src:=Folder:C1567(Application file:C491; fk platform path:K87:2)
	$dst:=Folder:C1567(fk desktop folder:K87:19)
	
	For each ($arch; ["x86_64"; "arm64"])
		$path:=$dst.path+[$arch; $src.fullName].join("/")
		$dst:=OB Class:C1730($src).new($path)
		$options:={src: $src; dst: $dst; arch: $arch}
		$lipo.thin($options)
	End for each 
	
End if 