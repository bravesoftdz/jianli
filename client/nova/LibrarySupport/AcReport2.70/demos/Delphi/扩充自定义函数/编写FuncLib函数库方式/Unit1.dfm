object Form1: TForm1
  Left = 375
  Top = 180
  Width = 306
  Height = 209
  Caption = #33258#23450#20041#20989#25968
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 96
    Top = 136
    Width = 75
    Height = 25
    Caption = #26174#31034#25253#34920
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 8
    Width = 273
    Height = 113
    Lines.Strings = (
      #26412#31243#24207#28436#31034#36890#36807'IAcFunctionLib'#20989#25968#24211#25509#21475#21152#33258#23450
      #20041#20989#25968#12290
      #20027#35201#26377#20004#20010#27493#39588#65306
      '1.'#23454#29616'IAcFunctionLib'#25509#21475#65292#32534#20889#20989#25968#24211#31867
      '2.'#35843#29992'AcRptEngine.AddFunctionLib()'#23558#20989#25968#24211#23545
      #35937#28155#21152#21040'AcReportEngine')
    TabOrder = 1
  end
  object conn1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\controls\ACrepor' +
      't\COM\demos\ReportDemo.mdb;Persist Security Info=False'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 248
    Top = 96
  end
  object ADOQuery1: TADOQuery
    Connection = conn1
    Parameters = <>
    Left = 248
    Top = 128
  end
end
