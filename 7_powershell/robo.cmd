REM Robocopy (just file structure)
robocopy C:\tmp C:\temp2 /e /xf *

REM net use: connect, remove and configure connections to shared resources like mapped drives
net use z: \\WM01\f$
robocopy z:\datacatalog e:\datacatalog /e /r:1 /w:5 /sec /secfix /timfix /log:"F:\robo_log.log" /np
net use z: /del
pause

REM and not map it to z
robocopy \\WM01\f$\datacatalog e:\datacatalog /e /r:1 /w:5 /sec /secfix /timfix /log:"F:\robo_log.log" /np

REM "" path
Robocopy "c:\Program Files (x86)\folder\folder2" "c:\Program Files (x86)\folder\folder2" /e /r:1 /w:5 /sec /secfix /timfix /log:"c:\Program Files (x86)\folder\folder2\robo_log.log" /np
