inherited frmQuerySellerDailyReport: TfrmQuerySellerDailyReport
  Caption = #21806#31080#21592#33829#25910#24773#20917#26085#25253#34920
  ClientHeight = 480
  ClientWidth = 1299
  ExplicitWidth = 1315
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1299
    Height = 73
    ExplicitWidth = 1299
    ExplicitHeight = 73
    object lbl1: TLabel
      Left = 28
      Top = 20
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
    object lbl6: TLabel
      Left = 14
      Top = 49
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl2: TLabel
      Left = 211
      Top = 20
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl3: TLabel
      Left = 408
      Top = 20
      Width = 14
      Height = 14
      Caption = #33267
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 62
      Top = 17
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
    object nvhelpUserid: TNovaHelp
      Left = 62
      Top = 47
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
    object dtpSellEnddate: TDateTimePicker
      Left = 434
      Top = 17
      Width = 121
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      Checked = False
      TabOrder = 2
    end
    object dtpSellStartdate: TDateTimePicker
      Left = 274
      Top = 17
      Width = 120
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      TabOrder = 1
    end
    object chkGroupby: TCheckBox
      Left = 211
      Top = 49
      Width = 121
      Height = 17
      Caption = #25353#21806#31080#26085#26399#32479#35745
      TabOrder = 4
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
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 118
    Width = 1299
    Height = 362
    ExplicitTop = 118
    ExplicitWidth = 1299
    ExplicitHeight = 362
    inherited GroupBox1: TGroupBox
      Width = 1299
      Height = 362
      ExplicitWidth = 1299
      ExplicitHeight = 362
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1295
        Height = 344
        FooterRowCount = 1
        ImeMode = imDisable
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
            Title.Caption = #26426#26500
            Width = 111
          end
          item
            EditButtons = <>
            FieldName = 'username'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21806#31080#21592'('#24037#21495')'
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'opratedate'
            Footers = <>
            Title.Caption = #21806#31080#26085#26399
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'sellreturncount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#21806#31080'|'#36820#31243#31080#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'sellcount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#21806#31080'|'#24635#24352#25968
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'sellprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#21806#31080'|'#37329#39069
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'eticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#21806#31080'|'#30005#23376#31080#25968
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'canclecount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#24223#31080'|'#24352#25968
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'cancleprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#24223#31080'|'#37329#39069
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'returncount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#36864#31080'|'#24352#25968
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'returnmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#36864#31080'|'#31080#20215#37329#39069
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'totalprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454'|'#31080#27454#23567#35745
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'chargesmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153'|'#36864#31080#25163#32493#36153
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'changenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153'|'#25913#31614#25968
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'changeservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153'|'#25913#31614#26381#21153#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'bookfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153'|'#35746#31080#26381#21153#36153
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'fee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153'|'#34917#31080#26381#21153#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153'|'#23567#35745
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'allcount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#24212#32564'|'#24352#25968
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'allmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#24212#32564'|'#24635#33829#25910
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'cashmoneypayable'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#24212#32564'|'#20854#20013#29616#37329
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'nonvouchermoneypayable'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#24212#32564'|'#20854#20013'VIP'#20648#20540
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
    DataSourceName = 'resultmap'
    QueryAddress = 'query/querySellerDailyReport'
    SaveAddress = 'query/querySellerDailyReport'
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
        Name = 'filter_LED_ttd!moneydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ttd!moneydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'groupbydate'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
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
end
