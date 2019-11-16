inherited FrmPlusScheduleEdt: TFrmPlusScheduleEdt
  Caption = 'FrmPlusScheduleEdt'
  ClientHeight = 479
  ClientWidth = 751
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 757
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 751
    Height = 434
    ExplicitWidth = 751
    ExplicitHeight = 434
    inherited Bevel1: TBevel
      Top = 426
      Width = 717
      ExplicitTop = 420
      ExplicitWidth = 717
    end
    object Label2: TLabel
      Left = 43
      Top = 94
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object Label3: TLabel
      Left = 57
      Top = 126
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label8: TLabel
      Left = 57
      Top = 324
      Width = 42
      Height = 14
      Caption = #24231#20301#25968
    end
    object Label1: TLabel
      Left = 43
      Top = 159
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object Label5: TLabel
      Left = 290
      Top = 91
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 290
      Top = 125
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 182
      Top = 322
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 187
      Top = 156
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 57
      Top = 354
      Width = 42
      Height = 14
      Caption = #26816#31080#21475
    end
    object Label25: TLabel
      Left = 57
      Top = 387
      Width = 42
      Height = 14
      Caption = #19978#36710#21345
    end
    object lbl4: TLabel
      Left = 39
      Top = 256
      Width = 60
      Height = 18
      Caption = #33829#36816#21333#20301
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 264
      Top = 222
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 39
      Top = 289
      Width = 60
      Height = 18
      Caption = #35745#21010#36710#36742
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label23: TLabel
      Left = 292
      Top = 355
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 292
      Top = 388
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 43
      Top = 29
      Width = 56
      Height = 14
      Caption = #21152#29677#26085#26399
    end
    object Label19: TLabel
      Left = 85
      Top = 61
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label10: TLabel
      Left = 43
      Top = 224
      Width = 56
      Height = 14
      Caption = #21378#29260#22411#21495
    end
    object Label11: TLabel
      Left = 265
      Top = 188
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 71
      Top = 191
      Width = 28
      Height = 14
      Caption = #36710#22411
    end
    object Label31: TLabel
      Left = 236
      Top = 193
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object NHelpRoute: TNovaHelp
      Left = 114
      Top = 88
      Width = 168
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 20
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
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
    object NEdtHelpCode: TNovaEdit
      Left = 114
      Top = 121
      Width = 168
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
    object dtStartTime: TDateTimePicker
      Left = 114
      Top = 153
      Width = 64
      Height = 22
      Date = 37834.000011574100000000
      Format = 'HH:mm'
      Time = 37834.000011574100000000
      Kind = dtkTime
      TabOrder = 4
    end
    object NHccbTicketEntrance: TNovaHComboBox
      Left = 114
      Top = 351
      Width = 168
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 8
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
          Value = 'TicketEntranceHelp'
        end>
    end
    object NHccbVehiclepark: TNovaHComboBox
      Left = 114
      Top = 383
      Width = 168
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 9
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
          Value = 'VehicleparkHelp'
        end>
    end
    object NovaHUnit: TNovaHelp
      Left = 113
      Top = 254
      Width = 168
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 5
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpVehicleno: TNovaHelp
      Left = 113
      Top = 288
      Width = 168
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
      OnIdChange = NovaHelpVehiclenoIdChange
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
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'brandname'
          Title.Caption = #21378#29260
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
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
    object GpOtherInfo: TGroupBox
      Left = 396
      Top = 19
      Width = 315
      Height = 382
      Caption = #20854#20182#20449#24687
      TabOrder = 10
      object Label4: TLabel
        Left = 37
        Top = 78
        Width = 56
        Height = 14
        Caption = #36816#33829#31867#21035
      end
      object Label6: TLabel
        Left = 37
        Top = 156
        Width = 56
        Height = 14
        Caption = #36816#34892#21306#22495
      end
      object Label7: TLabel
        Left = 37
        Top = 117
        Width = 56
        Height = 14
        Caption = #33829#36816#26041#24335
      end
      object Label13: TLabel
        Left = 37
        Top = 196
        Width = 56
        Height = 14
        Caption = #29677#27425#31867#22411
      end
      object Label14: TLabel
        Left = 176
        Top = 37
        Width = 28
        Height = 14
        Caption = #23567#26102
      end
      object Label9: TLabel
        Left = 37
        Top = 39
        Width = 56
        Height = 14
        Caption = #36816#34892#26102#38388
      end
      object Label20: TLabel
        Left = 36
        Top = 319
        Width = 84
        Height = 14
        Caption = #31080#38754#25171#21360#20449#24687
      end
      object Label21: TLabel
        Left = 231
        Top = 35
        Width = 8
        Height = 16
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 233
        Top = 74
        Width = 8
        Height = 16
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label27: TLabel
        Left = 233
        Top = 113
        Width = 8
        Height = 16
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 233
        Top = 152
        Width = 8
        Height = 16
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label29: TLabel
        Left = 233
        Top = 194
        Width = 8
        Height = 16
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object NEdtRuntime: TNovaEdit
        Left = 104
        Top = 34
        Width = 64
        Height = 22
        MaxLength = 50
        TabOrder = 0
        Text = '4'
        ValueTrim = '4'
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
      object CobWORKTYPE: TNovaComboBox
        Left = 104
        Top = 73
        Width = 120
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
        HelpOptions.TableName = 'schedule'
        HelpOptions.Columnname = 'worktype'
      end
      object CobWORKWAYS: TNovaComboBox
        Left = 104
        Top = 112
        Width = 120
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
        HelpOptions.TableName = 'schedule'
        HelpOptions.Columnname = 'workways'
      end
      object CobDISTRICTTYPE: TNovaComboBox
        Left = 106
        Top = 149
        Width = 120
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
        HelpOptions.TableName = 'route'
        HelpOptions.Columnname = 'districttype'
      end
      object CobTYPE: TNovaComboBox
        Left = 104
        Top = 191
        Width = 120
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        TabOrder = 4
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
        HelpOptions.TableName = 'schedule'
        HelpOptions.Columnname = 'scheduletype'
      end
      object ChkISCANMIXCHECK: TCheckBox
        Left = 164
        Top = 260
        Width = 100
        Height = 17
        Caption = #20801#35768#28151#26816
        TabOrder = 5
      end
      object ChkISORIGINATOR: TCheckBox
        Left = 58
        Top = 229
        Width = 100
        Height = 17
        Caption = #36807#36335#29677#27425
        TabOrder = 6
      end
      object ChkISSELLRETURNTICKET: TCheckBox
        Left = 58
        Top = 259
        Width = 100
        Height = 17
        Caption = #21452#31243#29677#27425
        TabOrder = 7
      end
      object ChkISSALEAFTERREPORT: TCheckBox
        Left = 164
        Top = 233
        Width = 100
        Height = 17
        Caption = #25253#21040#21806#31080
        TabOrder = 8
      end
      object ChkISPROPRIETARY: TCheckBox
        Left = 58
        Top = 288
        Width = 100
        Height = 17
        Caption = #26412#31449#19987#33829
        TabOrder = 9
      end
      object NEdtPRINTINFO: TNovaEdit
        Left = 56
        Top = 345
        Width = 226
        Height = 22
        MaxLength = 150
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
      end
    end
    object DpStartdate: TDateTimePicker
      Left = 114
      Top = 23
      Width = 120
      Height = 22
      Date = 40333.738843125000000000
      Time = 40333.738843125000000000
      TabOrder = 0
      OnChange = DpStartdateChange
    end
    object DpEnddate: TDateTimePicker
      Left = 114
      Top = 55
      Width = 120
      Height = 22
      Date = 40333.738843125000000000
      Time = 40333.738843125000000000
      TabOrder = 1
      OnChange = DpEnddateChange
    end
    object NEdtPLANSEATNUM: TNovaEdit
      Left = 114
      Top = 319
      Width = 62
      Height = 22
      Enabled = False
      MaxLength = 3
      TabOrder = 7
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
    object NvHcbbVehiclebrandmodel: TNovaHComboBox
      Left = 114
      Top = 219
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 11
      OnChange = NvHcbbVehiclebrandmodelChange
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
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehiclebrandmodelHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!vehicletypeid'
          ParamType = ptInput
        end>
    end
    object NovaVehicletype: TNovaHComboBox
      Left = 114
      Top = 191
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 12
      OnChange = NovaVehicletypeChange
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
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehicletypeHelp'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 434
    Width = 751
    ExplicitTop = 434
    ExplicitWidth = 751
    inherited bbtnSave: TBitBtn
      Left = 243
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 243
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 396
      Top = 6
      ExplicitLeft = 396
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 320
    Top = 24
  end
  object jcsdqryCycleVehicletype: TjsonClientDataSet
    DataSourceName = 'otherinfo'
    QueryAddress = 'dispatch/qryCycleVehicletype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 624
    Top = 296
  end
  object jcdsScheduleplus: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/scheduleplus'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'mbscheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.code'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.starttime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.runtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.planseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isproprietary'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.issellreturnticket'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.iscanmixcheck'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.issaleafterreport'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isoriginator'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.printinfo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.createby'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.ticketentranceid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.vehcileparkid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleid'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 1000
        Value = '0'
      end>
    RemoteServer = DMPublic.jcon
    Left = 328
    Top = 280
  end
end
