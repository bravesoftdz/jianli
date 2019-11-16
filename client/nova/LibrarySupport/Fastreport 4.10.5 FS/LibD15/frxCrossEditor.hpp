// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCrossEditor.pas' rev: 22.00

#ifndef FrxcrosseditorHPP
#define FrxcrosseditorHPP

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
#include <ImgList.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <frxDock.hpp>	// Pascal unit
#include <frxCross.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <frxCustomEditors.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <frxDsgnIntf.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcrosseditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCrossEditor;
class PASCALIMPLEMENTATION TfrxCrossEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxCrossEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCrossEditor(void) { }
	
};


class DELPHICLASS TfrxCrossEditorForm;
class PASCALIMPLEMENTATION TfrxCrossEditorForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	typedef System::StaticArray<System::UnicodeString, 6> _TfrxCrossEditorForm__1;
	
	typedef System::StaticArray<System::UnicodeString, 4> _TfrxCrossEditorForm__2;
	
	
__published:
	Menus::TPopupMenu* FuncPopup;
	Menus::TMenuItem* Func1MI;
	Menus::TMenuItem* Func2MI;
	Menus::TMenuItem* Func3MI;
	Menus::TMenuItem* Func4MI;
	Menus::TMenuItem* Func5MI;
	Menus::TMenuItem* Func6MI;
	Menus::TPopupMenu* SortPopup;
	Menus::TMenuItem* Sort1MI;
	Menus::TMenuItem* Sort2MI;
	Menus::TMenuItem* Sort3MI;
	Stdctrls::TGroupBox* DatasetL;
	Stdctrls::TComboBox* DatasetCB;
	Stdctrls::TListBox* FieldsLB;
	Stdctrls::TGroupBox* DimensionsL;
	Stdctrls::TLabel* RowsL;
	Stdctrls::TEdit* RowsE;
	Stdctrls::TLabel* ColumnsL;
	Stdctrls::TEdit* ColumnsE;
	Stdctrls::TLabel* CellsL;
	Stdctrls::TEdit* CellsE;
	Comctrls::TUpDown* UpDown1;
	Comctrls::TUpDown* UpDown2;
	Comctrls::TUpDown* UpDown3;
	Stdctrls::TGroupBox* StructureL;
	Extctrls::TShape* Shape1;
	Extctrls::TShape* Shape2;
	Buttons::TSpeedButton* SwapB;
	Stdctrls::TListBox* RowsLB;
	Stdctrls::TListBox* ColumnsLB;
	Stdctrls::TListBox* CellsLB;
	Stdctrls::TGroupBox* OptionsL;
	Stdctrls::TCheckBox* RowHeaderCB;
	Stdctrls::TCheckBox* ColumnHeaderCB;
	Stdctrls::TCheckBox* RowTotalCB;
	Stdctrls::TCheckBox* ColumnTotalCB;
	Stdctrls::TCheckBox* TitleCB;
	Stdctrls::TCheckBox* CornerCB;
	Stdctrls::TCheckBox* AutoSizeCB;
	Stdctrls::TCheckBox* BorderCB;
	Stdctrls::TCheckBox* DownAcrossCB;
	Stdctrls::TCheckBox* PlainCB;
	Stdctrls::TCheckBox* JoinCB;
	Forms::TScrollBox* Box;
	Extctrls::TPaintBox* PaintBox;
	Stdctrls::TButton* OkB;
	Stdctrls::TButton* CancelB;
	Stdctrls::TCheckBox* RepeatCB;
	Menus::TPopupMenu* StylePopup;
	Menus::TMenuItem* Sep1;
	Menus::TMenuItem* SaveStyleMI;
	Comctrls::TToolBar* ToolBar;
	Comctrls::TToolButton* StyleB;
	Menus::TMenuItem* Sort4MI;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall DatasetCBClick(System::TObject* Sender);
	void __fastcall DatasetCBDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	void __fastcall FieldsLBDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	void __fastcall LBDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	void __fastcall CellsLBDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	void __fastcall LBDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall LBDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall LBMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall LBClick(System::TObject* Sender);
	void __fastcall CBClick(System::TObject* Sender);
	void __fastcall FuncMIClick(System::TObject* Sender);
	void __fastcall CellsLBMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SortMIClick(System::TObject* Sender);
	void __fastcall SwapBClick(System::TObject* Sender);
	void __fastcall DimensionsChange(System::TObject* Sender);
	void __fastcall LBDblClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall PaintBoxPaint(System::TObject* Sender);
	void __fastcall SaveStyleMIClick(System::TObject* Sender);
	
private:
	Frxcross::TfrxCustomCrossView* FCross;
	Stdctrls::TListBox* FCurList;
	_TfrxCrossEditorForm__1 FFuncNames;
	Controls::TImageList* FImages;
	_TfrxCrossEditorForm__2 FSortNames;
	Frxclass::TfrxStyleSheet* FStyleSheet;
	Frxcross::TfrxDBCrossView* FTempCross;
	bool FUpdating;
	void __fastcall ReflectChanges(System::TObject* ChangesFrom, bool UpdateText = true);
	void __fastcall CreateStyleMenu(void);
	void __fastcall StyleClick(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxCrossEditorForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCrossEditorForm(void);
	__property Frxcross::TfrxCustomCrossView* Cross = {read=FCross, write=FCross};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxCrossEditorForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxCrossEditorForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxcrosseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxcrosseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcrosseditorHPP
