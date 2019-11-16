inherited frmQueryTicketDetail: TfrmQueryTicketDetail
  Caption = #30005#23376#31080#26126#32454#26597#35810
  ClientHeight = 478
  ClientWidth = 1189
  ExplicitWidth = 1205
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1189
    Height = 156
    ExplicitTop = 39
    ExplicitWidth = 1189
    ExplicitHeight = 156
    object lbl2: TLabel
      Left = 617
      Top = 24
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbl3: TLabel
      Left = 418
      Top = 24
      Width = 42
      Height = 14
      Caption = #21462#31080#28857
    end
    object lbl5: TLabel
      Left = 251
      Top = 58
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl8: TLabel
      Left = 421
      Top = 58
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object lbl9: TLabel
      Left = 617
      Top = 58
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object lbl11: TLabel
      Left = 18
      Top = 58
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl1: TLabel
      Left = 212
      Top = 24
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object lbl16: TLabel
      Left = 606
      Top = 95
      Width = 56
      Height = 14
      Caption = #36710#31080#31867#22411
    end
    object lbl17: TLabel
      Left = 432
      Top = 95
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl7: TLabel
      Left = 18
      Top = 95
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl14: TLabel
      Left = 251
      Top = 95
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label2: TLabel
      Left = 32
      Top = 24
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object Label1: TLabel
      Left = 19
      Top = 127
      Width = 56
      Height = 14
      Caption = #21462#31080#26085#26399
    end
    object Label3: TLabel
      Left = 253
      Top = 127
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label4: TLabel
      Left = 406
      Top = 127
      Width = 56
      Height = 14
      Caption = #26412#31449#32447#36335
    end
    object lbl13: TLabel
      Left = 634
      Top = 127
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object Label5: TLabel
      Left = 816
      Top = 24
      Width = 56
      Height = 14
      Caption = #39038#23458#22995#21517
    end
    object Label6: TLabel
      Left = 816
      Top = 56
      Width = 56
      Height = 14
      Caption = #35777#20214#21495#30721
    end
    object Label7: TLabel
      Left = 816
      Top = 92
      Width = 56
      Height = 14
      Caption = #32852#31995#30005#35805
    end
    object lbl4: TLabel
      Left = 830
      Top = 127
      Width = 42
      Height = 14
      Caption = #35746#21333#21495
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 273
      Top = 53
      Width = 112
      Height = 22
      Date = 40413.000000000000000000
      Time = 40413.000000000000000000
      TabOrder = 4
    end
    object nvhelpendstation: TNovaHelp
      Left = 665
      Top = 53
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhcbbTickettype: TNovaHComboBox
      Left = 665
      Top = 89
      Width = 111
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.DisAll = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketTypeHelp'
        end>
    end
    object chkIsnotcheck: TCheckBox
      Left = 1087
      Top = 79
      Width = 47
      Height = 17
      Caption = #26410#26816
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object chkIscheck: TCheckBox
      Left = 1087
      Top = 56
      Width = 50
      Height = 17
      Caption = #24050#26816
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object nvedtTicketno: TNovaEdit
      Left = 468
      Top = 89
      Width = 103
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
    object chkIsovertime: TCheckBox
      Left = 1087
      Top = 125
      Width = 45
      Height = 18
      Caption = #21152#29677
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
    object chkIsnotovertime: TCheckBox
      Left = 1087
      Top = 102
      Width = 48
      Height = 17
      Caption = #27491#29677
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 80
      Top = 53
      Width = 127
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      TabOrder = 3
    end
    object dtpBselldate: TDateTimePicker
      Left = 81
      Top = 89
      Width = 126
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      TabOrder = 1
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 273
      Top = 89
      Width = 112
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      TabOrder = 2
      OnChange = dtpEselldateChange
    end
    object nvhlpschedule: TNovaHelp
      Left = 665
      Top = 18
      Width = 111
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
      Left = 273
      Top = 18
      Width = 112
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
    object nvhlpDeparts: TNovaHelp
      Left = 469
      Top = 53
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
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
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
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
      TabOrder = 14
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhelpRoute: TNovaHelp
      Left = 468
      Top = 124
      Width = 103
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 15
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
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbticketstatus: TNovaComboBox
      Left = 665
      Top = 124
      Width = 112
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 16
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
    object nvedtCustomername: TNovaEdit
      Left = 878
      Top = 18
      Width = 195
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 17
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
    object nvedtCertificateno: TNovaEdit
      Left = 878
      Top = 53
      Width = 195
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 22
      TabOrder = 18
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
    object nvedtmobilephone: TNovaEdit
      Left = 878
      Top = 89
      Width = 195
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 11
      TabOrder = 19
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
    object nvcbborgprint: TNovaCheckedComboBox
      Left = 466
      Top = 18
      Width = 105
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 20
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
    object nvhelpTicketoutlets: TNovaHelp
      Left = 1079
      Top = 18
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 21
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 168
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edt1: TNovaEdit
      Left = 878
      Top = 124
      Width = 195
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 22
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1189
    ExplicitWidth = 1189
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
    Top = 201
    Width = 1189
    Height = 277
    ExplicitTop = 201
    ExplicitWidth = 1189
    ExplicitHeight = 277
    inherited GroupBox1: TGroupBox
      Width = 1189
      Height = 277
      ExplicitWidth = 1189
      ExplicitHeight = 277
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1185
        Height = 259
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
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #31080#21495
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'dpartname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'reachname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Width = 47
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
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#36141#31080#20215
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #36710#31080#31867#22411
            Width = 48
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
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#24494#26426#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31354#35843#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#29123#27833#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#37197#27700#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20445#38505#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20854#20182
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#23567#35745
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'serviceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36141#31080#26381#21153#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #20844#37324#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677#29677#27425
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            Title.Caption = #26159#21542#24050#26816#31080
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'istaked'
            Footers = <>
            Title.Caption = #26159#21542#24050#21462#31080
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            Title.Caption = #39038#23458#22995#21517
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypevalue'
            Footers = <>
            Title.Caption = #35777#20214#31867#22411
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #35777#20214#21495#30721
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #32852#31995#30005#35805
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'email'
            Footers = <>
            Title.Caption = 'Email'
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'taketime'
            Footers = <>
            Title.Caption = #21462#31080#26102#38388
          end
          item
            EditButtons = <>
            FieldName = 'lastbuytickettime'
            Footers = <>
            Title.Caption = #26368#21518#19968#27425#36141#31080#26102#38388
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'carrychildnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24102#20799#31461#25968
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'printorgname'
            Footers = <>
            Title.Caption = #21462#31080#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'printname'
            Footers = <>
            Title.Caption = #21462#31080#25171#21360#20154
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            Title.Caption = #26159#21542#24050#24320#36816#37327#21333
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesbyname'
            Footers = <>
            Title.Caption = #24320#20855#36816#37327#21333#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicestime'
            Footers = <>
            Title.Caption = #24320#36816#37327#21333#26102#38388
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footers = <>
            Title.Caption = #36816#37327#21333#21495
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            Title.Caption = #35746#21333#21495
            Width = 118
          end>
      end
    end
  end
  object dtpBtaketime: TDateTimePicker [3]
    Left = 81
    Top = 169
    Width = 126
    Height = 22
    Date = 40544.000000000000000000
    Time = 40544.000000000000000000
    ShowCheckbox = True
    TabOrder = 3
    OnChange = dtpBtaketimeChange
  end
  object dtpEtaketime: TDateTimePicker [4]
    Left = 273
    Top = 169
    Width = 112
    Height = 22
    Date = 40544.999988425930000000
    Time = 40544.999988425930000000
    ShowCheckbox = True
    TabOrder = 4
    OnChange = dtpEtaketimeChange
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
    DataSourceName = 'tickedetailmap'
    QueryAddress = 'query/queryTicketDetail'
    SaveAddress = 'query/findticketSellQry'
    Params = <
      item
        DataType = ftString
        Name = 'qp.departSdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.departEdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellSdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellEdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.schcode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.returnby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ticketstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellway'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.paymethod'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ischecked'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.islocalticket'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.saleorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.taketimeSdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.taketimeEdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.customername'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.mobilephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.printorgids'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'qp.orderno'
        ParamType = ptInput
      end>
    Left = 248
    Top = 312
    object wdstrngfldResultdpartname: TWideStringField
      FieldName = 'dpartname'
    end
    object wdstrngfldResultreachname: TWideStringField
      FieldName = 'reachname'
    end
    object wdstrngfldResultsellname: TWideStringField
      FieldName = 'sellname'
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 30
    end
    object blnfldResultischecked: TBooleanField
      FieldName = 'ischecked'
    end
    object blnfldResultisdepartinvoices: TBooleanField
      FieldName = 'isdepartinvoices'
    end
    object blnfldResultislocal: TBooleanField
      FieldName = 'islocal'
    end
    object wdstrngfldResultpaymethod: TWideStringField
      FieldName = 'paymethod'
      Size = 10
    end
    object wdstrngfldResultpaymethodname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodname'
      LookupDataSet = jcdsPaymethod
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'paymethod'
      Size = 40
      Lookup = True
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
    object wdstrngfldResultsellway: TWideStringField
      FieldName = 'sellway'
      Size = 10
    end
    object wdstrngfldResultsellwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'sellwayname'
      LookupDataSet = jcdsSellway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'sellway'
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
    object blnfldResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object intgrfldResultcarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object lrgntfldResultdistance: TLargeintField
      FieldName = 'distance'
    end
    object fltfldResultfullprice: TFloatField
      FieldName = 'fullprice'
    end
    object fltfldResultfueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object fltfldResultprice: TFloatField
      FieldName = 'price'
    end
    object wdstrngfldResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 60
    end
    object wdstrngfldResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 60
    end
    object wdstrngfldResultticketoutletname: TWideStringField
      FieldName = 'ticketoutletname'
    end
    object wdstrngfldResultsellip: TWideStringField
      FieldName = 'sellip'
      Size = 40
    end
    object wdstrngfldResultcustomername: TWideStringField
      FieldName = 'customername'
      Size = 30
    end
    object wdstrngfldResulthticketoutlesname: TWideStringField
      FieldName = 'hticketoutlesname'
      Size = 30
    end
    object wdstrngfldResulthoutletsaddress: TWideStringField
      FieldName = 'houtletsaddress'
      Size = 60
    end
    object wdstrngfldResultcheckedname: TWideStringField
      FieldName = 'checkedname'
      Size = 40
    end
    object wdstrngfldResultcheckstationname: TWideStringField
      FieldName = 'checkstationname'
      Size = 30
    end
    object wdstrngfldResultdepartinvoicesbyname: TWideStringField
      FieldName = 'departinvoicesbyname'
      Size = 40
    end
    object wdstrngfldResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
      Size = 40
    end
    object fltfldResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsResultvehiclebrandmodelname: TWideStringField
      FieldName = 'vehiclebrandmodelname'
      Size = 30
    end
    object dtmfldResultchecktime: TDateTimeField
      FieldName = 'checktime'
    end
    object wdstrngfldResulttickettypename: TWideStringField
      FieldName = 'tickettypename'
    end
    object dtmfldResultdepartinvoicestime: TDateTimeField
      FieldName = 'departinvoicestime'
    end
    object jcdsResultcomputefee: TFloatField
      FieldName = 'computefee'
    end
    object jcdsResultcoolairfee: TFloatField
      FieldName = 'coolairfee'
    end
    object jcdsResultadditionfee: TFloatField
      FieldName = 'additionfee'
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 60
    end
    object blnfldResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object wdstrngfldResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 30
    end
    object fltfldResultticketprice: TFloatField
      FieldName = 'ticketprice'
    end
    object fltfldResultreturnamount: TFloatField
      FieldName = 'returnamount'
    end
    object wdstrngfldResultreturnbyname: TWideStringField
      FieldName = 'returnbyname'
    end
    object dtmfldResultreturntime: TDateTimeField
      FieldName = 'returntime'
    end
    object wdstrngfldResultreturnway: TWideStringField
      FieldName = 'returnway'
      Size = 10
    end
    object wdstrngfldResultreturnwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'returnwayname'
      LookupDataSet = jcdsReturnway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'returnway'
      Size = 10
      Lookup = True
    end
    object jcdsResultmoreprice: TFloatField
      FieldName = 'moreprice'
    end
    object jcdsResultselltime: TDateTimeField
      FieldName = 'selltime'
    end
    object fltfldResultservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object fltfldResultwaterfee: TFloatField
      FieldName = 'waterfee'
    end
    object fltfldResultinsurefee: TFloatField
      FieldName = 'insurefee'
    end
    object fltfldResultserviceprice: TFloatField
      FieldName = 'serviceprice'
    end
    object fltfldResultsubtotal: TFloatField
      FieldName = 'subtotal'
    end
    object jcdsResultprintorgname: TWideStringField
      FieldName = 'printorgname'
      Size = 50
    end
    object jcdsResultprintname: TWideStringField
      FieldName = 'printname'
    end
    object jcdsResultcertificatetype: TWideStringField
      FieldName = 'certificatetype'
      Size = 0
    end
    object jcdsResultcertificatetypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certificatetypevalue'
      LookupDataSet = jcdsCertificatetype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Size = 80
      Lookup = True
    end
    object jcdsResultcertificateno: TWideStringField
      FieldName = 'certificateno'
      Size = 0
    end
    object jcdsResultmobilephone: TWideStringField
      FieldName = 'mobilephone'
      Size = 0
    end
    object jcdsResultemail: TWideStringField
      FieldName = 'email'
      Size = 0
    end
    object jcdsResultlastbuytickettime: TDateTimeField
      FieldName = 'lastbuytickettime'
    end
    object jcdsResulttaketime: TDateTimeField
      FieldName = 'taketime'
    end
    object jcdsResultistaked: TBooleanField
      FieldName = 'istaked'
    end
    object jcdsResultorderno: TWideStringField
      FieldName = 'orderno'
      Size = 100
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
    Left = 448
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
  object jcdsSellway: TjsonClientDataSet
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
    Left = 616
    Top = 360
  end
  object jcdsReturnway: TjsonClientDataSet
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
    Left = 704
    Top = 360
  end
  object jcdsCertificatetype: TjsonClientDataSet
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
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'certificatetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 808
    Top = 360
  end
end
