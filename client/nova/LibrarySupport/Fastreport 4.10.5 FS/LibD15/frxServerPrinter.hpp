// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerPrinter.pas' rev: 22.00

#ifndef FrxserverprinterHPP
#define FrxserverprinterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <frxPrinter.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxServerCache.hpp>	// Pascal unit
#include <frxUnicodeUtils.hpp>	// Pascal unit
#include <SyncObjs.hpp>	// Pascal unit
#include <frxServerTemplates.hpp>	// Pascal unit
#include <frxNetUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverprinter
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxServerPrinter;
class DELPHICLASS TfrxServerPrintQueue;
class PASCALIMPLEMENTATION TfrxServerPrinter : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TfrxServerPrintQueue* FQueue;
	Frxservertemplates::TfrxServerTemplate* FTemplate;
	bool FThreadActive;
	void __fastcall ProcessJobs(void);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxServerPrinter(void);
	__fastcall virtual ~TfrxServerPrinter(void);
	System::UnicodeString __fastcall GetHTML(const System::UnicodeString SessionId, const System::UnicodeString Report);
	void __fastcall AddPrintJob(const System::UnicodeString SessionId, System::UnicodeString Printer, const System::UnicodeString Pages, int Copies, bool Collate, bool Reverse);
	__property TfrxServerPrintQueue* Queue = {read=FQueue};
	__property Frxservertemplates::TfrxServerTemplate* Template = {read=FTemplate};
};


class DELPHICLASS TfrxServerPrintJob;
class PASCALIMPLEMENTATION TfrxServerPrintQueue : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TfrxServerPrintJob* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxServerPrintQueue(void);
	__fastcall virtual ~TfrxServerPrintQueue(void);
	__property TfrxServerPrintJob* Items[int Index] = {read=GetItems};
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TfrxServerPrintJob* __fastcall Add(void);
};


class PASCALIMPLEMENTATION TfrxServerPrintJob : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FSession;
	System::UnicodeString FFileName;
	Frxclass::TfrxReport* FReport;
	
public:
	__fastcall virtual TfrxServerPrintJob(Classes::TCollection* Collection);
	__fastcall virtual ~TfrxServerPrintJob(void);
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property System::UnicodeString Session = {read=FSession, write=FSession};
	__property Frxclass::TfrxReport* Report = {read=FReport};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Syncobjs::TCriticalSection* PrintCS1;
extern PACKAGE TfrxServerPrinter* ServerPrinter;

}	/* namespace Frxserverprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxserverprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverprinterHPP
