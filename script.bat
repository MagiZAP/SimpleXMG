@echo off
color 0B

echo Welcome to SimpleXMG - cpuminer-opt configuration assistant!
echo.
echo.
echo.
echo SELECT YOUR CPU ARCHITECTURE:
echo [1] - Core2, Nehalem, generic x86_64 with SSE2              (cpuminer-sse2.exe)
echo [2] - Westmere                                              (cpuminer-aes-sse42.exe)
echo [3] - Sandybridge, Ivybridge                                (cpuminer-avx.exe)
echo [4] - Haswell, Skylake, Kabylake, Coffeelake, Cometlake     (cpuminer-avx2.exe)
echo [5] - AMD Zen1, Zen2                                        (cpuminer-avx2-sha.exe)
echo [6] - Intel Alderlake, AMD Zen3                             (cpuminer-avx2-sha-vaes.exe)
echo [7] - Intel HEDT Skylake-X, Cascadelake                     (cpuminer-avx512.exe)
echo [8] - AMD Zen4, Intel Rocketlake, Icelake                   (cpuminer-avx512-sha-vaes.exe)
echo.

:architecture
set /p architecture=" Type 1-8 and hit Enter: "

if "%architecture%"=="1" (
    set "command=cpuminer-sse2.exe -a m7m"
) else if "%architecture%"=="2" (
    set "command=cpuminer-aes-sse42.exe -a m7m"
) else if "%architecture%"=="3" (
    set "command=cpuminer-avx.exe -a m7m"
) else if "%architecture%"=="4" (
    set "command=cpuminer-avx2.exe -a m7m"
) else if "%architecture%"=="5" (
    set "command=cpuminer-avx2-sha.exe -a m7m"
) else if "%architecture%"=="6" (
    set "command=cpuminer-avx2-sha-vaes.exe -a m7m"
) else if "%architecture%"=="7" (
    set "command=cpuminer-avx512.exe -a m7m"
) else if "%architecture%"=="8" (
    set "command=cpuminer-avx512-sha-vaes.exe -a m7m"
) else (
    echo Invalid input.
    echo.
    goto architecture
)

echo.
echo.

:type
echo DO YOU WANT TO SOLO-MINE OR POOL-MINE?
set /p type="Type 'solo' or 'pool' and hit Enter: "

if /i "%type%"=="solo" (
    echo.
    echo.
    echo MAKE SURE THESE LINES ARE INCLUDED IN THE 'magi.conf' FILE LOCATED AT 'C:\Users\YOUR_USERNAME\AppData\Magi':
    echo rpcuser=SET_A_USERNAME
    echo rpcpassword=SET_A_PASSWORD
    echo rpcport=8232
    echo rpcallowip=127.0.0.1
    echo.
    pause
    echo.
    echo.
    set /p solouser="ENTER THE RPC USERNAME FROM THE 'magi.conf' FILE: "
    echo.
    echo.
    set /p solopass="ENTER THE RPC PASSWORD FROM THE 'magi.conf' FILE: "
    echo.
    echo.
    set /p solothreads="SET THE NUMBER OF THREADS: "
    goto check
) else if /i "%type%"=="pool" (
    echo.
    echo.
    set /p poolurl="ENTER THE FULL POOL URL (e. g. stratum+tcp://bowserlab.ddns.net:6033): "
    echo.
    echo.
    set /p pooluser="ENTER YOUT POOL USERNAME (often a wallet address): "
    echo.
    echo.
    set /p poolpass="ENTER YOUR POOL PASSWORD (multi-crypto pools often use c=XMG): "
    echo.
    echo.
    set /p poolthreads="SET THE NUMBER OF THREADS: "
) else (
    echo Invalid input.
    echo.
    goto type
)
if not "%poolurl%"=="" (
    if not "%pooluser%"=="" (
        if not "%poolpass%"=="" (
            if not "%poolthreads%"=="" (
                set "command=%command% -o %poolurl% -u %pooluser% -p %poolpass% -t %poolthreads%"
                goto save
            )
        )
    )
)
echo Invalid input.
echo.
goto type

:check
if not "%solouser%"=="" (
    if not "%solopass%"=="" (
        if not "%solothreads%"=="" (
            set "command=%command% -o http://127.0.0.1:8232 -u %solouser% -p %solopass% -t %solothreads%"
            goto save
        )
    )
)
echo Invalid input.
echo.
goto type

:save
echo %command% > miner.bat

echo.
echo.
echo Config file "miner.bat" was created successfully!
echo.
echo.
echo.
echo INSTRUCTIONS:
echo Move the file to the cpuminer-opt folder, otherwise the mining software won't start.
echo If you want to have the file in a different location, then create a shortcut and keep the original file in the cpuminer-opt folder.
echo You can rename the file to anything you like.
echo Run the file to start mining.
echo.
echo.
echo.
echo Thank you for using SimpleXMG by MagiZAP!
echo XMG donation address: 998QXLkP9zjf7G3AE5JdWkBS7Kt83A6kEu
echo.
echo You can now close this window.
pause
