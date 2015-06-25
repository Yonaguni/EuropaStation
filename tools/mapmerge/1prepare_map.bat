SET z_levels=2
cd ../../maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy europa-%%i.dmm europa-%%i.dmm.backup
)

pause
