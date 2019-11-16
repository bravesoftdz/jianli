inherited FrmAboutRoute: TFrmAboutRoute
  Caption = 'FrmAboutRoute'
  ClientHeight = 293
  ClientWidth = 440
  ExplicitWidth = 446
  ExplicitHeight = 325
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 440
    Height = 248
    ExplicitWidth = 440
    ExplicitHeight = 248
    inherited Bevel1: TBevel
      Top = 233
      Width = 406
      ExplicitTop = 411
      ExplicitWidth = 479
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
      Top = 146
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
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
    object NovaHelpRoute: TNovaHelp
      Left = 138
      Top = 90
      Width = 200
      Height = 22
      CharCase = ecUpperCase
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
      HelpOptions.HelpHeight = 110
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
  end
  inherited pnlOperation: TPanel
    Top = 248
    Width = 440
    ExplicitTop = 248
    ExplicitWidth = 440
    inherited bbtnSave: TBitBtn
      Left = 113
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 113
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 246
      Top = 6
      ExplicitLeft = 246
      ExplicitTop = 6
    end
  end
  object jcdsSaveAboutRoute: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'ticketprice/saveformulaitemroute'
    SaveAddress = 'ticketprice/saveformulaitemroute'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemroute.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroute.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemroute.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroute.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemroute.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemroute.routeid'
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
    Left = 288
    Top = 136
  end
end
