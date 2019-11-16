// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxFileUtils.pas' rev: 22.00

#ifndef FrxfileutilsHPP
#define FrxfileutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ShlObj.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxfileutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE int __fastcall GetFileSize(const System::UnicodeString FileName);
extern PACKAGE int __fastcall StreamSearch(Classes::TStream* Strm, const int StartPos, const System::AnsiString Value);
extern PACKAGE System::UnicodeString __fastcall BrowseDialog(const System::UnicodeString Path, const System::UnicodeString Title = L"");
extern PACKAGE void __fastcall DeleteFolder(const System::UnicodeString DirName);
extern PACKAGE System::UnicodeString __fastcall GetFileMIMEType(const System::UnicodeString Extension);

}	/* namespace Frxfileutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxfileutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxfileutilsHPP
