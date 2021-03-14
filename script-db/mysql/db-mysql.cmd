@echo off

if "%MYSQL_HOME%" == "" goto SETUP
goto INIT

#------------------------------------------------------------------------------
# Setup environmental variales for MySQL
#------------------------------------------------------------------------------
:SETUP
set MYSQL_HOME=C:\db\mysql
set MYSQL_PATH=%PATH%
set PATH=%MYSQL_HOME%\bin;%PATH%
goto INIT

#------------------------------------------------------------------------------
# Check for input parameters
#------------------------------------------------------------------------------
:INIT
if "%1" == "console.start" goto CONSOLE_START
if "%1" == "console.stop" goto CONSOLE_STOP

if "%1" == "service.install" goto INSTALL
if "%1" == "service.uninstall" goto UNINSTALL
if "%1" == "service.start" goto SERVICE_START
if "%1" == "service.stop" goto SERVICE_STOP

if "%1" == "reset" goto RESET
goto USAGE

#------------------------------------------------------------------------------
# Install MySQL as windows service
#------------------------------------------------------------------------------
:INSTALL
mysqld --install MySQL
goto END

#------------------------------------------------------------------------------
# Uninstall MySQL windows service
#------------------------------------------------------------------------------
:UNINSTALL
net stop MySQL
mysqld --remove
goto END

#------------------------------------------------------------------------------
# Start MySQL console
#------------------------------------------------------------------------------
:CONSOLE_START
mysqld --console
goto END

#------------------------------------------------------------------------------
# Stop MySQL console
#------------------------------------------------------------------------------
:CONSOLE_STOP
mysqladmin -u root -p shutdown
goto END

#------------------------------------------------------------------------------
# Start MySQL windows service
#------------------------------------------------------------------------------
:SERVICE_START
net start MySQL
goto END

#------------------------------------------------------------------------------
# Stop MysQL windows service
#------------------------------------------------------------------------------
:SERVICE_STOP
net stop MySQL
goto RESET

#------------------------------------------------------------------------------
# Reset environmental variables
#------------------------------------------------------------------------------
:RESET
if not "%MYSQL_PATH%" == "" set PATH=%MYSQL_PATH%
set MYSQL_PATH=
set MYSQL_HOME=
goto END

#------------------------------------------------------------------------------
# Display usage info
#------------------------------------------------------------------------------
:USAGE
echo.
echo Usage: %0 [options]
echo where options are
echo.
echo   console.start     Start MySQL console   
echo   console.stop      Stop MySQL console   
echo.
echo   service.install   Install MySQL as windows service
echo   service.uninstall Uninstall MySQL windows service
echo   service.start     Start MySQL Windows service
echo   service.stop      Stop MySQL Windows service
echo.
echo   reset             Reset environment variables
echo.
goto END

:END

@echo on
