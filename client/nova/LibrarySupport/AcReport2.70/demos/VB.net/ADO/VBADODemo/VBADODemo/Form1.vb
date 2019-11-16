Imports ADODB
Imports AcReport

Public Class Form1
    Dim DataPath As String = ""
    Dim ReportPath As String = ""
    Dim mac As AcRptEngine ' As new AcReport.AcRptEngine(); ������AcRptEngineΪForm�ĳ�Ա����ʱ���������ڴ˳�ʼ����������ܳ��������������ͼ�겻��������ʾ������
    Dim adoconn = New ADODB.Connection()
    Dim rszlEmployee As New Recordset()
    Dim rsCustomer As New Recordset()
    Dim rsOrders As New Recordset()
    Dim rsAnimals As New Recordset()
    Dim rsBiolife As New Recordset()
    Dim rsContry As New Recordset()
    Dim rsParts As New Recordset()
    Dim rsVendors As New Recordset()
    Dim rsItems As New Recordset()
    Dim rsXueli As New Recordset()
    Dim rsPhoto As New Recordset()
    Dim rsXueLiEmp As New Recordset()
    Dim rsOITM As New Recordset()
    Dim rsGoods As New Recordset()
    Dim rsSales As New Recordset()
    Dim rsDoc As New Recordset
    Dim rsDocLines As New Recordset


    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim connstr As String

        mac = New AcRptEngine()

        DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\Data\"
        ReportPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\Reports\"
        connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
        adoconn.Open(connstr, "admin", "", -1)
        mac.SetAppConnectionString(connstr) '�����Ӵ��뱨���ڱ���������л����һ��������AppConnString���ڲ����ݱ�����õ��˱���
        OpenDatasets()
        AddDatasetsToAC()
        SetAcRegisterInfo()
        'rc.Open("select top 500 * from zlemployee", adoconn, ADODB.CursorTypeEnum.adOpenDynamic, ADODB.LockTypeEnum.adLockOptimistic, 1)
        ' tabControl1.SelectTab(1)
    End Sub

    Private Sub OpenDatasets()
        rszlEmployee.Open("select top 300 e.*, x.Name as XueLiName, D.Name As DptName from zlemployee e , XueLi x,ZlDept D" + _
                " where  e.XueLi = x.Code and e.Dept = D.Code", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsCustomer.CursorLocation = CursorLocationEnum.adUseClient
        '������ Order by ��SQL�������ǰ��ִ���������У�����֡���ǰ�ṩ����֧����������������Ľ��桱���쳣
        rsCustomer.Open("select * from customer order by custNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsOrders.CursorLocation = CursorLocationEnum.adUseClient
        rsOrders.Open("Select * from Orders order by OrderNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsAnimals.Open("Select * from animals", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsBiolife.Open("select * from biolife", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsContry.Open("select * from country", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsParts.CursorLocation = CursorLocationEnum.adUseClient
        rsParts.Open("Select * from Parts order by PartNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsVendors.CursorLocation = CursorLocationEnum.adUseClient
        rsVendors.Open("select * from vendors order by vendorNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsItems.CursorLocation = CursorLocationEnum.adUseClient
        rsItems.Open("select i.*, Description as PartName, ListPrice as Price,i.Qty * p.ListPrice as Total " + " from items i Left Join Parts p On i.PartNo= p.PartNo " + " order by ItemNo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsXueli.Open("Select * from XueLi", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsPhoto.Open("Select * from photo", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsXueLiEmp.CursorLocation = CursorLocationEnum.adUseClient
        rsXueLiEmp.Open("Select X.Code, X.Name, Count(*) As Num " + " From zlemployee z inner join Xueli X " + " On z.XueLi = X.Code " + " Group By X.Code, X.Name", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsOITM.CursorLocation = CursorLocationEnum.adUseClient
        rsOITM.Open("Select top 300 ItemCode, ItemName, FrgnName, CodeBars, OnHand from OITM order by ItemCode", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsGoods.CursorLocation = CursorLocationEnum.adUseClient
        rsGoods.Open("Select Code, Unit, Name, Spec, Stocks_1,Stocks_2 From Goods  Order By Code", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)

        rsSales.CursorLocation = CursorLocationEnum.adUseClient
        rsSales.Open("select * from ���  Order By DocDate, ItemCode", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)
        rsDoc.Open("select * from doc", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)
        rsDocLines.Open("select * from doclines", adoconn, CursorTypeEnum.adOpenKeyset, LockTypeEnum.adLockOptimistic, 1)
    End Sub 'OpenDatasets



    Private Sub AddDatasetsToAC()
        mac.Init() 'ִ��Init()������֮ǰ�Ѿ���ӵ�Dataset
        mac.AddDataset("zlemployee", rszlEmployee)

        mac.AddDataset("customer", rsCustomer)

        mac.AddDataset("Orders", rsOrders)

        mac.AddDataset("animals", rsAnimals)

        mac.AddDataset("biolife", rsBiolife)

        mac.AddDataset("country", rsContry)

        mac.AddDataset("Parts", rsParts)

        mac.AddDataset("vendors", rsVendors)

        mac.AddDataset("items", rsItems)

        mac.AddDataset("Xueli", rsXueli)

        mac.AddDataset("photos", rsPhoto)

        mac.AddDataset("XueLiEmp", rsXueLiEmp)

        mac.AddDataset("OITM", rsOITM)

        mac.AddDataset("Goods", rsGoods)

        mac.AddDataset("Sales", rsSales)
        mac.AddDataset("Doc", rsDoc)
        mac.AddDataset("DocLines", rsDocLines)

        '���´����������ֶεı�����һ����˵���ݿ��е��ֶ�����Ӣ�ģ�ͨ�����ñ���������ʹ�ֶζ����ڱ����������ĳ��֣��������Ĳ��빫ʽ����
        '  mac.SetDataFieldAliasName("OITM", "ItemCode,ItemName,OnHand", "���ϱ��,��������,�����");

        mac.AddDataset("��Ա����", rszlEmployee)  '���¼���һ����
        mac.SetDataFieldAliasName("��Ա����", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName", _
                                                 "����,���ű��,��������,����,����,��������,�ձ�,���֤,Ƹ������,����,ѧ��")
    End Sub 'AddDatasetsToAC


    Private Sub DoAct()
        mac.AddVariable("����1", textBox1.Text)
        mac.AddVariable("����2", textBox2.Text)

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
                        mac.ExportToXls("")
                    End If
                End If
            End If
        End If
    End Sub 'DoAct

    Private Sub SetAcRegisterInfo()
        Dim ErrCode As Integer = 0
        Dim ErrMsg As String = ""
        mac.SetRegisterInfo("280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D3D7DCD1DDCDD6D78680D8A" + _
               "D0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D", _
               "�췽������(acreport@sina.com qq:1655373859)", "23bd", "", "", "", "", ErrCode, ErrMsg)

        If ErrCode <> 0 Then
            MessageBox.Show(ErrMsg)
        End If
        'ע����Ϣ����Ӧ����ֻ��Ҫ����һ�Σ�����κ�һ��AcReportEngine�������ü��ɣ������Ķ���ʵ������Ҫ�ٵ��ô˷���
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
        mac.SetReportFile(ReportPath + "sales.apt")
        DoAct()
    End Sub

    Private Sub button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button3.Click
        mac.ClearDataRelations()
        If mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") <> 0 Then '���ӱ�Ķ�Ӧ��ϵ
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
        mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") '���ӱ�Ķ�Ӧ��ϵ
        mac.SetReportFile((ReportPath + "sub1.apt"))
        DoAct()
        mac.ClearDataRelations()
    End Sub

    Private Sub button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button6.Click
        mac.ClearDataRelations()
        mac.AddDatasetRelation("customer", "Orders", "CustNo=CustNo") '���ӱ�Ķ�Ӧ��ϵ
        mac.AddDatasetRelation("Orders", "Items", "OrderNo=OrderNo")
        mac.SetReportFile((ReportPath + "sub2.apt"))
        DoAct()
        mac.ClearDataRelations()
    End Sub

    Private Sub button7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button7.Click
        mac.SetReportFile(ReportPath + "label.apt")
        DoAct()
    End Sub

    Private Sub button8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button8.Click
        mac.SetReportFile(ReportPath + "multcol.apt")
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

    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Close()
    End Sub

    Private Sub button15_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button15.Click
        ' mac.SetAppConnectionString(adoconn.ConnectionString)
        mac.SetReportFile(ReportPath + "20.apt")
        DoAct()
    End Sub

    Private Sub button14_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button14.Click
        ' mac.SetAppConnectionString(adoconn.ConnectionString);
        '�������Ѿ��Ƶ�Form_Load�У������ǽ���ǰӦ�ó����ADO�����ַ������뱨��ִ�д˷�������AcReport�н�����һ����ΪAppConnString�Ĺ����������ڽű������У�
        '˫��Form���Կ��������Ӷ���ĸ�ֵ�ű�
        mac.SetReportFile(ReportPath + "22.apt")
        DoAct()
    End Sub

    Private Sub button16_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button16.Click
        ' mac.SetAppConnectionString(adoconn.ConnectionString)
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

    Private Sub button18_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button18.Click
        mac.SetReportFile(ReportPath + "group2.apt")
        DoAct()
    End Sub

    Private Sub button21_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button21.Click
        '  mac.AddDataset("��Ա����", rszlEmployee); //���¼���һ����
        '   mac.SetDataFieldAliasName("��Ա����", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
        '                 "����,���ű��,��������,����,����,��������,�ձ�,���֤,Ƹ������,����,ѧ��"); 
        '����Ĵ����� AddDatasetsToAC()��   
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


