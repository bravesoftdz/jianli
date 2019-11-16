// ACRptDemoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "ACRptDemo.h"
#include "ACRptDemoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CACRptDemoDlg dialog


CACRptDemoDlg::CACRptDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CACRptDemoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CACRptDemoDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

	if (Createobjects() == 0)
		RefreshData();

}

CACRptDemoDlg::~CACRptDemoDlg()
{
	ReleaseObjects();
}

int CACRptDemoDlg::Createobjects()
{
	HRESULT hr;

    CoInitialize(NULL);

	hr = mac.CreateInstance(__uuidof(AcRptEngine)); 
	if(!SUCCEEDED(hr))
		return -1;
    SetRegisterInfo();

	hr = pConn.CreateInstance(__uuidof(Connection));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsZlEmployee.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsCustomer.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsOrders.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsAnimals.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsBiolife.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsCountry.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsParts.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsVendors.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsItems.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsXueli.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsPhoto.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsXueLiEmp.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsOITM.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsCustomer.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsGoods.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	hr = prsSales.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;

	hr = prsDoc.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	
 hr = prsDocLines.CreateInstance(__uuidof(Recordset));  
	if(!SUCCEEDED(hr))
		return -1;
	
	return 0;
}

void CACRptDemoDlg::AddDataToAc(CString sql, CString sTableName, _RecordsetPtr rs)
{
    rs->CursorLocation = adUseClient;
	rs->Open((_bstr_t)sql, pConn.GetInterfacePtr(), adOpenStatic, adLockOptimistic, adCmdText);   
    mac->AddDataset((_bstr_t)sTableName, rs.GetInterfacePtr());
}

void CACRptDemoDlg::RefreshData()
{
	TCHAR szCurPath[MAX_PATH]; 
    memset(szCurPath,   0,   MAX_PATH); 
    GetModuleFileName(NULL, szCurPath, sizeof(szCurPath)/sizeof(TCHAR));
	CString   sConn, str = szCurPath;

    DataPath =  str.Left(str.ReverseFind('\\') + 1) +  "..\\..\\..\\..\\Data\\";
	ReportPath = str.Left(str.ReverseFind('\\') + 1) +  "..\\..\\..\\..\\reports\\";
  //  DataPath = "E:\\controls\\ACreport\\COM\\demos\\Data\\";
	sConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False";

	pConn->ConnectionString =(_bstr_t) sConn; //"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\\controls\\ACreport\\COM\\demos\\Data\\ReportDemo.mdb;Persist Security Info=False"; 
	pConn->Open(pConn->ConnectionString, "", "", -1);

	mac->SetAppConnectionString(pConn->ConnectionString);
    //上面行的作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，

	mac->Init();

/*
	prsZlEmployee->Open("select top 500 * from zlemployee", pConn.GetInterfacePtr(), adOpenStatic, adLockOptimistic, adCmdText);   
    mac->AddDataset((_bstr_t)"zlemployee", prsZlEmployee.GetInterfacePtr());

	prsCustomer->CursorLocation = adUseClient;
	prsCustomer->Open("select * from customer order by custNo", pConn.GetInterfacePtr(), adOpenStatic, adLockOptimistic, adCmdText);   
    mac->AddDataset((_bstr_t)"customer", prsCustomer.GetInterfacePtr());

*/

	AddDataToAc("select top 500 e.*, x.Name as XueLiName from zlemployee e Left Join XueLi x on e.XueLi = x.Code", "zlemployee", prsZlEmployee); 
	AddDataToAc("select * from customer order by custNo", "customer", prsCustomer); 
	AddDataToAc("Select * from Orders order by OrderNo", "Orders", prsOrders); 
	AddDataToAc("Select * from animals", "animals", prsAnimals);
	AddDataToAc("select * from biolife", "biolife", prsBiolife);
	AddDataToAc("select * from country", "country", prsCountry);
	AddDataToAc("Select * from Parts order by PartNo", "Parts", prsParts);
	AddDataToAc("select * from vendors order by vendorNo", "vendors", prsVendors);
	AddDataToAc((CString)"select i.*, Description as PartName, ListPrice as Price,i.Qty * p.ListPrice as Total " +
                 " from items i Left Join Parts p On i.PartNo= p.PartNo " +
                 " order by ItemNo", "items", prsItems);
	AddDataToAc("Select * from XueLi", "XueLi", prsXueli);
	AddDataToAc("Select * from photo", "photos", prsPhoto); 
	AddDataToAc((CString)"Select X.Code, X.Name, Count(*) As Num " +
                " From zlemployee z inner join Xueli X " +
                       " On z.XueLi = X.Code " +
                       " Group By X.Code, X.Name", "XueLiEmp", prsXueLiEmp);
	AddDataToAc("Select top 500 * from OITM", "oitm", prsOITM);
	AddDataToAc("select * from 结果 Order By DocDate, ItemCode", "sales", prsSales);
	AddDataToAc("Select Code, Unit, Name, Spec, Stocks_1,Stocks_2 From Goods  Order By Code", "goods", prsGoods);

	AddDataToAc("select * from doc", "Doc", prsDoc);
	AddDataToAc("select * from doclines", "DocLines", prsDocLines);
	
    mac->AddDataset("雇员档案", prsZlEmployee.GetInterfacePtr()); //以新名称重新加入一个表
    mac->SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName", 
                                                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历");
}

