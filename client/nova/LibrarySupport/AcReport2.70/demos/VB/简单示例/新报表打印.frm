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
   StartUpPosition =   1  '����������
   Begin VB.CommandButton Command3 
      Caption         =   "��ӡ���"
      Height          =   495
      Left            =   600
      TabIndex        =   2
      Top             =   2400
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "��ӡԤ��"
      Height          =   495
      Left            =   600
      TabIndex        =   1
      Top             =   1440
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "��ʼ��ӡ"
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


'ֱ�����ü��ɣ����AC���ǿ��Ӳ���    ���Dim AC1 AS AcRptEngine �ᵼ�³�����һ�δ������д��DATAENT1��

Private Sub Command1_Click()
  AC1.SetReportFile "���۵�.apt"
  AC1.PrintReport
End Sub

Private Sub Command2_Click()
  AC1.SetReportFile "���۵�.apt"
  AC1.Preview
End Sub

Private Sub Command3_Click()
  AC1.SetReportFile "���۵�.apt"
  AC1.ShowDesigner
End Sub

Private Sub Form_Load()

  Set AC1 = New AcRptEngine
  
  DataEnt1.Connection1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + App.Path + "\ReportDemo.mdb;Persist Security Info=False"
  DataEnt1.Connection1.Open
  DataEnt1.rs�����ֶ�.Open
  DataEnt1.rs��ͷ�ֶ�.Open
  DataEnt1.rs��β�ֶ�.Open
  DataEnt1.rsӦ��Ӧ��.Open
  AC1.Init
  AC1.AddDataset "�����ֶ�", DataEnt1.rs�����ֶ�
  AC1.AddDataset "��ͷ�ֶ�", DataEnt1.rs��ͷ�ֶ�
  AC1.AddDataset "Ӧ��Ӧ��", DataEnt1.rsӦ��Ӧ��
  
End Sub
Private Sub Form_Unload(Cancel As Integer)
  Set AC1 = Nothing
  DataEnt1.Connection1.Close
  Unload DataEnt1
End Sub

