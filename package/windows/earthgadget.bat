@echo off
set JLINK_VM_OPTIONS=-Xms32m -Xmx64m -Xss256k ^
-XX:TieredStopAtLevel=1 -XX:CICompilerCount=2 -XX:CompileThreshold=1500 ^
-XX:InitialCodeCacheSize=160k -XX:ReservedCodeCacheSize=32m ^
-XX:MetaspaceSize=12m ^
-XX:+UseSerialGC
set DIR=%~dp0
start "" /b "%DIR%\javaw" %JLINK_VM_OPTIONS% ^
-m com.torutk.gadget.earth/com.torutk.gadget.earth.EarthGadgetApp %*
