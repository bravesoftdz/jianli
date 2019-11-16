inherited frmTicketChangeQry: TfrmTicketChangeQry
  Caption = #25913#31614#24773#20917#26597#35810
  ClientHeight = 480
  ClientWidth = 1086
  ExplicitLeft = -201
  ExplicitWidth = 1102
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1086
    Height = 113
    ExplicitWidth = 1086
    ExplicitHeight = 113
    object lbl6: TLabel
      Left = 769
      Top = 22
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl1: TLabel
      Left = 225
      Top = 23
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
    end
    object lbl7: TLabel
      Left = 18
      Top = 86
      Width = 56
      Height = 14
      Caption = #25913#31614#26085#26399
    end
    object lbl14: TLabel
      Left = 265
      Top = 86
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl17: TLabel
      Left = 422
      Top = 52
      Width = 42
      Height = 14
      Caption = #26032#31080#21495
    end
    object lbl11: TLabel
      Left = 18
      Top = 53
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl5: TLabel
      Left = 265
      Top = 54
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 604
      Top = 54
      Width = 42
      Height = 14
      Caption = #21407#31080#21495
    end
    object lbl3: TLabel
      Left = 770
      Top = 51
      Width = 42
      Height = 14
      Caption = #21407#29677#27425
    end
    object lbl4: TLabel
      Left = 604
      Top = 23
      Width = 42
      Height = 14
      Caption = #25913#31614#21592
    end
    object Label2: TLabel
      Left = 32
      Top = 24
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object lbl8: TLabel
      Left = 425
      Top = 22
      Width = 42
      Height = 14
      Caption = #25913#31614#28857
    end
    object Label1: TLabel
      Left = 422
      Top = 84
      Width = 42
      Height = 14
      Caption = #20973#35777#21495
    end
    object lbl12: TLabel
      Left = 590
      Top = 84
      Width = 56
      Height = 14
      Caption = #25903#20184#26041#24335
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 288
      Top = 19
      Width = 120
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object nvhelpSellby: TNovaHelp
      Left = 818
      Top = 18
      Width = 112
      Height = 22
      CharCase = ecUpperCase
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
      HelpOptions.HelpHeight = 100
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
    object dtpBchangedate: TDateTimePicker
      Left = 81
      Top = 81
      Width = 125
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 10
      OnChange = dtpBchangedateChange
    end
    object dtpEchangedate: TDateTimePicker
      Left = 288
      Top = 81
      Width = 120
      Height = 22
      Date = 40413.999305555550000000
      Time = 40413.999305555550000000
      ShowCheckbox = True
      TabOrder = 11
      OnChange = dtpEchangedateChange
    end
    object nvedtTicketno: TNovaEdit
      Left = 472
      Top = 49
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
    object dtpBdepartdate: TDateTimePicker
      Left = 81
      Top = 49
      Width = 125
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      Checked = False
      TabOrder = 5
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 288
      Top = 49
      Width = 120
      Height = 22
      Date = 40413.999305555550000000
      Time = 40413.999305555550000000
      Checked = False
      TabOrder = 6
    end
    object nvedtOldTicketno: TNovaEdit
      Left = 652
      Top = 49
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
    object nvhelpChangeby: TNovaHelp
      Left = 652
      Top = 18
      Width = 111
      Height = 22
      CharCase = ecUpperCase
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
      HelpOptions.HelpHeight = 100
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
    object nvhlpschedule: TNovaHelp
      Left = 818
      Top = 46
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          Title.Caption = #29677#27425
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovachkPorg: TNovaCheckedComboBox
      Left = 80
      Top = 18
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbbTickeoutlets: TNovaCheckedComboBox
      Left = 472
      Top = 18
      Width = 111
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.HelpType = 'TicketoutletCheckCombox'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object changeticketno: TNovaEdit
      Left = 472
      Top = 81
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 12
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
    object nvcbbPaymethod: TNovaComboBox
      Left = 652
      Top = 81
      Width = 111
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'paymethod'
      HelpOptions.DisAll = True
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1086
    ExplicitWidth = 1086
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Visible = False
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
    inherited tbtn4: TToolButton
      Visible = False
    end
    inherited tbtnInfo: TToolButton
      Visible = False
    end
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 158
    Width = 1086
    Height = 322
    ExplicitTop = 158
    ExplicitWidth = 1086
    ExplicitHeight = 322
    inherited GroupBox1: TGroupBox
      Width = 1086
      Height = 322
      ExplicitWidth = 1086
      ExplicitHeight = 322
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1082
        Height = 304
        FooterRowCount = 1
        SumList.Active = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #31080#31181
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'changeticketoutlets'
            Footers = <>
            Title.Caption = #25913#31614#28857
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'changeticketno'
            Footers = <>
            Title.Caption = #25913#31614#20973#35777#21495
            Width = 106
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25913#31614#26381#21153#36153
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'oldschedulecode'
            Footers = <>
            Title.Caption = #21407#29677#27425#21495
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'newschedulecode'
            Footers = <>
            Title.Caption = #26032#29677#27425#21495
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'oldticketno'
            Footers = <>
            Title.Caption = #21407#31080#21495
            Width = 106
          end
          item
            EditButtons = <>
            FieldName = 'newticketno'
            Footers = <>
            Title.Caption = #26032#31080#21495
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'olddepartdate'
            Footers = <>
            Title.Caption = #21407#21457#36710#26085#26399
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'olddeparttime'
            Footers = <>
            Title.Caption = #21407#21457#36710#26102#38388
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'newdepartdate'
            Footers = <>
            Title.Caption = #26032#21457#36710#26085#26399
            Width = 108
          end
          item
            EditButtons = <>
            FieldName = 'newdeparttime'
            Footers = <>
            Title.Caption = #26032#21457#36710#26102#38388
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'oldseatno'
            Footers = <>
            Title.Caption = #21407#24231#20301#21495
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'newseatno'
            Footers = <>
            Title.Caption = #26032#24231#20301#21495
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'changeip'
            Footers = <>
            Title.Caption = #25913#31614#30005#33041'IP'
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'changebyname'
            Footers = <>
            Title.Caption = #25913#31614#20154
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'changetime'
            Footers = <>
            Title.Caption = #25913#31614#26102#38388
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 269
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #25903#20184#26041#24335
            Width = 70
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 96
    Top = 360
  end
  inherited ilToolBarDisable: TImageList
    Left = 184
    Top = 360
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketchangemap'
    QueryAddress = 'query/findTicketChangeQry'
    SaveAddress = 'query/findTicketChangeQry'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_ots!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ots!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_nts!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ots!sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_c!changeby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_os!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_c!changetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_c!changetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ots!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ots!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ct!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_c!changeticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_nts!paymethod'
        ParamType = ptInput
      end>
    Left = 256
    Top = 360
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 30
    end
    object wdstrngfldResultsellname: TWideStringField
      FieldName = 'sellname'
    end
    object wdstrngfldResultoldschedulecode: TWideStringField
      FieldName = 'oldschedulecode'
      Size = 30
    end
    object wdstrngfldResultnewschedulecode: TWideStringField
      FieldName = 'newschedulecode'
      Size = 30
    end
    object wdstrngfldResulttickettype: TWideStringField
      FieldName = 'tickettype'
      Size = 10
    end
    object wdstrngfldResultoldticketno: TWideStringField
      FieldName = 'oldticketno'
      Size = 30
    end
    object wdstrngfldResultnewticketno: TWideStringField
      FieldName = 'newticketno'
      Size = 30
    end
    object dtfldResultolddepartdate: TDateField
      FieldName = 'olddepartdate'
    end
    object wdstrngfldResultolddeparttime: TWideStringField
      FieldName = 'olddeparttime'
      Size = 10
    end
    object dtfldResultnewdepartdate: TDateField
      FieldName = 'newdepartdate'
    end
    object wdstrngfldResultnewdeparttime: TWideStringField
      FieldName = 'newdeparttime'
      Size = 30
    end
    object intgrfldResultoldseatno: TIntegerField
      FieldName = 'oldseatno'
    end
    object intgrfldResultnewseatno: TIntegerField
      FieldName = 'newseatno'
    end
    object fltfldResultprice: TFloatField
      FieldName = 'price'
    end
    object wdstrngfldResultchangeip: TWideStringField
      FieldName = 'changeip'
      Size = 40
    end
    object wdstrngfldResultchangeticketoutlets: TWideStringField
      FieldName = 'changeticketoutlets'
      Size = 30
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object dtmfldResultchangetime: TDateTimeField
      FieldName = 'changetime'
    end
    object wdstrngfldResultremarks: TWideStringField
      FieldName = 'remarks'
      Size = 260
    end
    object wdstrngfldResultchangebyname: TWideStringField
      FieldName = 'changebyname'
      Size = 30
    end
    object wdstrngfldResulttickettypename1: TWideStringField
      FieldName = 'tickettypename'
    end
    object fltfldResultservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object jcdsResultchangeticketno: TWideStringField
      FieldName = 'changeticketno'
    end
    object jcdsResultpaymethod: TWideStringField
      FieldName = 'paymethod'
    end
    object jcdsResultpaymethodname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodname'
      LookupDataSet = jcdsPaymethod
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'paymethod'
      Lookup = True
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 368
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 360
  end
  object jcdsTicketstatus: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'ticketstatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 528
    Top = 352
  end
  object jcdsPaymethod: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'paymethod'
      end>
    RemoteServer = DMPublic.jcon
    Left = 432
    Top = 328
  end
end
