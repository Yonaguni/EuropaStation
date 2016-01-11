
cd 

FOR %%f IN (../../maps/*.dmm) DO (
  java -jar MapPatcher.jar -clean ../../maps/%%f.backup ../../maps/%%f ../../maps/%%f
)

pause
