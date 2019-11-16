inherited frmSaleOtherTicketQry: TfrmSaleOtherTicketQry
  Caption = #26412#21806#24322#26126#32454#34920
  ClientHeight = 480
  ClientWidth = 1086
  ExplicitWidth = 1102
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1086
    Height = 147
    ExplicitWidth = 1086
    ExplicitHeight = 147
    object lbl5: TLabel
      Left = 261
      Top = 86
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl6: TLabel
      Left = 450
      Top = 56
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl8: TLabel
      Left = 450
      Top = 21
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object lbl9: TLabel
      Left = 640
      Top = 22
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object lbl11: TLabel
      Left = 18
      Top = 89
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl13: TLabel
      Left = 626
      Top = 54
      Width = 56
      Height = 14
      Caption = #36710#31080#29366#24577
    end
    object lbl1: TLabel
      Left = 223
      Top = 22
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
    end
    object lbl7: TLabel
      Left = 18
      Top = 56
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl14: TLabel
      Left = 261
      Top = 56
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 18
      Top = 120
      Width = 56
      Height = 14
      Caption = #36864#31080#26085#26399
    end
    object lbl4: TLabel
      Left = 261
      Top = 120
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl10: TLabel
      Left = 434
      Top = 85
      Width = 56
      Height = 14
      Caption = #36864#31080#31449#28857
    end
    object lbl15: TLabel
      Left = 640
      Top = 85
      Width = 42
      Height = 14
      Caption = #36864#31080#21592
    end
    object Label1: TLabel
      Left = 32
      Top = 24
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 286
      Top = 82
      Width = 113
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 7
      OnChange = dtpEdepartdateChange
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 286
      Top = 18
      Width = 152
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOtherOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object nvhelpendstation: TNovaHelp
      Left = 691
      Top = 16
      Width = 109
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpstartstation: TNovaHelp
      Left = 500
      Top = 17
      Width = 120
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
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StartStationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpSellby: TNovaHelp
      Left = 501
      Top = 48
      Width = 119
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
    object nvcbbticketstatus: TNovaComboBox
      Left = 691
      Top = 48
      Width = 109
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 12
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
      HelpOptions.Columnname = 'ticketstatus'
      HelpOptions.DisAll = True
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 80
      Top = 83
      Width = 127
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 6
      OnChange = dtpBdepartdateChange
    end
    object dtpBselldate: TDateTimePicker
      Left = 80
      Top = 55
      Width = 127
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 2
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 286
      Top = 51
      Width = 113
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 3
      OnChange = dtpEselldateChange
    end
    object dtpBreturnDate: TDateTimePicker
      Left = 80
      Top = 119
      Width = 127
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 10
      OnChange = dtpBreturnDateChange
    end
    object dtpEreturnDate: TDateTimePicker
      Left = 286
      Top = 115
      Width = 113
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 11
      OnChange = dtpEreturnDateChange
    end
    object nvhlpReturnby: TNovaHelp
      Left = 692
      Top = 81
      Width = 109
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
        end>
      HelpOptions.HelpHeight = 200
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
    object nvhelpReturnsation: TNovaHelp
      Left = 501
      Top = 82
      Width = 119
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 8
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
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #32534#30721
          Width = 40
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 170
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
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
      TabOrder = 13
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
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
    Top = 192
    Width = 1086
    Height = 288
    ExplicitTop = 192
    ExplicitWidth = 1086
    ExplicitHeight = 288
    inherited GroupBox1: TGroupBox
      Width = 1086
      Height = 288
      ExplicitWidth = 1086
      ExplicitHeight = 288
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1082
        Height = 270
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'sellorgname'
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #34987#21806#26426#26500
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletsname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 136
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            Title.Caption = #35746#21333#21495
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #31080#21495
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #37324#31243
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#31080#20215
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36141#31080#20215
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #36710#31080#31867#22411
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'charges'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25163#32493#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'returnwayname'
            Footers = <>
            Title.Caption = #36864#31080#36884#24452
            Width = 107
          end
          item
            EditButtons = <>
            FieldName = 'sellwayname'
            Footers = <>
            Title.Caption = #21806#31080#36884#24452
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #25903#20184#26041#24335
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215#24046
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'sellip'
            Footers = <>
            Title.Caption = #21806#31080#30005#33041'IP'
            Width = 107
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'returnsationname'
            Footers = <>
            Title.Caption = #36864#31080#28857
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'returnbyname'
            Footers = <>
            Title.Caption = #36864#31080#21592
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'returntime'
            Footers = <>
            Title.Caption = #36864#31080#26102#38388
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'returnip'
            Footers = <>
            Title.Caption = #36864#31080#30005#33041'IP'
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31449#21153#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#24494#26426#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31354#35843#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20445#38505#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#37197#27700#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20854#20182
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#23567#35745
            Width = 59
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
    DataSourceName = 'resultmap'
    QueryAddress = 'query/queryFocusSellOtherQry'
    SaveAddress = 'query/findSellOtherTicketQry'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_ts!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ts!ticketstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ts!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ts!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_tr!returnby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_tr!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_tr!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_tr!ticketoutletsid'
        ParamType = ptInput
      end>
    Left = 256
    Top = 360
    object jcdsResultsellorgname: TWideStringField
      FieldName = 'sellorgname'
      Size = 100
    end
    object wdstrngfldResultsellname: TWideStringField
      FieldName = 'sellname'
    end
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 30
    end
    object wdstrngfldResultticketstatus: TWideStringField
      FieldName = 'ticketstatus'
      Size = 10
    end
    object wdstrngfldResultticketstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ticketstatusname'
      LookupDataSet = jcdsTicketstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'ticketstatus'
      Lookup = True
    end
    object wdstrngfldResultticketno: TWideStringField
      FieldName = 'ticketno'
      Size = 30
    end
    object dtfldResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object intgrfldResultseatno: TIntegerField
      FieldName = 'seatno'
    end
    object fltfldResultprice: TFloatField
      FieldName = 'price'
    end
    object wdstrngfldResultsellip: TWideStringField
      FieldName = 'sellip'
      Size = 40
    end
    object dtmfldResultselltime: TDateTimeField
      FieldName = 'selltime'
    end
    object wdstrngfldResultreturnsationname: TWideStringField
      FieldName = 'returnsationname'
      Size = 30
    end
    object wdstrngfldResultreturnbyname: TWideStringField
      FieldName = 'returnbyname'
      Size = 30
    end
    object dtmfldResultreturntime: TDateTimeField
      FieldName = 'returntime'
    end
    object wdstrngfldResultreturnip: TWideStringField
      FieldName = 'returnip'
      Size = 30
    end
    object wdstrngfldResultdepartstationname: TWideStringField
      FieldName = 'departstationname'
      Size = 30
    end
    object wdstrngfldResultreachstationname: TWideStringField
      FieldName = 'reachstationname'
      Size = 30
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 30
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
    end
    object fltfldResultcomputefee: TFloatField
      FieldName = 'computefee'
    end
    object fltfldResultcoolairfee: TFloatField
      FieldName = 'coolairfee'
    end
    object fltfldResultadditionfee: TFloatField
      FieldName = 'additionfee'
    end
    object fltfldResultwaterfee: TFloatField
      FieldName = 'waterfee'
    end
    object fltfldResultinsurefee: TFloatField
      FieldName = 'insurefee'
    end
    object fltfldResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object fltfldResultmoreprice: TFloatField
      FieldName = 'moreprice'
    end
    object fltfldResultsubtotal: TFloatField
      FieldName = 'subtotal'
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object fltfldResultcharges: TFloatField
      FieldName = 'charges'
    end
    object jcdsResultticketoutletsname: TWideStringField
      FieldName = 'ticketoutletsname'
      Size = 100
    end
    object jcdsResultorderno: TWideStringField
      FieldName = 'orderno'
      Size = 100
    end
    object jcdsResultfullprice: TFloatField
      FieldName = 'fullprice'
    end
    object jcdsResulttickettype: TWideStringField
      FieldName = 'tickettype'
      Size = 100
    end
    object jcdsResulttickettypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'tickettypename'
      LookupDataSet = jcdsTickettype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'tickettype'
      Size = 100
      Lookup = True
    end
    object jcdsResultreturnway: TWideStringField
      FieldName = 'returnway'
      Size = 100
    end
    object jcdsResultreturnwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'returnwayname'
      LookupDataSet = jcdsreturnway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'returnway'
      Size = 100
      Lookup = True
    end
    object jcdsResultsellway: TWideStringField
      FieldName = 'sellway'
      Size = 100
    end
    object jcdsResultsellwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'sellwayname'
      LookupDataSet = jcdssellway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'sellway'
      Size = 100
      Lookup = True
    end
    object jcdsResultpaymethod: TWideStringField
      FieldName = 'paymethod'
      Size = 100
    end
    object jcdsResultpaymethodname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodname'
      LookupDataSet = jcdspaymethod
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'paymethod'
      Size = 100
      Lookup = True
    end
    object jcdsResultdistance: TLargeintField
      FieldName = 'distance'
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
  object jcdsTickettype: TjsonClientDataSet
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
        Value = 'tickettype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 640
    Top = 336
  end
  object jcdsreturnway: TjsonClientDataSet
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
        Value = 'ticketreturn'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'returnway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 344
  end
  object jcdssellway: TjsonClientDataSet
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
        Value = 'sellway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 824
    Top = 336
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'paymethod'
      end>
    RemoteServer = DMPublic.jcon
    Left = 888
    Top = 336
  end
end
