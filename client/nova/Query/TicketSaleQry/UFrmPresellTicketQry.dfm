inherited frmPresellTicketQry: TfrmPresellTicketQry
  Caption = #39044#21806#31080#24773#20917#26597#35810
  ClientHeight = 480
  ClientWidth = 1086
  OnShow = FormShow
  ExplicitWidth = 1102
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1086
    Height = 148
    ExplicitWidth = 1086
    ExplicitHeight = 148
    object lbl6: TLabel
      Left = 418
      Top = 55
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl8: TLabel
      Left = 419
      Top = 22
      Width = 42
      Height = 14
      Caption = #19978#36710#31449
    end
    object lbl9: TLabel
      Left = 572
      Top = 22
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object lbl13: TLabel
      Left = 199
      Top = 122
      Width = 56
      Height = 14
      Caption = #36710#31080#29366#24577
    end
    object lbl1: TLabel
      Left = 199
      Top = 22
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object lbl7: TLabel
      Left = 18
      Top = 56
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl14: TLabel
      Left = 236
      Top = 56
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl3: TLabel
      Left = 31
      Top = 120
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbl17: TLabel
      Left = 585
      Top = 58
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl16: TLabel
      Left = 404
      Top = 89
      Width = 56
      Height = 14
      Caption = #36710#31080#31867#22411
    end
    object Label2: TLabel
      Left = 32
      Top = 24
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object lbl5: TLabel
      Left = 236
      Top = 89
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl11: TLabel
      Left = 18
      Top = 90
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl12: TLabel
      Left = 405
      Top = 123
      Width = 56
      Height = 14
      Caption = #25903#20184#26041#24335
    end
    object nvhelpendstation: TNovaHelp
      Left = 619
      Top = 18
      Width = 98
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
      Left = 467
      Top = 18
      Width = 98
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
          Width = 80
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
    object nvhelpSellby: TNovaHelp
      Left = 467
      Top = 52
      Width = 98
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
      Left = 262
      Top = 118
      Width = 126
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 6
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
    object nvedtTicketno: TNovaEdit
      Left = 619
      Top = 52
      Width = 98
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 3
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
    object nvhcbbTickettype: TNovaHComboBox
      Left = 467
      Top = 85
      Width = 98
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 7
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
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketTypeHelp'
        end>
    end
    object chkIsnotlocal: TCheckBox
      Left = 654
      Top = 89
      Width = 67
      Height = 17
      Caption = #24322#31449#31080
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkIslocal: TCheckBox
      Left = 583
      Top = 89
      Width = 63
      Height = 17
      Caption = #26412#31449#31080
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object nvhlpschedule: TNovaHelp
      Left = 79
      Top = 118
      Width = 114
      Height = 22
      CharCase = ecUpperCase
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
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 262
      Top = 18
      Width = 126
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
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
    object NovachkPorg: TNovaCheckedComboBox
      Left = 80
      Top = 18
      Width = 114
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpBselldate: TDateTimePicker
      Left = 80
      Top = 52
      Width = 114
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 11
      OnChange = dtpBselldateChange
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 80
      Top = 85
      Width = 114
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 12
      OnChange = dtpBdepartdateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 262
      Top = 52
      Width = 126
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 13
      OnChange = dtpEselldateChange
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 262
      Top = 84
      Width = 126
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 14
      OnChange = dtpEdepartdateChange
    end
    object nvcbbPaymethod: TNovaComboBox
      Left = 467
      Top = 118
      Width = 98
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 15
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
    Top = 193
    Width = 1086
    Height = 287
    ExplicitTop = 193
    ExplicitWidth = 1086
    ExplicitHeight = 287
    inherited GroupBox1: TGroupBox
      Width = 1086
      Height = 287
      ExplicitWidth = 1086
      ExplicitHeight = 287
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1082
        Height = 269
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
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 139
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #19978#36710#28857
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36141#31080#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #31080#31181
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutlestname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sellip'
            Footers = <>
            Title.Caption = #21806#31080#30005#33041'IP'
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'islocal'
            Footers = <>
            Title.Caption = #26159#21542#24322#31449#31080
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31449#21153#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31354#35843#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#25187#36153'1'
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#37197#27700#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20445#38505#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20854#20182
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#23567#35745
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #25903#20184#26041#24335
            Width = 69
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
    DataSourceName = 'presellticketmap'
    QueryAddress = 'query/findPresellTicketQry'
    SaveAddress = 'query/findPresellTicketQry'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQS_ts!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
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
        Name = 'filter_EQB_ts!islocalticket'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ts!tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!code'
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
        Name = 'filter_EQS_ts!paymethod'
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
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 30
    end
    object wdstrngfldResultticketstatus: TWideStringField
      FieldName = 'ticketstatus'
      Size = 10
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
    object wdstrngfldResultdepartstationname: TWideStringField
      FieldName = 'departstationname'
      Size = 30
    end
    object wdstrngfldResultreachstationname: TWideStringField
      FieldName = 'reachstationname'
      Size = 30
    end
    object wdstrngfldResultticketoutlestname: TWideStringField
      FieldName = 'ticketoutlestname'
      Size = 30
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object blnfldResultislocal: TBooleanField
      FieldName = 'islocal'
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
    object wdstrngfldResulttickettypename: TWideStringField
      FieldName = 'tickettypename'
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
