@echo off

%JAVA_HOME%\bin\jpackage ^
--type msi ^
--win-upgrade-uuid 38d49c58-102e-486b-bfac-8a0f6e796a93 ^
--win-menu-group "High Bridge" ^
--win-menu ^
--win-shortcut ^
--app-version 0.2.4 ^
--description "Earth 3D rounding on desktop" ^
--name "EarthGadget" ^
--dest build\installer ^
--vendor Takahashi ^
--copyright "Copyright 2020 by TAKAHASHI,Toru. Licensed under APL2" ^
--module-path build\libs;javafx-gadgetsupport\build\libs ^
--module com.torutk.gadget.earth ^
--java-options "-Xms32m -Xmx64m -Xss256k -XX:TieredStopAtLevel=1 -XX:CICompilerCount=2 -XX:CompileThreshold=1500 -XX:InitialCodeCacheSize=160k -XX:ReservedCodeCacheSize=32m -XX:MetaspaceSize=12m -XX:+UseSerialGC" ^
--verbose

