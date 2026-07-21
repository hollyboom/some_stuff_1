@Echo off
title Just4Fun ONLY
Pushd "%~dp0"
:loop
msr-cmd.exe -l write 0x610 0x00FFFFFF00FFFFFF
goto loop