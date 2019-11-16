// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxRC4.pas' rev: 22.00

#ifndef Frxrc4HPP
#define Frxrc4HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxrc4
{
//-- type declarations -------------------------------------------------------
typedef System::Byte *PByte;

class DELPHICLASS TfrxRC4;
class PASCALIMPLEMENTATION TfrxRC4 : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::StaticArray<System::Byte, 256> FKey;
	void __fastcall xchg(System::Byte &byte1, System::Byte &byte2);
	
public:
	void __fastcall Start(void * Key, int KeyLength);
	void __fastcall Crypt(void * Source, void * Target, int Length);
public:
	/* TObject.Create */ inline __fastcall TfrxRC4(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxRC4(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxrc4 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxrc4;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxrc4HPP
