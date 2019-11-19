@echo off

set SourceFile="%~dp0Walkme_Extension.xpi"
set SettingsFile="%~dp0WalkmeExtension@walkme.com.json"
set FFConfigFile="%~dp0all-walkme.js"
:: Script Start Here:
if not exist "C:\Program Files\Walkme\" mkdir "C:\Program Files\Walkme\"
xcopy /s/y %SourceFile% "C:\Program Files\Walkme\"
xcopy /s/y %SettingsFile% "C:\Program Files\WalkMe\Extension\"
cd C:\Program Files\Walkme\
ren Walkme_Extension.xpi WalkmeExtension@walkme.com.xpi
::
ECHO "Copying WalkMe Extension to Firefox Default Profile"
for /D %%D in ("%appdata%\Mozilla\Firefox\Profiles\*") do xcopy /y "C:\Program Files\Walkme\WalkmeExtension@walkme.com.xpi" "%%D\Extensions\"
:: Firefox 64bit:
ECHO "Searching for Firefox 64-bit"
IF EXIST "C:\Program Files\Mozilla Firefox\firefox.exe" (
xcopy /y "C:\Program Files\Walkme\WalkmeExtension@walkme.com.xpi" "C:\Program Files\Mozilla Firefox\distribution\extensions\"
xcopy /y %FFConfigFile% "C:\Program Files\Mozilla Firefox\browser\defaults\preferences\"
) ELSE (
    ECHO "FireFox 64bit Was Not Found On This Computer"
)
ECHO "Deployment Ended"
:: Firefox 32bit:
ECHO "Searching for Firefox 32-bit"
IF EXIST "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" (
xcopy /y "C:\Program Files\Walkme\WalkmeExtension@walkme.com.xpi" "C:\Program Files (x86)\Mozilla Firefox\distribution\extensions\"
xcopy /y %FFConfigFile% "C:\Program Files (x86)\Mozilla Firefox\browser\defaults\preferences\"
) ELSE (
    ECHO "FireFox 32bit Was Not Found On This Computer"
)
ECHO "Deployment Ended"

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\ManagedStorage\WalkmeExtension@walkme.com /v "@" /t REG_SZ /d "C:\\Program Files\\WalkMe\\Extension\\WalkmeExtension@walkme.com.json" /f