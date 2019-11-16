using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using ADODB;
using AcNetUtils;

namespace ADONetDemo
{
    public partial class Form1 : Form
    {
        DataSet mDataset = new DataSet();
        OleDbConnection oleconn = new OleDbConnection();
        AcReport.AcRptEngine mac;
        string DataPath, ReportPath;    

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Data\";
            ReportPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Reports\";
            oleconn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + @"ReportDemo.mdb;Persist Security Info=False";
            oleconn.Open();
            RefreshData();
            mac = new AcReport.AcRptEngine();

            //2.5以前的版本需要将Ado.net下datatable在AC中copy一个复本，速度比较慢
           //  AcReport.AcUtils.CopyDatasetToAcRptEngine(mDataset, mac, false); 

            //新版本的处理方式，通过ADO-ADO.net适配器的方式直接访问
            DbAdapter.FillDatasetToAC(mDataset, mac); 

            SetReportConnString();
            SetAcRegisterInfo();

            //以下代码是设置字段的别名，一般来说数据库中的字段名是英文，通过设置别名，可以使字段对象在报表中以中文呈现，并以中文参与公式运算
            //  mac.SetDataFieldAliasName("OITM", "ItemCode,ItemName,OnHand", "物料编号,物料名称,库存量");

            mDataset.Tables["zlemployee"].TableName = "雇员档案";
            //  AcReport.AcUtils.CopyTableToAcRptEngine(mDataset.Tables["雇员档案"], mac, false);  //重新加入一个表到AcReport (旧版本方式)

            //在2.5以后的版本中，可以用如下的方式将ADO.net的DataTable对象通过AcRecordsetAdapter转换为ADO接口的方式直接加入到AcEngine，
            //这样做就不需要在AC中复制一个复本，大大提高的速度。
            //
            AcRecordsetAdapter RecordAdp = new AcRecordsetAdapter(mDataset.Tables["雇员档案"]);
            mac.AddNetAdoData("雇员档案", RecordAdp);

          //  以上两行也可以直接调用 AcNetUtils 类库里提供的现成方法
          //  AcNetUtils.DbAdapter.FillDataTableToAC(mDataset.Tables["雇员档案"], mac);


           mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName",
                                                "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历");
         //  tabControl1.SelectTab(1);
        }

        private void RefreshData()
        {
            OpenCmd("select top 300 e.*, x.Name as XueLiName, D.Name As DptName from zlemployee e , XueLi x,ZlDept D" +
                " where  e.XueLi = x.Code and e.Dept = D.Code", "zlemployee"); 
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

            OpenCmd("Select top 500 ItemCode, ItemName, FrgnName, CodeBars, OnHand from OITM", "OITM");
            OpenCmd("Select top 300 Code, Unit, Name, Spec, Stocks_1,Stocks_2 From Goods  Order By Code", "goods");
            OpenCmd("select * from 结果  Order By DocDate, ItemCode", "Sales");
            OpenCmd("select * from doc", "Doc");
            OpenCmd("select * from doclines", "DocLines");
        }
         
        private void OpenCmd(string cmdText, string sTableName)
        {
            OleDbCommand cmd = new OleDbCommand(cmdText, oleconn);
            OleDbDataAdapter oleDar = new OleDbDataAdapter(cmd);
            oleDar.Fill(mDataset);
            mDataset.Tables["Table"].TableName = sTableName; 
        }

        private void DoAct()
        {
            //将两个变量传入报表，如果此前已经存在该变量名，调用AddVariable后将覆盖旧值
            mac.AddVariable("变量1", textBox1.Text);
            mac.AddVariable("变量2", textBox1.Text);

            if (rb1.Checked)
                mac.Preview();
            else if (rb2.Checked)
                mac.ShowDesigner();
            else if (rb3.Checked)
                mac.Print();
            else if (rb4.Checked)
            {
                mac.PrepareReport();
                mac.ExportToXls("");
            }

        }

        private void SetReportConnString()
        {
            //设置报表连接字符串，主要方便于报表内脚本编程直接访问数据库，如果报表中没有直接访问数据库或未用到AppConnString变量，则不需要执行此过程
            DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Data\";
            String connstr = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + @"ReportDemo.mdb;Persist Security Info=False";
            mac.SetAppConnectionString(connstr);
        }

        private void SetAcRegisterInfo()
        {
            int ErrCode = 0;
            string ErrMsg = "";
            mac.SetRegisterInfo("280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D" +
            "3D7DCD1DDCDD6D78680D8AD0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D",

                "天方工作室(acreport@sina.com qq:1655373859)", "23bd", "", "", "", "", ref ErrCode, ref ErrMsg);
            if (ErrCode != 0)
                MessageBox.Show(ErrMsg);

            //注册信息整个应用中只需要设置一次，针对任何一个AcReportEngine对象设置即可，其它的对象实例不需要再调用此方法
        }

        private void button1_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "list.apt");
            DoAct();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            mac.ClearDataRelations();
            if (mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") != 0) //主从表的对应关系
            {
                int ErrCode = 0;
                string ErrMsg = "";

                mac.GetLastError(ref ErrCode, ref ErrMsg);
                throw new Exception(ErrMsg);
            }
            mac.SetReportFile(ReportPath + "md.apt");
            DoAct();
            mac.ClearDataRelations();
        }

        private void button17_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "00.apt");
            DoAct();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "sales.apt");
            DoAct();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "group.apt");
            DoAct();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            mac.ClearDataRelations();
            mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo"); //主从表的对应关系
            mac.SetReportFile(ReportPath + "sub1.apt");
            DoAct();
            mac.ClearDataRelations();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            mac.ClearDataRelations();
            mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo"); //主从表的对应关系
            mac.AddDatasetRelation("Orders", "items", "OrderNo=OrderNo");
            mac.SetReportFile(ReportPath + "sub2.apt");
            DoAct();
            mac.ClearDataRelations();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "label.apt");
            DoAct();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "04.apt"); //"multcol.apt");
            DoAct();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "014.apt");
            DoAct();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "dlg1.apt");
            DoAct();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "dlg2.apt");
            DoAct();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "itemlist.apt");
            DoAct();
        }

        private void button13_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "hideline.apt");
            DoAct();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button15_Click(object sender, EventArgs e)
        {
            SetReportConnString();
            mac.SetReportFile(ReportPath + "20.apt");
            DoAct();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            SetReportConnString();
            //上面行的作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，
            //双击Form可以看到给连接对象的赋值脚本
            mac.SetReportFile(ReportPath + "22.apt");
            DoAct();
        }

        private void button16_Click(object sender, EventArgs e)
        {
            SetReportConnString();
            mac.SetReportFile(ReportPath + "23.apt");
            DoAct();
        }

        private void button18_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "group2.apt");
            DoAct();
        }

        private void button19_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "doc1.apt");
            DoAct();
        }

        private void button20_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "ht1.apt");
            DoAct();
        }

        private void button21_Click(object sender, EventArgs e)
        {
            //  mac.AddDataset("雇员档案", rszlEmployee); //重新加入一个表
            //   mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
            //                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历"); 
            //上面的代码在 Form_Load 中   
            mac.SetReportFile(ReportPath + "01CN.apt");
            DoAct(); 
        }

        private void button22_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "keepPg1.apt");
            DoAct(); 
        }

        private void button27_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "keepPg2.apt");
            DoAct(); 
        }

        private void button23_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "group3.apt");
            DoAct(); 
        }

        private void button24_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "group4.apt");
            DoAct(); 
        }

        private void button25_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "DtMultCol.apt");
            DoAct(); 
        }

        private void button26_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "fill1.apt");
            DoAct();
        }

        private void RBView1_CheckedChanged(object sender, EventArgs e)
        {
            mac.ShowPreviewOnPrepare = false;
        }

        private void RBView2_CheckedChanged(object sender, EventArgs e)
        {
            mac.ShowPreviewOnPrepare = true;
        }

        private void button28_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "obj1.apt");
            DoAct();
        }

        private void button29_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "obj2.apt");
            DoAct();
        }

        private void button30_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "data1.apt");
            DoAct();
        }

        private void button31_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "custextra.apt");
            DoAct();
        }

        private void button32_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "reportview.apt");
            DoAct();
        }

        private void button33_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "reportview2.apt");
            DoAct();
        }

        private void button34_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "reportview3.apt");
            DoAct();
        }

        private void button35_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "reportview4.apt");
            DoAct();
        }
       
    }
}