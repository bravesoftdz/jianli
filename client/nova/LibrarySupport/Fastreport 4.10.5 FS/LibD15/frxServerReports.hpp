// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerReports.pas' rev: 22.00

#ifndef FrxserverreportsHPP
#define FrxserverreportsHPP

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
#include <frxClass.hpp>	// Pascal unit
#include <frxExportHTML.hpp>	// Pascal unit
#include <frxExportRTF.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <frxExportText.hpp>	// Pascal unit
#include <frxExportCSV.hpp>	// Pascal unit
#include <frxExportPDF.hpp>	// Pascal unit
#include <frxExportXML.hpp>	// Pascal unit
#include <frxExportImage.hpp>	// Pascal unit
#include <frxVariables.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxServerForms.hpp>	// Pascal unit
#include <frxServerCache.hpp>	// Pascal unit
#include <frxDCtrl.hpp>	// Pascal unit
#include <frxServerUtils.hpp>	// Pascal unit
#include <frxNetUtils.hpp>	// Pascal unit
#include <frxUnicodeUtils.hpp>	// Pascal unit
#include <frxServerLog.hpp>	// Pascal unit
#include <frxExportODF.hpp>	// Pascal unit
#include <frxServerPrinter.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <frxServerTemplates.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverreports
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxReportSession;
class PASCALIMPLEMENTATION TfrxReportSession : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	System::UnicodeString FPath;
	System::UnicodeString FBasePath;
	System::UnicodeString FSessionId;
	System::UnicodeString FReportPath;
	System::UnicodeString FPageRange;
	Frxserverutils::TfrxServerFormat FFormat;
	System::UnicodeString FMainDocument;
	System::UnicodeString FName;
	Frxvariables::TfrxVariables* FVariables;
	bool FReportErrors;
	System::UnicodeString FError;
	System::UnicodeString FResultPage;
	Frxclass::TfrxReport* FReport;
	Frxexporthtml::TfrxHTMLExport* FHTMLExport;
	Frxexportxml::TfrxXMLExport* FXMLExport;
	Frxexportrtf::TfrxRTFExport* FRTFExport;
	Frxexporttext::TfrxSimpleTextExport* FTXTExport;
	Frxexportimage::TfrxJPEGExport* FJPGExport;
	Frxexportimage::TfrxBMPExport* FBMPExport;
	Frxexportimage::TfrxGIFExport* FGIFExport;
	Frxexportimage::TfrxTIFFExport* FTIFFExport;
	Frxexportpdf::TfrxPDFExport* FPDFExport;
	Frxexportcsv::TfrxCSVExport* FCSVExport;
	Frxexportodf::TfrxODSExport* FODSExport;
	Frxexportodf::TfrxODTExport* FODTExport;
	Classes::TThread* FParentThread;
	Frxclass::TfrxDialogPage* CurPage;
	Classes::TComponent* FParentReportServer;
	bool FCached;
	bool FNativeClient;
	Classes::TMemoryStream* FStream;
	System::UnicodeString FCacheId;
	System::UnicodeString FPassword;
	bool FAuth;
	System::UnicodeString FMessage;
	bool FPageNav;
	bool FMultipage;
	System::UnicodeString FUserLogin;
	System::UnicodeString FUserGroup;
	System::UnicodeString FAvExports;
	System::UnicodeString Fvarstr;
	System::UnicodeString FMime;
	bool FPrint;
	void __fastcall DoError(void);
	void __fastcall DoFillForm(void);
	void __fastcall DoSaveForm(void);
	void __fastcall ShowReportDialog(Frxclass::TfrxDialogPage* Page);
	void __fastcall DoAfterBuildReport(void);
	System::UnicodeString __fastcall ExtractReportName(const System::UnicodeString FileName);
	void __fastcall SetNavTemplate(const System::UnicodeString ReportName, bool Multipage, bool PicsInSameFolder, System::UnicodeString Prefix, int TotalPages, System::UnicodeString &Template);
	void __fastcall SetMainTemplate(const System::UnicodeString Title, const System::UnicodeString FrameFolder, bool Multipage, System::UnicodeString &Template);
	System::UnicodeString __fastcall GetResultFileName(const System::UnicodeString ext);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	bool Active;
	bool Continue;
	bool DialogActive;
	bool Readed;
	__fastcall TfrxReportSession(void);
	__fastcall virtual ~TfrxReportSession(void);
	__property System::UnicodeString FileName = {read=FName, write=FName};
	__property Frxserverutils::TfrxServerFormat Format = {read=FFormat, write=FFormat, nodefault};
	__property System::UnicodeString IndexFileName = {read=FMainDocument, write=FMainDocument};
	__property System::UnicodeString PageRange = {read=FPageRange, write=FPageRange};
	__property Classes::TThread* ParentThread = {read=FParentThread, write=FParentThread};
	__property System::UnicodeString ReportPath = {read=FReportPath, write=FReportPath};
	__property System::UnicodeString ResultPage = {read=FResultPage};
	__property System::UnicodeString RootPath = {read=FBasePath, write=FBasePath};
	__property System::UnicodeString SessionId = {read=FSessionId, write=FSessionId};
	__property System::UnicodeString CacheId = {read=FCacheId, write=FCacheId};
	__property Frxvariables::TfrxVariables* Variables = {read=FVariables, write=FVariables};
	__property Classes::TComponent* ParentReportServer = {read=FParentReportServer, write=FParentReportServer};
	__property bool NativeClient = {read=FNativeClient, write=FNativeClient, nodefault};
	__property Classes::TMemoryStream* Stream = {read=FStream, write=FStream};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property bool Auth = {read=FAuth, nodefault};
	__property System::UnicodeString ReportMessage = {read=FMessage};
	__property bool PageNav = {read=FPageNav, write=FPageNav, nodefault};
	__property bool Multipage = {read=FMultipage, write=FMultipage, nodefault};
	__property System::UnicodeString UserLogin = {read=FUserLogin, write=FUserLogin};
	__property System::UnicodeString UserGroup = {read=FUserGroup, write=FUserGroup};
	__property System::UnicodeString Mime = {read=FMime};
	__property bool Print = {read=FPrint, write=FPrint, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frxserverreports */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Frxserverreports;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverreportsHPP