Class extends _CLI_Controller

Class constructor($CLI : cs:C1710._CLI)
	
	Super:C1705($CLI)
	
	This:C1470._stdOut:=""
	This:C1470._stdErr:=""
	This:C1470._progress:=0
	
Function onDataError($worker : 4D:C1709.SystemWorker; $params : Object)
	
	This:C1470._stdErr:=$params.data
	
Function onData($worker : 4D:C1709.SystemWorker; $params : Object)
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
	If (This:C1470.complete)
		//end of the queue
		This:C1470._stdOut:=""
		This:C1470._stdErr:=""
		This:C1470._progress:=100
	Else 
		$total:=This:C1470.instance.files.length
		$done:=$total-This:C1470._commands.length
		This:C1470._stdOut:=This:C1470._worker.commandLine
		This:C1470._progress:=$done/$total*100
	End if 
	
Function onError($worker : 4D:C1709.SystemWorker; $params : Object)
	
Function onTerminate($worker : 4D:C1709.SystemWorker; $params : Object)
	