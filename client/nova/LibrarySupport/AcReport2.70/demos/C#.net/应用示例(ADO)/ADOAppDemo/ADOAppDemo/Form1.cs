using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using ADODB;
using AcReport;
using System.Windows.Forms;

namespace ADOAppDemo
{
    public partial class Form1 : Form
    {
        string DataPath = "";
        string ReportPath = ""; 
        AcRptEngine mac;// = new AcReport.AcRptEngine(); 当定义AcRptEngine为Form的成员变量时，不建议在此初始化，否则可能出现设计器工具栏图标不能正常显示的现象
        Connection adoconn = new ADODB.Connection();
        Recordset rszlEmployee = new Recordset();
        Recordset rsCustomer = new Recordset();
        Recordset rsOrders = new Recordset();
        Recordset rsAnimals = new Recordset();
        Recordset rsBiolife = new Recordset();
        Recordset rsContry = new Recordset();
        Recordset rsParts = new Recordset();
        Recordset rsVendors = new Recordset();
        Recordset rsItems = new Recordset();
        Recordset rsXueli = new Recordset();
        Recordset rsPhoto = new Recordset();
        Recordset rsXueLiEmp = new Recordset();
        Recordset rsOITM = new Recordset();
        Recordset rsGoods = new Recordset();
        Recordset rsSales = new Recordset();
        Recordset rsDoc = new Recordset();
        Recordset rsDocLines = new Recordset();


        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Data\";
            ReportPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\Reports\";
            mac = new AcReport.AcRptEngine();
            SetAcRegisterInfo();

            adoconn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + @"ReportDemo.mdb;Persist Security Info=False";
  
            adoconn.Open(adoconn.ConnectionString, "admin", "", -1);

            mac.SetAppConnectionString(adoconn.ConnectionString);//此行的作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量
            
            OpenDatasets();
            AddDatasetsToAC();

            mac.ShowPreviewOnPrepare = true; //设置预览方式为边生成边预览

