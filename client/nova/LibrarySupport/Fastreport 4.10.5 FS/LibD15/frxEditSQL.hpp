// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditSQL.pas' rev: 22.00

#ifndef FrxeditsqlHPP
#define FrxeditsqlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <frxSynMemo.hpp>	// Pascal unit
#include <frxCustomDB.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <fqbClass.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditsql
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxSQLEditorForm;
class PASCALIMPLEMENTATION TfrxSQLEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar;
	Comctrls::TToolButton* OkB;
	Comctrls::TToolButton* CancelB;
	Comctrls::TToolButton* QBB;
	Comctrls::TToolButton* ParamsB;
	Comctrls::TToolButton* ToolButton2;
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall MemoKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall QBBClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ParamsBClick(System::TObject* Sender);
	
private:
	Frxsynmemo::TfrxSyntaxMemo* FMemo;
	Frxcustomdb::TfrxCustomQuery* FQuery;
	Fqbclass::TfqbEngine* FQBEngine;
	Classes::TStrings* FSaveSQL;
	System::UnicodeString FSaveSchema;
	Frxcustomdb::TfrxParams* FSaveParams;
	
public:
	__property Frxcustomdb::TfrxCustomQuery* Query = {read=FQuery, write=FQuery};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxSQLEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxSQLEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxSQLEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxSQLEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxeditsql */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxeditsql;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditsqlHPP
