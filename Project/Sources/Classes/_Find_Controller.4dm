Class extends _CLI_Controller

property _stdErrBuffer; _stdOutBuffer : Text
property _instance : Object
property _parameters : Collection

Class constructor
	
	Super:C1705()
	
	//MARK:-public methods
	
Function bind($instance : cs:C1710._CLI)
	
	If (OB Instance of:C1731($instance; cs:C1710._CLI))
		This:C1470._instance:=$instance
		This:C1470._parameters:=Copy parameters:C1790(2)
	End if 
	
	//MARK:-private methods
	
Function _reducePaths($param : Object)->$files : Collection
	
	var $path : Text
	$path:=$param.value
	
	Case of 
		: ($path="@.xlf")
		: ($path="@.xsl")
		: ($path="@.xml")
		: ($path="@.xsd")
		: ($path="@.yml")
		: ($path="@.svg")
		: ($path="@.rsrc")
		: ($path="@.json")
		: ($path="@.html")
		: ($path="@.htm")
		: ($path="@.css")
		: ($path="@.js")
		: ($path="@.ts")
		: ($path="@.coffee")
		: ($path="@.jscsrc")
		: ($path="@.jshintrc")
		: ($path="@.md")
		: ($path="@.editorconfig")
		: ($path="@.gitignore")
		: ($path="@.gitattributes")
		: ($path="@.strings")
		: ($path="@.4DSettings")
		: ($path="@.4DPreferences")
		: ($path="@.icns")
		: ($path="@.png")
		: ($path="@.ico")
		: ($path="@.jpg")
		: ($path="@.gif")
		: ($path="@.tif")
		: ($path="@.tiff")
		: ($path="@.txt")
		: ($path="@.dfont")
		: ($path="@.woff")
		: ($path="@.ttf")
		: ($path="@.otf")
		: ($path="@.woff2")
		: ($path="@.4DZ")
		: ($path="@.4DB")
		: ($path="@.4DIndy")
		: ($path="@.4DProject")
		: ($path="@.4il")
		: ($path="@.4vp")
		: ($path="@.4wp")
		: ($path="@.4dsyntax")
		: ($path="@.pem")
		: ($path="@.nib")
		: ($path="@.xib")
		: ($path="@.entitlements")
		: ($path="@.aff")
		: ($path="@.dic")
		: ($path="@.ini")
		: ($path="@.php")
		: ($path="@.sh")
		: ($path="@.project")
		: ($path="@/LICENSE")
		: ($path="@/PkgInfo")
			//: ($path="@/php-fcgi-4d")  //Mach-O 64-bit executable x86_64
		: ($path="@/_CodeSignature/CodeResources")
		: ($path="@/Info.plist")
		: ($path="@.npmignore")
		: ($path="@.nuspec")
		: ($path="@.eslintrc")
		: ($path="@.less")
		: ($path="@.scss")
		: ($path="@.eot")
		: ($path="@.dtd")
		: ($path="@.h")
		: ($path="@.cpp")
		: ($path="@.uni")
		: ($path="@.bin")
		: ($path="@.def")
		: ($path="@/mecabrc")
		: ($path="@/dicrc")
		: ($path="@.4lbp")
		: ($path="@.xcconfig")
		: ($path="@.swiftdoc")
		: ($path="@.swiftmodule")
		: ($path="@.swiftsourceinfo")
		: ($path="@.pak")
		: ($path="@.dat")
		: ($path="@/lib4d-arm64.dylib")
		: ($path="@.json5")
		: ($path="@.mp3")
		: ($path="@.wasm")
		: ($path="@.icc")
		: ($path="@.zip")
		: ($path="@.map")
		: ($path="@.modulemap")
		: ($path="@.swift")
		: ($path="@.storyboard")
		: ($path="@.kt")
		: ($path="@.kts")
		: ($path="@.4dm")
		: ($path="@.4dmobileapp")
		: ($path="@.jar")
		: ($path="@.plist")
		: ($path="@.gradle")
		: ($path="@.bat")
		: ($path="@.xcscheme")
		: ($path="@.pdf")
		: ($path="@.pbxproj")
		: ($path="@.xcworkspacedata")
		: ($path="@.xcsettings")
			
		Else 
			$param.accumulator.push(File:C1566($path))
	End case 
	
Function _clear()
	
	This:C1470._stdErrBuffer:=""
	This:C1470._stdOutBuffer:=""
	
	//MARK:-polymorphism
	
Function onDataError($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Case of 
		: ($worker.dataType="text")
			
			This:C1470._stdErrBuffer+=$params.data
			
		: ($worker.dataType="blob")
			
			This:C1470._stdErrBuffer+=Convert to text:C1012($params.data; This:C1470.encoding)
			
	End case 
	
Function onData($worker : 4D:C1709.SystemWorker; $params : Object)
	
	Case of 
		: ($worker.dataType="text")
			
			This:C1470._stdOutBuffer+=$params.data
			
		: ($worker.dataType="blob")
			
			This:C1470._stdOutBuffer+=Convert to text:C1012($params.data; This:C1470.encoding)
			
	End case 
	
Function onResponse($worker : 4D:C1709.SystemWorker; $params : Object)
	
	var $paths; $files : Collection
	
	$paths:=Split string:C1554(This:C1470._stdOutBuffer; "\n"; sk ignore empty strings:K86:1 | sk trim spaces:K86:2)
	$files:=$paths.reduce(This:C1470._reducePaths; New collection:C1472)
	
	If (This:C1470.complete)
		If (OB Instance of:C1731(This:C1470._instance.onResponse; 4D:C1709.Function))
			This:C1470._instance.onResponse($files; This:C1470._parameters)
		End if 
	End if 
	
Function onTerminate($worker : 4D:C1709.SystemWorker; $params : Object)
	
	If (This:C1470.complete)
		If (OB Instance of:C1731(This:C1470._instance.onTerminate; 4D:C1709.Function))
			This:C1470._instance.onTerminate(This:C1470._parameters)
		End if 
	End if 