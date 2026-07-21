:loop 
netsh int ipv4 set glob defaultcurhoplimit=65
ipconfig /flushdns
timeout /t 10
goto :loop 
