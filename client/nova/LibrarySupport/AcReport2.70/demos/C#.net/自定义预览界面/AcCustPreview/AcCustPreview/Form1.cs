using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using AcReport;
using ADODB;

namespace AcCustPreview
{
    public partial class Form1 : Form
    {
        AcRptEngine mac;
        string DataPath, ReportPath; 

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            AcRepView.ToolBarVisible = false;
            mac = new AcRptEngine();
            InitData();
        }
        private void InitData()
        {
            DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Data\";
            ReportPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Reports\";

            Connection adoconn = new Connection();
            adoconn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + @"ReportDemo.mdb;Persist Security Info=False";

            adoconn.Open(adoconn.ConnectionString, "admin", "", -1);

            ADODB.Recordset rszlEmployee = new ADODB.Recordset();
            rszlEmployee.Open("select top 300 e.*, x.Name as XueLiName from zlemployee e Left Join XueLi x on e.XueLi = x.Code", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);
            mac.AddDataset("zlemployee", rszlEmployee);
            mac.AddVariable("变量1", "天方工作室");

        }

        private void CB1_CheckedChanged(object sender, EventArgs e)
        {
            palTool.Visible = !CB1.Checked;
            AcRepView.ToolBarVisible = CB1.Checked;
        }

        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            AcRepView.ShowPageSetDlg();
        }

        private void tbClose_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnShowRep_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "list.apt");
            mac.PrepareReport();
            if (mac.PreparedPagesCount <= 0)
                return;
            mac.ExportToACR("d:\\actmp.acr");
            if (System.IO.File.Exists("d:\\actmp.acr"))
            {
                AcRepView.OpenRepFromFile("d:\\actmp.acr", false);
                EdLeftMgn.Text = AcRepView.LeftMargin.ToString();
                EdTopMgn.Text = AcRepView.TopMargin.ToString();
                btnApply.Enabled = true;
            }
        }

        private void btnShowDesiner_Click(object sender, EventArgs e)
        {
            mac.ShowDesigner();
        }

        private void tbOpen_Click(object sender, EventArgs e)
        {
            AcRepView.ShowOpenDlg();
        }

        private void tbSave_Click(object sender, EventArgs e)
        {
            AcRepView.ShowSaveDlg();
        }

        private void tbEdit_Click(object sender, EventArgs e)
        {
            AcRepView.EditCurPage();
        }

        private void tbExportXls_Click(object sender, EventArgs e)
        {
            AcRepView.ShowExportToExcelDlg();
        }

        private void tbPrint_Click(object sender, EventArgs e)
        {
            AcRepView.ShowPrintDlg();
        }

        private void tbPrintCurPg_Click(object sender, EventArgs e)
        {
            AcRepView.PrintCurPage();
        }

        private void tbSetToPg_Click(object sender, EventArgs e)
        {
            AcRepView.SetToPageSize();
        }

        private void tbZoomIn_Click(object sender, EventArgs e)
        {
            AcRepView.ZoomIn();
        }

        private void tbZoomOut_Click(object sender, EventArgs e)
        {
            AcRepView.ZoomOut();
        }

        private void tbFirst_Click(object sender, EventArgs e)
        {
            AcRepView.GotoFirstPage();
            tbEdIndex.Text = "1";
        }

        private void tbPrev_Click(object sender, EventArgs e)
        {
            AcRepView.GotoPriorPage();
            tbEdIndex.Text = AcRepView.GetCurPageIndex().ToString();
        }

        private void tbNext_Click(object sender, EventArgs e)
        {
            AcRepView.GotoNextPage();
            tbEdIndex.Text = AcRepView.GetCurPageIndex().ToString();
        }

        private void tbLast_Click(object sender, EventArgs e)
        {
            AcRepView.GotoLastPage();
            tbEdIndex.Text = AcRepView.GetCurPageIndex().ToString();
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            AcRepView.LeftMargin = Convert.ToInt32(EdLeftMgn.Text);
            AcRepView.TopMargin = Convert.ToInt32(EdTopMgn.Text);
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}