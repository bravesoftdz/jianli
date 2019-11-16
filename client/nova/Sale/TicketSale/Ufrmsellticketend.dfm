inherited frmsellticketend: Tfrmsellticketend
  Width = 451
  Height = 224
  ExplicitWidth = 451
  ExplicitHeight = 224
  inherited pnlticketreceipt: TPanel
    Width = 451
    TabOrder = 1
    ExplicitWidth = 451
    inherited bvlticketreceipt: TBevel
      Width = 451
      ExplicitWidth = 451
    end
  end
  inherited pnlrr: TPanel
    Top = 126
    Width = 451
    TabOrder = 2
    ExplicitTop = 126
    ExplicitWidth = 451
    inherited bvlrr: TBevel
      Width = 451
      ExplicitWidth = 451
    end
    object lblreceipt: TLabel
      Left = 46
      Top = 69
      Width = 30
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #23454#25910
    end
    object lblpayment: TLabel
      Left = 16
      Top = 20
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #25903#20184#26041#24335
    end
    object lblchange: TLabel
      Left = 263
      Top = 47
      Width = 40
      Height = 42
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '20'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -32
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblchange_: TLabel
      Left = 229
      Top = 69
      Width = 30
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #25214#38646
    end
    object nvedtreceipt: TNovaEdit
      Left = 83
      Top = 50
      Width = 104
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -24
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      MaxLength = 50
      ParentFont = False
      TabOrder = 0
      Text = '2000.50'
      OnChange = nvedtreceiptChange
      ValueTrim = '2000.50'
      ValueType = ssDouble
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
    object nvcbbpayment: TNovaComboBox
      Left = 83
      Top = 12
      Width = 104
      Height = 28
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 1
      Text = #29616#37329
      OnChange = nvcbbpaymentChange
      Items.Strings = (
        #29616#37329
        #38134#32852)
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clBlack
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'paymethod'
    end
  end
  object pnlinsurereceipt: TPanel
    Left = 0
    Top = 52
    Width = 451
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblinsurenum_: TLabel
      Left = 16
      Top = 1
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #21806#20445#38505#25968
    end
    object lblinsurenum: TLabel
      Left = 83
      Top = -8
      Width = 18
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '3'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblinsurereceivablenum_: TLabel
      Left = 199
      Top = 1
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #20445#38505#24212#25910
    end
    object lblinsurereceivablenum: TLabel
      Left = 263
      Top = -8
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
  end
  object pnlnetservicefee: TPanel
    Left = 0
    Top = 89
    Width = 451
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lbl3: TLabel
      Left = 154
      Top = 1
      Width = 105
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #32852#32593#26381#21153#36153#24212#25910
    end
    object lblnetservicefee: TLabel
      Left = 263
      Top = -8
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
  end
end
