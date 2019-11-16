inherited FrmBilldamagedEdit: TFrmBilldamagedEdit
  Caption = #22351#31080#30331#35760
  ClientHeight = 260
  ClientWidth = 586
  OnCreate = FormCreate
  ExplicitWidth = 592
  ExplicitHeight = 288
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 586
    Height = 215
    ExplicitWidth = 586
    ExplicitHeight = 215
    inherited Bevel1: TBevel
      Top = 207
      Width = 552
      ExplicitTop = 387
      ExplicitWidth = 461
    end
    object lbl1: TLabel
      Left = 69
      Top = 28
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object lbl2: TLabel
      Left = 69
      Top = 72
      Width = 56
      Height = 14
      Caption = #20351#29992#31080#21495
    end
    object lbl3: TLabel
      Left = 306
      Top = 72
      Width = 56
      Height = 14
      Caption = #32467#26463#31080#21495
    end
    object lbl4: TLabel
      Left = 97
      Top = 113
      Width = 28
      Height = 14
      Caption = #25968#37327
    end
    object lbl6: TLabel
      Left = 69
      Top = 155
      Width = 56
      Height = 14
      Caption = #25439#22351#25551#36848
    end
    object lbl5: TLabel
      Left = 492
      Top = 159
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object lbl7: TLabel
      Left = 306
      Top = 113
      Width = 56
      Height = 14
      Caption = #21097#20313#31080#25968
    end
    object edtstartno: TNovaEdit
      Left = 134
      Top = 68
      Width = 122
      Height = 22
      MaxLength = 50
      TabOrder = 1
      OnChange = edtstartnoChange
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
    object edtendno: TNovaEdit
      Left = 366
      Top = 67
      Width = 123
      Height = 22
      MaxLength = 20
      TabOrder = 3
      OnChange = edtendnoChange
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
    object edtbilltype: TNovaEdit
      Left = 134
      Top = 26
      Width = 122
      Height = 22
      Enabled = False
      MaxLength = 50
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
    object edtamount: TNovaEdit
      Left = 134
      Top = 110
      Width = 122
      Height = 22
      MaxLength = 15
      TabOrder = 2
      Text = '1'
      OnChange = edtamountChange
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
    object edtavailablecount: TNovaEdit
      Left = 366
      Top = 110
      Width = 123
      Height = 22
      Enabled = False
      MaxLength = 50
      TabOrder = 4
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
    object nvHcbbRemark: TNovaHComboBox
      Left = 134
      Top = 156
      Width = 355
      Height = 22
      ImeMode = imClose
      MaxLength = 50
      TabOrder = 5
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'damageddscribe'
      Params = <
        item
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BilldamagedRemark'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 215
    Width = 586
    ExplicitTop = 215
    ExplicitWidth = 586
    inherited bbtnSave: TBitBtn
      Left = 185
      Top = 6
      Caption = '&S '#30331#35760
      OnClick = bbtnSaveClick
      ExplicitLeft = 185
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 344
      Top = 6
      ExplicitLeft = 344
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 16
    Top = 0
  end
  object jcdsResultSavebilldamaged: TjsonClientDataSet
    DataSourceName = 'billdamagedmap'
    QueryAddress = 'sell/qrybilldamaged'
    SaveAddress = 'sell/savebilldamaged'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'billdamaged.billtypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.startno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.endno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.amount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.billinuseid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.damageddscribe'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billdamaged.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'recipients'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 32
    Top = 240
  end
end
