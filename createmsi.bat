@echo off

:: Usage
::   createmsi [jlink] [wix]
::   jlink    execute jlink
::   wix      execute heat, candle, light
::   if no option is specified, execute jlink and wix.

setlocal
set RUNTIME_PATH=runtime
set JAVAFX_JMOD_PATH="C:\Program Files\Java\JavaFX\javafx-jmods-11.0.1"
set MAIN_MODULE=com.torutk.gadget.earth
set MAIN_CLASS=%MAIN_MODULE%.EarthGadgetApp
set LAUNCHER=earthgadget
set TARGET_BASE=EarthGadget
set ENABLE_JLINK=0
set ENABLE_WIX=0

if "%1"=="" (
   set ENABLE_JLINK=1
   set ENABLE_WIX=1
)
if "%1"=="jlink" (
   set ENABLE_JLINK=1
   @shift
)
if "%1"=="wix" (
   set ENABLE_WIX=1
   @shift
)

:: move current directory on this file
cd /d %~dp0


if not "%ENABLE_JLINK%"=="1" goto WIX

:JLINK
if exist %RUNTIME_PATH% (
   echo # removing old runtime directory.
   rmdir /S /Q %RUNTIME_PATH%
)

echo # JLINK to create runtime image
jlink --module-path %JAVAFX_JMOD_PATH%;build\modules;javafx-gadgetsupport\build\modules ^
 --add-modules %MAIN_MODULE% ^
 --launcher %LAUNCHER%=%MAIN_MODULE%/%MAIN_CLASS% ^
 --compress=2 --no-header-files --output %RUNTIME_PATH%

if ERRORLEVEL 1 goto FAIL_JLINK

copy package\windows\%LAUNCHER%.bat %RUNTIME_PATH%\bin

if not "%ENABLE_WIX%"=="1" goto END

:WIX
if exist runtime.wxs (
   echo # removing old runtime.wxs
   del runtime.wxs
)

if not exist %RUNTIME_PATH% goto FAIL_NO_RUNTIME

:: harvest runtime image files
echo # HEAT to harvest runtime image
heat dir %RUNTIME_PATH% -nologo -srd -dr APPLICATIONFOLDER ^
 -cg RuntimeGroup -gg -g1 -sfrag -sreg ^
 -var "var.runtimeFolder" -o runtime.wxs

if ERRORLEVEL 1 goto FAIL_HEAT

:: candle wxs
echo # CANDLE to compile %TARGET_BASE%.wxs
candle -nologo -arch x64 package\windows\%TARGET_BASE%.wxs >nul
if ERRORLEVEL 1 goto FAIL_CANDLE

echo # CANDLE to compile runtime.wxs
candle -nologo -arch x64 -druntimeFolder=%RUNTIME_PATH% runtime.wxs >nul
if ERRORLEVEL 1 goto FAIL_CANDLE

:: light
echo # LIGHT to create MSI installer
light -nologo %TARGET_BASE%.wixobj runtime.wixobj -o %TARGET_BASE%.msi ^
-ext WixUIExtension
if ERRORLEVEL 1 goto FAIL_LIGHT

:: validate
if not exist %TARGET_BASE%.msi (
   echo ERROR: %TARGET_BASE%.msi cannot exist.
   goto FAIL_MSI
)
echo SUCCESSFULLY created %TARGET_BASE%.msi
goto END

:FAIL_JLINK
echo ERROR: jlink cannot create runtime image.
goto END

:FAIL_NO_RUNTIME
echo ERROR: no runtime image. do jlink before wix.
goto END

:FAIL_HEAT
echo ERROR: heat cannot harvest
goto END

:FAIL_CANDLE
echo ERROR: candle cannot compile
goto END

:FAIL_LIGHT
echo ERROR: light cannot link
goto END

:END
endlocal
