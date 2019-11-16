VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4980
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2520
   LinkTopic       =   "Form1"
   ScaleHeight     =   4980
   ScaleWidth      =   2520
   StartUpPosition =   1  '所有者中心
   Begin VB.CommandButton Command3 
      Caption         =   "打印设计"
      Height          =   495
      Left            =   600
      TabIndex        =   2
      Top             =   2400
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "打印预览"
      Height          =   495
      Left            =   600
      TabIndex        =   1
      Top             =   1440
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "开始打印"
      Height          =   495
      Left            =   600
      TabIndex        =   0
      Top             =   600
      Width           =   1335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim AC1 As AcRptEngine


'直接引用即可，这个AC不是可视部件    多次Dim AC1 AS AcRptEngine 会导致出错，有一段代码必须写在DATAENT1里

Private Sub Command1_Click()
  AC1.SetReportFile "销售单.apt"
  AC1.PrintReport
End Sub

Private Sub Command2_Click()
  AC1.SetReportFile "销售单.apt"
  AC1.Preview
End Sub

Private Sub Command3_Click()
  AC1.SetReportFile "销售单.apt"
  AC1.ShowDesigner
End Sub

Private Sub Form_Load()

  Set AC1 = New AcRptEngine
  
  DataEnt1.Connection1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + App.Path + "\ReportDemo.mdb;Persist Security Info=False"
  DataEnt1.Connection1.Open
  DataEnt1.rs表体字段.Open
  DataEnt1.rs表头字段.Open
  DataEnt1.rs表尾字段.Open
  DataEnt1.rs应收应付.Open
  AC1.Init
  AC1.AddDataset "表体字段", DataEnt1.rs表体字段
  AC1.AddDataset "表头字段", DataEnt1.rs表头字段
  AC1.AddDataset "应收应付", DataEnt1.rs应收应付
  
End Sub
Private Sub Form_Unload(Cancel As Integer)
  Set AC1 = Nothing
  DataEnt1.Connection1.Close
  Unload DataEnt1
End Sub

