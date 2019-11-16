// AcDemoShowDsg.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#import "c:\program files\common files\system\ado\msado15.dll" no_namespace
#import "E:\controls\ACreport\COM\com\acreport.dll"  no_namespace


int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
 	// TODO: Place code here.

	CoInitialize(NULL);
    IAcRptEnginePtr ac;
    ac.CreateInstance(__uuidof(AcRptEngine));      
	ac->ShowDesigner();
	ac.Release();
	CoUninitialize();
 
	return 0;
}



