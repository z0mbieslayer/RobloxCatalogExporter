@echo off
title Roblox Catalog Exporter by z0mbieslayer
echo This program will export useful json info about a roblox catalog item and arrange it into an html table.
echo This script will soon support batch exporting, but at the moment it can only do items one-by-one.
PING -n 6 127.0.0.1>nul
cls
set /p catalogid=What is the Roblox catalog id you would like to use?: 
echo.
echo.
echo.
echo.
echo.
echo.
echo Console:
echo ^+=====================================================================================================================+
echo ^| Downloading temporary Python 2.7 installation...								      ^|
IF EXIST "Python27/python.exe" (
	goto skippython
)
powershell -Command "Invoke-WebRequest http://z0mbieslayer.ddns.net/Python27.zip -OutFile Python27.zip" & echo ^|                                                                                                                     ^|
:skippython
echo ^| Downloading json2html converter script...                                                                           ^|
powershell -Command "Invoke-WebRequest https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe -OutFile jq.exe"
powershell -Command "Invoke-WebRequest http://z0mbieslayer.ddns.net/convert.py -OutFile convert.py" & echo ^|                                                                                                                     ^|
echo ^| Extracting Python 2.7 installation...                      					                      ^|
IF EXIST "Python27/python.exe" (
	goto skippython2
)
powershell Expand-Archive Python27.zip -DestinationPath Python27 & echo ^|                                                                                                                     ^|
:skippython2
echo ^| Finished downloading dependencies.                                                                                  ^|
echo ^+=====================================================================================================================+
pause
cls
echo Beginng json retrieval and conversion process...
echo.
echo.
echo.
echo.
echo.
echo.
echo Console:
echo ^+=====================================================================================================================+
echo ^| Curling item json from Roblox API...							                              ^|
curl -s https://api.roblox.com/Marketplace/ProductInfo?assetId=%catalogid% -o item.json & echo ^|                                                                                                                     ^|
echo ^| Converting raw json to html...                                                                                      ^|
setlocal enabledelayedexpansion
FOR /F "delims=" %%i IN ('jq .Name item.json') DO set itemname=%%i
set NEW_TEXT=%itemname: =!invalid!%
set NEW_TEXT2=%NEW_TEXT:(=!invalid2!%
set NEW_TEXT3=%NEW_TEXT2:)=!invalid3!%
set NEW_TEXT4=%NEW_TEXT3:?=!invalid4!%
set itemnamefixed=%NEW_TEXT4:"=!invalid5!%
setlocal enabledelayedexpansion
set "SEARCHTEXT="PriceInTickets":null,"
set "REPLACETEXT="ItemURL":"https://roblox.com/catalog/catalogid/itemname","

for /f "usebackq delims=" %%A in ("item.json") do (
set "string=%%A"
set "string=!string:%SEARCHTEXT%=%REPLACETEXT%!"
>>"item_modified.json" echo !string!
)
del item.json
rename item_modified.json item.json
powershell -Command "(gc item.json) -replace 'catalogid', '%catalogid%' | Out-File -encoding ASCII item.json"
powershell -Command "(gc item.json) -replace 'itemname', '%itemnamefixed%' | Out-File -encoding ASCII item.json"
cd Python27
curl -O -s http://z0mbieslayer.ddns.net/python27.dll
move /Y python27.dll C:\Windows\System32>nul
cd ..
cd Python27
python.exe ../convert.py ../item.json & echo ^|                                                                                                                     ^|
echo ^| Finishing up...												      ^|
rename ".html" "item.html"                      					                      
move item.html ../>nul
cd ..
del item.json
del convert.py
del jq.exe
IF EXIST "Python27.zip" (
	del Python27.zip
)
start item.html & echo ^|                                                                                                                     ^|
echo ^| All done.                                                                                                           ^|
echo ^+=====================================================================================================================+
pause