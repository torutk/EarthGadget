@echo off

"%JAVA_HOME%"\bin\javapackager -deploy -native msi ^
-v ^
-outdir dist -outfile EarthGadget ^
-srcdir dist -srcfiles EarthGadget.jar;lib\GadgetSupport.jar ^
-appclass com.torutk.gadget.earth.EarthGadgetApp ^
-name "EarthGadget" ^
-BappVersion=0.1.0 ^
-title "Earth Gadget" ^
-vendor Takahashi ^
-description "Earth 3D rounding on desktop"

