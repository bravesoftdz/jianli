inherited frmpatchsellticketend: Tfrmpatchsellticketend
  Height = 231
  ExplicitHeight = 231
  inherited pnlticketreceipt: TPanel
    TabOrder = 2
  end
  inherited pnlrr: TPanel
    Top = 168
    TabOrder = 4
    ExplicitTop = 168
  end
  inherited pnlinsurereceipt: TPanel
    TabOrder = 1
  end
  object pnlservicefee: TPanel
    Left = 0
    Top = 126
    Width = 451
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblservicefee_: TLabel
      Left = 184
      Top = 5
      Width = 75
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #26381#21153#36153#24212#25910
    end
    object lblservicefee: TLabel
      Left = 263
      Top = -4
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
    object nvedtservicefee: TNovaEdit
      Left = 83
      Top = 3
      Width = 39
      Height = 28
      MaxLength = 50
      NumbersOnly = True
      TabOrder = 1
      Text = '1'
      OnChange = nvedtservicefeeChange
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
    object chkservicefee: TCheckBox
      Left = 7
      Top = 6
      Width = 70
      Height = 17
      Caption = #26381#21153#36153
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = nvedtservicefeeChange
    end
  end
end
