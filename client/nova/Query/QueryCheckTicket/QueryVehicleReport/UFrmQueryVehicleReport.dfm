inherited frmQueryVehicleReport: TfrmQueryVehicleReport
  Caption = #29677#27425#25253#29677#24773#20917#26597#35810
  ClientHeight = 480
  ClientWidth = 1299
  ExplicitWidth = 1315
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1299
    Height = 92
    ExplicitWidth = 1299
    ExplicitHeight = 92
    object lbl11: TLabel
      Left = 253
      Top = 13
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
      Left = 490
      Top = 13
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
      Left = 476
      Top = 45
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
      Left = 30
      Top = 45
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object lbl4: TLabel
      Left = 254
      Top = 45
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
      Left = 28
      Top = 75
      Width = 56
      Height = 14
      Caption = #25253#21040#36710#36742
    end
    object lbl1: TLabel
      Left = 42
      Top = 13
      Width = 42
      Height = 14
      Caption = #35843#24230#31449
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 316
      Top = 9
      Width = 136
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      TabOrder = 0
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 519
      Top = 9
      Width = 121
      Height = 22
      Date = 40413.999305555550000000
      Time = 40413.999305555550000000
      TabOrder = 1
    end
    object nvhelpUnit: TNovaHelp
      Left = 92
      Top = 41
      Width = 139
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
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 69
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
      HelpOptions.HelpWidth = 240
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
      Left = 92
      Top = 71
      Width = 139
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
      HelpOptions.HelpHeight = 150
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
    object chkIsLine: TCheckBox
      Left = 254
      Top = 74
      Width = 67
      Height = 17
      Caption = #27969#27700#29677
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chkIsnotLine: TCheckBox
      Left = 327
      Top = 74
      Width = 79
      Height = 17
      Caption = #38750#27969#27700#29677
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object chkIsOver: TCheckBox
      Left = 445
      Top = 74
      Width = 51
      Height = 17
      Caption = #21152#29677
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object chkIsNotOver: TCheckBox
      Left = 509
      Top = 74
      Width = 53
      Height = 17
      Caption = #27491#29677
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkIsReport: TCheckBox
      Left = 613
      Top = 74
      Width = 67
      Height = 17
      Caption = #24050#25253#21040
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object chkIsNotReport: TCheckBox
      Left = 689
      Top = 74
      Width = 67
      Height = 17
      Caption = #26410#25253#21040
      TabOrder = 11
    end
    object nvhlpschedule: TNovaHelp
      Left = 519
      Top = 41
      Width = 121
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
    object nvhlproute: TNovaHelp
      Left = 316
      Top = 41
      Width = 137
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
    object nvHcbbOrg: TNovaHComboBox
      Left = 92
      Top = 9
      Width = 139
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 12
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
    Top = 137
    Width = 1299
    Height = 343
    ExplicitTop = 137
    ExplicitWidth = 1299
    ExplicitHeight = 343
    inherited GroupBox1: TGroupBox
      Width = 1299
      Height = 343
      ExplicitWidth = 1299
      ExplicitHeight = 343
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1295
        Height = 325
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #35843#24230#31449
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36816#33829#32447#36335
            Width = 128
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
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #29677#27425#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #27969#27700#29677
            Width = 55
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
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #25253#21040#36710#36742
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'isreported'
            Footers = <>
            Title.Caption = #24050#25253#21040
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'reporttime'
            Footers = <>
            Title.Caption = #25253#21040#26102#38388
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #25253#21040#21333#20301
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'planunitname'
            Footers = <>
            Title.Caption = #35745#21010#33829#36816#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'planvehicleno'
            Footers = <>
            Title.Caption = #35745#21010#36710#36742
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'drivername1'
            Footers = <>
            Title.Caption = #25253#21040#39550#39542#21592'1'
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'drivername2'
            Footers = <>
            Title.Caption = #25253#21040#39550#39542#21592'2'
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'drivername3'
            Footers = <>
            Title.Caption = #25253#21040#39550#39542#21592'3'
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'drivername4'
            Footers = <>
            Title.Caption = #25253#21040#39550#39542#21592'4'
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'stewardname1'
            Footers = <>
            Title.Caption = #25253#21040#20056#21153#21592'1'
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'stewardname2'
            Footers = <>
            Title.Caption = #25253#21040#20056#21153#21592'2'
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'plandriver1'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'1'
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'plandriver2'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'2'
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'plandriver3'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'3'
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'plandriver4'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'4'
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'plansteward1'
            Footers = <>
            Title.Caption = #35745#21010#20056#21153#21592'1'
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'plansteward2'
            Footers = <>
            Title.Caption = #35745#21010#20056#21153#21592'2'
            Width = 93
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
    DataSourceName = 'vehicleReportmap'
    QueryAddress = 'query/findVehicleReportStuation'
    SaveAddress = 'query/findVehicleReportStuation'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_st!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ut!id'
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
        Name = 'filter_EQL_vh!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isreported'
        ParamType = ptInput
      end>
    Left = 248
    Top = 360
    object blnfldResultisreported: TBooleanField
      FieldName = 'isreported'
    end
    object wdstrngfldResultstatus: TWideStringField
      FieldName = 'status'
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 30
    end
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 30
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 30
    end
    object dtfldResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object dtmfldResultreporttime: TDateTimeField
      FieldName = 'reporttime'
    end
    object wdstrngfldResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 30
    end
    object lrgntfldResultseatnum: TLargeintField
      FieldName = 'seatnum'
    end
    object blnfldResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object blnfldResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object wdstrngfldResultplanunitname: TWideStringField
      FieldName = 'planunitname'
      Size = 30
    end
    object wdstrngfldResultplanvehicleno: TWideStringField
      FieldName = 'planvehicleno'
      Size = 30
    end
    object wdstrngfldResultdrivername1: TWideStringField
      FieldName = 'drivername1'
      Size = 30
    end
    object wdstrngfldResultdrivername2: TWideStringField
      FieldName = 'drivername2'
      Size = 30
    end
    object wdstrngfldResultdrivername3: TWideStringField
      FieldName = 'drivername3'
      Size = 30
    end
    object wdstrngfldResultdrivername4: TWideStringField
      FieldName = 'drivername4'
      Size = 30
    end
    object wdstrngfldResultstewardname1: TWideStringField
      FieldName = 'stewardname1'
      Size = 30
    end
    object wdstrngfldResultstewardname2: TWideStringField
      FieldName = 'stewardname2'
      Size = 30
    end
    object wdstrngfldResultplandriver1: TWideStringField
      FieldName = 'plandriver1'
      Size = 30
    end
    object wdstrngfldResultplandriver2: TWideStringField
      FieldName = 'plandriver2'
      Size = 30
    end
    object wdstrngfldResultplandriver3: TWideStringField
      FieldName = 'plandriver3'
      Size = 30
    end
    object wdstrngfldResultplandriver4: TWideStringField
      FieldName = 'plandriver4'
      Size = 30
    end
    object wdstrngfldResultplansteward1: TWideStringField
      FieldName = 'plansteward1'
      Size = 30
    end
    object wdstrngfldResultplansteward2: TWideStringField
      FieldName = 'plansteward2'
      Size = 30
    end
    object wdstrngfldResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 30
    end
    object wdstrngfldResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsStatusname
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Size = 30
      Lookup = True
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 0
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
        Value = 'schedulestatus'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'schedulestatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 632
    Top = 336
  end
end
