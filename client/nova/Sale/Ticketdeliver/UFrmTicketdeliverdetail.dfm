inherited FrmTicketdeliverdetail: TFrmTicketdeliverdetail
  Caption = #36865#31080#35760#24405#26126#32454
  ClientHeight = 341
  ClientWidth = 359
  ExplicitWidth = 365
  ExplicitHeight = 369
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 359
    Height = 296
    ExplicitWidth = 359
    ExplicitHeight = 296
    inherited Bevel1: TBevel
      Top = 288
      Width = 325
      ExplicitTop = 204
      ExplicitWidth = 389
    end
    object lbl3: TLabel
      Left = 70
      Top = 88
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl4: TLabel
      Left = 42
      Top = 40
      Width = 56
      Height = 14
      Caption = #36865#31080#21306#22495
    end
    object lbl10: TLabel
      Left = 294
      Top = 40
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl11: TLabel
      Left = 294
      Top = 88
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl5: TLabel
      Left = 42
      Top = 219
      Width = 56
      Height = 14
      Caption = #36865#31080#22320#22336
    end
    object lbl2: TLabel
      Left = 294
      Top = 219
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl1: TLabel
      Left = 70
      Top = 129
      Width = 28
      Height = 14
      Caption = #25968#37327
    end
    object lbl6: TLabel
      Left = 42
      Top = 174
      Width = 56
      Height = 14
      Caption = #32467#26463#31080#21495
    end
    object edtarea: TNovaEdit
      Left = 104
      Top = 37
      Width = 186
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
    object edtticketno: TNovaEdit
      Left = 104
      Top = 82
      Width = 186
      Height = 22
      MaxLength = 50
      TabOrder = 1
      OnChange = edtticketnoChange
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
    object edtcount: TNovaEdit
      Left = 104
      Top = 126
      Width = 186
      Height = 22
      MaxLength = 5
      TabOrder = 2
      Text = '1'
      OnChange = edtcountChange
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
    object edtendticketno: TNovaEdit
      Left = 104
      Top = 171
      Width = 186
      Height = 22
      Enabled = False
      MaxLength = 50
      TabOrder = 3
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
    object edtaddress: TMemo
      Left = 104
      Top = 216
      Width = 186
      Height = 56
      TabOrder = 4
    end
  end
  inherited pnlOperation: TPanel
    Top = 296
    Width = 359
    ExplicitTop = 296
    ExplicitWidth = 359
    inherited bbtnSave: TBitBtn
      Left = 104
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 104
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 72
  end
  object jcdsResultTicketdeliverSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'sell/saveticketdeliverdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketdeliverdetail.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketdeliverdetail.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketdeliverdetail.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketdeliverdetail.ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketdeliverdetail.deliverid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'count'
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
      end
      item
        DataType = ftString
        Name = 'deliverid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 24
    Top = 248
  end
end
