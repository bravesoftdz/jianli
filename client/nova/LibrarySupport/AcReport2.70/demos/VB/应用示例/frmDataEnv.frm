VERSION 5.00
Begin VB.Form frmDataEnv 
   Caption         =   "AC Report�й�ʽ����(��Ҷ����)Demo"
   ClientHeight    =   6930
   ClientLeft      =   2505
   ClientTop       =   1725
   ClientWidth     =   11520
   LinkTopic       =   "Form1"
   ScaleHeight     =   6930
   ScaleWidth      =   11520
   StartUpPosition =   2  '��Ļ����
   Begin VB.Frame Frame7 
      Caption         =   "Ԥ����ʽ"
      Height          =   1455
      Left            =   8640
      TabIndex        =   42
      Top             =   2280
      Width           =   2415
      Begin VB.OptionButton opView2 
         Caption         =   "�����ɱ�Ԥ��"
         ForeColor       =   &H80000002&
         Height          =   255
         Left            =   240
         TabIndex        =   44
         Top             =   840
         Value           =   -1  'True
         Width           =   1935
      End
      Begin VB.OptionButton opView1 
         Caption         =   "���ɱ����Ԥ��"
         ForeColor       =   &H80000002&
         Height          =   255
         Left            =   240
         TabIndex        =   43
         Top             =   360
         Width           =   1575
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "����"
      Height          =   1935
      Left            =   8640
      TabIndex        =   37
      Top             =   120
      Width           =   2415
      Begin VB.OptionButton Option1 
         Caption         =   "Ԥ������"
         ForeColor       =   &H80000002&
         Height          =   375
         Left            =   240
         TabIndex        =   41
         Top             =   240
         Value           =   -1  'True
         Width           =   1695
      End
      Begin VB.OptionButton Option2 
         Caption         =   "��Ʊ���"
         ForeColor       =   &H80000002&
         Height          =   375
         Left            =   240
         TabIndex        =   40
         Top             =   680
         Width           =   1815
      End
      Begin VB.OptionButton Option3 
         Caption         =   "��ӡ"
         ForeColor       =   &H80000002&
         Height          =   255
         Left            =   240
         TabIndex        =   39
         Top             =   1120
         Width           =   975
      End
      Begin VB.OptionButton Option4 
         Caption         =   "����ΪExcel�ļ�"
         ForeColor       =   &H80000002&
         Height          =   375
         Left            =   240
         TabIndex        =   38
         Top             =   1440
         Width           =   1695
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "�°�����"
      Height          =   6495
      Left            =   4680
      TabIndex        =   30
      Top             =   120
      Width           =   3375
      Begin VB.CommandButton Command37 
         Caption         =   "������ͼ - ��̬��ͼ"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   53
         Top             =   2160
         Width           =   2895
      End
      Begin VB.CommandButton Command36 
         Caption         =   "������ͼ - ����"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   52
         Top             =   1680
         Width           =   2895
      End
      Begin VB.CommandButton Command35 
         Caption         =   "������ͼ - ��Ԫ�� - ����"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   51
         Top             =   1200
         Width           =   2895
      End
      Begin VB.CommandButton Command34 
         Caption         =   "������ͼ-���е���ϸ"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   50
         Top             =   720
         Width           =   2895
      End
      Begin VB.CommandButton Command33 
         Caption         =   "�Զ����ּ����м��"
         BeginProperty Font 
            Name            =   "����"
            Size            =   9
            Charset         =   134
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   49
         Top             =   240
         Width           =   2895
      End
      Begin VB.CommandButton Command31 
         Caption         =   "���ڿ��϶�����ı���2"
         Height          =   375
         Left            =   240
         TabIndex        =   46
         Top             =   3090
         Width           =   2895
      End
      Begin VB.CommandButton Command30 
         Caption         =   "���ڿ��϶�����ı���1"
         Height          =   375
         Left            =   240
         TabIndex        =   45
         Top             =   2640
         Width           =   2895
      End
      Begin VB.CommandButton Command29 
         Caption         =   "�״������(����ӡ����ͼ��)"
         Height          =   375
         Left            =   240
         TabIndex        =   36
         Top             =   5760
         Width           =   2895
      End
      Begin VB.CommandButton Command28 
         Caption         =   "��ϸ��������ӡ(����˳�����)"
         Height          =   375
         Left            =   240
         TabIndex        =   35
         Top             =   5310
         Width           =   2895
      End
      Begin VB.CommandButton Command27 
         Caption         =   "�����ҳ�������"
         Height          =   375
         Left            =   240
         TabIndex        =   34
         Top             =   4845
         Width           =   2895
      End
      Begin VB.CommandButton Command26 
         Caption         =   "����ҳβ����ҳ��ײ�"
         Height          =   375
         Left            =   240
         TabIndex        =   33
         Top             =   4395
         Width           =   2895
      End
      Begin VB.CommandButton Command25 
         Caption         =   "ҳβ������ҳ��ײ�(���������)"
         Height          =   375
         Left            =   240
         TabIndex        =   32
         Top             =   3945
         Width           =   2895
      End
      Begin VB.CommandButton Command24 
         Caption         =   "ҳβ������ҳ��ײ�"
         Height          =   375
         Left            =   240
         TabIndex        =   31
         Top             =   3495
         Width           =   2895
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "����"
      Height          =   1815
      Left            =   2280
      TabIndex        =   23
      Top             =   120
      Width           =   2175
      Begin VB.CommandButton Command22 
         Caption         =   "����2"
         Height          =   375
         Left            =   240
         TabIndex        =   29
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   780
         Width           =   1695
      End
      Begin VB.CommandButton Command21 
         Caption         =   "���"
         Height          =   375
         Left            =   240
         TabIndex        =   28
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   1200
         Width           =   1695
      End
      Begin VB.CommandButton Command20 
         Caption         =   "����"
         Height          =   375
         Left            =   240
         TabIndex        =   27
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   360
         Width           =   1695
      End
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   9240
      TabIndex        =   19
      Text            =   "AC Report"
      Top             =   4320
      Width           =   1695
   End
   Begin VB.Frame Frame3 
      Caption         =   "�ڲ����ݱ���"
      Height          =   1575
      Left            =   2280
      TabIndex        =   12
      Top             =   4440
      Width           =   2175
      Begin VB.CommandButton Command14 
         Caption         =   "��������"
         Height          =   375
         Left            =   240
         TabIndex        =   15
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   1080
         Width           =   1695
      End
      Begin VB.CommandButton Command13 
         Caption         =   "�ڲ�Query(ADO)"
         Height          =   375
         Left            =   240
         TabIndex        =   14
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   660
         Width           =   1695
      End
      Begin VB.CommandButton Command12 
         Caption         =   "�ڲ�Table(ADO)"
         Height          =   375
         Left            =   240
         TabIndex        =   13
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "�Ի���ͽű�"
      Height          =   2055
      Left            =   2280
      TabIndex        =   9
      Top             =   2040
      Width           =   2175
      Begin VB.CommandButton Command18 
         Caption         =   "��̬������"
         Height          =   375
         Left            =   240
         TabIndex        =   25
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   1560
         Width           =   1695
      End
      Begin VB.CommandButton Command17 
         Caption         =   "�м���ɫ�仯"
         Height          =   375
         Left            =   240
         TabIndex        =   24
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   1120
         Width           =   1695
      End
      Begin VB.CommandButton Command10 
         Caption         =   "����ȷ��"
         Height          =   375
         Left            =   240
         TabIndex        =   11
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   680
         Width           =   1695
      End
      Begin VB.CommandButton Command9 
         Caption         =   "��ӡ���������"
         Height          =   375
         Left            =   240
         TabIndex        =   10
         ToolTipText     =   "һ��������б������Զ����ܡ�"
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "���ñ���"
      Height          =   6495
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2055
      Begin VB.CommandButton Command32 
         Caption         =   "ʹ������ģ��"
         Height          =   375
         Left            =   120
         TabIndex        =   48
         Top             =   5760
         Width           =   1695
      End
      Begin VB.CommandButton Command23 
         Caption         =   "�����ֶα���"
         Height          =   375
         Left            =   120
         TabIndex        =   47
         Top             =   5280
         Width           =   1695
      End
      Begin VB.CommandButton Command19 
         Caption         =   "��̬��Rich�ı�"
         Height          =   375
         Left            =   120
         TabIndex        =   26
         Top             =   4800
         Width           =   1695
      End
      Begin VB.CommandButton Command16 
         Caption         =   "�кϲ����鱨��"
         Height          =   375
         Left            =   120
         TabIndex        =   22
         Top             =   2580
         Width           =   1695
      End
      Begin VB.CommandButton Command15 
         Caption         =   "��Ԫ����ʽչʾ"
         Height          =   375
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   1695
      End
      Begin VB.CommandButton Command11 
         Caption         =   "���Զ��ϲ�"
         Height          =   375
         Left            =   120
         TabIndex        =   17
         Top             =   1245
         Width           =   1695
      End
      Begin VB.CommandButton Command1 
         Caption         =   "��ͨ�嵥"
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   810
         Width           =   1695
      End
      Begin VB.CommandButton Command2 
         Caption         =   "���ӱ���"
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Top             =   1695
         Width           =   1695
      End
      Begin VB.CommandButton Command3 
         Caption         =   "���鱨��"
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   2130
         Width           =   1695
      End
      Begin VB.CommandButton Command5 
         Caption         =   "�ӱ���1"
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Top             =   3030
         Width           =   1695
      End
      Begin VB.CommandButton Command6 
         Caption         =   "�༶Ƕ���ӱ���"
         Height          =   375
         Left            =   120
         TabIndex        =   5
         Top             =   3465
         Width           =   1695
      End
      Begin VB.CommandButton Command7 
         Caption         =   "ͼ��"
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   3915
         Width           =   1695
      End
      Begin VB.CommandButton Command8 
         Caption         =   "��������"
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   4350
         Width           =   1695
      End
   End
   Begin VB.CommandButton Command4 
      Caption         =   "�˳�"
      Height          =   375
      Left            =   9480
      TabIndex        =   1
      Top             =   5160
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   9240
      TabIndex        =   0
      Text            =   "ͬ��������ԴEHR"
      Top             =   3960
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "����2"
      Height          =   255
      Left            =   8520
      TabIndex        =   21
      Top             =   4320
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "����1"
      Height          =   255
      Left            =   8520
      TabIndex        =   20
      Top             =   3960
      Width           =   615
   End
