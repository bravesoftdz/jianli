VERSION 5.00
Begin VB.Form frmDataEnv 
   Caption         =   "AC Report中国式报表(枫叶报表)Demo"
   ClientHeight    =   6930
   ClientLeft      =   2505
   ClientTop       =   1725
   ClientWidth     =   11520
   LinkTopic       =   "Form1"
   ScaleHeight     =   6930
   ScaleWidth      =   11520
   StartUpPosition =   2  '屏幕中心
   Begin VB.Frame Frame7 
      Caption         =   "预览方式"
      Height          =   1455
      Left            =   8640
      TabIndex        =   42
      Top             =   2280
      Width           =   2415
      Begin VB.OptionButton opView2 
         Caption         =   "边生成边预览"
         ForeColor       =   &H80000002&
         Height          =   255
         Left            =   240
         TabIndex        =   44
         Top             =   840
         Value           =   -1  'True
         Width           =   1935
      End
      Begin VB.OptionButton opView1 
         Caption         =   "生成报表后预览"
         ForeColor       =   &H80000002&
         Height          =   255
         Left            =   240
         TabIndex        =   43
         Top             =   360
         Width           =   1575
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "动作"
      Height          =   1935
      Left            =   8640
      TabIndex        =   37
      Top             =   120
      Width           =   2415
      Begin VB.OptionButton Option1 
         Caption         =   "预览报表"
         ForeColor       =   &H80000002&
         Height          =   375
         Left            =   240
         TabIndex        =   41
         Top             =   240
         Value           =   -1  'True
         Width           =   1695
      End
      Begin VB.OptionButton Option2 
         Caption         =   "设计报表"
         ForeColor       =   &H80000002&
         Height          =   375
         Left            =   240
         TabIndex        =   40
         Top             =   680
         Width           =   1815
      End
      Begin VB.OptionButton Option3 
         Caption         =   "打印"
         ForeColor       =   &H80000002&
         Height          =   255
         Left            =   240
         TabIndex        =   39
         Top             =   1120
         Width           =   975
      End
      Begin VB.OptionButton Option4 
         Caption         =   "导出为Excel文件"
         ForeColor       =   &H80000002&
         Height          =   375
         Left            =   240
         TabIndex        =   38
         Top             =   1440
         Width           =   1695
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "新版特性"
      Height          =   6495
      Left            =   4680
      TabIndex        =   30
      Top             =   120
      Width           =   3375
      Begin VB.CommandButton Command37 
         Caption         =   "报表视图 - 静态视图"
         BeginProperty Font 
            Name            =   "宋体"
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
         Caption         =   "报表视图 - 对象"
         BeginProperty Font 
            Name            =   "宋体"
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
         Caption         =   "报表视图 - 单元格 - 对象"
         BeginProperty Font 
            Name            =   "宋体"
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
         Caption         =   "报表视图-并列的明细"
         BeginProperty Font 
            Name            =   "宋体"
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
         Caption         =   "自定义字间距和行间距"
         BeginProperty Font 
            Name            =   "宋体"
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
         Caption         =   "基于可拖动对象的报表2"
         Height          =   375
         Left            =   240
         TabIndex        =   46
         Top             =   3090
         Width           =   2895
      End
      Begin VB.CommandButton Command30 
         Caption         =   "基于可拖动对象的报表1"
         Height          =   375
         Left            =   240
         TabIndex        =   45
         Top             =   2640
         Width           =   2895
      End
      Begin VB.CommandButton Command29 
         Caption         =   "套打辅助设计(不打印背景图案)"
         Height          =   375
         Left            =   240
         TabIndex        =   36
         Top             =   5760
         Width           =   2895
      End
      Begin VB.CommandButton Command28 
         Caption         =   "明细分两栏打印(横向顺序分栏)"
         Height          =   375
         Left            =   240
         TabIndex        =   35
         Top             =   5310
         Width           =   2895
      End
      Begin VB.CommandButton Command27 
         Caption         =   "分组分页补充空行"
         Height          =   375
         Left            =   240
         TabIndex        =   34
         Top             =   4845
         Width           =   2895
      End
      Begin VB.CommandButton Command26 
         Caption         =   "分组页尾保持页面底部"
         Height          =   375
         Left            =   240
         TabIndex        =   33
         Top             =   4395
         Width           =   2895
      End
      Begin VB.CommandButton Command25 
         Caption         =   "页尾保持在页面底部(保持外框线)"
         Height          =   375
         Left            =   240
         TabIndex        =   32
         Top             =   3945
         Width           =   2895
      End
      Begin VB.CommandButton Command24 
         Caption         =   "页尾保持在页面底部"
         Height          =   375
         Left            =   240
         TabIndex        =   31
         Top             =   3495
         Width           =   2895
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "单据"
      Height          =   1815
      Left            =   2280
      TabIndex        =   23
      Top             =   120
      Width           =   2175
      Begin VB.CommandButton Command22 
         Caption         =   "单据2"
         Height          =   375
         Left            =   240
         TabIndex        =   29
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   780
         Width           =   1695
      End
      Begin VB.CommandButton Command21 
         Caption         =   "表格"
         Height          =   375
         Left            =   240
         TabIndex        =   28
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   1200
         Width           =   1695
      End
      Begin VB.CommandButton Command20 
         Caption         =   "单据"
         Height          =   375
         Left            =   240
         TabIndex        =   27
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
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
      Caption         =   "内部数据报表"
      Height          =   1575
      Left            =   2280
      TabIndex        =   12
      Top             =   4440
      Width           =   2175
      Begin VB.CommandButton Command14 
         Caption         =   "参数报表"
         Height          =   375
         Left            =   240
         TabIndex        =   15
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   1080
         Width           =   1695
      End
      Begin VB.CommandButton Command13 
         Caption         =   "内部Query(ADO)"
         Height          =   375
         Left            =   240
         TabIndex        =   14
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   660
         Width           =   1695
      End
      Begin VB.CommandButton Command12 
         Caption         =   "内部Table(ADO)"
         Height          =   375
         Left            =   240
         TabIndex        =   13
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "对话框和脚本"
      Height          =   2055
      Left            =   2280
      TabIndex        =   9
      Top             =   2040
      Width           =   2175
      Begin VB.CommandButton Command18 
         Caption         =   "动态隐藏行"
         Height          =   375
         Left            =   240
         TabIndex        =   25
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   1560
         Width           =   1695
      End
      Begin VB.CommandButton Command17 
         Caption         =   "行间颜色变化"
         Height          =   375
         Left            =   240
         TabIndex        =   24
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   1120
         Width           =   1695
      End
      Begin VB.CommandButton Command10 
         Caption         =   "口令确认"
         Height          =   375
         Left            =   240
         TabIndex        =   11
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   680
         Width           =   1695
      End
      Begin VB.CommandButton Command9 
         Caption         =   "打印输入的内容"
         Height          =   375
         Left            =   240
         TabIndex        =   10
         ToolTipText     =   "一般的数据列表，可以自动汇总。"
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "常用报表"
      Height          =   6495
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2055
      Begin VB.CommandButton Command32 
         Caption         =   "使用数据模块"
         Height          =   375
         Left            =   120
         TabIndex        =   48
         Top             =   5760
         Width           =   1695
      End
      Begin VB.CommandButton Command23 
         Caption         =   "设置字段别名"
         Height          =   375
         Left            =   120
         TabIndex        =   47
         Top             =   5280
         Width           =   1695
      End
      Begin VB.CommandButton Command19 
         Caption         =   "动态的Rich文本"
         Height          =   375
         Left            =   120
         TabIndex        =   26
         Top             =   4800
         Width           =   1695
      End
      Begin VB.CommandButton Command16 
         Caption         =   "行合并分组报表"
         Height          =   375
         Left            =   120
         TabIndex        =   22
         Top             =   2580
         Width           =   1695
      End
      Begin VB.CommandButton Command15 
         Caption         =   "单元格样式展示"
         Height          =   375
         Left            =   120
         TabIndex        =   18
         Top             =   360
         Width           =   1695
      End
      Begin VB.CommandButton Command11 
         Caption         =   "行自动合并"
         Height          =   375
         Left            =   120
         TabIndex        =   17
         Top             =   1245
         Width           =   1695
      End
      Begin VB.CommandButton Command1 
         Caption         =   "普通清单"
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   810
         Width           =   1695
      End
      Begin VB.CommandButton Command2 
         Caption         =   "主从报表"
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Top             =   1695
         Width           =   1695
      End
      Begin VB.CommandButton Command3 
         Caption         =   "分组报表"
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   2130
         Width           =   1695
      End
      Begin VB.CommandButton Command5 
         Caption         =   "子报表1"
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Top             =   3030
         Width           =   1695
      End
      Begin VB.CommandButton Command6 
         Caption         =   "多级嵌套子报表"
         Height          =   375
         Left            =   120
         TabIndex        =   5
         Top             =   3465
         Width           =   1695
      End
      Begin VB.CommandButton Command7 
         Caption         =   "图表"
         Height          =   375
         Left            =   120
         TabIndex        =   4
         Top             =   3915
         Width           =   1695
      End
      Begin VB.CommandButton Command8 
         Caption         =   "分栏报表"
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   4350
         Width           =   1695
      End
   End
   Begin VB.CommandButton Command4 
      Caption         =   "退出"
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
      Text            =   "同享人力资源EHR"
      Top             =   3960
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "变量2"
      Height          =   255
      Left            =   8520
      TabIndex        =   21
      Top             =   4320
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "变量1"
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
  '  ACRptEngine1.AddDataset("雇员档案", rszlEmployee); //重新加入一个表
 '   ACRptEngine1.SetDataFieldAliasName("雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiN",
  '                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历");
  '上面的代码在 AddDatasetsToAC()中
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
   
   ACRptEngine1.AddGlobalVariable "使用单位", Text1.Text
   
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

        '以下代码是设置字段的别名，一般来说数据库中的字段名是英文，通过设置别名，可以使字段对象在报表中以中文呈现，并以中文参与公式运算
        '  ACRptEngine1.SetDataFieldAliasName("OITM", "ItemCode,ItemName,OnHand", "物料编号,物料名称,库存量");

  ACRptEngine1.AddDataset "雇员档案", DataEnvironment1.rsZlemployee  '以新名称重新加入一个表
  ACRptEngine1.SetDataFieldAliasName "雇员档案", "Code,Dept,DptName,CardNo,Name,BornDate,Sex,Sfz,PyDate,RoomBed,XueLiName", _
                                                 "工号,部门编号,部门名称,卡号,姓名,出生日期,姓别,身份证,聘用日期,床号,学历"
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
 ' ACRptEngine1.AddVariable "变量1", Text1.Text 'AddVariable将变量传入ACReport，如果变量名已经存在，则覆盖旧值
End Sub

Private Sub Text2_Change()
 ' ACRptEngine1.AddVariable "变量2", Text2.Text
End Sub

Private Sub DoAct()
  ACRptEngine1.AddVariable "变量1", Text1.Text 'AddVariable将变量传入ACReport，如果变量名已经存在，则覆盖旧值
  ACRptEngine1.AddVariable "变量2", Text2.Text
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
               "天方工作室(acreport@sina.com qq:1655373859)", "23bd", "", "", "", "", ErrCode, ErrMsg

        If ErrCode <> 0 Then
            MsgBox (ErrMsg)
        End If
   '注册信息整个应用中只需要设置一次，针对任何一个AcReportEngine对象设置即可，其它的对象实例不需要再调用此方法
End Sub 'SetAcRegisterInfo

