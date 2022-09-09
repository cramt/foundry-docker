@echo off
for /f %%f in ('dir /b foundry_zips\') do build.bat %%f
