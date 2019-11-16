inherited FrmAboutPrice: TFrmAboutPrice
  Caption = 'FrmAboutPrice'
  ExplicitWidth = 443
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    object Label3: TLabel
      Left = 75
      Top = 46
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object Label2: TLabel
      Left = 75
      Top = 147
      Width = 56
      Height = 14
      Caption = #32467#26463#31080#20215
    end
    object Label1: TLabel
      Left = 75
      Top = 96
      Width = 56
      Height = 14
      Caption = #36215#22987#31080#20215
    end
    object Label5: TLabel
      Left = 89
      Top = 197
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label6: TLabel
      Left = 265
      Top = 95
      Width = 84
      Height = 14
      Caption = #65288#21333#20301#65306#20803#65289
    end
    object NovaEdtName: TNovaEdit
      Left = 138
      Top = 42
      Width = 200
      Height = 22
      MaxLength = 50
      ReadOnly = True
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
    object NovaEdtValue: TNovaEdit
      Left = 138
      Top = 191
      Width = 121
      Height = 22
      MaxLength = 6
      TabOrder = 1
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
    object NovaEdtEndPrice: TNovaEdit
      Left = 138
      Top = 143
      Width = 121
      Height = 22
      MaxLength = 6
      TabOrder = 2
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
    object NovaEdtFromPrice: TNovaEdit
      Left = 138
      Top = 92
      Width = 121
      Height = 22
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
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jcdsSaveAboutPrice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'ticketprice/saveaboutprice'
    SaveAddress = 'ticketprice/saveaboutprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemprice.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemprice.endprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemprice.fromprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemprice.value'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemprice.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemprice.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemprice.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 200
  end
end