void CACRptDemoDlg::ReleaseObjects()
{
	if (mac)
	    mac.Release();
    if (pConn)
		pConn.Release();
    if (prsZlEmployee)
		prsZlEmployee.Release ();
    if (prsCustomer)
		prsCustomer.Release ();
    if (prsOrders)
		prsOrders.Release ();
    if (prsAnimals)
		prsAnimals.Release ();
    if (prsBiolife)
		prsBiolife.Release ();
    if (prsCountry)
		prsCountry.Release ();
    if (prsParts)
		prsParts.Release ();
    if (prsVendors)
		prsVendors.Release ();
    if (prsItems)
		prsItems.Release ();
    if (prsXueli)
		prsXueli.Release ();
    if (prsPhoto)
		prsPhoto.Release ();
    if (prsXueLiEmp)
		prsXueLiEmp.Release ();
    if (prsOITM)
		prsOITM.Release ();
    if (prsCustomer)
		prsCustomer.Release ();
    if (prsGoods)
		prsGoods.Release ();
    if (prsSales)
		prsSales.Release ();
	if (prsDoc)
		prsDoc.Release ();
	if (prsDocLines)
		prsDocLines.Release ();

	CoUninitialize();
}

void CACRptDemoDlg::DoAct()
{
	TCHAR str[255];
	memset(str,   0,   255); 

	//将2个变量值传入报表
	((CEdit *)this->GetDlgItem(IDC_EDIT1))->GetWindowText(str, 255);
	mac->AddVariable("变量1", (_bstr_t)str);

	((CEdit *)this->GetDlgItem(IDC_EDIT2))->GetWindowText(str, 255);
	mac->AddVariable("变量2", (_bstr_t)str);

	if (((CButton *)this->GetDlgItem(IDC_RADIO1))->GetCheck())
		mac->Preview();
	else 
	if (((CButton *)this->GetDlgItem(IDC_RADIO2))->GetCheck())
		mac->ShowDesigner();
	else
	if (((CButton *)this->GetDlgItem(IDC_RADIO3))->GetCheck())
		mac->Print(); 
}