           // tabControl1.SelectTab(1);
           
        }

 
        private void OpenDatasets()
        {
            rszlEmployee.Open("select top 300 e.*, x.Name as XueLiName, D.Name As DptName from zlemployee e , XueLi x,ZlDept D"+
                " where  e.XueLi = x.Code and e.Dept = D.Code", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsCustomer.CursorLocation = CursorLocationEnum.adUseClient;
            //对于有 Order by 的SQL，如果打开前不执行上面这行，会出现“当前提供程序不支持排序或过滤所必需的界面”的异常
            rsCustomer.Open("select * from customer order by custNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsOrders.CursorLocation = CursorLocationEnum.adUseClient;
            rsOrders.Open("Select * from Orders order by OrderNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsAnimals.Open("Select * from animals", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsBiolife.Open("select * from biolife", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsContry.Open("select * from country", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsParts.CursorLocation = CursorLocationEnum.adUseClient;
            rsParts.Open("Select * from Parts order by PartNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsVendors.CursorLocation = CursorLocationEnum.adUseClient;
            rsVendors.Open("select * from vendors order by vendorNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsItems.CursorLocation = CursorLocationEnum.adUseClient;
            rsItems.Open("select i.*, Description as PartName, ListPrice as Price,i.Qty * p.ListPrice as Total "+
                         " from items i Left Join Parts p On i.PartNo= p.PartNo "+
                         " order by ItemNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsXueli.Open("Select * from XueLi", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsPhoto.Open("Select * from photo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsXueLiEmp.CursorLocation = CursorLocationEnum.adUseClient;
            rsXueLiEmp.Open("Select X.Code, X.Name, Count(*) As Num "+
                       " From zlemployee z inner join Xueli X "+
                       " On z.XueLi = X.Code "+
                       " Group By X.Code, X.Name", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsOITM.CursorLocation = CursorLocationEnum.adUseClient;
            rsOITM.Open("Select top 500 ItemCode, ItemName, FrgnName, CodeBars, OnHand from OITM", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsGoods.CursorLocation = CursorLocationEnum.adUseClient;
            rsGoods.Open("Select Code, Unit, Name, Spec, Stocks_1,Stocks_2 From Goods  Order By Code", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsSales.CursorLocation = CursorLocationEnum.adUseClient;
            rsSales.Open("select * from 结果  Order By DocDate, ItemCode", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);

            rsDoc.Open("select * from doc", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);
            rsDocLines.Open("select * from doclines", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1);
        }

        private void AddDatasetsToAC()
        {
            mac.Init(); //执行Init()后会清除之前已经添加的Dataset

            mac.AddDataset("zlemployee", rszlEmployee);

            mac.AddDataset("customer", rsCustomer);

            mac.AddDataset("Orders", rsOrders);

            mac.AddDataset("animals", rsAnimals);

            mac.AddDataset("biolife", rsBiolife);

            mac.AddDataset("country", rsContry);

            mac.AddDataset("Parts", rsParts);

            mac.AddDataset("vendors", rsVendors);

            mac.AddDataset("items", rsItems);

            mac.AddDataset("Xueli", rsXueli);

            mac.AddDataset("photos", rsPhoto);

            mac.AddDataset("XueLiEmp", rsXueLiEmp);

            mac.AddDataset("OITM", rsOITM);

            mac.AddDataset("Goods", rsGoods);

            mac.AddDataset("Sales", rsSales);

            mac.AddDataset("Doc", rsDoc);
            mac.AddDataset("DocLines", rsDocLines);

            //以下代码是设置字段的别名，一般来说数据库中的字段名是英文，通过设置别名，可以使字段对象在报表中以中文呈现，并以中文参与公式运算
          //  mac.SetDataFieldAliasName("OITM", "ItemCode,ItemName,OnHand", "物料编号,物料名称,库存量");

            mac.AddDataset("雇员档案", rszlEmployee); //重新加入一个表
            mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName",
                                                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历"); 
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

        private void SetAcRegisterInfo()
        { 
            int ErrCode = 0;
            string ErrMsg = "";
            mac.SetRegisterInfo("280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D" +
            "3D7DCD1DDCDD6D78680D8AD0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D",

                "天方工作室(acreport@sina.com qq:1655373859)", "23bd", "", "", "", "", ref ErrCode, ref ErrMsg);
            if (ErrCode != 0)
                MessageBox.Show(ErrMsg);
        }

        private void button16_Click(object sender, EventArgs e)
        {
           // mac.SetAppConnectionString(adoconn.ConnectionString)
            mac.SetReportFile(ReportPath + "23.apt");
            DoAct();
        }

        private void button17_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "00.apt");
            DoAct();
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
           // mac.AddDataset("zlemployee", reczlEmployee); 
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
            mac.AddDatasetRelation("Orders", "Items", "OrderNo=OrderNo");
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
            mac.SetReportFile(ReportPath + "multcol.apt");
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

        private void button9_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "014.apt");
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

        private void button15_Click(object sender, EventArgs e)
        {
           // mac.SetAppConnectionString(adoconn.ConnectionString);
            mac.SetReportFile(ReportPath + "20.apt");
            DoAct();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "sales.apt");
          //  mac.LoadFromFile(ReportPath + "sales.apt");
          //  mac.GetLineX(4).GetCell(2).CellText = "=sum(Sales, Sales.LineTotal)"; 
            DoAct();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button14_Click(object sender, EventArgs e)
        {
           // mac.SetAppConnectionString(adoconn.ConnectionString);
            //上面行的作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，
            //双击Form可以看到给连接对象的赋值脚本
            mac.SetReportFile(ReportPath + "22.apt");
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

        private void Grid1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnPreview_Click(object sender, EventArgs e)
        { 
            
            
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

        private void button26_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "fill1.apt");
            DoAct();
        }

        private void button21_Click(object sender, EventArgs e)
        {
          //  mac.AddDataset("雇员档案", rszlEmployee); //重新加入一个表
         //   mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
            //                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历"); 
          //上面的代码在 AddDatasetsToAC()中   
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
            mac.SetReportFile(ReportPath + "ReportView.apt");
            DoAct();
        }

        private void button33_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "ReportView2.apt");
            DoAct();
        }

        private void button34_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "ReportView3.apt");
            DoAct();
        }

        private void button35_Click(object sender, EventArgs e)
        {
            mac.SetReportFile(ReportPath + "ReportView4.apt");
            DoAct();
        }
    }
}