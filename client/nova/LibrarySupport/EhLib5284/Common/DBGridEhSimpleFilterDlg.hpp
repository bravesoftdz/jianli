// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbgridehsimplefilterdlg.pas' rev: 21.00

#ifndef DbgridehsimplefilterdlgHPP
#define DbgridehsimplefilterdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dbctrlseh.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dbgrideh.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbgridehsimplefilterdlg
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBGridEhSimpleFilterDialog;
class PASCALIMPLEMENTATION TDBGridEhSimpleFilterDialog : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TComboBox* ComboBox1;
	Stdctrls::TComboBox* ComboBox2;
	Stdctrls::TEdit* Edit1;
	Stdctrls::TEdit* Edit2;
	Stdctrls::TLabel* Label1;
	Extctrls::TBevel* Bevel1;
	Stdctrls::TRadioButton* rbAnd;
	Stdctrls::TRadioButton* rbOr;
	Stdctrls::TLabel* Label2;
	Stdctrls::TLabel* Label3;
	Stdctrls::TButton* bOk;
	Stdctrls::TButton* bCancel;
	Dbctrlseh::TDBComboBoxEh* DBComboBoxEh1;
	Dbctrlseh::TDBComboBoxEh* DBComboBoxEh2;
	Dbctrlseh::TDBDateTimeEditEh* DBDateTimeEditEh1;
	Dbctrlseh::TDBDateTimeEditEh* DBDateTimeEditEh2;
	Dbctrlseh::TDBNumberEditEh* DBNumberEditEh1;
	Dbctrlseh::TDBNumberEditEh* DBNumberEditEh2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall DBComboBoxEh1Change(System::TObject* Sender);
	
public:
	Toolctrlseh::_di_IMemTableDataFieldValueListEh FieldValueList;
	Dbgrideh::TColumnEh* Column;
	void __fastcall Init(void);
	void __fastcall InitSignComboBox(Stdctrls::TComboBox* ComboBox);
	void __fastcall InitValuesComboBox(Dbctrlseh::TDBComboBoxEh* ComboBox, const Types::TPoint &Pos);
	void __fastcall FillDialogFromColumnFilter(Dbgrideh::TSTColumnFilterEh* STFilter);
	void __fastcall FillDialogFromColumnFilter1(Dbgrideh::TSTFilterOperatorEh Operator, const System::Variant &Operand, Stdctrls::TComboBox* OperatorComboBox, Dbctrlseh::TDBComboBoxEh* OperandComboBox);
	void __fastcall SetFilterFromDialog(void);
	void __fastcall SetFilterFromDialog1(System::UnicodeString &FilterString, Stdctrls::TComboBox* OperatorComboBox, Dbctrlseh::TDBComboBoxEh* OperandComboBox);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDBGridEhSimpleFilterDialog(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDBGridEhSimpleFilterDialog(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDBGridEhSimpleFilterDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBGridEhSimpleFilterDialog(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TDBGridEhSimpleFilterDialog* DBGridEhSimpleFilterDialog;
extern PACKAGE bool __fastcall StartDBGridEhColumnFilterDialog(Dbgrideh::TColumnEh* Column);

}	/* namespace Dbgridehsimplefilterdlg */
using namespace Dbgridehsimplefilterdlg;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbgridehsimplefilterdlgHPP
