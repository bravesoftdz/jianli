// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerForms.pas' rev: 22.00

#ifndef FrxserverformsHPP
#define FrxserverformsHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxDCtrl.hpp>	// Pascal unit
#include <frxUtils.hpp>	// Pascal unit
#include <frxExportMatrix.hpp>	// Pascal unit
#include <frxServerFormControls.hpp>	// Pascal unit
#include <frxUnicodeUtils.hpp>	// Pascal unit
#include <frxServerTemplates.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverforms
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxWebForm;
class PASCALIMPLEMENTATION TfrxWebForm : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Classes::TFileStream* Exp;
	Frxexportmatrix::TfrxIEMatrix* FMatrix;
	Frxclass::TfrxDialogPage* FDialog;
	System::UnicodeString FRepName;
	System::UnicodeString FSession;
	void __fastcall WriteExpLn(const System::AnsiString str)/* overload */;
	void __fastcall WriteExpLn(const System::UnicodeString str)/* overload */;
	System::AnsiString __fastcall GetHTML(Frxclass::TfrxDialogControl* Obj);
	
public:
	__fastcall TfrxWebForm(Frxclass::TfrxDialogPage* Dialog, System::UnicodeString Session);
	__fastcall virtual ~TfrxWebForm(void);
	void __fastcall Prepare(void);
	void __fastcall Clear(void);
	void __fastcall SaveFormToFile(System::UnicodeString FName);
	__property System::UnicodeString ReportName = {read=FRepName, write=FRepName};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxserverforms */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxserverforms;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverformsHPP
