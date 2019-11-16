inherited frmTicketReturnQry: TfrmTicketReturnQry
  Caption = #36864#31080#24773#20917#26597#35810
  ClientHeight = 488
  ClientWidth = 1299
  ExplicitLeft = -414
  ExplicitWidth = 1315
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1299
    Height = 146
    ExplicitWidth = 1299
    ExplicitHeight = 146
    object lbl1: TLabel
      Left = 223
      Top = 12
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 18
      Top = 97
      Width = 56
      Height = 14
      Caption = #36864#31080#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl14: TLabel
      Left = 262
      Top = 97
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
    object lbl11: TLabel
      Left = 18
      Top = 67
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
      Left = 262
      Top = 67
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
      Left = 435
      Top = 67
      Width = 28
      Height = 14
      Caption = #29677#27425
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 644
      Top = 40
      Width = 28
      Height = 14
      Caption = #32456#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 435
      Top = 40
      Width = 28
      Height = 14
      Caption = #36215#28857
    end
    object lbl4: TLabel
      Left = 630
      Top = 67
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl17: TLabel
      Left = 437
      Top = 97
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl2: TLabel
      Left = 630
      Top = 12
      Width = 42
      Height = 14
      Caption = #36864#31080#21592
    end
    object lbl6: TLabel
      Left = 423
      Top = 12
      Width = 42
      Height = 14
      Caption = #36864#31080#28857
    end
    object lbl10: TLabel
      Left = 224
      Top = 40
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
    object Label2: TLabel
      Left = 4
      Top = 12
      Width = 70
      Height = 14
      Caption = #21806#31080#20998#20844#21496
    end
    object Label1: TLabel
      Left = 4
      Top = 40
      Width = 70
      Height = 14
      Caption = #29677#27425#20998#20844#21496
    end
    object Label3: TLabel
      Left = 603
      Top = 97
      Width = 70
      Height = 14
      Caption = #36864#31080#20973#35777#21495
    end
    object Label4: TLabel
      Left = 42
      Top = 126
      Width = 28
      Height = 14
      Caption = #32447#36335
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 286
      Top = 8
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
    object dtpBreservetime: TDateTimePicker
      Left = 81
      Top = 92
      Width = 112
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      TabOrder = 6
      OnChange = dtpBreservetimeChange
    end
    object dtpEreservetime: TDateTimePicker
      Left = 286
      Top = 92
      Width = 111
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      ShowCheckbox = True
      TabOrder = 7
      OnChange = dtpEreservetimeChange
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 81
      Top = 64
      Width = 110
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      Checked = False
      TabOrder = 2
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 286
      Top = 64
      Width = 111
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      Checked = False
      TabOrder = 3
    end
    object nvhelpendstation: TNovaHelp
      Left = 675
      Top = 35
      Width = 113
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 11
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
    object chkIsallreturn: TCheckBox
      Left = 247
      Top = 124
      Width = 78
      Height = 17
      Caption = #20840#39069#36864#31080
      Checked = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 13
    end
    object chkIsnotallreturn: TCheckBox
      Left = 340
      Top = 124
      Width = 77
      Height = 17
      Caption = #24046#39069#36864#31080
      Checked = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 14
    end
    object nvhelpstartstation: TNovaHelp
      Left = 469
      Top = 35
      Width = 127
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
          Title.Caption = #21517#31216
          Width = 90
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
      HelpOptions.HelpWidth = 180
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
      Left = 675
      Top = 61
      Width = 113
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
    object nvedtTicketno: TNovaEdit
      Left = 470
      Top = 92
      Width = 126
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 12
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
    object nvhelpReturnby: TNovaHelp
      Left = 675
      Top = 8
      Width = 113
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
    object chkIsnotlocal: TCheckBox
      Left = 517
      Top = 124
      Width = 67
      Height = 17
      Caption = #24322#31449#31080
      Checked = True
      State = cbChecked
      TabOrder = 16
    end
    object chkIslocal: TCheckBox
      Left = 444
      Top = 124
      Width = 67
      Height = 17
      Caption = #26412#31449#31080
      Checked = True
      State = cbChecked
      TabOrder = 15
    end
    object nvhlpschedule: TNovaHelp
      Left = 469
      Top = 63
      Width = 127
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
    object nvcbbTickeoutlets: TNovaCheckedComboBox
      Left = 470
      Top = 8
      Width = 126
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.HelpType = 'TicketoutletCheckCombox'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbbScheduleorg: TNovaCheckedComboBox
      Left = 286
      Top = 35
      Width = 126
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
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
      Top = 6
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NovaCkSchSubOrg: TNovaCheckedComboBox
      Left = 80
      Top = 35
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      Version = '1.2'
      OnCheckClick = NovaCkSchSubOrgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NvEdtBackno: TNovaEdit
      Left = 675
      Top = 92
      Width = 113
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 19
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
    object nvhelpRoute: TNovaHelp
      Left = 80
      Top = 123
      Width = 143
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 20
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1299
    ExplicitWidth = 1299
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
    Top = 191
    Width = 1299
    Height = 297
    ExplicitTop = 191
    ExplicitWidth = 1299
    ExplicitHeight = 297
    inherited GroupBox1: TGroupBox
      Width = 1299
      Height = 297
      ExplicitWidth = 1299
      ExplicitHeight = 297
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1295
        Height = 279
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
            Width = 106
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32447#36335
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'scheduleorgname'
            Footers = <>
            Title.Caption = #29677#27425#26426#26500
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 71
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
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #22987#21457#31449
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletsname'
            Footers = <>
            Title.Caption = #36864#31080#28857
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'returntime'
            Footers = <>
            Title.Caption = #36864#31080#26102#38388
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'returnamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#37329#39069
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'charges'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25163#32493#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'ticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215
            Width = 40
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
            FieldName = 'returnip'
            Footers = <>
            Title.Caption = #36864#31080#30005#33041'IP'
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'returnwayname'
            Footers = <>
            Title.Caption = #36864#31080#36335#24452
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'returnbyname'
            Footers = <>
            Title.Caption = #36864#31080#20154
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'returnbycode'
            Footers = <>
            Title.Caption = #36864#31080#20154#24037#21495
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'returnvoucherno'
            Footers = <>
            Title.Caption = #36864#31080#20973#35777#21333#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'islocal'
            Footers = <>
            Title.Caption = #26159#21542#26412#31449#31080
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'sellbyname'
            Footers = <>
            Title.Caption = #21806#31080#20154
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31449#21153#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#25187#36153'1'
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31354#35843#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
            Width = 58
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
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#23567#35745
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 151
          end
          item
            EditButtons = <>
            FieldName = 'signcharges'
            Footers = <>
            Title.Caption = #31614#31080#25163#32493#36153
          end
          item
            EditButtons = <>
            FieldName = 'signbyname'
            Footers = <>
            Title.Caption = #31614#31080#22995#21517
          end
          item
            EditButtons = <>
            FieldName = 'signreason'
            Footers = <>
            Title.Caption = #31614#31080#21407#22240
          end
          item
            EditButtons = <>
            FieldName = 'signtime'
            Footers = <>
            Title.Caption = #31614#31080#26102#38388
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
    DataSourceName = 'ticketReturnmap'
    QueryAddress = 'query/findTicketreturntQry'
    SaveAddress = 'query/findTicketreturntQry'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_sellorg!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ts!departdate'
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
        Name = 'filter_EQS_ts!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sellby!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_tr!returnby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_tr!isselfschedule'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_NOEQG_tr!charges'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQG_tr!charges'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_ts!schedulecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_tr!ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_scheduleorg!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_tr!returnvoucherno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulecode'
        ParamType = ptInput
      end>
    Left = 248
    Top = 360
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 368
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 360
  end
  object jcdsReturnwayname: TjsonClientDataSet
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
    Left = 528
    Top = 352
  end
end
