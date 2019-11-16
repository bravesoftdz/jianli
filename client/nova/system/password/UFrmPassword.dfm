inherited FrmPassword: TFrmPassword
  Caption = #20462#25913#23494#30721
  ClientHeight = 278
  ClientWidth = 366
  ParentFont = False
  Font.Charset = GB2312_CHARSET
  Font.Height = -14
  Font.Name = #23435#20307
  ExplicitWidth = 372
  ExplicitHeight = 310
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 366
    Height = 233
    ExplicitWidth = 366
    ExplicitHeight = 233
    inherited Bevel1: TBevel
      Top = 225
      Width = 332
      ExplicitTop = 225
      ExplicitWidth = 332
    end
    object lbloldpassword: TLabel
      Left = 88
      Top = 42
      Width = 42
      Height = 14
      Caption = #26087#23494#30721
    end
    object lblnewpassword: TLabel
      Left = 88
      Top = 109
      Width = 42
      Height = 14
      Caption = #26032#23494#30721
    end
    object lblpassword: TLabel
      Left = 74
      Top = 173
      Width = 56
      Height = 14
      Caption = #30830#35748#23494#30721
    end
    object edtoldpassword: TNovaEdit
      Left = 154
      Top = 42
      Width = 121
      Height = 22
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 0
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
    object edtnewpassword: TNovaEdit
      Left = 154
      Top = 106
      Width = 121
      Height = 22
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 1
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
    object edtpassword: TNovaEdit
      Left = 154
      Top = 170
      Width = 121
      Height = 22
      MaxLength = 50
      PasswordChar = '*'
      TabOrder = 2
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
  end
  inherited pnlOperation: TPanel
    Top = 233
    Width = 366
    ExplicitTop = 233
    ExplicitWidth = 366
    inherited bbtnSave: TBitBtn
      Left = 74
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 74
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 192
      Top = 6
      ExplicitLeft = 192
      ExplicitTop = 6
    end
  end
  object jsonCDSPasswordsave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/savepassword'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'user.password'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'newpassword'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pass'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'nResult'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'sResult'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 312
    Top = 232
  end
end
