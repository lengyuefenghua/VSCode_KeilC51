@echo off
cls
echo compiling...
.vscode\AutoHotkey.exe .vscode\C51Compiler.ahk 
type %1\output\Results.txt