@echo off

rem This defines the installation directory, please change it:
set PSPSDKDIR=C:\pspsdk15\psp

echo Files will be copied to the following directory:
echo %PSPSDKDIR%
echo Please verify that it's correct, or edit this batch file.
pause

echo *****************
echo * Archive files *
echo *****************
echo %PSPSDKDIR%\lib
pause
copy liboslModAudio112.a %PSPSDKDIR%\lib
rem copy ..\OSTools\libost.a %PSPSDKDIR%\lib
IF ERRORLEVEL 1 GOTO ERROR

echo *****************
echo * Include files *
echo *****************

echo %PSPSDKDIR%\include\%OSLIBDIR%
pause

mkdir %PSPSDKDIR%\include\oslibAudio

cd source
copy audio.h %PSPSDKDIR%\include\oslibAudio
copy bgm.h %PSPSDKDIR%\include\oslibAudio
copy oslib.h %PSPSDKDIR%\include\oslibAudio
copy VirtualFile.h %PSPSDKDIR%\include\oslibAudio


IF ERRORLEVEL 1 GOTO ERROR
echo Installation completed successfully.
pause
exit

:ERROR
color c
echo Installation failed. Please verify the installation path!
pause
