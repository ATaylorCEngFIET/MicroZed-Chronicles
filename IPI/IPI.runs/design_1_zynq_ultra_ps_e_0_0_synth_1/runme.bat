@echo off

rem  Vivado (TM)
rem  runme.bat: a Vivado-generated Script
rem  Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.


set HD_SDIR=%~dp0
cd /d "%HD_SDIR%"
cscript /nologo /E:JScript "%HD_SDIR%\rundef.js" %*
