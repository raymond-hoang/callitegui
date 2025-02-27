@echo off
rem ##############################
rem Batch file for running vscript
rem ##############################
set vista_home=%~dp0/vscript/lib/vista
set jre_home=%~dp0../jre6/

if exist "%vista_home%/jython/jython.jar" goto :valid


:notfound

echo ############################################################
echo   Error: VISTA files not found
echo   ___
echo   Installation instructions
echo   ___
echo   The value of the environment variable vista_home in the 
echo   file vscript.bat needs to match the location where
echo   VISTA has been installed
echo ############################################################
PAUSE
goto :end

:valid

setlocal
rem ###############
rem Set path to location of dll
rem ###############

set wrims2_home=%~dp0/lib/
set misc_home=%~dp0/vscript/lib/misc

set PATH=%path%;%vista_home%/bin;%vista_home%/lib;

set PYPATH="%vista_home%/jython/Lib;%vista_home%/lib/Lib;%DSM2_HOME%/scripts"

set CPATH="%vista_home%/lib/vista.jar;%vista_home%/lib/vista-help.jar;%vista_home%/jython/jython.jar;%vista_home%/lib/pd.jar;%vista_home%/lib/misc.jar;%vista_home%/lib/jhall.jar;%vista_home%/lib/jnios.jar;%vista_home%/lib/widgets.jar;%vista_home%/lib/jhdf5.jar;%vista_home%/lib/jhdf5obj.jar;%vista_home%/lib/jhdfobj.jar;%vista_home%/lib/heclib.jar;%vista_home%/lib/dsm2-input-model.jar;%vista_home%/lib/ojdbc6.jar"

set CPATH="%vista_home%/lib/vista.jar;%vista_home%/lib/vista-help.jar;%vista_home%/jython/jython.jar;%vista_home%/lib/pd.jar;%vista_home%/lib/misc.jar;%vista_home%/lib/jhall.jar;%vista_home%/lib/jnios.jar;%vista_home%/lib/widgets.jar;%vista_home%/lib/jhdf5.jar;%vista_home%/lib/jhdf5obj.jar;%vista_home%/lib/jhdfobj.jar;%vista_home%/lib/dsm2-input-model.jar;%vista_home%/lib/ojdbc6.jar"

set HECPATH=%vista_home%/lib/heclib.jar;%vista_home%/lib/hec.jar;%vista_home%/lib/hecData.jar;%vista_home%/lib/rma.jar;%vista_home%/lib/dssvueHelp.jar;%vista_home%/lib/images.jar;

set CPATH=%CPATH%;%HECPATH%;"%wrims2_home%/WRIMSv2.jar;%misc_home%/wvscript.jar"

set LPATH="%vista_home%/lib" 

set PYHOME="%vista_home%/jython"

set ARGS=

:loop
if [%1] == [] goto endloop
        set ARGS=%ARGS% %1
        shift
        goto loop
:endloop

rem ###############
rem starting vscript
rem ###############

if defined ARGS goto run2

:run1
"%jre_home%\bin\java" -mx800m  -Djava.library.path=%LPATH% -Dvista.home="%vista_home%" -Dpython.home=%PYHOME% -Dpython.path=%PYPATH% -classpath %CPATH% org.python.util.jython -i "%vista_home%/lib/__init__.py"
goto end

:run2
"%jre_home%\bin\java" -mx800m  -Djava.library.path=%LPATH% -Dvista.home="%vista_home%" -Dpython.home=%PYHOME% -Dpython.path=%PYPATH% -classpath %CPATH% org.python.util.jython -i  %ARGS%

endlocal
:end 
