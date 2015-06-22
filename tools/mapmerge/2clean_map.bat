SET z_levels=1
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../maps/europa-%%i.dmm.backup ../../maps/europa-%%i.dmm ../../maps/europa-%%i.dmm
)

pause