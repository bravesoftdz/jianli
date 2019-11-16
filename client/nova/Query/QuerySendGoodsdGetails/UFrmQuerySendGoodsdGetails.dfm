inherited FrmQuerySendGoodsdGetails: TFrmQuerySendGoodsdGetails
  Caption = #21457#36135#26126#32454#26597#35810
  ClientHeight = 533
  ClientWidth = 887
  OnShow = FormShow
  ExplicitWidth = 903
  ExplicitHeight = 571
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 887
    Height = 156
    ExplicitTop = 490
    ExplicitWidth = 116
    ExplicitHeight = 156
    object Label5: TLabel
      Left = 818
      Top = 22
      Width = 98
      Height = 14
      Caption = #25176#36816#20154#30005#35805#21495#30721
    end
    object Label1: TLabel
      Left = 622
      Top = 22
      Width = 42
      Height = 14
      Caption = #25176#36816#20154
    end
    object Label2: TLabel
      Left = 50
      Top = 123
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label3: TLabel
      Left = 416
      Top = 22
      Width = 56
      Height = 14
      Caption = #34892#21253#21333#21495
    end
    object Label6: TLabel
      Left = 50
      Top = 71
      Width = 42
      Height = 14
      Caption = #21463#29702#21592
    end
    object Label7: TLabel
      Left = 224
      Top = 71
      Width = 42
      Height = 14
      Caption = #31614#21457#20154
    end
    object Label8: TLabel
      Left = 430
      Top = 71
      Width = 42
      Height = 14
      Caption = #30446#30340#22320
    end
    object Label9: TLabel
      Left = 240
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label10: TLabel
      Left = 36
      Top = 22
      Width = 56
      Height = 14
      Caption = #21463#29702#26085#26399
    end
    object Label11: TLabel
      Left = 622
      Top = 71
      Width = 42
      Height = 14
      Caption = #25910#36135#20154
    end
    object Label12: TLabel
      Left = 818
      Top = 71
      Width = 98
      Height = 14
      Caption = #25910#36135#20154#30005#35805#21495#30721
    end
    object Novahelpsenderuser: TNovaEdit
      Left = 670
      Top = 19
      Width = 120
      Height = 22
      Ctl3D = True
      MaxLength = 9
      ParentCtl3D = False
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
    object Novahelpsenderphoneno: TNovaEdit
      Left = 922
      Top = 19
      Width = 120
      Height = 22
      Ctl3D = True
      MaxLength = 9
      ParentCtl3D = False
      TabOrder = 1
      ValueType = ssTicket
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
    object nvhelpvehicleno: TNovaHelp
      Left = 98
      Top = 120
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object novahelpStation: TNovaHelp
      Left = 478
      Top = 68
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationDHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object sendstartdate: TDateTimePicker
      Left = 98
      Top = 19
      Width = 120
      Height = 22
      Date = 42075.737283831020000000
      Format = 'yyyy-MM-dd'
      Time = 42075.737283831020000000
      TabOrder = 4
    end
    object sendenddate: TDateTimePicker
      Left = 272
      Top = 19
      Width = 120
      Height = 22
      Date = 42075.737283831020000000
      Format = 'yyyy-MM-dd'
      Time = 42075.737283831020000000
      TabOrder = 5
    end
    object novehelppackno: TNovaEdit
      Left = 478
      Top = 19
      Width = 120
      Height = 22
      Ctl3D = True
      MaxLength = 9
      ParentCtl3D = False
      TabOrder = 6
      ValueType = ssTicket
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
    object novahelpconsigneeuser: TNovaEdit
      Left = 670
      Top = 68
      Width = 120
      Height = 22
      Ctl3D = True
      MaxLength = 9
      ParentCtl3D = False
      TabOrder = 7
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
    object novahelpconsigneephone: TNovaEdit
      Left = 922
      Top = 68
      Width = 120
      Height = 22
      Ctl3D = True
      MaxLength = 9
      ParentCtl3D = False
      TabOrder = 8
      ValueType = ssTicket
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
    object nvhelpsignby: TNovaHelp
      Left = 272
      Top = 68
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 9
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
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpsellby: TNovaHelp
      Left = 98
      Top = 68
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 10
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
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 887
    ExplicitWidth = 116
    ExplicitHeight = 490
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
  end
  inherited Panel1: TPanel
    Top = 201
    Width = 887
    Height = 332
    ExplicitTop = 646
    ExplicitWidth = 116
    ExplicitHeight = 260
    inherited GroupBox1: TGroupBox
      Width = 887
      Height = 332
      ExplicitWidth = 116
      ExplicitHeight = 260
      inherited dbgrdhResult: TNvDbgridEh
        Width = 883
        Height = 314
        Columns = <
          item
            EditButtons = <>
            FieldName = 'sendstationname'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'tostationname'
            Footers = <>
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 48
    Top = 384
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 360
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'querySendGoodsdGetails'
    QueryAddress = 'query/querySendGoodsdGetails'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!sendstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!senderphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!consigneephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!sender'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!signby'
        ParamType = ptInput
      end>
    Left = 184
    Top = 264
  end
  inherited dsResult: TDataSource
    DataSet = jcdsResult2
    Left = 32
    Top = 328
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 384
    Top = 352
  end
  object jcdsgoodstype: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'goodtype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 336
  end
  object jcdsshiptype: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'shiptype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 504
    Top = 280
  end
  object jcdspaymethod: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'paymethod'
      end>
    RemoteServer = DMPublic.jcon
    Left = 648
    Top = 288
  end
  object jscdsstutas: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'stutas'
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 280
  end
  object jcdspacked: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'packed'
      end>
    RemoteServer = DMPublic.jcon
    Left = 400
    Top = 264
  end
  object jcdsResult2: TjsonClientDataSet
    DataSourceName = 'querySendGoodsdGetails'
    QueryAddress = 'query/querySendGoodsdGetails'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!sendstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!senderphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!consigneephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!sender'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!signby'
        ParamType = ptInput
      end>
    Left = 112
    Top = 272
  end
end
