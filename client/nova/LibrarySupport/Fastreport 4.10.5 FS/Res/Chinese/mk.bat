..\frcc.exe frxrcClass.xml
..\frcc.exe frxrcDesgn.xml
..\frcc.exe frxrcExports.xml
..\frcc.exe frxrcInsp.xml
copy frxrcClass.pas ..\..\Source
copy frxrcDesgn.pas ..\..\Source
copy frxrcExports.pas ..\..\Source\ExportPack
copy frxrcInsp.pas ..\..\Source
copy *.pas ..\..\LibD15\
del *.pas
pause