void CACRptDemoDlg::SetRegisterInfo()
{

 long ErrCode;
 BSTR ErrMsg = ::SysAllocString(L"");

 //设置注册信息
 mac->SetRegisterInfo((_bstr_t)"280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D" +
	  "3D7DCD1DDCDD6D78680D8AD0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D", //注册码
	  "天方工作室(acreport@sina.com qq:1655373859)", //注册用户名称
	  "23bd", //附加码
	  "", 
	  "", 
	  "", 
	  "", 
	  &ErrCode, &ErrMsg);

 if (ErrCode != 0) 
	 MessageBox(_com_util::ConvertBSTRToString(ErrMsg));
 //注册信息整个应用中只需要设置一次，针对任何一个AcReportEngine对象设置即可，其它的对象实例不需要再调用此方法
}

void CACRptDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CACRptDemoDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CACRptDemoDlg, CDialog)
	//{{AFX_MSG_MAP(CACRptDemoDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_EXIT, OnExit)
	ON_BN_CLICKED(IDC_BUTTON2, OnButton2)
	ON_BN_CLICKED(IDC_BUTTON3, OnButton3)
	ON_BN_CLICKED(IDC_BUTTON4, OnButton4)
	ON_BN_CLICKED(IDC_BUTTON5, OnButton5)
	ON_BN_CLICKED(IDC_BUTTON6, OnButton6)
	ON_BN_CLICKED(IDC_BUTTON7, OnButton7)
	ON_BN_CLICKED(IDC_BUTTON8, OnButton8)
	ON_BN_CLICKED(IDC_BUTTON9, OnButton9)
	ON_BN_CLICKED(IDC_BUTTON10, OnButton10)
	ON_BN_CLICKED(IDC_BUTTON11, OnButton11)
	ON_BN_CLICKED(IDC_BUTTON12, OnButton12)
	ON_BN_CLICKED(IDC_BUTTON13, OnButton13)
	ON_BN_CLICKED(IDC_BUTTON14, OnButton14)
	ON_BN_CLICKED(IDC_BUTTON15, OnButton15)
	ON_BN_CLICKED(IDC_BUTTON16, OnButton16)
	ON_BN_CLICKED(IDC_BUTTON17, OnButton17)
	ON_BN_CLICKED(IDC_BUTTON18, OnButton18)
	ON_BN_CLICKED(IDC_BUTTON19, OnButton19)
	ON_BN_CLICKED(IDC_BUTTON20, OnButton20)
	ON_BN_CLICKED(IDC_BUTTON21, OnButton21)
	ON_BN_CLICKED(IDC_BUTTON22, OnButton22)
	ON_BN_CLICKED(IDC_BUTTON23, OnButton23)
	ON_BN_CLICKED(IDC_BUTTON24, OnButton24)
	ON_BN_CLICKED(IDC_BUTTON25, OnButton25)
	ON_BN_CLICKED(IDC_BUTTON26, OnButton26)
	ON_BN_CLICKED(IDC_BUTTON27, OnButton27)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CACRptDemoDlg message handlers

BOOL CACRptDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here

	((CButton *)this->GetDlgItem(IDC_RADIO1))->SetCheck(TRUE); //默认打印预览

//	CEdit * c;

	((CEdit *)this->GetDlgItem(IDC_EDIT1))->SetWindowText("天方工作室" );
	((CEdit *)this->GetDlgItem(IDC_EDIT2))->SetWindowText("AcReport" );

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CACRptDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CACRptDemoDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CACRptDemoDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CACRptDemoDlg::OnExit() 
{
	// TODO: Add your control notification handler code here
//	ExitProcess(0);
	SendMessage(WM_CLOSE, 0, 0);
}

void CACRptDemoDlg::OnButton2() 
{
	// TODO: Add your control notification handler code here
	mac->SetReportFile((_bstr_t)ReportPath +"00.apt");
	DoAct();
	
}

void CACRptDemoDlg::OnButton3() 
{
	// TODO: Add your control notification handler code here
	mac->SetReportFile((_bstr_t)ReportPath +"list.apt");
	DoAct();	
}

void CACRptDemoDlg::OnButton4() 
{ 
	// TODO: Add your control notification handler code here
	mac->SetReportFile((_bstr_t)ReportPath +"sales.apt");
	DoAct();	
}

