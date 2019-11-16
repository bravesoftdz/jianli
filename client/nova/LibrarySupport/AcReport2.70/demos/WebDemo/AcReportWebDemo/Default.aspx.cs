using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using AcReport;
using System.IO;
using System.Configuration;
namespace AcReportWebDemo
{
    public partial class _Default : System.Web.UI.Page
    {
        AcRptEngine acReportEngine = new AcRptEngine();
        DataSet mDataset = new DataSet();
        OleDbConnection oleconn = new OleDbConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            OpenCmd("select top 300 e.*, x.Name as XueLiName from zlemployee e Left Join XueLi x on e.XueLi = x.Code", "zlemployee");
            OpenCmd("select top 30 * from customer ", "customer");
            OpenCmd("Select top 20 * from Orders order by OrderNo", "Orders");
            //  OpenCmd("Select * from animals", "animals");
            //  OpenCmd("select * from biolife", "biolife");
            //   OpenCmd("select * from country", "country");
            OpenCmd("Select * from Parts order by PartNo", "Parts");
            OpenCmd("select * from vendors order by vendorNo", "vendors");
            OpenCmd("select top 300 i.*, Description as PartName, ListPrice as Price,i.Qty * p.ListPrice as Total " +
                " from items i Left Join Parts p On i.PartNo= p.PartNo " +
                " order by ItemNo", "items");
            OpenCmd("Select * from XueLi", "XueLi");
            OpenCmd("Select * from photo", "photos");
            OpenCmd("Select X.Code, X.Name, Count(*) As Num " +
                " From zlemployee z inner join Xueli X " +
                       " On z.XueLi = X.Code " +
                       " Group By X.Code, X.Name", "XueLiEmp");

            OpenCmd("Select top 300 * from OITM", "OITM");
            OpenCmd("Select top 300 Code, Unit, Name, Spec, Stocks_1,Stocks_2 From Goods  Order By Code", "goods");
            AcUtils.CopyDatasetToAcRptEngine(mDataset, acReportEngine, false);
        }
        private void OpenCmd(string cmdText, string sTableName)
        {
            OleDbCommand cmd = new OleDbCommand(cmdText, oleconn);
            OleDbDataAdapter oleDar = new OleDbDataAdapter(cmd);
            oleDar.Fill(mDataset);
            mDataset.Tables["Table"].TableName = sTableName;
        }
        private void GenerateReport(string strFileName)
        {
            string strFile = Server.MapPath("~/Report/" + strFileName);
            string strFileNoExt = Path.GetFileNameWithoutExtension(strFile);
            acReportEngine.SetReportFile(strFile);
            //acReportEngine.ShowProgress = false;
            int iResult = acReportEngine.PrepareReport();
            if (iResult != 0)
            {
                string strError = string.Empty;
                int icode = 0;
                acReportEngine.GetLastError(ref icode, ref strError);
                Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "<script>alert('错误代码：" + icode + ",错误信息：" + strError + "');</script>");
            }
            if (acReportEngine.PreparedPagesCount != 0)
            {
                strFile = Server.MapPath("~/OutputFile/" + strFileNoExt + ".acr");
                //if (File.Exists(strFile))
                //    File.Delete(strFile);
                acReportEngine.ExportToACR(strFile);
                string strUrl = "http://" + HttpContext.Current.Request.Url.Host + ":" + Request.ServerVariables["SERVER_PORT"] + "/OutputFile/" + strFileNoExt + ".acr";
                Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "<script>SetAcReportUrl(\"" + strUrl + "\");</script>");
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            GenerateReport("00.apt");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            GenerateReport("list.apt");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            GenerateReport("sales.apt");
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            acReportEngine.ClearDataRelations();
            if (acReportEngine.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") != 0) //主从表的对应关系
            {
                int ErrCode = 0;
                string ErrMsg = "";

                acReportEngine.GetLastError(ref ErrCode, ref ErrMsg);
                throw new Exception(ErrMsg);
            }
            GenerateReport("md.apt");
            acReportEngine.ClearDataRelations();
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            GenerateReport("group.apt");
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {

        }
    }
}