End
Attribute VB_Name = "frmDataEnv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim DataPath
Dim ReportPath
Dim ACRptEngine1 As AcRptEngine



Private Sub Command1_Click()
  ACRptEngine1.SetReportFile ReportPath + "list.apt"
  DoAct
End Sub

Private Sub Command10_Click()
  ACRptEngine1.ClearDataRelations
  
  ACRptEngine1.SetReportFile ReportPath + "dlg2.apt"
  DoAct
  ACRptEngine1.ClearDataRelations
End Sub

Private Sub Command11_Click()

  ACRptEngine1.SetReportFile ReportPath + "sales.apt"
  DoAct
  ACRptEngine1.ClearDataRelations
End Sub

Private Sub Command12_Click()

  ACRptEngine1.SetReportFile ReportPath + "20.apt"
  DoAct
End Sub

Private Sub Command13_Click()

  ACRptEngine1.SetReportFile ReportPath + "22.apt"
  DoAct
End Sub

Private Sub Command14_Click()

  ACRptEngine1.SetReportFile ReportPath + "23.apt"
  DoAct
End Sub

Private Sub Command15_Click()
  ACRptEngine1.SetReportFile ReportPath + "00.apt"
  DoAct
End Sub

Private Sub Command16_Click()
  ACRptEngine1.SetReportFile ReportPath + "group2.apt"
  DoAct