void CACRptDemoDlg::OnButton5() 
{
	// TODO: Add your control notification handler code here
  mac->ClearDataRelations();
  if (mac->AddDatasetRelation("customer", "Orders", "CustNo=CustNo") != 0) //设置主从表关联关系
  {
    // long ErrCode = 0;
   //  unsigned short ** ErrMsg;
    // mac->GetLastError(&ErrCode, ErrMsg);
	  return;
     
  }
  mac->SetReportFile((_bstr_t)ReportPath + "md.apt");
  DoAct();
  mac->ClearDataRelations();
}

void CACRptDemoDlg::OnButton6() 
{
	// TODO: Add your control notification handler code here
	mac->SetReportFile((_bstr_t)ReportPath +"group.apt");
	DoAct();	
}

void CACRptDemoDlg::OnButton7() 
{
	// TODO: Add your control notification handler code here
	mac->ClearDataRelations();
    mac->AddDatasetRelation("customer", "Orders", "CustNo=CustNo"); //设置主从表关联关系
    mac->SetReportFile((_bstr_t)ReportPath + "sub1.apt");
    DoAct();
    mac->ClearDataRelations();
}

void CACRptDemoDlg::OnButton8() 
{
	// TODO: Add your control notification handler code here
    mac->ClearDataRelations();
    mac->AddDatasetRelation("customer", "Orders", "CustNo=CustNo"); //设置主从表关联关系
    mac->AddDatasetRelation("Orders", "Items", "OrderNo=OrderNo");
    mac->SetReportFile((_bstr_t)ReportPath + "sub2.apt");
    DoAct();
    mac->ClearDataRelations();	
}

void CACRptDemoDlg::OnButton9() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "label.apt");
  DoAct();	
}

void CACRptDemoDlg::OnButton10() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "multcol.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton11() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "014.apt");
  DoAct();	
}

void CACRptDemoDlg::OnButton12() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "dlg1.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton13() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "dlg2.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton14() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "itemlist.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton15() 
{
	// TODO: Add your control notification handler code here
  mac->SetReportFile((_bstr_t)ReportPath + "hideline.apt");
  DoAct();	
}

void CACRptDemoDlg::OnButton16() 
{
//	mac->SetAppConnectionString(pConn->ConnectionString);
    //上面行已经移到RefreshData()中，作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，
            //双击Form可以看到给连接对象的赋值脚本

  mac->SetReportFile((_bstr_t)ReportPath + "20.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton17() 
{
	//	mac->SetAppConnectionString(pConn->ConnectionString);
    //上面行已经移到RefreshData()中，作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，
            //双击Form可以看到给连接对象的赋值脚本

  mac->SetReportFile((_bstr_t)ReportPath + "22.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton18() 
{
//	mac->SetAppConnectionString(pConn->ConnectionString);
    //上面行已经移到RefreshData()中，作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，
            //双击Form可以看到给连接对象的赋值脚本
  mac->SetReportFile((_bstr_t)ReportPath + "23.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton19() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "custextra.apt");
  DoAct();	
}

void CACRptDemoDlg::OnButton20() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "ReportView.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton21() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "ReportView2.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton22() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "ReportView3.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton23() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "obj1.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton24() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "data1.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton25() 
{
	   //  mac.AddDataset("雇员档案", rszlEmployee); //重新加入一个表
       //   mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
       //                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历"); 
      //上面的代码在 RefreshData()中   
  mac->SetReportFile((_bstr_t)ReportPath + "01CN.apt");
  DoAct();		
}

void CACRptDemoDlg::OnButton26() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "DtMultCol.apt");
  DoAct();	
}

void CACRptDemoDlg::OnButton27() 
{
  mac->SetReportFile((_bstr_t)ReportPath + "fill1.apt");
  DoAct();		
}
