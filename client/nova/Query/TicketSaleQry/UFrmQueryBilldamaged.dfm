inherited frmQueryBilldamaged: TfrmQueryBilldamaged
  Caption = #22351#31080#30331#35760#24773#20917#26597#35810
  ClientHeight = 480
  ClientWidth = 1299
  ExplicitWidth = 1315
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1299
    Height = 104
    ExplicitWidth = 1299
    ExplicitHeight = 104
    object lbl1: TLabel
      Left = 33
      Top = 17
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
      Left = 259
      Top = 17
      Width = 84
      Height = 14
      Caption = #22351#31080#30331#35760#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 535
      Top = 17
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
      Left = 20
      Top = 52
      Width = 70
      Height = 14
      Caption = #30331#35760#26426#22120'IP'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 504
      Top = 52
      Width = 70
      Height = 14
      Caption = #22351#31080#30331#35760#20154
    end
    object lbl4: TLabel
      Left = 260
      Top = 52
      Width = 84
      Height = 14
      Caption = #22351#31080#30331#35760#31449#28857
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 33
      Top = 82
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 98
      Top = 15
      Width = 141
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
    object dtpStartRecordtime: TDateTimePicker
      Left = 353
      Top = 15
      Width = 140
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      TabOrder = 1
    end
    object dtpEndRecordtime: TDateTimePicker
      Left = 584
      Top = 15
      Width = 140
      Height = 22
      Date = 40413.999988425920000000
      Time = 40413.999988425920000000
      TabOrder = 2
    end
    object nvhlpUser: TNovaHelp
      Left = 584
      Top = 49
      Width = 140
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
          Width = 69
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
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
    object edtIP: TNovaEdit
      Left = 98
      Top = 49
      Width = 141
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
    end
    object nvhlpTicketoutlets: TNovaHelp
      Left = 353
      Top = 49
      Width = 140
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 280
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
    object nvHcbbOrgnovahcbbtype: TNovaHComboBox
      Left = 98
      Top = 79
      Width = 141
      Height = 22
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.DisAll = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BilltypeHelp'
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
    Top = 149
    Width = 1299
    Height = 331
    ExplicitTop = 149
    ExplicitWidth = 1299
    ExplicitHeight = 331
    inherited GroupBox1: TGroupBox
      Width = 1299
      Height = 331
      ExplicitWidth = 1299
      ExplicitHeight = 331
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1295
        Height = 313
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        jsonConnection = DMPublic.jcon
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'recordbyname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22351#31080#30331#35760#20154
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletname'
            Footers = <>
            Title.Caption = #22351#31080#30331#35760#31449#28857
            Width = 143
          end
          item
            EditButtons = <>
            FieldName = 'billtypename'
            Footers = <>
            Title.Caption = #31080#25454#31867#22411
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'startno'
            Footers = <>
            Title.Caption = #36215#22987#31080#21495
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'endno'
            Footers = <>
            Title.Caption = #25130#27490#31080#21495
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'amount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25968#37327
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'damageddscribe'
            Footers = <>
            Title.Caption = #25439#22351#25551#36848
            Width = 215
          end
          item
            EditButtons = <>
            FieldName = 'recordip'
            Footers = <>
            Title.Caption = #30331#35760#30005#33041'IP '
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'recordtime'
            Footers = <>
            Title.Caption = #22351#31080#30331#35760#26102#38388
            Width = 149
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
    DataSourceName = 'billdamagedmap'
    QueryAddress = 'query/queryBilldamaged'
    SaveAddress = 'query/queryBilldamaged'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_b!recordip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_b!billtypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_b!recordtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_b!recordtime'
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
