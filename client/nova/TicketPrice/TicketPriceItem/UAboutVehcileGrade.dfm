inherited FrmAboutVehcilGrade: TFrmAboutVehcilGrade
  Caption = 'FrmAboutVehcilGrade'
  OnShow = FormShow
  ExplicitWidth = 443
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    object Label1: TLabel
      Left = 94
      Top = 95
      Width = 28
      Height = 14
      Caption = #36710#22411
    end
    object Label2: TLabel
      Left = 80
      Top = 200
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
    object Label4: TLabel
      Left = 66
      Top = 147
      Width = 56
      Height = 14
      Caption = #20844#36335#31561#32423
    end
    object NovaHcbbVehcile: TNovaHComboBox
      Left = 135
      Top = 92
      Width = 162
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
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
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehicletypeHelp'
        end>
    end
    object NovaEdtValue: TNovaEdit
      Left = 135
      Top = 197
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
    object NovaEdtName: TNovaEdit
      Left = 135
      Top = 40
      Width = 162
      Height = 22
      MaxLength = 50
      ReadOnly = True
      TabOrder = 2
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
      Left = 135
      Top = 144
      Width = 162
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
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
  object jcdsSaveItemAboutVchileRoad: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveaboutvchroadgrade'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemvehcileroadgrad.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcileroadgrad.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemvehcileroadgrad.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcileroadgrad.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemvehcileroadgrad.roadgrade'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcileroadgrad.value'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcileroadgrad.vehciletypeid'
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
    Left = 312
    Top = 200
  end
end
