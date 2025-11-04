@echo off
echo Removing all "Blocked:" rules from Windows Firewall...
for /f "tokens=1,* delims=:" %%a in ('netsh advfirewall firewall show rule name^=all ^| findstr /I "Blocked:"') do (
    netsh advfirewall firewall delete rule name="%%a:%%b"
)
echo.
echo Done! All "Blocked:" rules have been removed.
pause
