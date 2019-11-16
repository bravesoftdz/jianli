inherited FrmAboutStationGrade: TFrmAboutStationGrade
  Caption = 'FrmAboutStationGrade'
  OnShow = FormShow
  ExplicitWidth = 443
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    object Label1: TLabel
      Left = 52
      Top = 101
      Width = 70
      Height = 14
      Caption = #23458#36816#31449#31561#32423
    end
    object Label2: TLabel
      Left = 80
      Top = 165
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label3: TLabel
      Left = 66
      Top = 43
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object NovaEdtValue: TNovaEdit
      Left = 135
      Top = 162
      Width = 121
      Height = 22
      MaxLength = 6
      TabOrder = 0
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
    object NovaEdtName: TNovaEdit
      Left = 135
      Top = 40
      Width = 162
      Height = 22
      MaxLength = 50
      ReadOnly = True
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
    object NovacbbStationGrade: TNovaComboBox
      Left = 135
      Top = 98
      Width = 162
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
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
      HelpOptions.TableName = 'station'
      HelpOptions.Columnname = 'level'
    end
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jcdsSaveItemAboutStationGrade: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'ticketprice/saveaboutstationgrade'
    SaveAddress = 'ticketprice/saveaboutstationgrade'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemorggrade.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemorggrade.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemorggrade.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemorggrade.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemorggrade.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemorggrade.stationgrade'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftUnknown
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 88
    Top = 200
  end
end
