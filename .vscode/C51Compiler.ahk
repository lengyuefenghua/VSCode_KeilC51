
SetRegView 64
RegRead, OutputVar, HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Keil\Products\C51, Path
Keil_BIN := OutputVar . "\BIN"
tmp := StrSplit(A_ScriptDir,"\.vscode") 
Project_Path := tmp[1]
src := Project_Path . "\src"
output := Project_Path . "\output" 
lib := Project_Path . "\lib" 
inc := lib . "\inc"	

;msgbox Keil_BIN: %Keil_BIN%`nProject_Path: %Project_Path%`nsrc: %src%`noutput: %output%`nlib: %lib%`ninc: %inc%
global errors_count = 0
global warnings_count = 0
global temp1 = 
global ObjName :=inc . "\C51S.LIB"
global flag = 0

SetWorkingDir %src%
runwait, %comspec% /c %Keil_BIN%\A51.exe "%src%\STARTUP.A51" SET (SMALL) DEBUG PRINT(%output%\STARTUP.lst) OBJECT(%output%\STARTUP.obj) EP,,Hide
objFolder :=   ComObjCreate("Shell.Application").NameSpace(src)
for item in objFolder.items
   if   Not item.isFolder
	{
		OldStr:=item.Name
		Needle = .c  	
		IfInString,OldStr,%Needle%
		{
			arr := StrSplit(OldStr,".") 
			OldStr := arr[1] 
			cmd = %Keil_BIN%\C51.exe "%OldStr%.c" OMF2 OPTIMIZE (8,SPEED) BROWSE INCDIR(%lib%;%lib%\inc) DEBUG PRINT(%output%\%OldStr%.lst) OBJECT(%output%\%OldStr%.obj)
			runwait, %comspec% /c %cmd% | clip,,Hide
			t := StrSplit(clipboard,"reserved."," `t`r`n") 
			t := StrSplit(t[2],"C51 COMPILATION COMPLETE."," `t`r`n") 
		    if InStr(clipboard, "0 WARNING(S),  0 ERROR(S)") = 0
			{
				arr := StrSplit(clipboard,"reserved."," `t`r`n") 
			    arr := StrSplit(arr[2],"C51 COMPILATION COMPLETE."," `t`r`n")
                temp1 := temp1 . arr[1] . "`r`n"
				warnings_count +=  SubStr(arr[2],1,2) 
				errors_count +=  SubStr(arr[2], 16, 2) 
				flag = 1 
			}
		}
	}
if flag
{
	goto endCompile
}

Link:
objFolder :=   ComObjCreate("Shell.Application").NameSpace(output)
for item in objFolder.items
   if   Not item.isFolder
	{
		OldStr:=item.Name
		Needle = .OBJ  	
		IfInString,OldStr,%Needle%
		{
			ObjName := ObjName . "," . OldStr
		}
	}
;ObjName := SubStr(ObjName, 2)
;msgbox %Objname%
runwait, %comspec% /c cd %output%&%Keil_BIN%\LX51.exe %ObjName% TO main REMOVEUNUSED | CLIP,,Hide
;msgbox %Clipboard%
if InStr(clipboard, "0 WARNING(S),  0 ERROR(S)") = 0
{
	arr := StrSplit(clipboard,"REMOVEUNUSED"," `n`r") 
	temp1 := temp1 . arr[2] . "`r`n"
	errors_count++
	goto Endlink
}
Else
{
	arr := StrSplit(clipboard,"REMOVEUNUSED"," `n`r") 
	arr := StrSplit(arr[2],"LX51"," `n`r") 
	temp1 := temp1 . arr[1] . "`r`n"
}

CreateHex:
	runwait, %comspec% /c %Keil_BIN%\OHx51.exe %output%\main HEX,,Hide

endHex:
	FileDelete,  %Project_Path%\output\Results.txt
	FileAppend, 
	(
linking...
Creating Hex file...
%temp1%
%errors_count%  Error(s) , %warnings_count%  Warning(s)`n
Build Successfully!!!
%Project_Path%
	), %Project_Path%\output\Results.txt
	FileAppend, sss,*
	SoundPlay, *64
return

Endlink:
	FileDelete,  %Project_Path%\output\Results.txt
	FileAppend, 
	(
linking...
%temp1%
%errors_count%  Error(s) , %warnings_count%  Warning(s)`n
Build Failed!!!
%Project_Path%
	), %Project_Path%\output\Results.txt
	SoundPlay, *64
return

endCompile:
	FileDelete,  %Project_Path%\output\Results.txt
	FileAppend, 
	(
%temp1%
%errors_count%  Error(s) , %warnings_count%  Warning(s)`n
Build Failed!!!
%Project_Path%
	), %Project_Path%\output\Results.txt
	SoundPlay, *64
return
