// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDBSet.pas' rev: 22.00

#ifndef FrxdbsetHPP
#define FrxdbsetHPP

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
#include <frxClass.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <WideStrings.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdbset
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxDBDataset;
class PASCALIMPLEMENTATION TfrxDBDataset : public Frxclass::TfrxCustomDBDataSet
{
	typedef Frxclass::TfrxCustomDBDataSet inherited;
	
private:
	System::DynamicArray<System::Byte> FBookmark;
	// System::TArray__1<System::Byte>  FBookmark;
	Db::TDataSet* FDataSet;
	Db::TDataSource* FDataSource;
	Db::TDataSet* FDS;
	bool FEof;
	bool FBCDToCurrency;
	Db::TDataSetNotifyEvent FSaveOpenEvent;
	Db::TDataSetNotifyEvent FSaveCloseEvent;
	void __fastcall BeforeClose(Db::TDataSet* Sender);
	void __fastcall AfterOpen(Db::TDataSet* Sender);
	void __fastcall SetDataSet(Db::TDataSet* Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	bool __fastcall DataSetActive(void);
	bool __fastcall IsDataSetStored(void);
	
protected:
	virtual System::WideString __fastcall GetDisplayText(System::UnicodeString Index);
	virtual int __fastcall GetDisplayWidth(System::UnicodeString Index);
	virtual Frxclass::TfrxFieldType __fastcall GetFieldType(System::UnicodeString Index);
	virtual System::Variant __fastcall GetValue(System::UnicodeString Index);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	virtual void __fastcall Initialize(void);
	virtual void __fastcall Finalize(void);
	virtual void __fastcall First(void);
	virtual void __fastcall Next(void);
	virtual void __fastcall Prior(void);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual bool __fastcall Eof(void);
	Db::TDataSet* __fastcall GetDataSet(void);
	virtual bool __fastcall IsBlobField(const System::UnicodeString fName);
	virtual int __fastcall RecordCount(void);
	virtual void __fastcall AssignBlobTo(const System::UnicodeString fName, System::TObject* Obj);
	virtual void __fastcall GetFieldList(Classes::TStrings* List);
	
__published:
	__property Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet, stored=IsDataSetStored};
	__property Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource, stored=IsDataSetStored};
	__property bool BCDToCurrency = {read=FBCDToCurrency, write=FBCDToCurrency, nodefault};
public:
	/* TfrxCustomDBDataSet.Create */ inline __fastcall virtual TfrxDBDataset(Classes::TComponent* AOwner) : Frxclass::TfrxCustomDBDataSet(AOwner) { }
	/* TfrxCustomDBDataSet.Destroy */ inline __fastcall virtual ~TfrxDBDataset(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDBDataset(Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomDBDataSet(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxdbset */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxdbset;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdbsetHPP
