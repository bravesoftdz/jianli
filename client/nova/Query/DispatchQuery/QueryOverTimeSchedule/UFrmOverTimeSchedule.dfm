inherited frmOverTimeSchedule: TfrmOverTimeSchedule
  Caption = #23458#36816#31449#21152#29677#27425#24773#20917
  ClientHeight = 484
  ClientWidth = 1058
  OnShow = FormShow
  ExplicitWidth = 1074
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1058
    Height = 97
    ExplicitWidth = 1058
    ExplicitHeight = 97
    object lbldate: TLabel
      Left = 234
      Top = 18
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lblroute: TLabel
      Left = 50
      Top = 47
      Width = 28
      Height = 14
      Caption = #32447#36335
    end
    object lbl1: TLabel
      Left = 467
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 234
      Top = 47
      Width = 56
      Height = 14
      Caption = #32463#33829#21333#20301
    end
    object lbl3: TLabel
      Left = 429
      Top = 48
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object lbl6: TLabel
      Left = 13
      Top = 18
      Width = 70
      Height = 14
      Caption = #24403#21069#35843#24230#31449
    end
    object lblsc: TLabel
      Left = 27
      Top = 77
      Width = 56
      Height = 14
      Caption = #29677#27425#29366#24577
    end
    object dtpstartdate: TDateTimePicker
      Left = 295
      Top = 15
      Width = 123
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 3
    end
    object dtpenddate: TDateTimePicker
      Left = 488
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 4
    end
    object nvhlpBalanceUnit: TNovaHelp
      Left = 219
      Top = -236
      Width = 115
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
    object nvhlpUnit: TNovaHelp
      Left = 295
      Top = 45
      Width = 123
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
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 180
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpBUnit: TNovaHelp
      Left = 488
      Top = 45
      Width = 118
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
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 180
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
      Left = 86
      Top = 45
      Width = 124
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
    object NovaHCbbOrg: TNovaHComboBox
      Left = 87
      Top = 13
      Width = 123
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
    object nvcbbSchedulestatus: TNovaCheckedComboBox
      Left = 87
      Top = 74
      Width = 123
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
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
          Value = 'schedulestatus'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'schedulestatus'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1058
    ExplicitWidth = 1058
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
    Top = 142
    Width = 1058
    Height = 342
    ExplicitTop = 142
    ExplicitWidth = 1058
    ExplicitHeight = 342
    object spl1: TSplitter [0]
      Left = 0
      Top = 0
      Width = 1
      Height = 342
      ExplicitLeft = 1001
      ExplicitTop = 6
      ExplicitHeight = 362
    end
    inherited GroupBox1: TGroupBox
      Left = 1
      Width = 1057
      Height = 342
      ExplicitLeft = 1
      ExplicitWidth = 1057
      ExplicitHeight = 342
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1053
        Height = 324
        FooterRowCount = 1
        ImeMode = imDisable
        RowHeight = 26
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
            Title.Caption = #32447#36335
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'schedulename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 73
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
            FieldName = 'status'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'reportvehicleno'
            Footers = <>
            Title.Caption = #25253#21040#36710#36742
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#24231#20301
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24050#21806
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'reservenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20313#24231
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'sellprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#37329#39069
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'vtname'
            Footers = <>
            Title.Caption = #36710#36742#31867#22411
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'begincheck'
            Footers = <>
            Title.Caption = #26816#31080#29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #19978#36710#20301
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Footers = <>
            Title.Caption = #21806#31080#29366#24577
            Width = 42
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
            FieldName = 'issaleafterreport'
            Footers = <>
            Title.Caption = #25253#21040#21806#31080
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #32463#33829#21333#20301
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'balanceunitname'
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'viastation'
            Footers = <>
            Title.Caption = #36884#32463#31449#28857
            Width = 125
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
          object pnl2: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 1
            object grp2: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 0
              Align = alClient
              Caption = #26597#35810#32467#26524
              TabOrder = 0
              object nvdbgrdh2: TNvDbgridEh
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
                ImeMode = imDisable
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
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'id'
                    Footers = <>
                    Visible = False
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
                    FieldName = 'routename'
                    Footer.Value = #21512#35745
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    Title.Caption = #32447#36335
                    Width = 133
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
                    FieldName = 'isdeparted'
                    Footers = <>
                    Title.Caption = #21457#29677
                    Width = 40
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
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'buspark'
                    Footers = <>
                    Title.Caption = #19978#36710#20301
                    Width = 100
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
                    FieldName = 'viastation'
                    Footers = <>
                    Title.Caption = #36884#32463#31449#28857
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicletypeid'
                    Footers = <>
                    Visible = False
                  end
                  item
                    EditButtons = <>
                    Footers = <>
                    Visible = False
                  end
                  item
                    EditButtons = <>
                    Footers = <>
                    Visible = False
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
    DataSourceName = 'resultmap'
    QueryAddress = 'query/findOvertimeSchedule'
    SaveAddress = 'query/findOvertimeSchedule'
    Params = <
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
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_vrr!reportunit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vrr!balanceid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'curstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ss!status'
        ParamType = ptInput
      end>
    Left = 304
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 368
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 360
  end
end
