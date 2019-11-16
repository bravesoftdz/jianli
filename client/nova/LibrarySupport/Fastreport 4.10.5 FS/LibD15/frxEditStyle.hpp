// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditStyle.pas' rev: 22.00

#ifndef FrxeditstyleHPP
#define FrxeditstyleHPP

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
#include <ExtCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditstyle
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxStyleEditorForm;
class PASCALIMPLEMENTATION TfrxStyleEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar;
	Comctrls::TToolButton* AddB;
	Comctrls::TToolButton* DeleteB;
	Comctrls::TToolButton* Sep1;
	Comctrls::TToolButton* LoadB;
	Comctrls::TToolButton* SaveB;
	Comctrls::TToolButton* Sep2;
	Comctrls::TToolButton* CancelB;
	Comctrls::TToolButton* OkB;
	Dialogs::TOpenDialog* OpenDialog;
	Dialogs::TSaveDialog* SaveDialog;
	Comctrls::TTreeView* StylesTV;
	Comctrls::TToolButton* EditB;
	Extctrls::TPaintBox* PaintBox;
	Stdctrls::TButton* ColorB;
	Stdctrls::TButton* FontB;
	Stdctrls::TButton* FrameB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall PaintBoxPaint(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall LoadBClick(System::TObject* Sender);
	void __fastcall SaveBClick(System::TObject* Sender);
	void __fastcall BClick(System::TObject* Sender);
	void __fastcall StylesTVClick(System::TObject* Sender);
	void __fastcall StylesTVEdited(System::TObject* Sender, Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
private:
	Controls::TImageList* FImageList;
	Frxclass::TfrxReport* FReport;
	Frxclass::TfrxStyles* FStyles;
	void __fastcall UpdateStyles(int Focus = 0x0);
	void __fastcall UpdateControls(void);
	
public:
	__fastcall virtual TfrxStyleEditorForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxStyleEditorForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxStyleEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxStyleEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxeditstyle */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxeditstyle;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditstyleHPP
