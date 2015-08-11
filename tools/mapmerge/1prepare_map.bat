SET z_levels=3
cd ../../maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy europa-%%i.dmm europa-%%i.dmm.backup
  copy box-%%i.dmm box-%%i.dmm.backup
)

pause
