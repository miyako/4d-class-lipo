Class extends _Lipo_Controller

Class constructor($CLI : cs:C1710._CLI)
	
	Super:C1705($CLI)
	
Function onDataError($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Super:C1706.onDataError($worker; $params)
	
	If (Form:C1466#Null:C1517)
		
		Form:C1466.progress:=This:C1470._progress
		Form:C1466.stdErr:=This:C1470._stdErr
		
	End if 
	
Function onData($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Super:C1706.onData($worker; $params)
	
	If (Form:C1466#Null:C1517)
		
		Form:C1466.progress:=This:C1470._progress
		Form:C1466.stdOut:=This:C1470._stdOut
		
	End if 
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Super:C1706.onResponse($worker; $params)
	
	If (Form:C1466#Null:C1517)
		
		Form:C1466.progress:=This:C1470._progress
		Form:C1466.stdErr:=This:C1470._stdErr
		Form:C1466.stdOut:=This:C1470._stdOut
		
	End if 
	
Function onTerminate($worker : 4D:C1709.SystemWorker; $params : Object)
	
	If (Form:C1466#Null:C1517)
		
		If (This:C1470.complete)
			
			Form:C1466.isProcessing(False:C215).toggleButtons()
			
		End if 
		
	End if 