// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditQueryParams.pas' rev: 22.00

#ifndef FrxeditqueryparamsHPP
#define FrxeditqueryparamsHPP

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
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <frxCustomDB.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditqueryparams
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxParamsEditorForm;
class PASCALIMPLEMENTATION TfrxParamsEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TListView* ParamsLV;
	Stdctrls::TComboBox* TypeCB;
	Stdctrls::TEdit* ValueE;
	Stdctrls::TButton* OkB;
	Stdctrls::TButton* CancelB;
	Extctrls::TPanel* ButtonPanel;
	Buttons::TSpeedButton* ExpressionB;
	void __fastcall ParamsLVSelectItem(System::TObject* Sender, Comctrls::TListItem* Item, bool Selected);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ParamsLVMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ValueEButtonClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
private:
	Frxcustomdb::TfrxParams* FParams;
	
public:
	__property Frxcustomdb::TfrxParams* Params = {read=FParams, write=FParams};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxParamsEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxParamsEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxParamsEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxParamsEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxeditqueryparams */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxeditqueryparams;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditqueryparamsHPP
