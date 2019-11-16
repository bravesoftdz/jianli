// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditAliases.pas' rev: 22.00

#ifndef FrxeditaliasesHPP
#define FrxeditaliasesHPP

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
#include <ComCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditaliases
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxAliasesEditorForm;
class PASCALIMPLEMENTATION TfrxAliasesEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TListView* AliasesLV;
	Stdctrls::TButton* OkB;
	Stdctrls::TButton* CancelB;
	Stdctrls::TButton* ResetB;
	Stdctrls::TLabel* HintL;
	Stdctrls::TLabel* DSAliasL;
	Stdctrls::TEdit* DSAliasE;
	Stdctrls::TLabel* FieldAliasesL;
	Stdctrls::TButton* UpdateB;
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ResetBClick(System::TObject* Sender);
	void __fastcall AliasesLVKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UpdateBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall AliasesLVEdited(System::TObject* Sender, Comctrls::TListItem* Item, System::UnicodeString &S);
	
private:
	Frxclass::TfrxCustomDBDataSet* FDataSet;
	void __fastcall BuildAliasList(Classes::TStrings* List);
	
public:
	__property Frxclass::TfrxCustomDBDataSet* DataSet = {read=FDataSet, write=FDataSet};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxAliasesEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxAliasesEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxAliasesEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxAliasesEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxeditaliases */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxeditaliases;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditaliasesHPP
