@echo off

if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Preview\MSBuild\Current\Bin" goto vs16prev
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin" goto vs16ent
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin" goto vs16pro
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin" goto vs16com
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin" goto vs16build

echo "Unable to detect suitable environment. Check if VS 2019 is installed."
exit 1

goto CheckVersionChange

:CheckVersionChange
echo Have you made sure that you have changed the build/release number before publishing? (Y/N)
set INPUT=
set /P INPUT=Type input: %=%
If /I "%INPUT%"=="y" goto yes
If /I "%INPUT%"=="n" goto no
echo Unknown response & goto CheckVersionChange

:yes

:vs16prev
set msbuildpath=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Preview\MSBuild\Current\Bin
goto build

:vs16ent
set msbuildpath=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin
goto build

:vs16pro
set msbuildpath=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin
goto build

:vs16com
set msbuildpath=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin
goto build

:vs16build
set msbuildpath=%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin
goto build

:build
set targets=Build
if not "%~1" == "" set targets=%~1
"%msbuildpath%\msbuild.exe" /t:%targets% build.proj /fl /flp:logfile=build.log

:no
echo Plese alter file '{Path}\filename' before executing script.
pause