End Sub

Private Sub Command17_Click()
   ACRptEngine1.SetReportFile (ReportPath + "itemlist.apt")
   DoAct
End Sub

Private Sub Command18_Click()
  ACRptEngine1.SetReportFile (ReportPath + "hideline.apt")
  DoAct
End Sub

Private Sub Command19_Click()
  ACRptEngine1.SetReportFile ReportPath + "014.apt"
  DoAct
End Sub

Private Sub Command2_Click()
  ACRptEngine1.ClearDataRelations
  ACRptEngine1.AddDatasetRelation "Customer", "Orders", "CustNo=CustNo"
  ACRptEngine1.SetReportFile ReportPath + "md.apt"
  DoAct
  ACRptEngine1.ClearDataRelations
End Sub

Private Sub Command20_Click()
  ACRptEngine1.SetReportFile ReportPath + "doc1.apt"
  DoAct
End Sub

Private Sub Command21_Click()
  ACRptEngine1.SetReportFile ReportPath + "ht1.apt"
  DoAct
End Sub

Private Sub Command22_Click()
  ACRptEngine1.SetReportFile ReportPath + "doc2.apt"
  DoAct
End Sub

Private Sub Command23_Click()
  '  ACRptEngine1.AddDataset("��Ա����", rszlEmployee); //���¼���һ����
 '   ACRptEngine1.SetDataFieldAliasName("��Ա����", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
  '                 "����,���ű��,��������,����,����,��������,�ձ�,���֤,Ƹ������,����,ѧ��");
  '����Ĵ����� AddDatasetsToAC()��
  ACRptEngine1.SetReportFile (ReportPath + "01CN.apt")
  DoAct
