inherited FrmSecurity: TFrmSecurity
  Caption = #36710#36742#23433#26816#20449#24687
  ClientHeight = 564
  ClientWidth = 1052
  Font.Charset = GB2312_CHARSET
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1068
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1052
    Height = 100
    ExplicitWidth = 1052
    ExplicitHeight = 100
    object Label1: TLabel
      Left = 232
      Top = 46
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label2: TLabel
      Left = 218
      Top = 77
      Width = 56
      Height = 14
      Caption = #23433#26816#32467#26524
    end
    object Label3: TLabel
      Left = 424
      Top = 46
      Width = 42
      Height = 14
      Caption = #23433#26816#21592
    end
    object Label4: TLabel
      Left = 7
      Top = 46
      Width = 56
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = #36710#23646#21333#20301
      ParentBiDiMode = False
    end
    object Label8: TLabel
      Left = 218
      Top = 13
      Width = 56
      Height = 14
      Cursor = crDrag
      Caption = #23433#26816#26085#26399
    end
    object Label9: TLabel
      Left = 452
      Top = 13
      Width = 14
      Height = 14
      Cursor = crDrag
      Caption = #33267
    end
    object Label10: TLabel
      Left = 7
      Top = 13
      Width = 56
      Height = 14
      Caption = #23433#26816#36710#31449
    end
    object lbltype: TLabel
      Left = 7
      Top = 77
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#22411
    end
    object LabResult: TLabel
      Left = 586
      Top = 73
      Width = 76
      Height = 19
      Caption = #23433#26816#32467#26524
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 582
      Top = 13
      Width = 28
      Height = 14
      Cursor = crDrag
      Caption = #32534#21495
    end
    object nvhelpcheckname: TNovaHelp
      Left = 469
      Top = 42
      Width = 101
      Height = 22
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      MaxLength = 50
      TabOrder = 4
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
          Title.Caption = #22995#21517
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object startdate: TDateTimePicker
      Left = 281
      Top = 9
      Width = 100
      Height = 22
      Date = 40603.000000000000000000
      Time = 40603.000000000000000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 0
      OnChange = startdateChange
    end
    object enddate: TDateTimePicker
      Left = 469
      Top = 9
      Width = 101
      Height = 22
      Date = 40589.999988425930000000
      Time = 40589.999988425930000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 1
    end
    object nvhelpcardno: TNovaHelp
      Left = 469
      Top = 71
      Width = 103
      Height = 27
      CharCase = ecUpperCase
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 7
      OnChange = nvhelpcardnoChange
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
      HDBGColumns = <>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'cardno'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'CardissueHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQS_i!cardtype'
          ParamType = ptInput
          Value = '0'
        end>
      notFocusedShowHelp = False
    end
    object nvhelpunitname: TNovaHelp
      Left = 71
      Top = 42
      Width = 129
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      MaxLength = 50
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpvehicleno: TNovaHelp
      Left = 281
      Top = 42
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #36710#29260#21495
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25253#21040#21345
          Width = 100
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
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbbChecktype: TNovaCheckedComboBox
      Left = 71
      Top = 73
      Width = 128
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'vehicle'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'type'
        end>
    end
    object nvcbbResult: TNovaCheckedComboBox
      Left = 281
      Top = 73
      Width = 100
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'securitycheck'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'result'
        end>
    end
    object chkAutoCheck: TCheckBox
      Left = 721
      Top = 45
      Width = 122
      Height = 17
      Caption = #21047#21345#33258#21160#20363#26816
      TabOrder = 8
    end
    object chkPrint: TCheckBox
      Left = 586
      Top = 45
      Width = 122
      Height = 17
      Caption = #25171#21360#23433#26816#36890#30693#21333
      TabOrder = 9
    end
    object chkIsCheck: TCheckBox
      Left = 390
      Top = 76
      Width = 76
      Height = 17
      Caption = #25253#29677#21345#21495
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object CheckPrintTitle: TCheckBox
      Left = 721
      Top = 12
      Width = 115
      Height = 17
      Caption = #25171#21360#23433#26816#26631#31614
      TabOrder = 11
    end
    object EdtNotenum: TEdit
      Left = 613
      Top = 9
      Width = 99
      Height = 22
      TabOrder = 12
    end
    object cbborg: TNovaHComboBox
      Left = 71
      Top = 11
      Width = 128
      Height = 22
      ImeMode = imClose
      TabOrder = 13
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1052
    ExplicitWidth = 1052
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #23433#26816
      ImageIndex = 28
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Caption = #27880#38144
      OnClick = tbtnDeleteClick
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
  end
  inherited Panel1: TPanel
    Top = 145
    Width = 1052
    Height = 419
    ExplicitTop = 145
    ExplicitWidth = 1052
    ExplicitHeight = 419
    inherited GroupBox1: TGroupBox
      Width = 1052
      Height = 419
      ExplicitWidth = 1052
      ExplicitHeight = 419
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1048
        Height = 401
        FooterFont.Charset = GB2312_CHARSET
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        TitleFont.Charset = GB2312_CHARSET
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'checktime'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #23433#26816#26085#26399
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #23433#26816#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #36710#36742#31867#22411
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 118
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #33829#36816#31867#22411
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'workno'
            Footers = <>
            Title.Caption = #33829#36816#35777#21495
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'qualification'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#21495
            Width = 128
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495#30721
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'roadno'
            Footers = <>
            Title.Caption = #32447#36335#29260#32534#21495
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'light'
            Footers = <>
            Title.Caption = #25972#36710#19982#36710#36523
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'turn'
            Footers = <>
            Title.Caption = #36716#21521#31995
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'drive'
            Footers = <>
            Title.Caption = #20256#21160#31995
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'brake'
            Footers = <>
            Title.Caption = #21046#21160#31995
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'hang'
            Footers = <>
            Title.Caption = #36710#26550#12289#24748#26550#21644#36710#26725
            Width = 132
          end
          item
            EditButtons = <>
            FieldName = 'wheel'
            Footers = <>
            Title.Caption = #36718#32974
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'mirror'
            Footers = <>
            Title.Caption = #30005#27668#37096#20998
            Width = 132
          end
          item
            EditButtons = <>
            FieldName = 'safety'
            Footers = <>
            Title.Caption = #23433#20840#35774#26045
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'window'
            Footers = <>
            Title.Caption = #20854#23427#37096#20998
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'leak'
            Footers = <>
            Title.Caption = #35777#20214
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'camera'
            Footers = <>
            Title.Caption = 'GPS'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returncheck'
            Footers = <>
            Title.Caption = #22238#31243#26816#26597
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'resultname'
            Footers = <>
            Title.Caption = #23433#26816#32467#26524
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'drivername'
            Footers = <>
            Title.Caption = #39550#39542#21592#31614#23383
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'checkname'
            Footers = <>
            Title.Caption = #23433#26816#21592#31614#23383
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Visible = False
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'notenum'
            Footers = <>
            Title.Caption = #23433#26816#21333#32534#21495
            Visible = False
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 200
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 280
  end
  inherited ilToolBarDisable: TImageList
    Left = 120
    Top = 280
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'securitymap'
    QueryAddress = 'check/qrysecurity'
    SaveAddress = 'check/savesecurity'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_t!notenum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_t!result'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'filter_EQL_t!checkby'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'filter_EQL_v!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_v!cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_v!vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_t!checktime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!checktime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_us!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_v!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!id'
        ParamType = ptInput
      end>
    Left = 168
    Top = 224
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResulttype: TWideStringField
      FieldName = 'type'
    end
    object jcdsResultunitname: TWideStringField
      FieldName = 'unitname'
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object nn: TWideStringField
      FieldName = 'checkname'
    end
    object jcdsResultresult: TWideStringField
      FieldName = 'result'
    end
    object jcdsResultcreatename: TWideStringField
      FieldName = 'createname'
    end
    object jcdsResultupdatename: TWideStringField
      FieldName = 'updatename'
    end
    object jcdsResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsResultcheckby: TLargeintField
      FieldName = 'checkby'
    end
    object jcdsResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jcdsResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdstypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Lookup = True
    end
    object jcdsResultlight: TWideStringField
      FieldName = 'light'
    end
    object jcdsResultmirror: TWideStringField
      FieldName = 'mirror'
    end
    object jcdsResultdrive: TWideStringField
      FieldName = 'drive'
    end
    object jcdsResultbrake: TWideStringField
      FieldName = 'brake'
    end
    object jcdsResultturn: TWideStringField
      FieldName = 'turn'
    end
    object jcdsResultwheel: TWideStringField
      FieldName = 'wheel'
    end
    object jcdsResulthang: TWideStringField
      FieldName = 'hang'
    end
    object jcdsResultleak: TWideStringField
      FieldName = 'leak'
    end
    object jcdsResultwindow: TWideStringField
      FieldName = 'window'
    end
    object jcdsResultsafety: TWideStringField
      FieldName = 'safety'
    end
    object jcdsResultresultname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'resultname'
      LookupDataSet = jcdsResultname
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'result'
      Lookup = True
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultchecktime: TDateTimeField
      FieldName = 'checktime'
    end
    object jcdsResultremarks: TWideStringField
      FieldName = 'remarks'
      Size = 200
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 30
    end
    object wdstrngfldResultcamera: TWideStringField
      FieldName = 'camera'
    end
    object wdstrngfldResultreturncheck: TWideStringField
      FieldName = 'returncheck'
    end
    object jcdsResultnotenum: TWideStringField
      FieldName = 'notenum'
      Size = 30
    end
    object jcdsResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
    end
    object jcdsResultdrivername: TWideStringField
      FieldName = 'drivername'
      Size = 0
    end
  end
  inherited dsResult: TDataSource
    Left = 24
    Top = 288
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 248
    Top = 280
  end
  object jcdstypename: TjsonClientDataSet
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
        Value = 'vehicle'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 152
    Top = 368
  end
  object jsonCDSVehInit: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'param'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'helpType'
        ParamType = ptInput
        Size = 1000
        Value = 'VehicleHelp'
      end>
    RemoteServer = DMPublic.jcon
    Left = 64
    Top = 368
  end
  object jsonCDSUnitInit: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'param'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'helpType'
        ParamType = ptInput
        Size = 1000
        Value = 'UnitHelp'
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 360
  end
  object jsonCDSVehicletypeid: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'VehicletypeHelp'
      end>
    RemoteServer = DMPublic.jcon
    Left = 400
    Top = 280
  end
  object jcdsResultname: TjsonClientDataSet
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
        Value = 'securitycheck'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'result'
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 368
  end
  object jcdsChickinfo: TjsonClientDataSet
    DataSourceName = 'checkinfo'
    QueryAddress = 'check/qrycheckinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'checkid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 664
    Top = 272
  end
  object jscdAutoCheck: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'check/autoSaveCheck'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isautosave'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'checkid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 488
    Top = 208
  end
  object jcdsDeletChecked: TjsonClientDataSet
    DataSourceName = 'unitlist'
    QueryAddress = 'check/qrycheckitem'
    SaveAddress = 'check/delteChecked'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'checkid'
        ParamType = ptInput
      end
      item
        DataType = ftString
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
    Top = 216
  end
  object jsonShowValidate: TjsonClientDataSet
    DataSourceName = 'checkVehicle'
    QueryAddress = 'check/showValidate'
    SaveAddress = 'check/showValidate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 696
    Top = 121
  end
  object jcdsVehicledistance: TjsonClientDataSet
    DataSourceName = 'lastactivemap'
    QueryAddress = 'vehicledistance/qryVheicledistiance'
    SaveAddress = 'vehicledistance/qryVheicledistiance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'iscomparedate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 576
    Top = 200
  end
  object jsonVehicleResult: TjsonClientDataSet
    DataSourceName = 'vehiclemap'
    QueryAddress = 'base/qryVehicles'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_v!cardno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 680
    Top = 200
    object jsonVehicleResultid: TLargeintField
      FieldName = 'id'
    end
    object jsonVehicleResultunitname: TWideStringField
      FieldName = 'unitname'
    end
    object jsonVehicleResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
    end
    object wdstrngfldVehicleResultcardno: TWideStringField
      FieldName = 'cardno'
    end
    object wdstrngfldVehicleResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
  end
end
