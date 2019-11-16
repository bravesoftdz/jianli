inherited FrmSetPassword: TFrmSetPassword
  Caption = #20462#25913#23494#30721
  ClientHeight = 220
  ClientWidth = 334
  ExplicitWidth = 340
  ExplicitHeight = 252
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 334
    Height = 175
    ExplicitWidth = 407
    ExplicitHeight = 175
    inherited Bevel1: TBevel
      Top = 167
      Width = 300
      ExplicitTop = 167
      ExplicitWidth = 373
    end
    object Label1: TLabel
      Left = 74
      Top = 54
      Width = 28
      Height = 14
      Caption = #23494#30721
    end
    object Label2: TLabel
      Left = 46
      Top = 108
      Width = 56
      Height = 14
      Caption = #30830#35748#23494#30721
    end
    object NovaEdtPassword: TNovaEdit
      Left = 111
      Top = 50
      Width = 160
      Height = 22
      MaxLength = 20
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
    object NovaEdtPassword2: TNovaEdit
      Left = 111
      Top = 102
      Width = 160
      Height = 22
      MaxLength = 20
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
  end
  inherited pnlOperation: TPanel
    Top = 175
    Width = 334
    ExplicitTop = 175
    ExplicitWidth = 407
    inherited bbtnSave: TBitBtn
      Left = 62
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 62
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 200
      Top = 6
      ExplicitLeft = 200
      ExplicitTop = 6
    end
  end
end
