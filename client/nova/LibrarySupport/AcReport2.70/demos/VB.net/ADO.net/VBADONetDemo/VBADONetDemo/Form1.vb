Imports System
Imports System.Data
Imports System.Data.OleDb
Imports AcReport
Imports AcNetUtils

Public Class Form1
    Private mDataset As New DataSet()
    Private oleconn As New OleDbConnection()
    Private mac As AcReport.AcRptEngine
    Private DataPath, ReportPath As String

    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Close()
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\Data\"
        ReportPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\Reports\"

        oleconn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
        oleconn.Open()
        RefreshData()
        mac = New AcReport.AcRptEngine()
        '2.5之前的版本，需要在AC中复制一个复本，速度较慢
        'AcUtils.CopyDatasetToAcRptEngine(mDataset, mac, False)

        '2.5以后的版本直接支持将ADO.net模拟为ADO接口的方式直接传入报表Engine(需要引用 AcNetUtils.dll 类库)
        AcNetUtils.DbAdapter.FillDatasetToAC(mDataset, mac)

        SetReportConnString()
        SetAcRegisterInfo()

        '以下代码是设置字段的别名，一般来说数据库中的字段名是英文，通过设置别名，可以使字段对象在报表中以中文呈现，并以中文参与公式运算
        '  mac.SetDataFieldAliasName("OITM", "ItemCode,ItemName,OnHand", "物料编号,物料名称,库存量")
        '重新加入一个表到AcReport
        mDataset.Tables("zlemployee").TableName = "雇员档案"

        ' AcUtils.CopyTableToAcRptEngine(mDataset.Tables("雇员档案"), mac, False) '旧版本方式

        AcNetUtils.DbAdapter.FillDataTableToAC(mDataset.Tables("雇员档案"), mac) '新版本方式


        mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName", _
                                       "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历")
        tabControl1.SelectTab(1)

    End Sub


    Private Sub RefreshData()
        OpenCmd("select top 300 e.*, x.Name as XueLiName, D.Name As DptName from zlemployee e , XueLi x,ZlDept D" + _
                " where  e.XueLi = x.Code and e.Dept = D.Code", "zlemployee")
        OpenCmd("select top 30 * from customer ", "customer")
        OpenCmd("Select top 20 * from Orders order by OrderNo", "Orders")
        '  OpenCmd("Select * from animals", "animals");
        '  OpenCmd("select * from biolife", "biolife");
        '   OpenCmd("select * from country", "country");
        OpenCmd("Select * from Parts order by PartNo", "Parts")
        OpenCmd("select * from vendors order by vendorNo", "vendors")
        OpenCmd("select top 300 i.*, Description as PartName, ListPrice as Price,i.Qty * p.ListPrice as Total " + " from items i Left Join Parts p On i.PartNo= p.PartNo " + " order by ItemNo", "items")
        OpenCmd("Select * from XueLi", "XueLi")
        OpenCmd("Select * from photo", "photos")
        OpenCmd("Select X.Code, X.Name, Count(*) As Num " + " From zlemployee z inner join Xueli X " + " On z.XueLi = X.Code " + " Group By X.Code, X.Name", "XueLiEmp")

        OpenCmd("Select top 300 ItemCode, ItemName, FrgnName, CodeBars, OnHand from OITM", "OITM")
        OpenCmd("Select top 300 Code, Unit, Name, Spec, Stocks_1,Stocks_2 From Goods  Order By Code", "goods")
        OpenCmd("select * from 结果  Order By DocDate, ItemCode", "Sales")
        OpenCmd("select * from doc", "Doc")
        OpenCmd("select * from doclines", "DocLines")
    End Sub 'RefreshData


    Private Sub OpenCmd(ByVal cmdText As String, ByVal sTableName As String)
        Dim cmd As New OleDbCommand(cmdText, oleconn)
        Dim oleDar As New OleDbDataAdapter(cmd)
        oleDar.Fill(mDataset)
        mDataset.Tables("Table").TableName = sTableName
    End Sub 'OpenCmd


    Private Sub DoAct()
        '将两个变量传入报表，如果此前已经存在该变量名，调用AddVariable后将覆盖旧值
        mac.AddVariable("变量1", textBox1.Text)
        mac.AddVariable("变量2", textBox1.Text)

        If rb1.Checked Then
            mac.Preview()
        Else
            If rb2.Checked Then
                mac.ShowDesigner()
            Else
                If rb3.Checked Then
                    mac.Print()
                Else
                    If rb4.Checked Then
                        mac.PrepareReport()
                        mac.ExportToXls("")
                    End If
                End If
            End If
        End If
    End Sub 'DoAct

    Private Sub SetReportConnString()
        '设置报表连接字符串，主要方便于报表内脚本编程直接访问数据库，如果报表中没有直接访问数据库或未用到AppConnString变量，则不需要执行此过程
        DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\Data\"
        Dim connstr As [String] = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
        mac.SetAppConnectionString(connstr)
    End Sub 'SetReportConnString

    Private Sub SetAcRegisterInfo()
        Dim ErrCode As Integer = 0
        Dim ErrMsg As String = ""
        mac.SetRegisterInfo("280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D3D7DCD1DDCDD6D78680D8A" + _
               "D0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D", _
               "天方工作室(acreport@sina.com qq:1655373859)", "23bd", "", "", "", "", ErrCode, ErrMsg)

        If ErrCode <> 0 Then
            MessageBox.Show(ErrMsg)
        End If
        '注册信息整个应用中只需要设置一次，针对任何一个AcReportEngine对象设置即可，其它的对象实例不需要再调用此方法
    End Sub 'SetAcRegisterInfo

    Private Sub button17_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button17.Click
        mac.SetReportFile(ReportPath + "00.apt")
        DoAct()
    End Sub

    Private Sub button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button1.Click
        mac.SetReportFile(ReportPath + "list.apt")
        DoAct()
    End Sub

    Private Sub button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button2.Click
        mac.SetReportFile(ReportPath + "list.apt")
        DoAct()
    End Sub

    Private Sub button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button3.Click
        mac.ClearDataRelations()
        If mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") <> 0 Then '主从表的对应关系
            Dim ErrCode As Integer = 0
            Dim ErrMsg As String = ""

            mac.GetLastError(ErrCode, ErrMsg)
            Throw New Exception(ErrMsg)
        End If
        mac.SetReportFile((ReportPath + "md.apt"))
        DoAct()
        mac.ClearDataRelations()
    End Sub

    Private Sub button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button4.Click
        mac.SetReportFile(ReportPath + "group.apt")
        DoAct()
    End Sub

    Private Sub button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button5.Click
        mac.ClearDataRelations()
        mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") '主从表的对应关系
        mac.SetReportFile(ReportPath + "sub1.apt")
        DoAct()
        mac.ClearDataRelations()
    End Sub

    Private Sub button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button6.Click
        mac.ClearDataRelations()
        mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") '主从表的对应关系
        mac.AddDatasetRelation("Orders", "items", "OrderNo=OrderNo")
        mac.SetReportFile((ReportPath + "sub2.apt"))
        DoAct()
    End Sub

    Private Sub button7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button7.Click
        mac.SetReportFile(ReportPath + "label.apt")
        DoAct()
    End Sub

    Private Sub button8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button8.Click
        mac.SetReportFile(ReportPath + "04.apt") '"multcol.apt")
        DoAct()
    End Sub

    Private Sub button9_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button9.Click
        mac.SetReportFile(ReportPath + "014.apt")
        DoAct()
    End Sub

    Private Sub button10_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button10.Click
        mac.SetReportFile(ReportPath + "dlg1.apt")
        DoAct()
    End Sub

    Private Sub button11_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button11.Click
        mac.SetReportFile(ReportPath + "dlg2.apt")
        DoAct()
    End Sub

    Private Sub button12_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button12.Click
        mac.SetReportFile(ReportPath + "itemlist.apt")
        DoAct()
    End Sub

    Private Sub button13_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button13.Click
        mac.SetReportFile(ReportPath + "hideline.apt")
        DoAct()
    End Sub

    Private Sub button15_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button15.Click
        SetReportConnString()
        mac.SetReportFile(ReportPath + "20.apt")
        DoAct()
    End Sub

    Private Sub button14_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button14.Click
        SetReportConnString()
        '上面行的作用是将当前应用程序的ADO连接字符串传入报表，执行此方法后，在AcReport中将生成一个名为AppConnString的公共变量，在脚本窗体中，
        '双击Form可以看到给连接对象的赋值脚本
        mac.SetReportFile((ReportPath + "22.apt"))
        DoAct()
    End Sub

    Private Sub button16_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button16.Click
        SetReportConnString()
        mac.SetReportFile(ReportPath + "23.apt")
        DoAct()
    End Sub

    Private Sub button19_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button19.Click
        mac.SetReportFile(ReportPath + "doc1.apt")
        DoAct()
    End Sub

    Private Sub button20_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button20.Click
        mac.SetReportFile(ReportPath + "ht1.apt")
        DoAct()
    End Sub

    Private Sub button21_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button21.Click
        '  mac.AddDataset("雇员档案", rszlEmployee); //重新加入一个表
        '   mac.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
        '                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历"); 
        '上面的代码在 AddDatasetsToAC()中   
        mac.SetReportFile(ReportPath + "01CN.apt")
        DoAct()
    End Sub

    Private Sub button22_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button22.Click
        mac.SetReportFile(ReportPath + "keepPg1.apt")
        DoAct()
    End Sub

    Private Sub button27_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button27.Click
        mac.SetReportFile(ReportPath + "keepPg2.apt")
        DoAct()
    End Sub

    Private Sub button23_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button23.Click
        mac.SetReportFile(ReportPath + "group3.apt")
        DoAct()
    End Sub

    Private Sub button24_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button24.Click
        mac.SetReportFile(ReportPath + "group4.apt")
        DoAct()
    End Sub

    Private Sub button25_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button25.Click
        mac.SetReportFile(ReportPath + "DtMultCol.apt")
        DoAct()
    End Sub

    Private Sub button26_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button26.Click
        mac.SetReportFile(ReportPath + "fill1.apt")
        DoAct()
    End Sub

    Private Sub RBView1_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RBView1.CheckedChanged
        If Not (mac Is Nothing) Then
            mac.ShowPreviewOnPrepare = False
        End If
    End Sub

    Private Sub RBView2_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RBView2.CheckedChanged
        If Not (mac Is Nothing) Then
            mac.ShowPreviewOnPrepare = True
        End If
    End Sub

    Private Sub button18_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button18.Click
        mac.SetReportFile(ReportPath + "group2.apt")
        DoAct()
    End Sub

    Private Sub button28_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button28.Click
        mac.SetReportFile(ReportPath + "obj1.apt")
        DoAct()
    End Sub

    Private Sub button29_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button29.Click
        mac.SetReportFile(ReportPath + "obj2.apt")
        DoAct()
    End Sub

    Private Sub button30_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button30.Click
        mac.SetReportFile(ReportPath + "data1.apt")
        DoAct()
    End Sub

    Private Sub button31_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button31.Click
        mac.SetReportFile(ReportPath + "custextra.apt")
        DoAct()
    End Sub

    Private Sub button32_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button32.Click
        mac.SetReportFile(ReportPath + "ReportView.apt")
        DoAct()
    End Sub

    Private Sub button33_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button33.Click
        mac.SetReportFile(ReportPath + "ReportView2.apt")
        DoAct()
    End Sub

    Private Sub button34_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button34.Click
        mac.SetReportFile(ReportPath + "ReportView3.apt")
        DoAct()
    End Sub

    Private Sub button35_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button35.Click
        mac.SetReportFile(ReportPath + "ReportView4.apt")
        DoAct()
    End Sub
End Class
