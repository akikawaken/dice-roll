@echo off
if exist dice.tcf ( goto loadsetting ) ELSE ( goto dice )
:dice
echo dice roll! (max:32767)
echo if u type "license", can see license!
set /p dice=1d
if %dice% == license goto license
echo start!
set countlog=0
set logtime=%date%-%time%
:roll
set check= %random%
set /a countlog=%countlog% + 1
if %showall% == true echo %check%
if %count% == true echo %countlog% 
if %showallforlog% == true echo %check%>> dice%logtime%.log
if %showcountforlog% == true echo %countlog%>> dice%logtime%.log
if %stopatzero% == true if %check% == 0 pause
if %check% LEQ %dice% ( if not %check% == 0 ( goto done ) ELSE ( goto roll) ) ELSE ( goto roll )
:done
if %count% == true echo total : %countlog% 
echo 1d%dice% -^>%check%
if %log% == true echo 1d%dice% -^>%check%>> dice%logtime%.log
pause
if %noexit% == true goto dice
exit
:license
echo;
echo MIT License
echo;
echo Copyright (c) 2023 akikawa9616
echo;
echo Permission is hereby granted, free of charge, to any person obtaining a copy
echo of this software and associated documentation files (the "Software"), to deal
echo in the Software without restriction, including without limitation the rights
echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo copies of the Software, and to permit persons to whom the Software is
echo furnished to do so, subject to the following conditions:
echo;
echo The above copyright notice and this permission notice shall be included in all
echo copies or substantial portions of the Software.
echo;
echo THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo SOFTWARE.
pause
exit
:loadsetting
for /f "tokens=1-7" %%a in (dice.tcf) do (
  if %%a == log:true ( set log=true ) ELSE ( set log=false )
  if %%b == ShowAll:true ( set showall=true ) ELSE ( set showall=false )
  if %%c == NoExit:true ( set noexit=true ) ELSE ( set noexit=false )
  if %%d == Count:true ( set count=true ) ELSE ( set count=false )
  if %%e == ShowCountForLog:true ( set showcountforlog=true ) ELSE ( set showcountforlog=false )
  if %%f == ShowAllForLog:true ( set showallforlog=true ) ELSE ( set showallforlog=false )
  if %%g == StopAtZero:true ( set stopatzero=true ) ELSE ( set stopatzero=false )
)
echo setting file found
echo;
  echo log %log%
  echo showall %showall%
  echo noexit %noexit%
  echo count %count%
  echo showcountforlog %showcountforlog%
  echo showallforlog %showallforlog%
  echo stopatzero %stopatzero%
echo;
goto dice