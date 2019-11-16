inherited frmchangeticketend: Tfrmchangeticketend
  Width = 546
  Height = 312
  ExplicitWidth = 546
  ExplicitHeight = 312
  inherited pnlticketreceipt: TPanel
    Width = 546
    ExplicitWidth = 546
    inherited lblticketreceivablenum_: TLabel
      Left = 237
      ExplicitLeft = 237
    end
    inherited lblticketreceivablenum: TLabel
      Left = 301
      ExplicitLeft = 301
    end
    inherited bvlticketreceipt: TBevel
      Width = 546
      ExplicitWidth = 461
    end
  end
  inherited pnlrr: TPanel
    Top = 210
    Width = 546
    ExplicitTop = 210
    ExplicitWidth = 546
    inherited bvlrr: TBevel
      Width = 546
      ExplicitWidth = 461
    end
  end
  inherited pnlinsurereceipt: TPanel
    Width = 546
    ExplicitWidth = 546
    inherited lblinsurereceivablenum_: TLabel
      Left = 236
      ExplicitLeft = 236
    end
    inherited lblinsurereceivablenum: TLabel
      Left = 300
      ExplicitLeft = 300
    end
  end
  inherited pnlnetservicefee: TPanel
    Width = 546
    TabOrder = 4
    ExplicitWidth = 546
  end
  object pnlservicefee: TPanel
    Left = 0
    Top = 126
    Width = 546
    Height = 84
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblservicefee_: TLabel
      Left = 231
      Top = 50
      Width = 75
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #26381#21153#36153#24212#25910
    end
    object lblservicefee: TLabel
      Left = 310
      Top = 41
      Width = 18
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '0'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblserviceprice: TLabel
      Left = 26
      Top = 50
      Width = 75
      Height = 20
      Caption = #25913#31614#26381#21153#36153
    end
    object lblpropotion: TLabel
      Left = 152
      Top = 50
      Width = 13
      Height = 20
      Caption = '%'
    end
    object Label1: TLabel
      Left = 28
      Top = 12
      Width = 75
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #21407#36710#31080#24212#36864
    end
    object lblTicketreturn: TLabel
      Left = 107
      Top = 4
      Width = 116
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '1800.50'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 231
      Top = 9
      Width = 75
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #21407#20445#38505#24212#36864
      Visible = False
    end
    object lblinsurereturn: TLabel
      Left = 310
      Top = 4
      Width = 116
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '1800.50'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object bvl1: TBevel
      Left = 0
      Top = 0
      Width = 546
      Height = 5
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Shape = bsTopLine
      ExplicitTop = 56
      ExplicitWidth = 451
    end
    object nvedtservicefee: TNovaEdit
      Left = 107
      Top = 46
      Width = 39
      Height = 28
      Color = clBtnFace
      MaxLength = 50
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
      Text = '1'
      ValueTrim = '1'
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
end