End Sub

Private Sub Command24_Click()
  ACRptEngine1.SetReportFile (ReportPath + "keepPg1.apt")
  DoAct
End Sub

Private Sub Command25_Click()
   ACRptEngine1.SetReportFile (ReportPath + "keepPg2.apt")
   DoAct
End Sub

Private Sub Command26_Click()
  ACRptEngine1.SetReportFile (ReportPath + "group3.apt")
  DoAct
End Sub

Private Sub Command27_Click()
   ACRptEngine1.SetReportFile (ReportPath + "group4.apt")
   DoAct
End Sub

Private Sub Command28_Click()
  ACRptEngine1.SetReportFile (ReportPath + "DtMultCol.apt")
  DoAct
End Sub

Private Sub Command29_Click()
  ACRptEngine1.SetReportFile (ReportPath + "fill1.apt")
  DoAct
End Sub

Private Sub Command3_Click()

  ACRptEngine1.SetReportFile ReportPath + "group.apt"
  DoAct
End Sub

Private Sub Command30_Click()
  ACRptEngine1.SetReportFile (ReportPath + "obj1.apt")
  DoAct
End Sub

Private Sub Command31_Click()
  ACRptEngine1.SetReportFile (ReportPath + "obj2.apt")
  DoAct
End Sub

Private Sub Command32_Click()
  ACRptEngine1.SetReportFile (ReportPath + "data1.apt")
  DoAct
End Sub

Private Sub Command33_Click()
  ACRptEngine1.SetReportFile (ReportPath + "custextra.apt")
  DoAct
End Sub

Private Sub Command34_Click()
  ACRptEngine1.SetReportFile (ReportPath + "ReportView.apt")
  DoAct
End Sub

Private Sub Command35_Click()
  ACRptEngine1.SetReportFile (ReportPath + "ReportView2.apt")
  DoAct
End Sub

Private Sub Command36_Click()
  ACRptEngine1.SetReportFile (ReportPath + "ReportView3.apt")
  DoAct
End Sub

Private Sub Command37_Click()
  ACRptEngine1.SetReportFile (ReportPath + "ReportView4.apt")
  DoAct
End Sub

Private Sub Command4_Click()
  End
End Sub

Private Sub Command5_Click()
  ACRptEngine1.ClearDataRelations
  ACRptEngine1.AddDatasetRelation "Customer", "Orders", "CustNo=CustNo"
  ACRptEngine1.SetReportFile ReportPath + "sub1.apt"
  DoAct
  ACRptEngine1.ClearDataRelations
End Sub

Private Sub Command6_Click()
  ACRptEngine1.ClearDataRelations
  ACRptEngine1.AddDatasetRelation "Customer", "Orders", "CustNo=CustNo"
  ACRptEngine1.AddDatasetRelation "Orders", "Items", "OrderNo=OrderNo"
  ACRptEngine1.SetReportFile ReportPath + "sub2.apt"
  DoAct
  ACRptEngine1.ClearDataRelations
End Sub

Private Sub Command7_Click()

  ACRptEngine1.SetReportFile ReportPath + "label.apt"
  DoAct
End Sub

Private Sub Command8_Click()

  ACRptEngine1.SetReportFile ReportPath + "multcol.apt"
  DoAct
End Sub

Private Sub Command9_Click()
  ACRptEngine1.SetReportFile ReportPath + "dlg1.apt"
  DoAct
End Sub

