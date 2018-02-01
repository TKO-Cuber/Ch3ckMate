@echo off
 ::This is a simple batch script that checks Apple's TSS servers for changes. Just run it and you're done.
 
 echo Welcome to Ch3ckMate! 
 echo.
 echo.
 ::The intro
 
 ::Get some needed stuff from user
 SET emailFrom=ch3ckmatetss@gmail.com
 SET body=Hey there! Some changes have occured in the TSS server! Go and check your script to see!
 SET subject=TSS SERVER SIGNING CHANGED!
 set /p ECID=Please enter your ECID here ^>^>^>^>
 cls
 set /p DeviceModel=What is your device model? (iPhone7,2 for example) ^>^>^>^>
 cls
 set /p SendMail=Would you like to recieve an email if a previously unsigned version is signed again? (yes or no) ^>^>^>^>
  IF /I "%SendMail%"=="yes" (
    set /p emailRecipient=What is your email address? ^>^>^>^>
  )
 echo Thanks. Now just sit back, relax, and let the script run.
 
 :Start
 cd Programs
 
 ::Check iOS 11.2.2
 echo Checking iOS 11.2.2
 tsschecker_windows.exe -d %DeviceModel% --buildid 15C202 >output.txt
 >nul findstr /c:"Build 15C202 for device %DeviceModel% IS being signed!" output1.txt && (
    echo iOS 11.2.2 IS BEING SIGNED! SAVING BLOBS!
	tsschecker_windows.exe -d %DeviceModel% --buildid 15C202 -e %ECID% -s >NUL
	::Send mail
	cd Programs
	cd blat
	blat.exe -mailfrom %emailFrom% -to %emailRecipient% -body "%body%" -subject "%subj%" -server localhost
      ) || (
    echo.
	cd ../../..
  )
  pause
  
 ::Check iOS 11.2.5
 echo Checking iOS 11.2.5
 tsschecker_windows.exe -d %DeviceModel% --buildid 15D60 >output1.txt
 cd Output
 >nul findstr /c:"Build 15D60 for device %DeviceModel% IS being signed!" output1.txt && (
    echo iOS 11.2.5 IS BEING SIGNED! SAVING BLOBS!
	tsschecker_windows.exe -d %DeviceModel% --buildid 15D60 -e %ECID% -s >NUL
	::Send mail
	cd Programs
	cd blat
	blat.exe -mailfrom %emailFrom% -to %emailRecipient% -body "%body%" -subject "%subj%" -server localhost
      ) || (
    echo.
	cd ../../..
  )
  pause
