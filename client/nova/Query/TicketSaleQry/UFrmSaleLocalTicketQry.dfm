inherited frmSaleLocalTicketQry: TfrmSaleLocalTicketQry
  Caption = #24322#31449#21806#26412#31449#24773#20917
  ClientHeight = 474
  ClientWidth = 1247
  ExplicitWidth = 1263
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1247
    Height = 159
    ExplicitWidth = 1247
    ExplicitHeight = 159
    object lbl3: TLabel
      Left = 427
      Top = 75
      Width = 56
      Height = 14
      Caption = #20195#21806#31449#28857
    end
    object lbl5: TLabel
      Left = 251
      Top = 50
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl9: TLabel
      Left = 612
      Top = 110
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object lbl11: TLabel
      Left = 17
      Top = 49
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl13: TLabel
      Left = 628
      Top = 13
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object lbl7: TLabel
      Left = 17
      Top = 80
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl14: TLabel
      Left = 251
      Top = 80
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 17
      Top = 109
      Width = 56
      Height = 14
      Caption = #36864#31080#26085#26399
    end
    object lbl4: TLabel
      Left = 251
      Top = 110
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl10: TLabel
      Left = 427
      Top = 107
      Width = 56
      Height = 14
      Caption = #36864#31080#31449#28857
    end
    object lbl15: TLabel
      Left = 614
      Top = 76
      Width = 42
      Height = 14
      Caption = #36864#31080#21592
    end
    object lbl6: TLabel
      Left = 416
      Top = 14
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 785
      Top = 46
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object lbl17: TLabel
      Left = 628
      Top = 46
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object Label2: TLabel
      Left = 32
      Top = 16
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object Label4: TLabel
      Left = 799
      Top = 75
      Width = 28
      Height = 14
      Caption = #32447#36335
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 285
      Top = 44
      Width = 129
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 7
      OnChange = dtpEdepartdateChange
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 285
      Top = 10
      Width = 128
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
      Left = 662
      Top = 106
      Width = 104
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 14
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
    object nvcbbticketstatus: TNovaComboBox
      Left = 662
      Top = 10
      Width = 104
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 5
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
    object nvhelpTicketoutlets: TNovaHelp
      Left = 490
      Top = 69
      Width = 104
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
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 180
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 78
      Top = 44
      Width = 116
      Height = 22
      BiDiMode = bdLeftToRight
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      ParentBiDiMode = False
      TabOrder = 6
      OnChange = dtpBdepartdateChange
    end
    object dtpBselldate: TDateTimePicker
      Left = 78
      Top = 75
      Width = 116
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 2
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 285
      Top = 75
      Width = 129
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 3
      OnChange = dtpEselldateChange
    end
    object dtpBreturnDate: TDateTimePicker
      Left = 78
      Top = 106
      Width = 116
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 10
      OnChange = dtpBreturnDateChange
    end
    object dtpEreturnDate: TDateTimePicker
      Left = 285
      Top = 106
      Width = 129
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 11
      OnChange = dtpEreturnDateChange
    end
    object nvhelpReturnby: TNovaHelp
      Left = 662
      Top = 72
      Width = 104
      Height = 22
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
      HelpOptions.HelpWidth = 140
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
      Left = 490
      Top = 103
      Width = 105
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
          Width = 90
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
      HelpOptions.HelpWidth = 190
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbSchOrgs: TNovaCheckedComboBox
      Left = 480
      Top = 10
      Width = 130
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhlpstartstation: TNovaHelp
      Left = 833
      Top = 41
      Width = 104
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 13
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
    object edtTicketno: TNovaEdit
      Left = 662
      Top = 41
      Width = 106
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
    object NovachkPorg: TNovaCheckedComboBox
      Left = 78
      Top = 10
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
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
      Left = 833
      Top = 72
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 16
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
    object ChkAllOrg: TCheckBox
      Left = 210
      Top = 13
      Width = 72
      Height = 17
      Caption = #20195#21806#26426#26500
      TabOrder = 17
      OnClick = ChkAllOrgClick
    end
    object CheckBox1: TCheckBox
      Left = 433
      Top = 46
      Width = 153
      Height = 17
      Caption = #20351#29992#28151#26816#21069#21457#36710#26085#26399
      TabOrder = 18
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1247
    ExplicitWidth = 1247
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
    Top = 204
    Width = 1247
    Height = 270
    ExplicitTop = 204
    ExplicitWidth = 1247
    ExplicitHeight = 270
    inherited GroupBox1: TGroupBox
      Width = 1247
      Height = 270
      ExplicitWidth = 1247
      ExplicitHeight = 270
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1243
        Height = 252
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
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'currorgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #34987#21806#26426#26500
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            ReadOnly = False
            Title.Caption = #35746#21333#21495
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 151
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32447#36335
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #37324#31243
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36141#31080#20215
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #36710#31080#31867#22411
            Width = 75
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
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'istaked'
            Footers = <>
            Title.Caption = #26159#21542#24050#21462#31080
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'taketime'
            Footers = <>
            Title.Caption = #21462#31080#26102#38388
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'sellwayname'
            Footers = <>
            ReadOnly = False
            Title.Caption = #21806#31080#36884#24452
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #25903#20184#26041#24335
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'checkedname'
            Footers = <>
            Title.Caption = #26816#31080#20154
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'tickettype'
            Footers = <>
            Title.Caption = #31080#31181
            Visible = False
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #21457#36710#20301
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'agentname'
            Footers = <>
            Title.Caption = #20195#21806#28857
            Visible = False
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31449#21153#36153
            Width = 53
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
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20445#38505#36153
            Width = 54
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
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20854#20182
            Width = 45
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
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'sellip'
            Footers = <>
            Title.Caption = #21806#31080#30005#33041'IP'
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            Title.Caption = #26159#21542#24050#26816
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #26159#21542#27969#27700#29677
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            Title.Caption = #21457#29677
            Width = 35
          end
          item
            EditButtons = <>
            FieldName = 'checkstationname'
            Footers = <>
            Title.Caption = #26816#31080#28857
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'checktime'
            Footers = <>
            Title.Caption = #26816#31080#26102#38388
            Width = 154
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatus'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Visible = False
            Width = 80
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
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'returnbyname'
            Footers = <>
            Title.Caption = #36864#31080#21592
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'returntime'
            Footers = <>
            Title.Caption = #36864#31080#26102#38388
            Width = 99
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
            FieldName = 'returnsationname'
            Footers = <>
            Title.Caption = #36864#31080#31449#28857
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'olddepartdate'
            Footers = <>
            Title.Caption = #28151#26816#21069#26085#26399
            Width = 75
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
    QueryAddress = 'query/queryFocusSellLocakQry'
    SaveAddress = 'query/findSellLocakTicketQry'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_ts!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ts!ticketstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!reachstationid'
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
        Name = 'filter_EQL_tr!ticketoutletsid'
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
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_scheduleorg!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sd!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ts!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.isolddate'
        ParamType = ptInput
      end
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
        Name = 'filter_GED_ts!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!departdate'
        ParamType = ptInput
      end>
    Left = 248
    Top = 336
    object wdstrngfldResultsellip: TWideStringField
      FieldName = 'sellip'
      Size = 60
    end
    object dtmfldResultselltime: TDateTimeField
      FieldName = 'selltime'
    end
    object wdstrngfldResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 40
    end
    object fltfldResultprice: TFloatField
      FieldName = 'price'
    end
    object fltfldResultfullprice1: TFloatField
      FieldName = 'fullprice'
    end
    object lrgntfldResultdistance1: TLargeintField
      FieldName = 'distance'
    end
    object blnfldResultislinework1: TBooleanField
      FieldName = 'islinework'
    end
    object wdstrngfldResultticketentrance1: TWideStringField
      FieldName = 'ticketentrance'
      Size = 30
    end
    object dtfldResultdepartdate1: TDateField
      FieldName = 'departdate'
    end
    object intgrfldResultseatno1: TIntegerField
      FieldName = 'seatno'
    end
    object wdstrngfldResultticketno1: TWideStringField
      FieldName = 'ticketno'
      Size = 30
    end
    object wdstrngfldResultticketstatus1: TWideStringField
      FieldName = 'ticketstatus'
    end
    object wdstrngfldResulttickettype: TWideStringField
      FieldName = 'tickettype'
    end
    object fltfldResultstationservicefee1: TFloatField
      FieldName = 'stationservicefee'
    end
    object blnfldResultischecked1: TBooleanField
      FieldName = 'ischecked'
    end
    object dtmfldResultchecktime1: TDateTimeField
      FieldName = 'checktime'
    end
    object wdstrngfldResultcheckedname1: TWideStringField
      FieldName = 'checkedname'
      Size = 30
    end
    object wdstrngfldResultcheckstationname1: TWideStringField
      FieldName = 'checkstationname'
      Size = 30
    end
    object wdstrngfldResultsellname1: TWideStringField
      FieldName = 'sellname'
      Size = 30
    end
    object wdstrngfldResultreachstationname: TWideStringField
      FieldName = 'reachstationname'
      Size = 30
    end
    object wdstrngfldResultdepartstationname: TWideStringField
      FieldName = 'departstationname'
      Size = 30
    end
    object wdstrngfldResultschedulecode1: TWideStringField
      FieldName = 'schedulecode'
      Size = 40
    end
    object wdstrngfldResulttickettypename1: TWideStringField
      FieldName = 'tickettypename'
      Size = 30
    end
    object wdstrngfldResultagentname: TWideStringField
      FieldName = 'agentname'
      Size = 30
    end
    object fltfldResultcharges: TFloatField
      FieldName = 'charges'
    end
    object wdstrngfldResultreturnip: TWideStringField
      FieldName = 'returnip'
      Size = 50
    end
    object wdstrngfldResultticketoutletname1: TWideStringField
      FieldName = 'ticketoutletname'
      Size = 30
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
    object wdstrngfldResultvehicletypename1: TWideStringField
      FieldName = 'vehicletypename'
      Size = 30
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 40
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
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 30
    end
    object blnfldResultisdepartinvoices: TBooleanField
      FieldName = 'isdepartinvoices'
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
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
    end
    object jcdsResultcurrorgname: TWideStringField
      FieldName = 'currorgname'
      Size = 100
    end
    object jcdsResultorderno: TWideStringField
      FieldName = 'orderno'
      Size = 100
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
    object jcdsResultistaked: TWideStringField
      FieldName = 'istaked'
      Size = 100
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
    object jcdsResulttaketime: TWideStringField
      FieldName = 'taketime'
      Size = 100
    end
    object jcdsResultolddepartdate: TDateField
      FieldName = 'olddepartdate'
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
    Left = 616
    Top = 344
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
    Left = 712
    Top = 352
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
    Left = 776
    Top = 304
  end
end
