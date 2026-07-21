@Echo off
title Just4Fun ONLY 4 Xeon E3 1230 v3 2bypass cpu bin config win_x64-no fw-1
Pushd "%~dp0"
:loop
msr-cmd.exe -l write 0x610 0x00FFFFFF00FFFFFF
goto loop
