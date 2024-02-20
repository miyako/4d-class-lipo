![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%&color=blue)
[![license](https://img.shields.io/github/license/miyako/4d-class-lipo)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-class-lipo/total)

Classes to split universal binary app with the lipo program

 # About

 Executes `lipo -thin` on exectuable files inside an .app to create separate instances for Intel/Mac architecture.

<img src="https://github.com/miyako/4d-class-lipo/assets/1725068/aa8e671c-801a-41b6-b52a-e8dce83b9939" width="450" />

|source|original size|x86_64|arm64|
|:-:|:-:|:-:|:-:|
|4D 20 R3|965.1 MB|881.6 MB|661.8 MB|
|4D 19.7|1.07 GB|779.8 MB|784.8 MB|

**Note**: 4D 19 contains 4D Mobile.

# Remarks

The [LSRequiresNativeExecution](https://developer.apple.com/documentation/bundleresources/information_property_list/lsrequiresnativeexecution) key is not added to *Info.plist*.
