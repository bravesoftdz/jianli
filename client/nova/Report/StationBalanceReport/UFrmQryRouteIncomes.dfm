inherited FrmQryRouteIncomes: TFrmQryRouteIncomes
  Caption = 'FrmQryRouteIncomes'
  ClientHeight = 417
  ClientWidth = 1221
  OnShow = FormShow
  ExplicitWidth = 1237
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1221
    Height = 100
    ExplicitWidth = 1221
    ExplicitHeight = 100
    object Label2: TLabel
      Left = 15
      Top = 24
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label3: TLabel
      Left = 238
      Top = 24
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 416
      Top = 24
      Width = 28
      Height = 14
      Caption = #32447#36335
    end
    object Label4: TLabel
      Left = 224
      Top = 65
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object Label5: TLabel
      Left = 28
      Top = 65
      Width = 42
      Height = 14
      Caption = #20572#38752#28857
    end
    object dtpstartdate: TDateTimePicker
      Left = 81
      Top = 20
      Width = 121
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 268
      Top = 20
      Width = 121
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 1
    end
    object cbbyroute: TCheckBox
      Left = 588
      Top = 24
      Width = 97
      Height = 17
      Caption = #25353#32447#36335#20998#32452
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbbyschedule: TCheckBox
      Left = 416
      Top = 65
      Width = 97
      Height = 17
      Caption = #25353#29677#27425#20998#32452
      TabOrder = 3
    end
    object cbbyreachstation: TCheckBox
      Left = 588
      Top = 65
      Width = 117
      Height = 17
      Caption = #25353#20572#38752#28857#20998#32452
      TabOrder = 4
    end
    object nvhelpRoute: TNovaHelp
      Left = 450
      Top = 21
      Width = 121
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
    object nvhelpstation: TNovaHelp
      Left = 81
      Top = 63
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 15
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
    object nvhlpschedule: TNovaHelp
      Left = 268
      Top = 63
      Width = 121
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1221
    ExplicitWidth = 1221
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
    Top = 145
    Width = 1221
    Height = 272
    ExplicitTop = 145
    ExplicitWidth = 1221
    ExplicitHeight = 272
    inherited GroupBox1: TGroupBox
      Width = 1221
      Height = 272
      ExplicitWidth = 1221
      ExplicitHeight = 272
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1217
        Height = 254
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'reachname'
            Footers = <>
            Title.Caption = #20572#38752#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schedulename'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'zxzdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#20013#24515#31449'|'#20154#25968
            Width = 80
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'zxzbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#20013#24515#31449'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ctzdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#38271#36884#31449'|'#20154#25968
            Width = 80
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'ctzbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#38271#36884#31449'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'hcdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#28779#36710'|'#20154#25968
            Width = 80
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'hcbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#28779#36710'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totaldepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21512#35745'||'#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totalbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21512#35745'||'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'zwticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36335#37197'|'#20154#25968
            Width = 80
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'zwtotalmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36335#37197'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schedulenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#36710#21512#35745'||'#29677#27425#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'hjdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#36710#21512#35745'||'#20154#25968
            Width = 80
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'hjbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#36710#21512#35745'||'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'nonhjdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26410#36208#21512#35745'||'#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'nonhjbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26410#36208#21512#35745'||'#37329#39069
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 248
  end
  inherited ilToolBarDisable: TImageList
    Left = 256
    Top = 248
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/qryRouteBalanceIncome'
    Params = <
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
        Name = 'isroutegroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isstationgroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isschedulegroup'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stationid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterOpen = jcdsResultAfterOpen
    Left = 368
    Top = 264
  end
  inherited dsResult: TDataSource
    Left = 152
    Top = 256
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 480
    Top = 264
  end
end
