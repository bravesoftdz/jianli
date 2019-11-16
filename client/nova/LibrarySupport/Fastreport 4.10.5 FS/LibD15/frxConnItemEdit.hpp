// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxConnItemEdit.pas' rev: 22.00

#ifndef FrxconnitemeditHPP
#define FrxconnitemeditHPP

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
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxconnitemedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxConnectionItemEdit;
class PASCALIMPLEMENTATION TfrxConnectionItemEdit : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Stdctrls::TLabel* ConnL;
	Stdctrls::TEdit* ConnE;
	Stdctrls::TButton* ConnB;
	Stdctrls::TButton* OkB;
	Stdctrls::TButton* CancelB;
	Stdctrls::TLabel* NameL;
	Stdctrls::TEdit* NameE;
	Stdctrls::TGroupBox* GroupBox1;
	Stdctrls::TRadioButton* SystemRB;
	Stdctrls::TRadioButton* UserRB;
	void __fastcall ConnBClick(System::TObject* Sender);
	
public:
	Frxclass::TfrxReport* Report;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxConnectionItemEdit(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxConnectionItemEdit(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxConnectionItemEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxConnectionItemEdit(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfrxConnectionItemEdit* frxConnectionItemEdit;

}	/* namespace Frxconnitemedit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxconnitemedit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxconnitemeditHPP
