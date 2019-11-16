// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditPicture.pas' rev: 22.00

#ifndef FrxeditpictureHPP
#define FrxeditpictureHPP

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
#include <frxCtrls.hpp>	// Pascal unit
#include <frxDock.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditpicture
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxPictureEditorForm;
class PASCALIMPLEMENTATION TfrxPictureEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Comctrls::TToolBar* ToolBar;
	Comctrls::TToolButton* LoadB;
	Comctrls::TToolButton* ClearB;
	Comctrls::TToolButton* OkB;
	Forms::TScrollBox* Box;
	Comctrls::TToolButton* ToolButton1;
	Comctrls::TToolButton* CancelB;
	Extctrls::TImage* Image;
	Comctrls::TStatusBar* StatusBar;
	Comctrls::TToolButton* CopyB;
	Comctrls::TToolButton* PasteB;
	void __fastcall ClearBClick(System::TObject* Sender);
	void __fastcall LoadBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CopyBClick(System::TObject* Sender);
	void __fastcall PasteBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
private:
	Classes::TWndMethod FStatusBarOldWindowProc;
	void __fastcall StatusBarWndProc(Messages::TMessage &Message);
	void __fastcall UpdateImage(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxPictureEditorForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxPictureEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxPictureEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxPictureEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxeditpicture */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxeditpicture;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditpictureHPP
