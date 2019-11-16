inherited FrmSchPlanManage: TFrmSchPlanManage
  Caption = #32508#21512#35843#24230
  ClientHeight = 421
  ClientWidth = 1165
  OnShow = FormShow
  ExplicitLeft = -297
  ExplicitTop = -38
  ExplicitWidth = 1181
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 114
    Width = 1165
    Height = 123
    ExplicitTop = 114
    ExplicitWidth = 1165
    ExplicitHeight = 123
    object lbldate: TLabel
      Left = 234
      Top = 23
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lblroute: TLabel
      Left = 18
      Top = 61
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lblschedule: TLabel
      Left = 246
      Top = 58
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lblstation: TLabel
      Left = 431
      Top = 93
      Width = 56
      Height = 14
      Caption = #35745#21010#36710#36742
    end
    object lbl1: TLabel
      Left = 466
      Top = 25
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl3: TLabel
      Left = 232
      Top = 96
      Width = 56
      Height = 14
      Caption = #35745#21010#36710#22411
    end
    object Label1: TLabel
      Left = 425
      Top = 59
      Width = 56
      Height = 14
      Caption = #29677#27425#29366#24577
    end
    object Label2: TLabel
      Left = 620
      Top = 94
      Width = 56
      Height = 14
      Caption = #32463#33829#21333#20301
    end
    object lbl6: TLabel
      Left = 19
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lblRun: TLabel
      Left = 620
      Top = 60
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object lbl8: TLabel
      Left = 28
      Top = 96
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object dtpstartdate: TDateTimePicker
      Left = 298
      Top = 20
      Width = 123
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 0
      OnChange = dtpstartdateChange
    end
    object dtpenddate: TDateTimePicker
      Left = 490
      Top = 19
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 1
      OnChange = dtpenddateChange
    end
    object nvhlproute: TNovaHelp
      Left = 81
      Top = 55
      Width = 138
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
      OnIdChange = nvhlprouteIdChange
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
          Title.Caption = #21517#31216
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'endstationcode'
          Title.Caption = #25805#20316#30721
          Width = 120
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 270
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpschedule: TNovaHelp
      Left = 298
      Top = 55
      Width = 123
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
          Title.Caption = #29677#27425
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 70
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
    object nvhlpendstation: TNovaHelp
      Left = 491
      Top = 90
      Width = 110
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'unitname'
          Title.Caption = #36710#23646#21333#20301
          Width = 80
          Visible = True
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
    object nvhlpvehicletype: TNovaHelp
      Left = 298
      Top = 90
      Width = 123
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rationseatnum'
          Title.Caption = #22352#20301#25968
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehicletypeHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object yes: TCheckBox
      Left = 620
      Top = 22
      Width = 60
      Height = 17
      Caption = #21152#29677
      TabOrder = 6
    end
    object no: TCheckBox
      Left = 686
      Top = 22
      Width = 49
      Height = 17
      Caption = #27491#29677
      TabOrder = 7
    end
    object nvhlpunit: TNovaHelp
      Left = 683
      Top = 90
      Width = 110
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
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
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
    object NovaCobbScheduleStatus: TNovaComboBox
      Left = 490
      Top = 55
      Width = 110
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'schedulestatus'
      HelpOptions.Columnname = 'schedulestatus'
      HelpOptions.DisAll = True
    end
    object chkIssaleafterreport: TCheckBox
      Left = 815
      Top = 56
      Width = 97
      Height = 17
      Caption = #25253#21040#21806#31080
      TabOrder = 10
    end
    object NovaHCbbOrg: TNovaHComboBox
      Left = 81
      Top = 19
      Width = 137
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 11
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
      HelpOptions.HDataSourceName = 'list'
      HelpOptions.HQueryAddress = 'dispatch/qryCurOrg'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object ChkIsDepart: TCheckBox
      Left = 749
      Top = 22
      Width = 60
      Height = 17
      Caption = #21457#29677
      TabOrder = 12
    end
    object ChkIsNotDepart: TCheckBox
      Left = 815
      Top = 22
      Width = 60
      Height = 17
      Caption = #26410#21457#29677
      TabOrder = 13
    end
    object nvcbbType: TNovaCheckedComboBox
      Left = 683
      Top = 56
      Width = 110
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
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
          Value = 'route'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'districttype'
        end>
    end
    object ChkFullseats: TCheckBox
      Left = 815
      Top = 91
      Width = 97
      Height = 17
      Caption = #28385#24231#29677#27425
      TabOrder = 15
    end
    object nvhlpDeparts: TNovaHelp
      Left = 81
      Top = 90
      Width = 138
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1165
    Height = 114
    ButtonHeight = 53
    ButtonWidth = 76
    ExplicitWidth = 1165
    ExplicitHeight = 114
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtn1: TToolButton
      Left = 76
      ExplicitLeft = 76
      ExplicitHeight = 53
    end
    inherited tbtnInsert: TToolButton
      Left = 84
      Caption = #30041#20301
      ImageIndex = 43
      OnClick = tbtnInsertClick
      ExplicitLeft = 84
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtnEdit: TToolButton
      Left = 160
      OnClick = tbtnEditClick
      ExplicitLeft = 160
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtnDelete: TToolButton
      Left = 236
      Caption = #31449#28857#31080#20215
      ImageIndex = 15
      OnClick = tbtnDeleteClick
      ExplicitLeft = 236
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited ToolButton50: TToolButton
      Left = 312
      AutoSize = False
      Caption = #21152#29677
      DropdownMenu = PopupMenu1
      ImageIndex = 21
      Style = tbsDropDown
      Visible = True
      ExplicitLeft = 312
      ExplicitWidth = 93
      ExplicitHeight = 53
    end
    inherited ToolButton51: TToolButton
      Left = 405
      AutoSize = False
      Caption = #24231#20301#25968
      ImageIndex = 22
      Visible = True
      OnClick = ToolButton51Click
      ExplicitLeft = 405
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtn3: TToolButton
      Left = 0
      Wrap = True
      ExplicitLeft = 0
      ExplicitHeight = 61
    end
    inherited tbtnSave: TToolButton
      Left = 0
      Top = 61
      Caption = #20572#29677'/'#22797#29677
      ImageIndex = 18
      OnClick = tbtnSaveClick
      ExplicitLeft = 0
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtnCancel: TToolButton
      Left = 76
      Top = 61
      Caption = #27491#24120#21806#31080
      OnClick = tbtnCancelClick
      ExplicitLeft = 76
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited ToolButton52: TToolButton
      Left = 152
      Top = 61
      AutoSize = False
      Caption = #20572#21806
      ImageIndex = 46
      Visible = True
      OnClick = ToolButton52Click
      ExplicitLeft = 152
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited ToolButton53: TToolButton
      Left = 228
      Top = 61
      AutoSize = False
      Caption = #36710#22411
      ImageIndex = 47
      Visible = True
      OnClick = ToolButton53Click
      ExplicitLeft = 228
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtn4: TToolButton
      Left = 304
      Top = 61
      Hint = #28155#21152#20020#26102#20572#38752#31449#28857#21806#31080
      Caption = #20572#38752#28857
      ImageIndex = 44
      Style = tbsButton
      OnClick = tbtn4Click
      ExplicitLeft = 304
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtnInfo: TToolButton
      Left = 380
      Top = 61
      ParentCustomHint = False
      ParentShowHint = False
      Visible = False
      ExplicitLeft = 380
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtn5: TToolButton
      Left = 456
      Top = 61
      Visible = False
      ExplicitLeft = 456
      ExplicitTop = 61
      ExplicitHeight = 53
    end
    inherited tbtnExcel: TToolButton
      Left = 464
      Top = 61
      ExplicitLeft = 464
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtnPrinter: TToolButton
      Left = 540
      Top = 61
      Visible = False
      ExplicitLeft = 540
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    inherited tbtn6: TToolButton
      Left = 616
      Top = 61
      ExplicitLeft = 616
      ExplicitTop = 61
      ExplicitHeight = 53
    end
    inherited tbtnClose: TToolButton
      Left = 624
      Top = 61
      ExplicitLeft = 624
      ExplicitTop = 61
      ExplicitWidth = 76
      ExplicitHeight = 53
    end
    object seatinfo: TToolButton
      Left = 700
      Top = 61
      Caption = #24231#20301#20449#24687
      ImageIndex = 12
      OnClick = seatinfoClick
    end
    object cancleshift: TToolButton
      Left = 776
      Top = 61
      Caption = #21462#28040#24182#29677
      ImageIndex = 3
      OnClick = cancleshiftClick
    end
    object canticketsell: TToolButton
      Left = 852
      Top = 61
      Caption = #24674#22797#21806#31080
      ImageIndex = 14
      OnClick = canticketsellClick
    end
  end
  inherited Panel1: TPanel
    Top = 237
    Width = 1165
    Height = 184
    ExplicitTop = 237
    ExplicitWidth = 1165
    ExplicitHeight = 184
    inherited GroupBox1: TGroupBox
      Width = 1165
      Height = 184
      ExplicitWidth = 1165
      ExplicitHeight = 184
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1161
        Height = 166
        FooterRowCount = 1
        PopupMenu = PopupMenu1
        RowHeight = 28
        SumList.Active = True
        UseMultiTitle = True
        OnGetCellParams = dbgrdhResultGetCellParams
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32447#36335#21517#31216
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'departname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'schedulename'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'vcstatus'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            STFilter.ListSource = dsResult
            Title.Caption = #21457#36710#26102#38388
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'localsell'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24050#21806'|'#24403#21069#31449
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'othersell'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24050#21806'|'#20854#20182#31449
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24050#21806'|'#21512#35745
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'carrychildnum'
            Footers = <>
            Title.Caption = #25658#31461#25968
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'reservenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20313#24231
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'fixedreserveseatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #30041#20301'|'#22266#23450
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'autocancelreserveseatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #30041#20301'|'#33258#21160#21462#28040
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'unautocancelreserveseatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #30041#20301'|'#19981#21462#28040
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #21457#29677
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            STFilter.ListSource = dsResult
            Title.Caption = #21457#29677#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'reportvehicleno'
            Footers = <>
            Title.Caption = #25253#21040#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reporttime'
            Footers = <>
            Title.Caption = #25253#21040#26102#38388
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #35745#21010#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vtname'
            Footers = <>
            Title.Caption = #35745#21010#36710#22411
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schtype'
            Footers = <>
            Title.Caption = #29677#27425#31867#22411
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#22411
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'brandmodelname'
            Footers = <>
            Title.Caption = #36710#36742#21378#29260
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'endroutename'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'begincheck'
            Footers = <>
            Title.Caption = #24320#26816
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'vcworkways'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'isproprietary'
            Footers = <>
            Title.Caption = #26412#31449#19987#33829
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'issaleafterreport'
            Footers = <>
            Title.Caption = #25253#21040#21806#31080
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #21345#20301
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #27969#27700#29677
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'planunit'
            Footers = <>
            Title.Caption = #35745#21010#33829#36816#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #33829#36816#21333#20301
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'viastation'
            Footers = <>
            Title.Caption = #36884#32463#31449#28857
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #29677#27425#22791#27880
            Width = 50
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object GroupBox2: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 0
              Align = alClient
              Caption = #26597#35810#32467#26524
              TabOrder = 0
              object NvDbgridEh1: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 1104
                Height = 324
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsResult
                Flat = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = #23435#20307
                Font.Style = []
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -15
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                ImeMode = imClose
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ParentFont = False
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                RowHeight = 30
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -15
                TitleFont.Name = #23435#20307
                TitleFont.Style = [fsBold]
                UseMultiTitle = True
                OnGetCellParams = dbgrdhResultGetCellParams
                ExpOpenType = AutoOpen
                AutoSetMultiSelect = False
                AutoSetCtrlKey = False
                PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
                PrintInfo.TitleFont.Color = clWindowText
                PrintInfo.TitleFont.Height = -21
                PrintInfo.TitleFont.Name = #23435#20307
                PrintInfo.TitleFont.Style = [fsBold]
                PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
                PrintInfo.GridHeadFont.Color = clWindowText
                PrintInfo.GridHeadFont.Height = -32
                PrintInfo.GridHeadFont.Name = #23435#20307
                PrintInfo.GridHeadFont.Style = [fsBold]
                PrintInfo.TitleNullLine = 0
                PrintInfo.PrintPageFooter = True
                PrintInfo.PrintPrintFooterTime = True
                PrintInfo.PageFooterRight = #21335#20940#31185#25216
                PrintInfo.PageSize.BottomMargin = 1.000000000000000000
                PrintInfo.PageSize.LeftMargin = 1.000000000000000000
                PrintInfo.PageSize.RightMargin = 1.000000000000000000
                PrintInfo.PageSize.TopMargin = 1.000000000000000000
                PrintOptions = [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]
                PrintAutoNewLine = False
                jsonConnection = DMPublic.jcon
                AutoGridAdject = True
                AutoGridSave = True
                AutoAPPPopuMenu = True
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'departdate'
                    Footers = <>
                    Title.Caption = #21457#36710#26085#26399
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'routename'
                    Footer.Value = #21512#35745
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    Title.Caption = #32447#36335
                    Width = 133
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departname'
                    Footer.DisplayFormat = #21512#35745
                    Footer.ValueType = fvtCount
                    Footers = <>
                    Title.Caption = #21457#36710#31449
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'schedulename'
                    Footer.ValueType = fvtCount
                    Footers = <>
                    Title.Caption = #29677#27425
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vcstatus'
                    Footers = <>
                    Title.Caption = #29366#24577
                    Width = 48
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departtime'
                    Footers = <>
                    Title.Caption = #21457#36710#26102#38388
                    Width = 42
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seatnum'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #24635#24231#20301
                    Width = 51
                  end
                  item
                    EditButtons = <>
                    FieldName = 'soldeatnum'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #24050#21806
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'reservenum'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #20313#24231
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'fixedreserveseatnum'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #30041#20301'|'#22266#23450
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'autocancelreserveseatnum'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #30041#20301'|'#33258#21160#21462#28040
                    Width = 47
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unautocancelreserveseatnum'
                    Footer.ValueType = fvtSum
                    Footers = <>
                    Title.Caption = #30041#20301'|'#19981#33258#21160#21462#28040
                    Width = 56
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isovertime'
                    Footers = <>
                    Title.Caption = #21152#29677
                    Width = 42
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issaleafterreport'
                    Footers = <>
                    Title.Caption = #25253#21040#21806#31080
                    Width = 36
                  end
                  item
                    EditButtons = <>
                    FieldName = 'reportvehicleno'
                    Footers = <>
                    Title.Caption = #25253#21040#36710#36742
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'orgname'
                    Footers = <>
                    Title.Caption = #25253#21040#36710#31449
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'reporttime'
                    Footers = <>
                    Title.Caption = #25253#21040#26102#38388
                    Width = 140
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isdeparted'
                    Footers = <>
                    Title.Caption = #21457#29677
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vtname'
                    Footers = <>
                    Title.Caption = #36710#36742#31867#22411
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issellable'
                    Footers = <>
                    Title.Caption = #21806#31080#29366#24577
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'begincheck'
                    Footers = <>
                    Title.Caption = #26816#31080#29366#24577
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ticketentrance'
                    Footers = <>
                    Title.Caption = #26816#31080#21475
                    Width = 55
                  end
                  item
                    EditButtons = <>
                    FieldName = 'buspark'
                    Footers = <>
                    Title.Caption = #19978#36710#20301
                    Width = 57
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicleno'
                    Footers = <>
                    Title.Caption = #35745#21010#36710#36742
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unitname'
                    Footers = <>
                    Title.Caption = #32463#33829#21333#20301
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'soldeatnum'
                    Footers = <>
                    Title.Caption = #26412#31449#24212#19978#36710#20154#25968
                    Width = 72
                  end
                  item
                    EditButtons = <>
                    FieldName = 'endroutename'
                    Footers = <>
                    Title.Caption = #32456#28857#31449
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'islinework'
                    Footers = <>
                    Title.Caption = #27969#27700#29677
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'workways'
                    Footers = <>
                    Title.Caption = #36816#34892#26041#24335
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'driver1'
                    Footers = <>
                    Title.Caption = #27491#39550#39542
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'driver2'
                    Footers = <>
                    Title.Caption = #21103#39550#39542'1'
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'driver3'
                    Footers = <>
                    Title.Caption = #21103#39550#39542'2'
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'startroutename'
                    Footers = <>
                    Title.Caption = #22987#21457#31449
                    Visible = False
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'viastation'
                    Footers = <>
                    Title.Caption = #36884#32463#31449#28857
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'brandmodelname'
                    Footers = <>
                    Title.Caption = #21697#29260#22411#21495
                    Width = 80
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 440
    Top = 312
  end
  inherited ilToolBarDisable: TImageList
    Left = 728
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'statusmap'
    QueryAddress = 'dispatch/qryschedulestatus'
    SaveAddress = 'dispatch/qryschedulestatus'
    Params = <
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sv!planvehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vt!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sv!planunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!issaleafterreport'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vrr!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!isdeparted'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fromdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_s!districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isfullseat'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 112
    Top = 216
    object w: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultautocancelreserveseatnum: TIntegerField
      FieldName = 'autocancelreserveseatnum'
    end
    object jcdsResultunautocancelreserveseatnum: TIntegerField
      FieldName = 'unautocancelreserveseatnum'
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object d: TIntegerField
      FieldName = 'fixedreserveseatnum'
    end
    object jcdsResultsoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsResultissellable: TBooleanField
      FieldName = 'issellable'
    end
    object jcdsResultisproprietary: TBooleanField
      FieldName = 'isproprietary'
    end
    object jcdsResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsResultdepartname: TWideStringField
      FieldName = 'departname'
      Size = 50
    end
    object jcdsResultschedulename: TWideStringField
      FieldName = 'schedulename'
    end
    object jcdsResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 50
    end
    object jcdsResultstartroutename: TWideStringField
      FieldName = 'startroutename'
      Size = 50
    end
    object jcdsResultendroutename: TWideStringField
      FieldName = 'endroutename'
      Size = 50
    end
    object jcdsResultbegincheck: TBooleanField
      FieldName = 'begincheck'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResultreportvehicleno: TWideStringField
      FieldName = 'reportvehicleno'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 30
    end
    object jcdsResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 30
    end
    object jcdsResultviastation: TWideStringField
      FieldName = 'viastation'
      Size = 200
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 40
    end
    object jcdsResultvtname: TWideStringField
      FieldName = 'vtname'
      Size = 30
    end
    object jcdsResultschedulestatusid: TLargeintField
      FieldName = 'schedulestatusid'
    end
    object jcdsResultdepartstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcdsResultvehicletypeid: TLargeintField
      FieldName = 'vehicletypeid'
    end
    object jcdsResultscheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsResultvehiclebrandmodelid: TLargeintField
      FieldName = 'vehiclebrandmodelid'
    end
    object jcdsResultplanvehicleid: TLargeintField
      FieldName = 'planvehicleid'
    end
    object jcdsResultschedulevehiclepeopleplanid: TLargeintField
      FieldName = 'schedulevehiclepeopleplanid'
    end
    object jcdsResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsResultreservenum: TIntegerField
      FieldName = 'reservenum'
    end
    object jcdsResultisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsResultissaleafterreport: TBooleanField
      FieldName = 'issaleafterreport'
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultruntime: TFloatField
      FieldName = 'runtime'
    end
    object jcdsResultvcstatus: TWideStringField
      FieldKind = fkLookup
      FieldName = 'vcstatus'
      LookupDataSet = jcdsScheduleStatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Size = 30
      Lookup = True
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 50
    end
    object jcdsResultreporttime: TDateTimeField
      FieldName = 'reporttime'
    end
    object jcdsResultbrandmodelname: TWideStringField
      FieldName = 'brandmodelname'
    end
    object jcdsResultdistricttype: TWideStringField
      FieldName = 'districttype'
      Size = 10
    end
    object jcdsResultvcworkways: TWideStringField
      FieldKind = fkLookup
      FieldName = 'vcworkways'
      LookupDataSet = jcdsworkways
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'workways'
      Size = 10
      Lookup = True
    end
    object jcdsResultworkways: TWideStringField
      FieldName = 'workways'
      Size = 10
    end
    object jcdsResultothersell: TIntegerField
      FieldName = 'othersell'
    end
    object jcdsResultplanunit: TWideStringField
      FieldName = 'planunit'
      Size = 40
    end
    object jcdsResultcarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object jcdsResultremark: TWideStringField
      FieldName = 'remarks'
      Size = 100
    end
    object jcdsResultschtype: TWideStringField
      FieldName = 'schtype'
    end
    object jcdsResultlocalsell: TIntegerField
      FieldName = 'localsell'
    end
    object jcdsResultplanunitid: TLargeintField
      FieldName = 'planunitid'
    end
    object jcdsResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object jcdsResultstarttime: TWideStringField
      FieldName = 'starttime'
      Size = 5
    end
    object jcdsResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
    end
    object jcdsResultworktypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'worktypename'
      LookupDataSet = jcdsworktypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'worktype'
      Lookup = True
    end
  end
  inherited dsResult: TDataSource
    Left = 152
    Top = 256
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 560
    Top = 216
  end
  object jcdsScheduleStatus: TjsonClientDataSet
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
        Value = 'schedulestatus'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'schedulestatus'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 104
    Top = 320
  end
  object jscdUpdateSale: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/updateIssaleafterreport'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 216
  end
  object jscdAllowTicketsell: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/allowTicketsell'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.scheduleplan.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.createby'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 320
  end
  object jscdStopTicketsell: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/stopTicketsell'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.scheduleplan.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.createby'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 320
  end
  object jcsdallowScheduleplan: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/allowScheduleplan'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.scheduleplan.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.createby'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 536
    Top = 312
  end
  object jcdsworkways: TjsonClientDataSet
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
        Value = 'workways'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 304
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 112
    object N1: TMenuItem
      Caption = #27169#26495#21152#29677
      OnClick = ModelPlus
    end
    object N2: TMenuItem
      Caption = #29677#32447#21152#29677
      OnClick = RoutePlus
    end
  end
  object jsonCancelShift: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/cancleShift'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'schedulename'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'oldscheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 352
  end
  object jsoncheck: TjsonClientDataSet
    DataSourceName = 'statusmap'
    QueryAddress = 'dispatch/checkticketstatus'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 312
    Top = 288
  end
  object jcdscansaleticket: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/cansaleticket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'schedulename'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'oldscheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 872
    Top = 128
  end
  object jcdsworktypename: TjsonClientDataSet
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
    Left = 240
    Top = 200
  end
end
