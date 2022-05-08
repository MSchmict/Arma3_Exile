@echo off
color 0a
title Exile Monitor
:Serverstart
echo Launching Server
C: 
cd "C:\Users\Administrator\Desktop\Arma3\Arma3"
echo Exile Server Monitor... Active !
start "Arma3" /min /wait arma3server.exe -mod=@exilemod;@Extended_Base_Mod; -servermod=@exileserver;@infiSTAR_Exile;@Extended_Base_Mod;@Enigma; -config=C:\Users\Administrator\Desktop\Arma3\Arma3\@ExileServer\config.cfg -port=2302 -profiles=SC -cfg=C:\Users\Administrator\Desktop\Arma3\Arma3\@ExileServer\basic.cfg -name=SC -autoinit
ping 127.0.0.1 -n 15 >NUL
echo Exile Server Shutdown ... Restarting!
ping 127.0.0.1 -n 5 >NUL
cls
goto Serverstart