inherited FrmPrintTemplateTypeItemAdd: TFrmPrintTemplateTypeItemAdd
  Caption = 'FrmPrintTemplateTypeItemAdd'
  ClientHeight = 259
  ClientWidth = 342
  ParentFont = False
  Font.Charset = ANSI_CHARSET
  Font.Height = -14
  Font.Name = #23435#20307
  OnCreate = FormCreate
  ExplicitWidth = 348
  ExplicitHeight = 284
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 342
    Height = 214
    ExplicitWidth = 342
    ExplicitHeight = 214
    inherited Bevel1: TBevel
      Top = 206
      Width = 308
      ExplicitTop = 206
      ExplicitWidth = 308
    end
    object lblitemname: TLabel
      Left = 72
      Top = 43
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object lblitemcode: TLabel
      Left = 72
      Top = 97
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object lblitemtype: TLabel
      Left = 72
      Top = 152
      Width = 28
      Height = 14
      Caption = #31867#22411
    end
    object lbl1: TLabel
      Left = 266
      Top = 44
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 266
      Top = 97
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 266
      Top = 152
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object nvedtitemname: TNovaEdit
      Left = 115
      Top = 39
      Width = 140
      Height = 22
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
    object nvcbbitemtype: TNovaComboBox
      Left = 115
      Top = 148
      Width = 140
      Height = 22
      ImeMode = imClose
      TabOrder = 2
      Text = #35831#36873#25321'...'
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'printtemplatetypeitem'
      HelpOptions.Columnname = 'itemtype'
    end
    object nvedtitemcode: TNovaEdit
      Left = 115
      Top = 93
      Width = 140
      Height = 22
      ImeMode = imClose
      MaxLength = 50
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
    Top = 214
    Width = 342
    ExplicitTop = 214
    ExplicitWidth = 342
    inherited bbtnSave: TBitBtn
      Left = 63
      OnClick = bbtnSaveClick
      ExplicitLeft = 63
    end
    inherited bbtnClose: TBitBtn
      Left = 200
      ExplicitLeft = 200
    end
  end
  object jcdsSavePrinttemplatetypeitem: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/savePrinttemplatetypeitem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'printtemplatetypeitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplatetypeitem.itemname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplatetypeitem.islist'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplatetypeitem.itemcode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplatetypeitem.itemtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplatetypeitem.printtemplatetype.id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftLargeint
        Name = 'operationid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 24
    Top = 72
  end
end
