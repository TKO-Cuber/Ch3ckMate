@echo off
 ::This is a simple batch script that checks Apple's TSS servers for changes. Just run it and you're done.
 
 echo Welcome to Ch3ckMate! 
 echo.
 echo.
 ::The intro
 
 ::Get some needed stuff from user
 SET emailFrom=ch3ckmatetss@gmail.com
 SET body=Hey there some changes have occured in the TSS server signing... Go and check your script to see.
 SET subject=TSS SIGNING STATUES CHANGED
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
 cls
 
  ::Check iOS 11.2.5
  :11.2.5
 echo Checking iOS 11.2.5
 tsschecker_windows.exe -d %DeviceModel% --buildid 15D60 >output.txt
  >nul find "Build 15D60 for device %DeviceModel% IS being signed!" output.txt && (
      echo iOS 11.2.5 IS BEING SIGNED! SAVING BLOBS!
      >nul tsschecker_windows.exe -d %DeviceModel% --buildid 15D60 -e %ECID% -s
      goto 11.2.5_c
    ) || (
      echo iOS 11.2.5 is not being signed for the %DeviceModel%
      goto 11.2.5_finish
    )
	  :11.2.5_c
	  IF "%SendMail%"=="yes" (
	    goto 11.2.5_m
	  )
	  else (
	    goto 11.2.5_f
	  )
	  :: If not signed
	  ) || (
        echo iOS 11.2.2 is not being signed for the %DeviceModel%
		goto 11.2.5_finish
      )
		:11.2.5_m
	    cd blat
	      blat -mailfrom "%emailFrom%" -to "%emailRecipient%" -body "%body%" -subject "%subject%" -server "smtp.gmail.com" -port "25" -f "ch3ckmatetss@gmail.com"
		  goto 11.2.5_f
		  :11.2.5_f
	      cd ../../..
	      echo.
		  pause
		  goto 11.2.2

 
 
 
 
 ::Check iOS 11.2.2
 :11.2.2
 echo Checking iOS 11.2.2
 pause
