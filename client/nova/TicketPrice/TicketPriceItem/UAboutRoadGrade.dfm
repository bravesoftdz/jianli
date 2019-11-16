inherited FrmAboutRoadGrade: TFrmAboutRoadGrade
  Caption = 'FrmAboutRoadGrade'
  OnShow = FormShow
  ExplicitWidth = 443
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    object Label1: TLabel
      Left = 77
      Top = 112
      Width = 56
      Height = 14
      Caption = #20844#36335#31561#32423
    end
    object Label2: TLabel
      Left = 91
      Top = 179
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label3: TLabel
      Left = 77
      Top = 54
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object NovaEdtValue: TNovaEdit
      Left = 146
      Top = 176
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
    object NovaEdtName: TNovaEdit
      Left = 146
      Top = 51
      Width = 162
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
    object NovaCbbRoadGrade: TNovaComboBox
      Left = 146
      Top = 109
      Width = 162
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
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
      HelpOptions.TableName = 'routeroad'
      HelpOptions.Columnname = 'roadgrade'
    end
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jcdsSaveItemAboutRoadGrade: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveaboutroadgrade'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemroadgrade.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroadgrade.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemroadgrade.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroadgrade.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroadgrade.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemroadgrade.roadgrade'
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
    Left = 320
    Top = 200
  end
end
