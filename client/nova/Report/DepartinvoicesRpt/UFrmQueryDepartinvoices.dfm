inherited frmQueryDepartinvoices: TfrmQueryDepartinvoices
  Caption = #29677#27425#32467#31639#24773#20917#26597#35810
  ClientHeight = 662
  ClientWidth = 1284
  ExplicitLeft = -311
  ExplicitWidth = 1300
  ExplicitHeight = 701
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1284
    Height = 125
    ExplicitWidth = 1284
    ExplicitHeight = 125
    object lbl1: TLabel
      Left = 18
      Top = 15
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl11: TLabel
      Left = 228
      Top = 15
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 486
      Top = 15
      Width = 14
      Height = 14
      Caption = #33267
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 242
      Top = 46
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 228
      Top = 76
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object lbl4: TLabel
      Left = 18
      Top = 46
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 444
      Top = 76
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label4: TLabel
      Left = 656
      Top = 15
      Width = 56
      Height = 14
      Caption = #32467#31639#29366#24577
    end
    object Label9: TLabel
      Left = 670
      Top = 46
      Width = 42
      Height = 14
      Caption = #25171#21333#21592
    end
    object Label1: TLabel
      Left = 961
      Top = 76
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
      Visible = False
    end
    object lbl7: TLabel
      Left = 444
      Top = 46
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object lbl8: TLabel
      Left = 18
      Top = 76
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object Label2: TLabel
      Left = 9
      Top = 103
      Width = 70
      Height = 14
      Caption = #24320#36816#37327#21333#20301
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 226
      Top = 103
      Width = 56
      Height = 14
      Caption = #25171#21333#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 484
      Top = 103
      Width = 14
      Height = 14
      Caption = #33267
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 81
      Top = 12
      Width = 125
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 290
      Top = 12
      Width = 133
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      Checked = False
      TabOrder = 1
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 508
      Top = 12
      Width = 133
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      TabOrder = 2
    end
    object nvhelpUnit: TNovaHelp
      Left = 290
      Top = 71
      Width = 133
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 170
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpVehicle: TNovaHelp
      Left = 508
      Top = 74
      Width = 133
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          Title.Caption = #36710#29260#21495#30721
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = 'IC'#21345#21495
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
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbStatus: TNovaComboBox
      Left = 718
      Top = 12
      Width = 83
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
      HelpOptions.TableName = 'departinvoices'
      HelpOptions.Columnname = 'status'
      HelpOptions.DisAll = True
    end
    object nvcbbScheduletype: TNovaComboBox
      Left = 1055
      Top = 68
      Width = 125
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 11
      Visible = False
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
      HelpOptions.DisAll = True
    end
    object nvhelpUserid: TNovaHelp
      Left = 718
      Top = 43
      Width = 83
      Height = 22
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
    object nvedtTicketno: TNovaEdit
      Left = 508
      Top = 43
      Width = 133
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
    object nvhlpBalanceunit: TNovaHelp
      Left = 81
      Top = 75
      Width = 125
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 170
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlproute: TNovaHelp
      Left = 81
      Top = 43
      Width = 125
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
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 55
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpschedule: TNovaHelp
      Left = 290
      Top = 43
      Width = 133
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
    object cbbdepart: TNovaCheckedComboBox
      Left = 81
      Top = 103
      Width = 125
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object DtpPrintstartdate: TDateTimePicker
      Left = 290
      Top = 101
      Width = 133
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      ShowCheckbox = True
      TabOrder = 13
      OnClick = DtpPrintstartdateClick
    end
    object DtpPrintenddate: TDateTimePicker
      Left = 508
      Top = 101
      Width = 133
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 14
      OnChange = DtpPrintenddateChange
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1284
    ButtonWidth = 77
    ExplicitWidth = 1284
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 77
    end
    inherited tbtn1: TToolButton
      Left = 77
      ExplicitLeft = 77
    end
    inherited tbtnInsert: TToolButton
      Left = 85
      Visible = False
      ExplicitLeft = 85
      ExplicitWidth = 77
    end
    inherited tbtnEdit: TToolButton
      Left = 162
      Visible = False
      ExplicitLeft = 162
      ExplicitWidth = 77
    end
    inherited tbtnDelete: TToolButton
      Left = 239
      Visible = False
      ExplicitLeft = 239
      ExplicitWidth = 77
    end
    inherited ToolButton50: TToolButton
      Left = 316
      Caption = #36816#37327#21333#26126#32454
      ImageIndex = 34
      Visible = True
      OnClick = ToolButton50Click
      ExplicitLeft = 316
      ExplicitWidth = 81
    end
    inherited ToolButton51: TToolButton
      Left = 397
      ExplicitLeft = 397
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 415
      Visible = False
      ExplicitLeft = 415
    end
    inherited tbtnSave: TToolButton
      Left = 423
      Visible = False
      ExplicitLeft = 423
      ExplicitWidth = 77
    end
    inherited tbtnCancel: TToolButton
      Left = 500
      Visible = False
      ExplicitLeft = 500
      ExplicitWidth = 77
    end
    inherited ToolButton52: TToolButton
      Left = 577
      ExplicitLeft = 577
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 595
      ExplicitLeft = 595
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 613
      Visible = False
      ExplicitLeft = 613
    end
    inherited tbtnInfo: TToolButton
      Left = 621
      Visible = False
      ExplicitLeft = 621
      ExplicitWidth = 77
    end
    inherited tbtn5: TToolButton
      Left = 698
      Visible = False
      ExplicitLeft = 698
    end
    inherited tbtnExcel: TToolButton
      Left = 706
      ExplicitLeft = 706
      ExplicitWidth = 77
    end
    inherited tbtnPrinter: TToolButton
      Left = 783
      ExplicitLeft = 783
      ExplicitWidth = 77
    end
    inherited tbtn6: TToolButton
      Left = 860
      ExplicitLeft = 860
    end
    inherited tbtnClose: TToolButton
      Left = 868
      ExplicitLeft = 868
      ExplicitWidth = 77
    end
  end
  inherited Panel1: TPanel
    Top = 170
    Width = 1284
    Height = 492
    ExplicitTop = 170
    ExplicitWidth = 1284
    ExplicitHeight = 492
    inherited GroupBox1: TGroupBox
      Width = 1284
      Height = 256
      ExplicitWidth = 1284
      ExplicitHeight = 256
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1280
        Height = 238
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32467#31639#21333#21495
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29366#24577
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'balanceunitname'
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 159
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 94
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
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#31080#20215
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20215#24046
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#38468#21152#36153
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'othterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#25187#36153
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20056#23458#24231#20301#25968
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26816#31080#25968
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'supplyticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34917#24405#31080#25968
            Visible = False
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'supplyamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34917#24405#31080#20215#24635#39069
            Visible = False
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'supplybalanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34917#24405#32467#31639#37329#39069
            Visible = False
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #29677#27425#31867#21035
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #33829#36816#36710#36742
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'vehicletypname'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'printip'
            Footers = <>
            Title.Caption = #24320#21333#26426#26500'IP'
            Width = 119
          end
          item
            EditButtons = <>
            FieldName = 'printbyname'
            Footers = <>
            Title.Caption = #25171#21333#21592
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'printtime'
            Footers = <>
            Title.Caption = #24320#21333#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'd1name'
            Footers = <>
            Title.Caption = #39550#39542#21592'1'
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'd2name'
            Footers = <>
            Title.Caption = #39550#39542#21592'2'
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'd3name'
            Footers = <>
            Title.Caption = #39550#39542#21592'3'
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'd4name'
            Footers = <>
            Title.Caption = #39550#39542#21592'4'
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 's1name'
            Footers = <>
            Title.Caption = #20056#21153#21592'1'
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 's2name'
            Footers = <>
            Title.Caption = #20056#21153#21592'2'
            Width = 63
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object pnl1: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object grp1: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 0
              Align = alClient
              Caption = #26597#35810#32467#26524
              TabOrder = 0
              object nvdbgrdh1: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 1295
                Height = 229
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsResult
                Flat = False
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -14
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                ImeMode = imDisable
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                ExpOpenType = AutoOpen
                AutoSetMultiSelect = False
                AutoSetCtrlKey = False
                PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
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
                jsonConnection = DMPublic.jcon
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'orgname'
                    Footers = <>
                    Title.Caption = #26426#26500
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'routename'
                    Footers = <>
                    Title.Caption = #33829#36816#32447#36335
                    Width = 95
                  end
                  item
                    EditButtons = <>
                    FieldName = 'status'
                    Footers = <>
                    Visible = False
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unitname'
                    Footers = <>
                    Title.Caption = #33829#36816#21333#20301
                    Width = 97
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicletypename'
                    Footers = <>
                    Title.Caption = #36710#22411
                    Width = 112
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seatnum'
                    Footers = <>
                    Title.Caption = #24231#20301#25968
                    Width = 53
                  end
                  item
                    EditButtons = <>
                    FieldName = 'soldeatnum'
                    Footers = <>
                    Title.Caption = #24050#21806
                    Width = 42
                  end
                  item
                    EditButtons = <>
                    FieldName = 'distance'
                    Footers = <>
                    Title.Caption = #20844#37324#25968
                    Width = 98
                  end
                  item
                    EditButtons = <>
                    FieldName = 'autocancelreserveseatnum'
                    Footers = <>
                    Title.Caption = #33258#21160#21462#28040#30041#20301#25968
                    Width = 110
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unautocancelreserveseatnum'
                    Footers = <>
                    Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
                    Width = 124
                  end
                  item
                    EditButtons = <>
                    FieldName = 'runtime'
                    Footers = <>
                    Title.Caption = #36816#34892#26102#38388
                    Width = 61
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departdate'
                    Footers = <>
                    Title.Caption = #21457#36710#26085#26399
                    Width = 83
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departtime'
                    Footers = <>
                    Title.Caption = #21457#36710#26102#38388
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'highdistance'
                    Footers = <>
                    Title.Caption = #39640#36895#37324#31243
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isovertime'
                    Footers = <>
                    Title.Caption = #26159#21542#21152#29677
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'islinework'
                    Footers = <>
                    Title.Caption = #26159#21542#27969#27700#29677
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'worktype'
                    Footers = <>
                    Title.Caption = #33829#36816#31867#21035
                    Width = 65
                  end
                  item
                    EditButtons = <>
                    FieldName = 'workways'
                    Footers = <>
                    Width = 81
                  end
                  item
                    EditButtons = <>
                    FieldName = 'districttype'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isproprietary'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issellreturnticket'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'endtime'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isoriginator'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issaleafterrepor'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'iscanmixcheck'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'statusname'
                    Footers = <>
                    Title.Caption = #29677#27425#29366#24577
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
          end
        end
      end
    end
    object grp3: TGroupBox
      Left = 0
      Top = 256
      Width = 1284
      Height = 236
      Align = alBottom
      TabOrder = 1
      object grp2: TGroupBox
        Left = 594
        Top = 16
        Width = 688
        Height = 218
        Align = alClient
        Caption = #32467#31639#21333#25187#36153#26126#32454#24773#20917
        TabOrder = 0
        object dbgrdhroutestop: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 684
          Height = 200
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsDeductdetail
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FooterRowCount = 1
          ImeMode = imDisable
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -14
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          ExpOpenType = AutoOpen
          AutoSetMultiSelect = False
          AutoSetCtrlKey = False
          PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
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
          ParentName = 'frmDriver'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'typenme'
              Footer.DisplayFormat = #21512#35745
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #25187#36153#26041#24335
              Width = 71
            end
            item
              EditButtons = <>
              FieldName = 'objectname'
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #25187#36153#23545#35937
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'itemname'
              Footers = <>
              Title.Caption = #25187#36153#39033#30446
              Width = 76
            end
            item
              EditButtons = <>
              FieldName = 'type'
              Footers = <>
              Title.Caption = #25187#36153'/'#20844#24335#31867#22411
              Width = 103
            end
            item
              EditButtons = <>
              FieldName = 'deductmoney'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #37329#39069
              Width = 44
            end
            item
              EditButtons = <>
              FieldName = 'startdate'
              Footers = <>
              Title.Caption = #24320#22987#26085#26399
              Width = 78
            end
            item
              EditButtons = <>
              FieldName = 'enddate'
              Footers = <>
              Title.Caption = #32467#26463#26085#26399
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'unitname'
              Footers = <>
              Title.Caption = #26426#26500
              Width = 74
            end
            item
              EditButtons = <>
              FieldName = 'routename'
              Footers = <>
              Title.Caption = #32447#36335
              Width = 75
            end
            item
              EditButtons = <>
              FieldName = 'scheduename'
              Footers = <>
              Title.Caption = #29677#27425
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'vehicleno'
              Footers = <>
              Title.Caption = #36710#36742
              Width = 73
            end
            item
              EditButtons = <>
              FieldName = 'remarks'
              Footers = <>
              Title.Caption = #22791#27880
              Width = 169
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object grp8: TGroupBox
        Left = 2
        Top = 16
        Width = 592
        Height = 218
        Align = alLeft
        Caption = #32467#31639#21333#26126#32454#24773#20917
        TabOrder = 1
        object nvdbgrdhWork: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 588
          Height = 200
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsDetail
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FooterRowCount = 1
          ImeMode = imDisable
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -14
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          ExpOpenType = AutoOpen
          AutoSetMultiSelect = False
          AutoSetCtrlKey = False
          PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
          ParentName = 'frmDriver'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'fromstaionname'
              Footer.DisplayFormat = #21512#35745
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #19978#36710#31449
              Width = 105
            end
            item
              EditButtons = <>
              FieldName = 'reachstationname'
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #21040#36798#31449
              Width = 92
            end
            item
              EditButtons = <>
              FieldName = 'distance'
              Footers = <>
              Title.Caption = #36317#31163
              Width = 33
            end
            item
              EditButtons = <>
              FieldName = 'tickettypename'
              Footers = <>
              Title.Caption = #36710#31080#31867#22411
              Width = 61
            end
            item
              EditButtons = <>
              FieldName = 'issupply'
              Footers = <>
              Title.Caption = #26159#21542#34917#24405
              Visible = False
              Width = 67
            end
            item
              EditButtons = <>
              FieldName = 'balanceamount'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #32467#31639#37329#39069
              Width = 92
            end
            item
              EditButtons = <>
              FieldName = 'totalamount'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #24635#31080#20215
              Width = 49
            end
            item
              EditButtons = <>
              FieldName = 'price'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #31080#20215
              Width = 39
            end
            item
              EditButtons = <>
              FieldName = 'moreprice'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #20215#24046
              Width = 60
            end
            item
              EditButtons = <>
              FieldName = 'ticketnum'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #26816#31080#25968
              Width = 47
            end
            item
              EditButtons = <>
              FieldName = 'stationservicefee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #31449#21153#36153
            end
            item
              EditButtons = <>
              FieldName = 'othterfee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #20854#20182#25187#36153
              Width = 65
            end
            item
              EditButtons = <>
              FieldName = 'agentfee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #23458#36816#20195#29702#36153
              Width = 81
            end
            item
              EditButtons = <>
              FieldName = 'fueladditionfee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #29123#27833#38468#21152#36153
              Width = 76
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 104
    Top = 248
  end
  inherited ilToolBarDisable: TImageList
    Left = 168
    Top = 248
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/DepartinvoicesStuation'
    SaveAddress = 'query/DepartinvoicesStuation'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ds!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ds!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ds!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ds!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ds!departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u2!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ds!printorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ds!printtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ds!printtime'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 240
    Top = 248
    object lrgntfldResultid: TLargeintField
      FieldName = 'id'
    end
    object wdstrngfldResultdepartstationname: TWideStringField
      FieldName = 'departstationname'
      Size = 50
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 50
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 30
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 30
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 50
    end
    object jcdsResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 50
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 50
    end
    object jcdsResultvehicletypname: TWideStringField
      FieldName = 'vehicletypname'
      Size = 50
    end
    object jcdsResultticketnum: TLargeintField
      FieldName = 'ticketnum'
    end
    object jcdsResulttotalamount: TFloatField
      FieldName = 'totalamount'
    end
    object jcdsResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object jcdsResultprintip: TWideStringField
      FieldName = 'printip'
      Size = 40
    end
    object jcdsResultprintbyname: TWideStringField
      FieldName = 'printbyname'
      Size = 50
    end
    object jcdsResultprinttime: TDateTimeField
      FieldName = 'printtime'
    end
    object jcdsResultsupplyticketnum: TLargeintField
      FieldName = 'supplyticketnum'
    end
    object jcdsResultsupplyamount: TFloatField
      FieldName = 'supplyamount'
    end
    object jcdsResultsupplybalanceamount: TFloatField
      FieldName = 'supplybalanceamount'
    end
    object wdstrngfldResultd1name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'd1name'
      Size = 50
      Calculated = True
    end
    object jcdsResultd2name: TWideStringField
      FieldName = 'd2name'
      Size = 50
    end
    object jcdsResultd3name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'd3name'
      Size = 50
      Calculated = True
    end
    object jcdsResultd4name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'd4name'
      Size = 50
      Calculated = True
    end
    object jcdsResults1name: TWideStringField
      FieldName = 's1name'
      Size = 50
    end
    object jcdsResults2name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 's2name'
      Size = 50
      Calculated = True
    end
    object wdstrngfldResulttype: TWideStringField
      FieldName = 'type'
      Size = 10
    end
    object wdstrngfldResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object wdstrngfldResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
      Size = 50
    end
    object wdstrngfldResultworktypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'worktypename'
      LookupDataSet = jcdsWorktkypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'worktype'
      Size = 30
      Lookup = True
    end
    object wdstrngfldResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdstypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Lookup = True
    end
    object wdstrngfldResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsStatusname
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object lrgntfldResultseatnum: TLargeintField
      FieldName = 'seatnum'
    end
    object fltfldResultfueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object fltfldResultothterfee: TFloatField
      FieldName = 'othterfee'
    end
    object fltfldResultagentfee: TFloatField
      FieldName = 'agentfee'
    end
    object fltfldResultbalanceamount: TFloatField
      FieldName = 'balanceamount'
    end
    object wdstrngfldResultbalanceunitname: TWideStringField
      FieldName = 'balanceunitname'
    end
    object jcdsResultmoreprice: TFloatField
      FieldName = 'moreprice'
    end
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 248
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 328
    Top = 248
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'scheduletype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 512
    Top = 248
  end
  object dsDetail: TDataSource
    DataSet = jcdsDepartinvoicesDetail
    Left = 72
    Top = 512
  end
  object jcdsDepartinvoicesDetail: TjsonClientDataSet
    DataSourceName = 'detailresultmap'
    QueryAddress = 'query/departinvoicesDetailStuation'
    SaveAddress = 'query/departinvoicesDetailStuation'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_dtd!departinvoices.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 160
    Top = 528
  end
  object jcdsWorktkypename: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'worktype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 423
    Top = 248
  end
  object jcdsStatusname: TjsonClientDataSet
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
        Value = 'departinvoices'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 248
  end
  object dsDeductdetail: TDataSource
    DataSet = jcdsDeductdetail
    Left = 768
    Top = 440
  end
  object jcdsDeductdetail: TjsonClientDataSet
    DataSourceName = 'deductdetailresultmap'
    QueryAddress = 'query/queryDeductdetail'
    SaveAddress = 'query/queryDeductdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ds!departinvoices.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 832
    Top = 440
  end
end
