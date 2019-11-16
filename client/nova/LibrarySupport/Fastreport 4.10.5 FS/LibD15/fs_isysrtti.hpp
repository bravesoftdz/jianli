// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fs_isysrtti.pas' rev: 22.00

#ifndef Fs_isysrttiHPP
#define Fs_isysrttiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <fs_iinterpreter.hpp>	// Pascal unit
#include <fs_itools.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <MaskUtils.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <ComObj.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fs_isysrtti
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfsSysFunctions;
class PASCALIMPLEMENTATION TfsSysFunctions : public Fs_iinterpreter::TfsRTTIModule
{
	typedef Fs_iinterpreter::TfsRTTIModule inherited;
	
private:
	System::UnicodeString FCatConv;
	System::UnicodeString FCatDate;
	System::UnicodeString FCatFormat;
	System::UnicodeString FCatMath;
	System::UnicodeString FCatOther;
	System::UnicodeString FCatStr;
	System::Variant __fastcall CallMethod1(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod2(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod3(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod4(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod5(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod6(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	System::Variant __fastcall CallMethod7(System::TObject* Instance, System::TClass ClassType, const System::UnicodeString MethodName, Fs_iinterpreter::TfsMethodHelper* Caller);
	
public:
	__fastcall virtual TfsSysFunctions(Fs_iinterpreter::TfsScript* AScript);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfsSysFunctions(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Fs_isysrtti */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Fs_isysrtti;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fs_isysrttiHPP