Private Sub Form_Load()
   Set ACRptEngine1 = New AcRptEngine
   SetAcRegisterInfo
   
   ACRptEngine1.AddGlobalVariable "ʹ�õ�λ", Text1.Text
   
   DataPath = App.Path + "\..\..\Data\"
   ReportPath = App.Path + "\..\..\reports\"
   DataEnvironment1.Connection1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
   DataEnvironment1.Connection1.Open
   
   ACRptEngine1.SetAppConnectionString (DataEnvironment1.Connection1.ConnectionString)
   
   DataEnvironment1.rsCustomer.Open
   DataEnvironment1.rsOrders.Open
   DataEnvironment1.rsItems.Open
   DataEnvironment1.rsBiolife.Open
   DataEnvironment1.rscountry.Open
   DataEnvironment1.rsGroups.Open
   DataEnvironment1.rsZlemployee.Open
   DataEnvironment1.rsAnimals.Open
   DataEnvironment1.rsPhoto.Open
   DataEnvironment1.rsXueli.Open
   DataEnvironment1.rsXueLiEmp.Open
   DataEnvironment1.rsgoods.Open
   DataEnvironment1.rsSales.Open
   DataEnvironment1.rsDoc.Open
   DataEnvironment1.rsDocLines.Open
   DataEnvironment1.rsOITM.Open
   
  ACRptEngine1.Init
  ACRptEngine1.AddDataset "animals", DataEnvironment1.rsAnimals
  ACRptEngine1.AddDataset "zlemployee", DataEnvironment1.rsZlemployee
  ACRptEngine1.AddDataset "goods", DataEnvironment1.rsgoods
  ACRptEngine1.AddDataset "Orders", DataEnvironment1.rsOrders
  ACRptEngine1.AddDataset "Customer", DataEnvironment1.rsCustomer
  ACRptEngine1.AddDataset "Orders", DataEnvironment1.rsOrders
    
  ACRptEngine1.AddDataset "xueli", DataEnvironment1.rsXueli
  ACRptEngine1.AddDataset "XueLiEmp", DataEnvironment1.rsXueLiEmp
  ACRptEngine1.AddDataset "photos", DataEnvironment1.rsPhoto
  ACRptEngine1.AddDataset "animals", DataEnvironment1.rsAnimals
  ACRptEngine1.AddDatasetRelation "customer", "orders", "CustNo=CustNo"
  ACRptEngine1.AddDataset "Sales", DataEnvironment1.rsSales
  ACRptEngine1.AddDataset "OITM", DataEnvironment1.rsOITM
  
  ACRptEngine1.AddDataset "Doc", DataEnvironment1.rsDoc
  ACRptEngine1.AddDataset "DocLines", DataEnvironment1.rsDocLines

        '���´����������ֶεı�����һ����˵���ݿ��е��ֶ�����Ӣ�ģ�ͨ�����ñ���������ʹ�ֶζ����ڱ����������ĳ��֣��������Ĳ��빫ʽ����
        '  ACRptEngine1.SetDataFieldAliasName("OITM", "ItemCode,ItemName,OnHand", "���ϱ��,��������,�����");

  ACRptEngine1.AddDataset "��Ա����", DataEnvironment1.rsZlemployee  '�����������¼���һ����
  ACRptEngine1.SetDataFieldAliasName "��Ա����", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName", _
                                                 "����,���ű��,��������,����,����,��������,�ձ�,���֤,Ƹ������,����,ѧ��"
End Sub

Private Sub ACRptEngine1_OnClick()

End Sub

Private Sub opView1_Click()
  ACRptEngine1.ShowPreviewOnPrepare = False
End Sub

Private Sub opView2_Click()
  ACRptEngine1.ShowPreviewOnPrepare = True
End Sub

Private Sub Text1_Change()
 ' ACRptEngine1.AddVariable "����1", Text1.Text 'AddVariable����������ACReport������������Ѿ����ڣ��򸲸Ǿ�ֵ
End Sub

Private Sub Text2_Change()
 ' ACRptEngine1.AddVariable "����2", Text2.Text
End Sub

Private Sub DoAct()
  ACRptEngine1.AddVariable "����1", Text1.Text 'AddVariable����������ACReport������������Ѿ����ڣ��򸲸Ǿ�ֵ
  ACRptEngine1.AddVariable "����2", Text2.Text
  If Option1.Value Then
    ACRptEngine1.Preview
  Else
  If Option2.Value Then
    ACRptEngine1.ShowDesigner
  Else
  If Option3.Value Then
    ACRptEngine1.PrintReport
  Else
    ACRptEngine1.PrintReport
    ACRptEngine1.ExportToXls ""
  End If
  End If
  End If
  ACRptEngine1.ClearDataRelations
End Sub
Private Sub SetAcRegisterInfo()
        Dim ErrCode As Long
        Dim ErrMsg As String
        ACRptEngine1.SetRegisterInfo "280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D3D7DCD1DDCDD6D78680D8A" + _
               "D0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D", _
               "�췽������(acreport@sina.com qq:1655373859)", "23bd", "", "", "", "", ErrCode, ErrMsg

        If ErrCode <> 0 Then
            MsgBox (ErrMsg)
        End If
   'ע����Ϣ����Ӧ����ֻ��Ҫ����һ�Σ�����κ�һ��AcReportEngine�������ü��ɣ������Ķ���ʵ������Ҫ�ٵ��ô˷���
End Sub 'SetAcRegisterInfo

