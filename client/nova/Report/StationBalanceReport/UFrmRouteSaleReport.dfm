inherited FrmRouteSaleReport: TFrmRouteSaleReport
  Caption = #32447#36335#21806#31080#32479#35745#34920
  ClientHeight = 448
  ClientWidth = 1241
  OnShow = FormShow
  ExplicitWidth = 1257
  ExplicitHeight = 486
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1241
    Height = 110
    ExplicitWidth = 1241
    ExplicitHeight = 110
    object Label10: TLabel
      Left = 22
      Top = 18
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
    object Label1: TLabel
      Left = 617
      Top = 18
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object Label2: TLabel
      Left = 913
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl4: TLabel
      Left = 133
      Top = 86
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lblRun: TLabel
      Left = 326
      Top = 18
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object lblworkways: TLabel
      Left = 1012
      Top = 51
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object lblstation: TLabel
      Left = 439
      Top = 51
      Width = 42
      Height = 14
      Caption = #20572#38752#28857
    end
    object lblroute: TLabel
      Left = 145
      Top = 51
      Width = 28
      Height = 14
      Caption = #32447#36335
    end
    object lblcode: TLabel
      Left = 717
      Top = 51
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label3: TLabel
      Left = 439
      Top = 88
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object dtpstartdate: TDateTimePicker
      Left = 687
      Top = 15
      Width = 196
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 2
    end
    object dtpenddate: TDateTimePicker
      Left = 985
      Top = 15
      Width = 200
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 3
    end
    object NovaChkSaleOrg: TNovaCheckedComboBox
      Left = 111
      Top = 15
      Width = 180
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object chkgroup: TCheckBox
      Left = 22
      Top = 83
      Width = 105
      Height = 17
      Caption = #25353#21806#31080#21592#20998#32452
      TabOrder = 12
      OnClick = chkgroupClick
    end
    object nvhlpseller: TNovaHelp
      Left = 181
      Top = 82
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 30
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
          FieldName = 'code'
          Title.Caption = #29992#25143#21517
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 80
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
    object chkStation: TCheckBox
      Left = 326
      Top = 49
      Width = 108
      Height = 17
      Caption = #25353#20572#38752#28857#20998#32452
      TabOrder = 6
      OnClick = chkStationClick
    end
    object chkRoute: TCheckBox
      Left = 22
      Top = 48
      Width = 92
      Height = 17
      Caption = #25353#32447#36335#20998#32452
      TabOrder = 4
      OnClick = chkRouteClick
    end
    object nvcbbType: TNovaCheckedComboBox
      Left = 396
      Top = 15
      Width = 198
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
    object chkworkways: TCheckBox
      Left = 892
      Top = 50
      Width = 116
      Height = 17
      Caption = #25353#33829#36816#26041#24335#20998#32452
      Checked = True
      State = cbChecked
      TabOrder = 10
      OnClick = chkworkwaysClick
    end
    object nvcbbworkways: TNovaCheckedComboBox
      Left = 1075
      Top = 47
      Width = 110
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
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
          Value = 'schedule'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'workways'
        end>
    end
    object nvhelpstation: TNovaHelp
      Left = 487
      Top = 44
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 15
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
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpRoute: TNovaHelp
      Left = 181
      Top = 47
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object chkCode: TCheckBox
      Left = 617
      Top = 49
      Width = 87
      Height = 17
      Caption = #25353#29677#27425#20998#32452
      TabOrder = 8
      OnClick = chkCodeClick
    end
    object nvhlpschedule: TNovaHelp
      Left = 765
      Top = 47
      Width = 118
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
    object CheckBox1: TCheckBox
      Left = 326
      Top = 86
      Width = 105
      Height = 17
      Caption = #25353#21806#31080#28857#20998#32452
      TabOrder = 14
      OnClick = CheckBox1Click
    end
    object nvhlpTicketoutlets: TNovaHelp
      Left = 487
      Top = 82
      Width = 107
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1241
    ExplicitWidth = 1241
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
  end
  inherited Panel1: TPanel
    Top = 155
    Width = 1241
    Height = 293
    ExplicitTop = 155
    ExplicitWidth = 1241
    ExplicitHeight = 293
    inherited GroupBox1: TGroupBox
      Width = 1241
      Height = 293
      ExplicitWidth = 1241
      ExplicitHeight = 293
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1237
        Height = 275
        FooterRowCount = 1
        Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghExtendVertLines]
        SumList.Active = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 124
          end
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footers = <>
            Title.Caption = #20572#38752#31449#28857
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletsname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'workwaysname'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#20840#31080'||'#24352#25968
            Visible = False
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'ticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#20840#31080'||'#37329#39069
            Visible = False
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'halfticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#21322#31080'||'#24352#25968
            Visible = False
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'halfticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#21322#31080'||'#37329#39069
            Visible = False
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'studentticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#23398#29983#31080'||'#24352#25968
            Visible = False
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'studentticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#23398#29983#31080'||'#37329#39069
            Visible = False
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'discountticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#25171#25240#31080'||'#24352#25968
            Visible = False
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'discountticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080'||'#25171#25240#31080'||'#37329#39069
            Visible = False
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'totalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totalprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080'||'#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080'||'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returncharges'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080'||'#25163#32493#36153
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080'||'#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'cancelprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080'||'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'changenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25913#31614'||'#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'changeservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25913#31614'||'#25163#32493#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totalpersonnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#20154#25968
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'factpeoplenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#21457#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'nonfactpeoplenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28431#20056#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'xianjinprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069'||'#29616#37329
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'netprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069'||'#32593#38134
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totalpeopleprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069'||'#24635#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24494#26426#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31354#35843#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38468#21152#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37197#27700#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'incomeprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'revenueprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#33829#25910
            Visible = False
            Width = 100
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 312
    Top = 256
  end
  inherited ilToolBarDisable: TImageList
    Left = 456
    Top = 272
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryRouteIncome'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'issellgroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seller'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isstationgroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isroutegroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isworkwaysgroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'iscodegroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isticketoutletsgroup'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    Left = 256
    Top = 320
  end
  inherited dsResult: TDataSource
    Left = 136
    Top = 248
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 328
  end
end
