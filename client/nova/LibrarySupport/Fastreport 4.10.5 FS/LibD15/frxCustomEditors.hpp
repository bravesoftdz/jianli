// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCustomEditors.pas' rev: 22.00

#ifndef FrxcustomeditorsHPP
#define FrxcustomeditorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxDMPClass.hpp>	// Pascal unit
#include <frxDsgnIntf.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcustomeditors
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxViewEditor;
class PASCALIMPLEMENTATION TfrxViewEditor : public Frxdsgnintf::TfrxComponentEditor
{
	typedef Frxdsgnintf::TfrxComponentEditor inherited;
	
public:
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxViewEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Menus::TMenu* Menu) : Frxdsgnintf::TfrxComponentEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxViewEditor(void) { }
	
};


class DELPHICLASS TfrxCustomMemoEditor;
class PASCALIMPLEMENTATION TfrxCustomMemoEditor : public TfrxViewEditor
{
	typedef TfrxViewEditor inherited;
	
public:
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxCustomMemoEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Menus::TMenu* Menu) : TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCustomMemoEditor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxcustomeditors */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxcustomeditors;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcustomeditorsHPP
