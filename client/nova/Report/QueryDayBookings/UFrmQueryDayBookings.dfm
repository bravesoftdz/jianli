inherited frmQueryDayBookings: TfrmQueryDayBookings
  Caption = #39044#21806#31080#26085#25253#34920
  ClientHeight = 480
  ClientWidth = 1444
  OnShow = FormShow
  ExplicitWidth = 1460
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1444
    Height = 44
    ExplicitWidth = 1444
    ExplicitHeight = 44
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 1444
      Height = 44
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label2: TLabel
        Left = 28
        Top = 19
        Width = 28
        Height = 14
        Caption = #26426#26500
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 223
        Top = 19
        Width = 28
        Height = 14
        Caption = #26085#26399
      end
      object Label4: TLabel
        Left = 1309
        Top = 19
        Width = 14
        Height = 14
        Caption = #33267
        Visible = False
      end
      object Label5: TLabel
        Left = 392
        Top = 19
        Width = 28
        Height = 14
        Caption = #32447#36335
      end
      object lbl3: TLabel
        Left = 576
        Top = 20
        Width = 42
        Height = 14
        Caption = #21806#31080#28857
      end
      object lbl16: TLabel
        Left = 751
        Top = 21
        Width = 70
        Height = 14
        Caption = #21806#31080#28857#31867#22411
      end
      object lbl1: TLabel
        Left = 28
        Top = 19
        Width = 28
        Height = 14
        Caption = #26426#26500
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object nvhelpRoute: TNovaHelp
        Left = 426
        Top = 16
        Width = 127
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 0
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
      object nvhelpTicketoutlets: TNovaHelp
        Left = 624
        Top = 16
        Width = 100
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
      object nvhcbbTickettype: TNovaComboBox
        Left = 827
        Top = 16
        Width = 145
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        MaxLength = 10
        TabOrder = 2
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
        HelpOptions.TableName = 'ticketoutlets'
        HelpOptions.Columnname = 'type'
        HelpOptions.DisAll = True
      end
      object nvckbOrgid: TNovaCheckedComboBox
        Left = 63
        Top = 16
        Width = 138
        Height = 22
        ColorNotFocus = clWhite
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Version = '1.2'
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'datalist'
        HelpOptions.HQueryAddress = 'system/queryhelpcombox'
        HelpOptions.HelpType = 'OrgHelp'
        HelpOptions.SelectAll = True
        Params = <>
      end
      object dtpenddate: TDateTimePicker
        Left = 1329
        Top = 16
        Width = 110
        Height = 22
        Date = 40640.999988425930000000
        Time = 40640.999988425930000000
        TabOrder = 4
        Visible = False
      end
      object dtpstartdate: TDateTimePicker
        Left = 277
        Top = 16
        Width = 110
        Height = 22
        Date = 40640.000000000000000000
        Time = 40640.000000000000000000
        TabOrder = 5
      end
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1444
    ExplicitWidth = 1444
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
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 89
    Width = 1444
    Height = 391
    ExplicitTop = 89
    ExplicitWidth = 1444
    ExplicitHeight = 391
    inherited GroupBox1: TGroupBox
      Width = 1444
      Height = 391
      ExplicitWidth = 1444
      ExplicitHeight = 391
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1440
        Height = 373
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #26426#26500
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.Value = #21512#35745
            Footers = <>
            Title.Caption = #32447#36335
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletsname'
            Footer.Value = #21512#35745
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletstypevalue'
            Footer.Value = #21512#35745
            Footers = <>
            Title.Caption = #21806#31080#28857#31867#22411
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#37327'('#20154#27425')|'#24403#26085#36816#37327
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'backtennum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#37327'('#20154#27425')|'#39044#21806#36816#37327
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'numPercent'
            Footers = <>
            Title.Caption = #23458#36816#37327'('#20154#27425')|'#39044#21806#21344#24403#26085'%'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedayprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33829#25910#37329#39069'('#20803')|'#24403#26085#33829#25910#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'backtenprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33829#25910#37329#39069'('#20803')|'#39044#21806#33829#25910#37329#39069
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'pricePercent'
            Footers = <>
            Title.Caption = #33829#25910#37329#39069'('#20803')|'#39044#21806#21344#24403#26085'%'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|1'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum2'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|2'#22825
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum3'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|3'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum4'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|4'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum5'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|5'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum6'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|6'#22825
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum7'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|7'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum8'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|8'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum9'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|9'#22825
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'samedaynum10'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21518#21313#22825#39044#21806#23458#31080#25968'|10'#22825
            Width = 99
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
    DataSourceName = 'dayBookings'
    QueryAddress = 'query/queryDayBookings'
    DisableStringTrim = True
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_p!startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_c!compSdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_c!compEdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_t!ticketoutletstype'
        ParamType = ptInput
      end>
    Left = 264
    Top = 256
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 0
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 0
    end
    object jcdsResultticketoutletsname: TWideStringField
      FieldName = 'ticketoutletsname'
      Size = 0
    end
    object jcdsResultticketoutletstype: TWideStringField
      FieldName = 'ticketoutletstype'
      Size = 0
    end
    object jcdsResultticketoutletstypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ticketoutletstypevalue'
      LookupDataSet = jcdsticketoutletsvalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'ticketoutletstype'
      Size = 80
      Lookup = True
    end
    object jcdsResultsamedaynum: TFloatField
      FieldName = 'samedaynum'
    end
    object jcdsResultbacktennum: TFloatField
      FieldName = 'backtennum'
    end
    object jcdsResultnumPercent: TWideStringField
      FieldName = 'numPercent'
      Size = 0
    end
    object jcdsResultsamedayprice: TFloatField
      FieldName = 'samedayprice'
    end
    object jcdsResultbacktenprice: TFloatField
      FieldName = 'backtenprice'
    end
    object jcdsResultpricePercent: TWideStringField
      FieldName = 'pricePercent'
      Size = 0
    end
    object jcdsResultsamedaynum1: TFloatField
      FieldName = 'samedaynum1'
    end
    object jcdsResultsamedaynum2: TFloatField
      FieldName = 'samedaynum2'
    end
    object jcdsResultsamedaynum3: TFloatField
      FieldName = 'samedaynum3'
    end
    object jcdsResultsamedaynum4: TFloatField
      FieldName = 'samedaynum4'
    end
    object jcdsResultsamedaynum5: TFloatField
      FieldName = 'samedaynum5'
    end
    object jcdsResultsamedaynum6: TFloatField
      FieldName = 'samedaynum6'
    end
    object jcdsResultsamedaynum7: TFloatField
      FieldName = 'samedaynum7'
    end
    object jcdsResultsamedaynum8: TFloatField
      FieldName = 'samedaynum8'
    end
    object jcdsResultsamedaynum9: TFloatField
      FieldName = 'samedaynum9'
    end
    object jcdsResultsamedaynum10: TFloatField
      FieldName = 'samedaynum10'
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
  object jcdsticketoutletsvalue: TjsonClientDataSet
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
        Value = 'ticketoutlets'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 488
    Top = 224
  end
end
