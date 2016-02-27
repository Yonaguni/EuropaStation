@echo off
echo node.js 5.3.0 or newer must be installed for this script to work.
echo If this script fails, try closing editors and running it again first.
echo Any warnings about optional dependencies can be safely ignored.
pause
echo Install Gulp
cmd /c npm install gulp-cli
echo Install tgui dependencies
cmd /c npm install
echo Flatten dependency tree
cmd /c npm dedupe
echo Clean dependency tree
cmd /c npm prune
pause
