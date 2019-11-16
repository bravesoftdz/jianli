inherited FrmPrintRoadInfo: TFrmPrintRoadInfo
  Caption = #34892#36710#36335#21333#38468#21152#20449#24687
  ClientHeight = 246
  ClientWidth = 449
  ExplicitWidth = 455
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 449
    Height = 201
    ExplicitWidth = 449
    ExplicitHeight = 201
    inherited Bevel1: TBevel
      Top = 193
      Width = 415
      ExplicitTop = 255
      ExplicitWidth = 415
    end
    object Label1: TLabel
      Left = 68
      Top = 48
      Width = 56
      Height = 14
      Caption = #26377#25928#22825#25968
    end
    object lbl3: TLabel
      Left = 266
      Top = 47
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 97
      Top = 88
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object NovaEdtDays: TNovaEdit
      Left = 131
      Top = 44
      Width = 121
      Height = 22
      MaxLength = 2
      TabOrder = 0
      Text = '1'
      ValueTrim = '1'
      ValueType = ssNumber
      OnEnterColor = clSkyBlue
      OnExitColot = clWindow
      StopErrorKey = True
      OnFocusSelectAll = False
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
    end
    object MeRemark: TMemo
      Left = 131
      Top = 85
      Width = 223
      Height = 76
      TabOrder = 1
    end
  end
  inherited pnlOperation: TPanel
    Top = 201
    Width = 449
    ExplicitTop = 201
    ExplicitWidth = 449
    inherited bbtnSave: TBitBtn
      Left = 113
      Top = 6
      Caption = '&P '#25171#21360
      OnClick = bbtnSaveClick
      ExplicitLeft = 113
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 262
      Top = 6
      ExplicitLeft = 262
      ExplicitTop = 6
    end
  end
end
