@echo off

GOTO start

:start
python -Wdefault run_bot.py

CHOICE /M "Restart bat?"

IF ERRORLEVEL 2 GOTO end
IF ERRORLEVEL 1 GOTO start

:end