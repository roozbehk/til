@ECHO OFF
SET SvcName=Hamachi2Svc

SC QUERYEX "%SvcName%" | FIND "STATE" | FIND /v "RUNNING" > NUL && (
    ECHO %SvcName% is not running 
    ECHO START %SvcName%

    NET START "%SvcName%" > NUL || (
        ECHO "%SvcName%" wont start 
        EXIT /B 1
    )
    ECHO "%SvcName%" is started
    EXIT /B 0
) 

"C:\Program Files (x86)\LogMeIn Hamachi\x64\hamachi-2.exe" --cli | FIND "offline" > NUL && (
    ECHO "%SvcName%" is running but trying to login user now... 

    "C:\Program Files (x86)\LogMeIn Hamachi\x64\hamachi-2.exe" --cli login > NUL || (
        ECHO "%SvcName%" is running but I can not login 
        EXIT /B 1
    )  

) || (
   
  ECHO "%SvcName%" is running and user is logged in.
  EXIT /B 0 
)

