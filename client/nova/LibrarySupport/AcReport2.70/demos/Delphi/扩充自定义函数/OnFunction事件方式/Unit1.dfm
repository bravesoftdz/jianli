object Form1: TForm1
  Left = 375
  Top = 180
  Width = 287
  Height = 195
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
    Top = 128
    Width = 75
    Height = 25
    Caption = #26174#31034#25253#34920
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 265
    Height = 113
    Lines.Strings = (
      #26412#31243#24207#28436#31034#36890#36807#21709#24212'AcRptEngine.OnFunction'#20107
      #20214#28155#21152#33258#23450#20041#20989#25968#12290
      #20027#35201#26377#20004#20010#27493#39588#65306
      '1.'#35843#29992'AcRptEngine.AddFunctionName'#21152#20837#20989#25968#30340
      #25551#36848
      '2.'#21709#24212'OnFunction'#20107#20214#65292#32534#20889#20989#25968#22788#29702#20195#30721)
    TabOrder = 1
  end
  object conn1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=E:\controls\ACrepor' +
      't\COM\demos\ReportDemo.mdb;Persist Security Info=False'
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 200
    Top = 56
  end
  object ADOQuery1: TADOQuery
    Connection = conn1
    Parameters = <>
    Left = 200
    Top = 88
  end
end
