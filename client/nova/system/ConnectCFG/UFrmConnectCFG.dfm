object frmConnectCFG: TfrmConnectCFG
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #24212#29992#26381#21153#22120#36830#25509#37197#32622
  ClientHeight = 262
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lbl1: TLabel
    Left = 105
    Top = 45
    Width = 31
    Height = 15
    Caption = 'IP'#65306
  end
  object lbl2: TLabel
    Left = 91
    Top = 79
    Width = 45
    Height = 15
    Caption = #31471#21475#65306
  end
  object lbl3: TLabel
    Left = 91
    Top = 114
    Width = 45
    Height = 15
    Caption = #36335#24452#65306
  end
  object lbl4: TLabel
    Left = 91
    Top = 149
    Width = 45
    Height = 15
    Caption = #23494#38053#65306
  end
  object EdtIP: TEdit
    Left = 153
    Top = 41
    Width = 121
    Height = 23
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object EdtPort: TEdit
    Left = 153
    Top = 75
    Width = 121
    Height = 23
    TabOrder = 1
    Text = '80'
  end
  object btn1: TBitBtn
    Left = 82
    Top = 200
    Width = 75
    Height = 25
    Caption = #27979#35797#36830#25509
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btn1Click
  end
  object btnSave: TBitBtn
    Left = 219
    Top = 200
    Width = 75
    Height = 25
    Caption = #20445#23384
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object EdtPath: TEdit
    Left = 153
    Top = 110
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'Station'
  end
  object EdtKey: TEdit
    Left = 153
    Top = 145
    Width = 121
    Height = 23
    PasswordChar = '*'
    TabOrder = 5
    Text = 'EdtKey'
  end
  object tmactive: TTimer
    Enabled = False
    OnTimer = tmactiveTimer
    Left = 24
    Top = 104
  end
  object jsonClientDataSet1: TjsonClientDataSet
    DataSourceName = 'dataSet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 136
  end
end
