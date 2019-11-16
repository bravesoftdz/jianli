inherited FrmAboutRouteStop: TFrmAboutRouteStop
  Caption = 'FrmAboutRouteStop'
  ClientWidth = 454
  OnShow = FormShow
  ExplicitWidth = 460
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 454
    ExplicitWidth = 454
    inherited Bevel1: TBevel
      Width = 420
      ExplicitWidth = 420
    end
    object Label3: TLabel
      Left = 69
      Top = 45
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object Label1: TLabel
      Left = 69
      Top = 93
      Width = 56
      Height = 14
      Caption = #30456#20851#32447#36335
    end
    object Label2: TLabel
      Left = 83
      Top = 194
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label4: TLabel
      Left = 83
      Top = 143
      Width = 42
      Height = 14
      Caption = #20572#38752#28857
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
    object NovaHelpRoute: TNovaHelp
      Left = 138
      Top = 90
      Width = 200
      Height = 22
      MaxLength = 50
      TabOrder = 2
      OnIdChange = NovaHelpRouteIdChange
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #32447#36335#21517#31216
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHCbbRouteStop: TNovaHComboBox
      Left = 138
      Top = 140
      Width = 200
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'param'
          ParamType = ptInput
        end>
    end
  end
  inherited pnlOperation: TPanel
    Width = 454
    ExplicitWidth = 454
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jcdsSaveAboutRoute: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'ticketprice/saveaboutroutestop'
    SaveAddress = 'ticketprice/saveaboutroutestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemroutestop.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroutestop.stationid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroutestop.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemroutestop.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroutestop.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroutestop.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemroutestop.routeid'
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
    Top = 208
  end
end
