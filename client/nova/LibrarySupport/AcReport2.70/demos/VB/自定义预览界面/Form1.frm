VERSION 5.00
Object = "{CAB717DC-437A-4FED-8B04-CC6A040AC354}#1.0#0"; "AcWebClient.ocx"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "自定义预览"
   ClientHeight    =   8565
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   13665
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8565
   ScaleWidth      =   13665
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  '窗口缺省
   Begin AcWebClient.AcWebClientView AcRepView 
      Height          =   8175
      Left            =   2160
      TabIndex        =   1
      Top             =   120
      Width           =   11415
      Object.Visible         =   -1  'True
      AutoScroll      =   0   'False
      AutoSize        =   0   'False
      AxBorderStyle   =   1
      Caption         =   "AC Report打印预览"
      Color           =   -16777201
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      KeyPreview      =   0   'False
      PixelsPerInch   =   96
      PrintScale      =   1
      Scaled          =   -1  'True
      DropTarget      =   0   'False
      HelpFile        =   ""
      ScreenSnap      =   0   'False
      SnapBuffer      =   10
      DoubleBuffered  =   0   'False
      Enabled         =   -1  'True
      RepFileName     =   ""
      URL             =   ""
      ToolBarVisible  =   -1  'True
      LeftMargin      =   20
      TopMargin       =   20
      RightMargin     =   20
      BottomMargin    =   20
      ScaleRate       =   100
   End
   Begin VB.CommandButton Command10 
      Caption         =   "缩小"
      Height          =   375
      Left            =   360
      TabIndex        =   13
      Top             =   4920
      Width           =   1215
   End
   Begin VB.CommandButton Command9 
      Caption         =   "放大"
      Height          =   375
      Left            =   360
      TabIndex        =   12
      Top             =   4560
      Width           =   1215
   End
   Begin VB.CommandButton Command8 
      Caption         =   "最后一页"
      Height          =   375
      Left            =   360
      TabIndex        =   11
      Top             =   4200
      Width           =   1215
   End
   Begin VB.CommandButton Command7 
      Caption         =   "下一页"
      Height          =   375
      Left            =   360
      TabIndex        =   9
      Top             =   3840
      Width           =   1215
   End
   Begin VB.CommandButton Command6 
      Caption         =   "上一页"
      Height          =   375
      Left            =   360
      TabIndex        =   8
      Top             =   3480
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "第一页"
      Height          =   375
      Left            =   360
      TabIndex        =   7
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "打印"
      Height          =   375
      Left            =   360
      TabIndex        =   6
      Top             =   2760
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Height          =   8295
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   1935
      Begin VB.CommandButton Command11 
         Caption         =   "退出"
         Height          =   495
         Left            =   240
         TabIndex        =   10
         Top             =   1200
         Width           =   1215
      End
      Begin VB.CommandButton Command3 
         Caption         =   "页面设置"
         Height          =   375
         Left            =   240
         TabIndex        =   5
         Top             =   2400
         Width           =   1215
      End
      Begin VB.CheckBox CB1 
         Caption         =   "显示默认工具条"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   1920
         Value           =   1  'Checked
         Width           =   1575
      End
      Begin VB.CommandButton Command2 
         Caption         =   "设计器..."
         Height          =   495
         Left            =   240
         TabIndex        =   3
         Top             =   720
         Width           =   1215
      End
      Begin VB.CommandButton Command1 
         Caption         =   "显示报表"
         Height          =   495
         Left            =   240
         TabIndex        =   2
         Top             =   240
         Width           =   1215
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim AcRptEngine As AcRptEngine
Dim DataPath As String
Dim ReportPath As String
Dim AdoConn As Connection
Dim rsEmployee As Recordset

Private Sub CB1_Click()
  AcRepView.ToolBarVisible = CB1.Value
End Sub

Private Sub Command1_Click()
  AcRptEngine.SetReportFile ReportPath + "list.apt"
  AcRptEngine.PrepareReport
  If AcRptEngine.PreparedPagesCount > 0 Then
    AcRptEngine.ExportToACR "d:\tmp_vb.acr"
    AcRepView.OpenRepFromFile "d:\tmp_vb.acr", False
  End If
End Sub

Private Sub Command10_Click()
  AcRepView.ZoomOut
End Sub

Private Sub Command11_Click()
  End
End Sub

Private Sub Command2_Click()
  AcRptEngine.ShowDesigner
End Sub

Private Sub Command3_Click()
  AcRepView.ShowPageSetDlg
End Sub

Private Sub Command4_Click()
  AcRepView.ShowPrintDlg
End Sub

Private Sub Command5_Click()
  AcRepView.GotoFirstPage
End Sub

Private Sub Command6_Click()
  AcRepView.GotoPriorPage
End Sub

Private Sub Command7_Click()
  AcRepView.GotoNextPage
End Sub

Private Sub Command8_Click()
  AcRepView.GotoLastPage
End Sub

Private Sub Command9_Click()
  AcRepView.ZoomIn
End Sub

Private Sub Form_Load()
   Dim strSQL As String
   Set AcRptEngine = New AcRptEngine
   Set AdoConn = New Connection
   Set rsEmployee = New Recordset
   DataPath = App.Path + "\..\..\Data\"
   ReportPath = App.Path + "\..\..\reports\"
   AdoConn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
   strSQL = "select top 300 e.*, x.Name as XueLiName from zlemployee e Left Join XueLi x on e.XueLi = x.Code"
   AdoConn.Open AdoConn.ConnectionString, "admin", "", -1
   rsEmployee.Open strSQL, AdoConn, adOpenKeyset, adLockOptimistic, 1
   
   AcRptEngine.AddDataset "zlEmployee", rsEmployee
   AcRptEngine.AddVariable "变量1", "天方工作室"
End Sub
