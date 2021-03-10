@echo off

REM increment the version number each creation.
set APP_VERSION=0.3.0

%JAVA_HOME%\bin\jpackage ^
--type msi ^
--win-upgrade-uuid 38d49c58-102e-486b-bfac-8a0f6e796a93 ^
--win-menu-group "High Bridge" ^
--win-menu ^
--win-shortcut ^
--app-version %APP_VERSION% ^
--description "Earth 3D rounding on desktop" ^
--name "EarthGadget" ^
--dest build\installer ^
--vendor "High Bridge" ^
--module-path build\libs;javafx-gadgetsupport\build\libs ^
--module com.torutk.gadget.earth ^
--java-options "-Xms32m -Xmx64m -Xss256k -XX:TieredStopAtLevel=1 -XX:CICompilerCount=2 -XX:CompileThreshold=1500 -XX:InitialCodeCacheSize=160k -XX:ReservedCodeCacheSize=32m -XX:MetaspaceSize=12m -XX:+UseSerialGC" ^
--verbose

