inherited frmQueryRouteDynamicCompare: TfrmQueryRouteDynamicCompare
  Caption = #23458#36816#29677#32447#21160#24577#34920
  ClientHeight = 480
  ClientWidth = 1362
  OnShow = FormShow
  ExplicitWidth = 1378
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1362
    Height = 102
    ExplicitWidth = 1362
    ExplicitHeight = 102
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
    object lbldate: TLabel
      Left = 213
      Top = 19
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 403
      Top = 21
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 2
      Top = 76
      Width = 56
      Height = 14
      Caption = #23545#27604#39033#30446
    end
    object lbl3: TLabel
      Left = 214
      Top = 48
      Width = 56
      Height = 14
      Caption = #21516#27604#26085#26399
    end
    object lbl4: TLabel
      Left = 403
      Top = 48
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl5: TLabel
      Left = 29
      Top = 48
      Width = 28
      Height = 14
      Caption = #32447#36335
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 63
      Top = 16
      Width = 138
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
    object dtpstartdate: TDateTimePicker
      Left = 277
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 428
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
      OnChange = dtpenddateChange
    end
    object dtpComStar: TDateTimePicker
      Left = 278
      Top = 45
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 4
      OnChange = dtpComStarChange
    end
    object dtpComEnd: TDateTimePicker
      Left = 428
      Top = 45
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 5
      OnChange = dtpComEndChange
    end
    object nvcbbAddObject: TNovaCheckedComboBox
      Left = 63
      Top = 74
      Width = 138
      Height = 23
      ColorNotFocus = clWhite
      ItemHeight = 17
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'addobject'
      HelpOptions.HQueryAddress = 'query/addcompare'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhlpRoute: TNovaHelp
      Left = 63
      Top = 45
      Width = 138
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
          Title.Caption = #21517#31216
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 90
          Visible = True
        end>
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 290
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object chkByroute: TCheckBox
      Left = 395
      Top = 74
      Width = 113
      Height = 17
      Caption = #25353#29677#32447#21517#32479#35745
      TabOrder = 7
    end
    object chkBydate: TCheckBox
      Left = 245
      Top = 74
      Width = 116
      Height = 17
      Caption = #25353#21457#36710#26085#26399#32479#35745
      TabOrder = 8
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1362
    ExplicitWidth = 1362
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
    Top = 147
    Width = 1362
    Height = 333
    ExplicitTop = 147
    ExplicitWidth = 1362
    ExplicitHeight = 333
    inherited GroupBox1: TGroupBox
      Width = 1362
      Height = 333
      ExplicitWidth = 1362
      ExplicitHeight = 333
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1358
        Height = 315
        FooterRowCount = 1
        ImeMode = imDisable
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
            Title.Caption = #29677#32447#21517
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'schnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#29677#25968'|'#26412#26399
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'schnum1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#29677#25968'|'#21516#26399
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'schnumComp'
            Footers = <>
            Title.Caption = #21457#29677#25968'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'schnumPercent'
            Footers = <>
            Title.Caption = #21457#29677#25968'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'seats'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#24231#20301#25968'|'#26412#26399
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'seats1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#24231#20301#25968'|'#21516#26399
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'seatsComp'
            Footers = <>
            Title.Caption = #24635#24231#20301#25968'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'seatsPercent'
            Footers = <>
            Title.Caption = #24635#24231#20301#25968'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ticketnumComp'
            Footers = <>
            Title.Caption = #20154#25968'|'#21516#27604
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'ticketnumPercent'
            Footers = <>
            Title.Caption = #20154#25968'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26816#31080#37329#39069'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'totalamount1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26816#31080#37329#39069'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'totalamountComp'
            Footers = <>
            Title.Caption = #26816#31080#37329#39069'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'totalamountPercent'
            Footers = <>
            Title.Caption = #26816#31080#37329#39069'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'balanceamountComp'
            Footers = <>
            Title.Caption = #32467#31639#37329#39069'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'balanceamountPercent'
            Footers = <>
            Title.Caption = #32467#31639#37329#39069'|'#22686#38271#29575
            Width = 66
          end
          item
            Alignment = taRightJustify
            EditButtons = <>
            FieldName = 'stationincome'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#31449#25910#20837'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stationincome1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#31449#25910#20837'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stationincomeComp'
            Footers = <>
            Title.Caption = #36710#31449#25910#20837'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'stationincomePercent'
            Footers = <>
            Title.Caption = #36710#31449#25910#20837'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'agentfee1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'agentfeeComp'
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'agentfeePercent'
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefeeComp'
            Footers = <>
            Title.Caption = #31449#21153#36153'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefeePercent'
            Footers = <>
            Title.Caption = #31449#21153#36153'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25187#36153'1|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'computefee1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25187#36153'1|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'computefeeComp'
            Footers = <>
            Title.Caption = #25187#36153'1|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'computefeePercent'
            Footers = <>
            Title.Caption = #25187#36153'1|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31354#35843#36153'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31354#35843#36153'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'coolairfeeComp'
            Footers = <>
            Title.Caption = #31354#35843#36153'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'coolairfeePercent'
            Footers = <>
            Title.Caption = #31354#35843#36153'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38468#21152#36153'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'additionfee1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38468#21152#36153'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'additionfeeComp'
            Footers = <>
            Title.Caption = #38468#21152#36153'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'additionfeePercent'
            Footers = <>
            Title.Caption = #38468#21152#36153'|'#22686#38271#29575
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'routedistance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32447#36335#24635#20844#37324'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'routedistance1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32447#36335#24635#20844#37324'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'routedistanceComp'
            Footers = <>
            Title.Caption = #32447#36335#24635#20844#37324'|'#21516#27604
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'routedistancePercent'
            Footers = <>
            Title.Caption = #32447#36335#24635#20844#37324'|'#22686#38271#29575
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'peopledistance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21608#36716#37327'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'peopledistance1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21608#36716#37327'|'#21516#26399
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'peopledistanceComp'
            Footers = <>
            Title.Caption = #21608#36716#37327'|'#21516#27604
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'peopledistancePercent'
            Footers = <>
            Title.Caption = #21608#36716#37327'|'#22686#38271#29575
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'rate'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #23454#36733#29575'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'rate1'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #23454#36733#29575'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'rateComp'
            Footers = <>
            Title.Caption = #23454#36733#29575'|'#21516#27604
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'ratePercent'
            Footers = <>
            Title.Caption = #23454#36733#29575'|'#22686#38271#29575
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'seatrate'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #24231#20301#21033#29992#29575'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'seatrate1'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #24231#20301#21033#29992#29575'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'seatrateComp'
            Footers = <>
            Title.Caption = #24231#20301#21033#29992#29575'|'#21516#27604
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'seatratePercent'
            Footers = <>
            Title.Caption = #24231#20301#21033#29992#29575'|'#22686#38271#29575
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'incomerate'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #33829#25910#27604#37325'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'incomerate1'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #33829#25910#27604#37325'|'#21516#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'incomerateComp'
            Footers = <>
            Title.Caption = #33829#25910#27604#37325'|'#21516#27604
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'incomeratePercent'
            Footers = <>
            Title.Caption = #33829#25910#27604#37325'|'#22686#38271#29575
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'sellincome'
            Footers = <>
            Title.Caption = #21806#31080#25910#20837'|'#26412#26399
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'sellincome1'
            Footers = <>
            Title.Caption = #21806#31080#25910#20837'|'#21516#26399
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'sellincomeComp'
            Footers = <>
            Title.Caption = #21806#31080#25910#20837'|'#21516#27604
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'sellincomePercent'
            Footers = <>
            Title.Caption = #21806#31080#25910#20837'|'#22686#38271#29575
            Width = 58
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
    DataSourceName = 'routeDynamic'
    QueryAddress = 'query/routeDynamicCompare'
    SaveAddress = 'query/routeDynamicCompare'
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
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_c!addObject'
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
        Name = 'isbydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isbyroute'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    Left = 296
    Top = 216
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
