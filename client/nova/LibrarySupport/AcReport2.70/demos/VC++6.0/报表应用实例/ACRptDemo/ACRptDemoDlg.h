// ACRptDemoDlg.h : header file
//
#import "c:\program files\common files\system\ado\msado15.dll" no_namespace rename("EOF","adoEOF")
#import "E:\controls\ACreport\COM\com\acreport.dll"  no_namespace
 
#if !defined(AFX_ACRPTDEMODLG_H__105F8459_6785_4D18_B841_CC80A3C9B2AE__INCLUDED_)
#define AFX_ACRPTDEMODLG_H__105F8459_6785_4D18_B841_CC80A3C9B2AE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CACRptDemoDlg dialog

class CACRptDemoDlg : public CDialog
{
// Construction
public:
	CACRptDemoDlg(CWnd* pParent = NULL);	// standard constructor
	~CACRptDemoDlg();

// Dialog Data
	//{{AFX_DATA(CACRptDemoDlg)
	enum { IDD = IDD_ACRPTDEMO_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CACRptDemoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CACRptDemoDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnExit();
	afx_msg void OnButton2();
	afx_msg void OnButton3();
	afx_msg void OnButton4();
	afx_msg void OnButton5();
	afx_msg void OnButton6();
	afx_msg void OnButton7();
	afx_msg void OnButton8();
	afx_msg void OnButton9();
	afx_msg void OnButton10();
	afx_msg void OnButton11();
	afx_msg void OnButton12();
	afx_msg void OnButton13();
	afx_msg void OnButton14();
	afx_msg void OnButton15();
	afx_msg void OnButton16();
	afx_msg void OnButton17();
	afx_msg void OnButton18();
	afx_msg void OnButton19();
	afx_msg void OnButton20();
	afx_msg void OnButton21();
	afx_msg void OnButton22();
	afx_msg void OnButton23();
	afx_msg void OnButton24();
	afx_msg void OnButton25();
	afx_msg void OnButton26();
	afx_msg void OnButton27();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

private:
	IAcRptEnginePtr mac;
	_ConnectionPtr pConn;
	_RecordsetPtr  prsZlEmployee, prsCustomer, prsOrders, prsAnimals, prsBiolife, prsCountry,
		prsParts, prsVendors, prsItems, prsXueli, prsPhoto, prsXueLiEmp, prsOITM, prsGoods, prsSales,
		prsDoc, prsDocLines;
	CString DataPath, ReportPath;

	int Createobjects();
	void RefreshData();
	void ReleaseObjects();
	void AddDataToAc(CString sql, CString sTableName, _RecordsetPtr rs);
	void DoAct();
	void SetRegisterInfo();

};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ACRPTDEMODLG_H__105F8459_6785_4D18_B841_CC80A3C9B2AE__INCLUDED_)
