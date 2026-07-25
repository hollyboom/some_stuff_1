@echo off
title XMRig - SOLO MINING REAL PE HERO_MINERS
cd /d "%~dp0"

echo [+] Se porneste XMRig in mod SOLO real...
echo [+] Tinta: ://herominers.com
echo [+] Placa video (OpenCL) este DEZACTIVATA pentru eficienta CPU.
echo [+] Hash rate trebuie sa fie peste 2150 H/s alfel Undervot
echo [+] Ideal peste 2300 H/s
echo [+] Undervolt maxim \0.940 res BSOD
echo [+] Max 70ºC 42W cpu
echo.

:: --no-config opreste incarcarea fisierului JSON blocat
:: --no-opencl opreste placa video RX 570
:: xmrig.exe --donate-level 1 -o 	de.monero.herominers.com -u solo:42NKURwgNdudDbydr6LeZqJmjwYMBETxsLEmPKWTShhr3rPytZsaheq9T8XqHY11CRFD5Hoj4QNGN1K7yF7REHia4B5uY3F.2 -a rx/0 -k --tls



@echo off
xmrig.exe --donate-level 1 -o de.monero.herominers.com:1111 -u solo:42NKURwgNdudDbydr6LeZqJmjwYMBETxsLEmPKWTShhr3rPytZsaheq9T8XqHY11CRFD5Hoj4QNGN1K7yF7REHia4B5uY3F.my1+50000 -a rx/0 -k 
pause





