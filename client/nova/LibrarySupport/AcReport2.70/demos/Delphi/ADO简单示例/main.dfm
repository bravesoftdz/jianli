object Form1: TForm1
  Left = 317
  Top = 190
  Width = 474
  Height = 358
  Caption = 'AC ReportEngine Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object rg1: TRadioGroup
    Left = 280
    Top = 10
    Width = 129
    Height = 89
    Caption = #21160#20316
    ItemIndex = 0
    Items.Strings = (
      #39044#35272
      #35774#35745
      #25171#21360)
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 280
    Width = 245
    Height = 21
    TabOrder = 1
    Text = #22825#26041#36719#20214#24037#20316#23460
  end
  object BitBtn1: TBitBtn
    Left = 328
    Top = 264
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 113
    Height = 245
    Caption = #24120#35268#25253#34920
    TabOrder = 3
    object B1: TBitBtn
      Left = 11
      Top = 23
      Width = 89
      Height = 25
      Caption = #26222#36890#28165#21333
      TabOrder = 0
      OnClick = B1Click
    end
    object B2: TBitBtn
      Left = 11
      Top = 54
      Width = 89
      Height = 25
      Caption = #20027#20174#34920
      TabOrder = 1
      OnClick = B2Click
    end
    object B3: TBitBtn
      Left = 11
      Top = 84
      Width = 89
      Height = 25
      Caption = #20998#32452#25253#34920
      TabOrder = 2
      OnClick = B3Click
    end
    object B4: TBitBtn
      Left = 11
      Top = 115
      Width = 89
      Height = 25
      Caption = #23376#25253#34920'1'
      TabOrder = 3
      OnClick = B4Click
    end
    object B5: TBitBtn
      Left = 11
      Top = 147
      Width = 89
      Height = 25
      Caption = #23376#25253#34920'2'
      TabOrder = 4
      OnClick = B5Click
    end
    object B6: TBitBtn
      Left = 11
      Top = 177
      Width = 89
      Height = 25
      Caption = #22270#34920'/'#22270#20687
      TabOrder = 5
      OnClick = B6Click
    end
    object BitBtn2: TBitBtn
      Left = 12
      Top = 207
      Width = 89
      Height = 25
      Caption = #20998#26639#25253#34920
      TabOrder = 6
      OnClick = BitBtn2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 136
    Top = 8
    Width = 129
    Height = 94
    Caption = #23545#35805#26694#21644#33050' '#26412
    TabOrder = 5
    object BitBtn3: TBitBtn
      Left = 12
      Top = 24
      Width = 97
      Height = 25
      Caption = #25171#21360#36755#20837#30340#20869#23481
      TabOrder = 0
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 12
      Top = 56
      Width = 97
      Height = 25
      Caption = #23494#30721#30830#35748
      TabOrder = 1
      OnClick = BitBtn4Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 136
    Top = 112
    Width = 129
    Height = 141
    Caption = #20869#37096#25968#25454#25253#34920
    TabOrder = 4
    object Button1: TButton
      Left = 16
      Top = 21
      Width = 97
      Height = 25
      Caption = #20869#37096'Table'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 50
      Width = 97
      Height = 25
      Caption = #20869#37096'Query'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 16
      Top = 79
      Width = 97
      Height = 25
      Caption = #20869#37096'Query(ADO)'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 16
      Top = 109
      Width = 97
      Height = 25
      Caption = #21442#25968#25253#34920
      TabOrder = 3
      OnClick = Button4Click
    end
  end
end
