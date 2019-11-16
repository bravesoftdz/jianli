inherited FrmAboutDistance: TFrmAboutDistance
  Caption = 'FrmAboutDistance'
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
      Caption = #32467#26463#37324#31243
    end
    object Label1: TLabel
      Left = 76
      Top = 100
      Width = 56
      Height = 14
      Caption = #24320#22987#37324#31243
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
      Width = 98
      Height = 14
      Caption = #65288#21333#20301#65306#20844#37324#65289
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
      TabOrder = 3
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
    object NovaEdtEndDistance: TNovaEdit
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
    object NovaEdtFromDistance: TNovaEdit
      Left = 138
      Top = 92
      Width = 121
      Height = 22
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
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 408
    Top = 120
  end
  object jcdsSaveAboutDistance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'ticketprice/saveaboutdistance'
    SaveAddress = 'ticketprice/saveaboutdistance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemdistance.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemdistance.fromdistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemdistance.enddistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemdistance.value'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemdistance.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemdistance.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemdistance.createtime'
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
