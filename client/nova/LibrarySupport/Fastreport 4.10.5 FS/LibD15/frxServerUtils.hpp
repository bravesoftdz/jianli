// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerUtils.pas' rev: 22.00

#ifndef FrxserverutilsHPP
#define FrxserverutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <frxUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverutils
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TfrxServerFormat { sfHTM, sfXML, sfXLS, sfRTF, sfCSV, sfTXT, sfPDF, sfJPG, sfBMP, sfTIFF, sfGIF, sfFRP, sfODS, sfODT };
#pragma option pop

typedef System::Set<TfrxServerFormat, TfrxServerFormat::sfHTM, TfrxServerFormat::sfODT>  TfrxServerOutputFormats;

#pragma option push -b-
enum TfrxHTTPQueryType { qtGet, qtPost, qtHead };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::AnsiString __fastcall StrToHex(const System::AnsiString s);
extern PACKAGE System::AnsiString __fastcall HexToStr(const System::AnsiString s);
extern PACKAGE System::AnsiString __fastcall Byte2Hex(const System::Byte b);
extern PACKAGE System::AnsiString __fastcall GetHTTPErrorText(const int ErrorCode);
extern PACKAGE System::UnicodeString __fastcall GetUniqueFileName(const System::UnicodeString Path, const System::UnicodeString Prefix);
extern PACKAGE System::AnsiString __fastcall Str2HTML(const System::AnsiString Str);
extern PACKAGE System::AnsiString __fastcall HTML2Str(const System::AnsiString Line);
extern PACKAGE System::AnsiString __fastcall UnQuoteStr(const System::AnsiString s);
extern PACKAGE System::UnicodeString __fastcall GetEnvVar(const System::UnicodeString VarName);
extern PACKAGE System::AnsiString __fastcall MakeSessionId(void);
extern PACKAGE System::UnicodeString __fastcall frxGetAbsPath(const System::UnicodeString Path);
extern PACKAGE System::UnicodeString __fastcall frxGetAbsPathDir(const System::UnicodeString Path, const System::UnicodeString Dir);
extern PACKAGE System::UnicodeString __fastcall frxGetRelPath(const System::UnicodeString Path);
extern PACKAGE System::UnicodeString __fastcall frxGetRelPathDir(const System::UnicodeString Path, const System::UnicodeString Dir);
extern PACKAGE void __fastcall frxTouchDir(const System::UnicodeString Path);

}	/* namespace Frxserverutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxserverutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverutilsHPP
