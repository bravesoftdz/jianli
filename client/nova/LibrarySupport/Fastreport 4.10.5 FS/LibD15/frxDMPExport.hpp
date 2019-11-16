// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDMPExport.pas' rev: 22.00

#ifndef FrxdmpexportHPP
#define FrxdmpexportHPP

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
#include <Buttons.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <frxDMPClass.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdmpexport
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TfrxTranslateEvent)(System::TObject* Sender, System::AnsiString &s);

class DELPHICLASS TfrxDotMatrixExport;
class PASCALIMPLEMENTATION TfrxDotMatrixExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	typedef System::DynamicArray<char> _TfrxDotMatrixExport__1;
	
	typedef System::DynamicArray<System::Byte> _TfrxDotMatrixExport__2;
	
	typedef System::DynamicArray<int> _TfrxDotMatrixExport__3;
	
	
private:
	int FBufWidth;
	int FBufHeight;
	_TfrxDotMatrixExport__1 FCharBuf;
	int FCopies;
	System::AnsiString FCustomFrameSet;
	int FEscModel;
	_TfrxDotMatrixExport__2 FFrameBuf;
	bool FGraphicFrames;
	int FMaxHeight;
	bool FOEMConvert;
	bool FPageBreaks;
	int FPageStyle;
	System::AnsiString FPrinterInitString;
	bool FSaveToFile;
	Classes::TStream* FStream;
	_TfrxDotMatrixExport__3 FStyleBuf;
	bool FUseIniSettings;
	TfrxTranslateEvent FOnTranslate;
	System::UnicodeString __fastcall GetTempFName(void);
	Frxdmpclass::TfrxDMPFontStyles __fastcall IntToStyle(int i);
	System::UnicodeString __fastcall StyleChange(int OldStyle, int NewStyle);
	System::UnicodeString __fastcall StyleOff(int Style);
	System::UnicodeString __fastcall StyleOn(int Style);
	int __fastcall StyleToInt(Frxdmpclass::TfrxDMPFontStyles Style);
	void __fastcall CreateBuf(int Width, int Height);
	void __fastcall DrawFrame(int x, int y, int dx, int dy, int Style);
	void __fastcall DrawMemo(int x, int y, int dx, int dy, Frxdmpclass::TfrxDMPMemoView* Memo);
	void __fastcall FlushBuf(void);
	void __fastcall FormFeed(void);
	void __fastcall FreeBuf(void);
	void __fastcall Landscape(void);
	void __fastcall Portrait(void);
	void __fastcall Reset(void);
	void __fastcall SetFrame(int x, int y, System::Byte typ);
	void __fastcall SetString(int x, int y, System::AnsiString s);
	void __fastcall SetStyle(int x, int y, int Style);
	void __fastcall SpoolFile(const System::UnicodeString FileName);
	void __fastcall WriteStrLn(const System::AnsiString str);
	void __fastcall WriteStr(const System::AnsiString str);
	
public:
	__fastcall virtual TfrxDotMatrixExport(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDotMatrixExport(void);
	virtual Controls::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	
__published:
	__property System::AnsiString CustomFrameSet = {read=FCustomFrameSet, write=FCustomFrameSet};
	__property int EscModel = {read=FEscModel, write=FEscModel, nodefault};
	__property bool GraphicFrames = {read=FGraphicFrames, write=FGraphicFrames, nodefault};
	__property System::AnsiString InitString = {read=FPrinterInitString, write=FPrinterInitString};
	__property bool OEMConvert = {read=FOEMConvert, write=FOEMConvert, default=1};
	__property bool PageBreaks = {read=FPageBreaks, write=FPageBreaks, default=1};
	__property bool SaveToFile = {read=FSaveToFile, write=FSaveToFile, nodefault};
	__property bool UseIniSettings = {read=FUseIniSettings, write=FUseIniSettings, nodefault};
	__property TfrxTranslateEvent OnTranslate = {read=FOnTranslate, write=FOnTranslate};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxDotMatrixExport(void) : Frxclass::TfrxCustomExportFilter() { }
	
};


class DELPHICLASS TfrxDMPExportDialog;
class PASCALIMPLEMENTATION TfrxDMPExportDialog : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TButton* OK;
	Stdctrls::TButton* Cancel;
	Dialogs::TSaveDialog* SaveDialog1;
	Extctrls::TImage* Image1;
	Stdctrls::TGroupBox* PrinterL;
	Stdctrls::TComboBox* PrinterCB;
	Stdctrls::TGroupBox* EscL;
	Stdctrls::TComboBox* EscCB;
	Stdctrls::TGroupBox* CopiesL;
	Stdctrls::TLabel* CopiesNL;
	Stdctrls::TEdit* CopiesE;
	Comctrls::TUpDown* CopiesUD;
	Stdctrls::TGroupBox* PagesL;
	Stdctrls::TLabel* DescrL;
	Stdctrls::TRadioButton* AllRB;
	Stdctrls::TRadioButton* CurPageRB;
	Stdctrls::TRadioButton* PageNumbersRB;
	Stdctrls::TEdit* RangeE;
	Stdctrls::TGroupBox* OptionsL;
	Stdctrls::TCheckBox* SaveToFileCB;
	Stdctrls::TCheckBox* PageBreaksCB;
	Stdctrls::TCheckBox* OemCB;
	Stdctrls::TCheckBox* PseudoCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PrinterCBDrawItem(Controls::TWinControl* Control, int Index, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	void __fastcall PrinterCBClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall RangeEEnter(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
private:
	int OldIndex;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxDMPExportDialog(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDMPExportDialog(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDMPExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDMPExportDialog(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


typedef System::StaticArray<System::UnicodeString, 23> Frxdmpexport__3;

class DELPHICLASS TfrxDMPrinter;
class PASCALIMPLEMENTATION TfrxDMPrinter : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	typedef System::StaticArray<System::UnicodeString, 23> _TfrxDMPrinter__1;
	
	
public:
	_TfrxDMPrinter__1 Commands;
	virtual void __fastcall Assign(Classes::TPersistent* Source);
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxDMPrinter(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxDMPrinter(void) { }
	
};


class DELPHICLASS TfrxDMPrinters;
class PASCALIMPLEMENTATION TfrxDMPrinters : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TfrxDMPrinter* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TfrxDMPrinter* __fastcall GetItem(int Index);
	
public:
	__fastcall TfrxDMPrinters(void);
	HIDESBASE TfrxDMPrinter* __fastcall Add(void);
	void __fastcall ReadDefaultPrinters(void);
	void __fastcall ReadExtPrinters(void);
	void __fastcall ReadPrinters(Frxxml::TfrxXMLDocument* x);
	__property TfrxDMPrinter* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxDMPrinters(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt cmdName = 0x1;
static const System::ShortInt cmdReset = 0x2;
static const System::ShortInt cmdFormFeed = 0x3;
static const System::ShortInt cmdLandscape = 0x4;
static const System::ShortInt cmdPortrait = 0x5;
static const System::ShortInt cmdBoldOn = 0x6;
static const System::ShortInt cmdBoldOff = 0x7;
static const System::ShortInt cmdItalicOn = 0x8;
static const System::ShortInt cmdItalicOff = 0x9;
static const System::ShortInt cmdUnderlineOn = 0xa;
static const System::ShortInt cmdUnderlineOff = 0xb;
static const System::ShortInt cmdSuperscriptOn = 0xc;
static const System::ShortInt cmdSuperscriptOff = 0xd;
static const System::ShortInt cmdSubscriptOn = 0xe;
static const System::ShortInt cmdSubscriptOff = 0xf;
static const System::ShortInt cmdCondensedOn = 0x10;
static const System::ShortInt cmdCondensedOff = 0x11;
static const System::ShortInt cmdWideOn = 0x12;
static const System::ShortInt cmdWideOff = 0x13;
static const System::ShortInt cmd12cpiOn = 0x14;
static const System::ShortInt cmd12cpiOff = 0x15;
static const System::ShortInt cmd15cpiOn = 0x16;
static const System::ShortInt cmd15cpiOff = 0x17;
static const System::ShortInt CommandCount = 0x17;
extern PACKAGE Frxdmpexport__3 CommandNames;
extern PACKAGE TfrxDMPrinters* frxDMPrinters;

}	/* namespace Frxdmpexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxdmpexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdmpexportHPP
