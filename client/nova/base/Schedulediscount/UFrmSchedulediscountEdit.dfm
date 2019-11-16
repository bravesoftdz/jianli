inherited FrmSchedulediscountEdit: TFrmSchedulediscountEdit
  Caption = #29677#27425#25240#25187#20449#24687
  ClientHeight = 437
  ClientWidth = 566
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 572
  ExplicitHeight = 465
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 566
    Height = 392
    ExplicitWidth = 566
    ExplicitHeight = 392
    inherited Bevel1: TBevel
      Top = 384
      Width = 532
      ExplicitTop = 257
      ExplicitWidth = 532
    end
    object Label1: TLabel
      Left = 253
      Top = 27
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl1: TLabel
      Left = 70
      Top = 27
      Width = 28
      Height = 14
      Caption = #32447#36335
    end
    object lbl2: TLabel
      Left = 331
      Top = 27
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object Label2: TLabel
      Left = 526
      Top = 27
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl5: TLabel
      Left = 14
      Top = 116
      Width = 84
      Height = 14
      Caption = #26368#23567#36141#31080#24352#25968
    end
    object lbl6: TLabel
      Left = 275
      Top = 116
      Width = 84
      Height = 14
      Caption = #21487#21806#25171#25240#31080#25968
    end
    object lbl7: TLabel
      Left = 28
      Top = 161
      Width = 70
      Height = 14
      Caption = #40664#35748#25240#25187#29575
    end
    object lbl8: TLabel
      Left = 289
      Top = 162
      Width = 70
      Height = 14
      Caption = #26368#20302#25240#25187#29575
    end
    object Label3: TLabel
      Left = 526
      Top = 116
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label5: TLabel
      Left = 526
      Top = 71
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label6: TLabel
      Left = 526
      Top = 162
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label7: TLabel
      Left = 253
      Top = 116
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label8: TLabel
      Left = 253
      Top = 161
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl3: TLabel
      Left = 42
      Top = 71
      Width = 56
      Height = 14
      Caption = #36215#22987#26085#26399
    end
    object lbl4: TLabel
      Left = 303
      Top = 71
      Width = 56
      Height = 14
      Caption = #32456#27490#26085#26399
    end
    object Label4: TLabel
      Left = 253
      Top = 71
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl9: TLabel
      Left = 21
      Top = 213
      Width = 77
      Height = 14
      Caption = 'VIP'#23545#24212#25240#25187
    end
    object lbl10: TLabel
      Left = 266
      Top = 161
      Width = 7
      Height = 14
      Caption = '%'
      Visible = False
    end
    object lbl11: TLabel
      Left = 539
      Top = 161
      Width = 7
      Height = 14
      Caption = '%'
      Visible = False
    end
    object nvhelproute: TNovaHelp
      Left = 108
      Top = 24
      Width = 139
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 0
      OnChange = nvhelprouteChange
      OnExit = nvhelprouteExit
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
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #32447#36335
          Width = 150
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 150
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbbhelpcode: TNovaCheckedComboBox
      Left = 371
      Top = 24
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      OnEnter = cbbhelpcodeEnter
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'ScheduletimeHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!route.id'
          ParamType = ptInput
        end>
    end
    object cbbstartdate: TDateTimePicker
      Left = 108
      Top = 68
      Width = 139
      Height = 22
      Date = 40589.726920023160000000
      Time = 40589.726920023160000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 2
    end
    object cbbenddate: TDateTimePicker
      Left = 371
      Top = 68
      Width = 142
      Height = 22
      Date = 40589.727512476850000000
      Time = 40589.727512476850000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 3
    end
    object edtfromnum: TNovaEdit
      Left = 104
      Top = 113
      Width = 143
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 4
      ValueType = ssNumber
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
    object edtendnum: TNovaEdit
      Left = 365
      Top = 113
      Width = 148
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 5
      ValueType = ssNumber
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
    object edtdefaultdiscountrate: TNovaEdit
      Left = 108
      Top = 158
      Width = 139
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 8
      TabOrder = 6
      Text = '1'
      OnExit = edtdefaultdiscountrateExit
      ValueTrim = '1'
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
    object edtmindiscountrate: TNovaEdit
      Left = 371
      Top = 158
      Width = 142
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 8
      TabOrder = 7
      Text = '1'
      OnExit = edtmindiscountrateExit
      ValueTrim = '1'
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
    object nvdbgrdh1: TNvDbgridEh
      Left = 108
      Top = 213
      Width = 325
      Height = 133
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsResult
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -14
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      ImeMode = imClose
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      RowDetailPanel.Color = clBtnFace
      TabOrder = 8
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      ExpOpenType = AutoOpen
      AutoSetMultiSelect = False
      AutoSetCtrlKey = False
      PrintInfo.TitleFont.Charset = GB2312_CHARSET
      PrintInfo.TitleFont.Color = clWindowText
      PrintInfo.TitleFont.Height = -19
      PrintInfo.TitleFont.Name = #23435#20307
      PrintInfo.TitleFont.Style = []
      PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
      PrintInfo.GridHeadFont.Color = clWindowText
      PrintInfo.GridHeadFont.Height = -11
      PrintInfo.GridHeadFont.Name = 'Tahoma'
      PrintInfo.GridHeadFont.Style = []
      PrintInfo.TitleNullLine = 0
      PrintInfo.PrintPageFooter = True
      PrintInfo.PrintPrintFooterTime = True
      PrintInfo.PageFooterRight = #21335#20940#31185#25216
      PrintInfo.PageSize.BottomMargin = 1.000000000000000000
      PrintInfo.PageSize.LeftMargin = 1.000000000000000000
      PrintInfo.PageSize.RightMargin = 1.000000000000000000
      PrintInfo.PageSize.TopMargin = 1.000000000000000000
      PrintOptions = [pghOptimalColWidths]
      PrintAutoNewLine = False
      ParentName = 'FrmSchedulediscountEdit'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'gradename'
          Footers = <>
          Title.Caption = 'VIP'#21345#32423#21035
          Width = 134
        end
        item
          EditButtons = <>
          FieldName = 'defaultdiscountrate'
          Footers = <>
          Title.Caption = #23545#24212#25240#25187#29575
          Width = 114
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object edtschedule: TNovaEdit
      Left = 371
      Top = 24
      Width = 142
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 9
      Visible = False
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
    Top = 392
    Width = 566
    ExplicitTop = 392
    ExplicitWidth = 566
    inherited bbtnSave: TBitBtn
      Left = 159
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 159
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 314
      Top = 6
      ExplicitLeft = 314
      ExplicitTop = 6
    end
  end
  object dsResult: TDataSource
    DataSet = jsonCDSSchedulediscountSave
    Left = 296
    Top = 280
  end
  object jsonCDSSchedulediscountSave: TjsonClientDataSet
    DataSourceName = 'vipmap'
    UpdateDataSet = 'schedulevipdiscounts'
    QueryAddress = 'base/qryvip'
    SaveAddress = 'base/saveschedulediscount'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'schedulediscount.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.fromnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.endnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.defaultdiscountrate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.mindiscountrate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulediscount.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'flag'
        ParamType = ptOutput
        Value = 'null'
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Value = 'null'
      end
      item
        DataType = ftString
        Name = 'schedulediscount.scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 192
    Top = 320
    object wdstrngfldCDSSchedulediscountSavevipgrade: TWideStringField
      FieldName = 'vipgrade'
    end
    object fltfldCDSSchedulediscountSavedefaultdiscountrate: TFloatField
      FieldName = 'defaultdiscountrate'
    end
    object wdstrngfldCDSSchedulediscountSavegradename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'gradename'
      LookupDataSet = jcdsgradename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'vipgrade'
      Lookup = True
    end
    object lrgntfldCDSSchedulediscountSaveid: TLargeintField
      FieldName = 'id'
    end
  end
  object jcdsgradename: TjsonClientDataSet
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
        Value = 'vip'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'grade'
      end>
    RemoteServer = DMPublic.jcon
    Left = 376
    Top = 280
  end
end
