// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCodeUtils.pas' rev: 22.00

#ifndef FrxcodeutilsHPP
#define FrxcodeutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcodeutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall frxAddCodeRes(void);
extern PACKAGE void __fastcall frxGetEventHandlersList(Classes::TStrings* Code, const System::UnicodeString Language, Typinfo::PTypeInfo EventType, Classes::TStrings* List);
extern PACKAGE int __fastcall frxLocateEventHandler(Classes::TStrings* Code, const System::UnicodeString Language, const System::UnicodeString EventName);
extern PACKAGE int __fastcall frxLocateMainProc(Classes::TStrings* Code, const System::UnicodeString Language);
extern PACKAGE int __fastcall frxAddEvent(Classes::TStrings* Code, const System::UnicodeString Language, Typinfo::PTypeInfo EventType, const System::UnicodeString EventName);
extern PACKAGE void __fastcall frxEmptyCode(Classes::TStrings* Code, const System::UnicodeString Language);

}	/* namespace Frxcodeutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxcodeutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcodeutilsHPP
