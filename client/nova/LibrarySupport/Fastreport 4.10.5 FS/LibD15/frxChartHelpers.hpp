// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxChartHelpers.pas' rev: 22.00

#ifndef FrxcharthelpersHPP
#define FrxcharthelpersHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <frxChart.hpp>	// Pascal unit
#include <TeeProcs.hpp>	// Pascal unit
#include <TeEngine.hpp>	// Pascal unit
#include <Chart.hpp>	// Pascal unit
#include <Series.hpp>	// Pascal unit
#include <TeCanvas.hpp>	// Pascal unit
#include <GanttCh.hpp>	// Pascal unit
#include <TeeShape.hpp>	// Pascal unit
#include <BubbleCh.hpp>	// Pascal unit
#include <ArrowCha.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcharthelpers
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxSeriesHelper;
class PASCALIMPLEMENTATION TfrxSeriesHelper : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void) = 0 ;
	virtual void __fastcall AddValues(Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TfrxSeriesHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxSeriesHelper(void) { }
	
};


class DELPHICLASS TfrxStdSeriesHelper;
class PASCALIMPLEMENTATION TfrxStdSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxStdSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxStdSeriesHelper(void) { }
	
};


class DELPHICLASS TfrxPieSeriesHelper;
class PASCALIMPLEMENTATION TfrxPieSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxPieSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPieSeriesHelper(void) { }
	
};


class DELPHICLASS TfrxGanttSeriesHelper;
class PASCALIMPLEMENTATION TfrxGanttSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxGanttSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxGanttSeriesHelper(void) { }
	
};


class DELPHICLASS TfrxArrowSeriesHelper;
class PASCALIMPLEMENTATION TfrxArrowSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxArrowSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxArrowSeriesHelper(void) { }
	
};


class DELPHICLASS TfrxBubbleSeriesHelper;
class PASCALIMPLEMENTATION TfrxBubbleSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxBubbleSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBubbleSeriesHelper(void) { }
	
};


typedef TMetaClass* TfrxSeriesHelperClass;

//-- var, const, procedure ---------------------------------------------------
static const System::ShortInt frxNumSeries = 0xb;
extern PACKAGE System::StaticArray<Frxchart::TSeriesClass, 11> frxChartSeries;
extern PACKAGE System::StaticArray<TfrxSeriesHelperClass, 11> frxSeriesHelpers;
extern PACKAGE TfrxSeriesHelper* __fastcall frxFindSeriesHelper(Teengine::TChartSeries* Series);

}	/* namespace Frxcharthelpers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxcharthelpers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcharthelpersHPP
