inherited FrmFinancialBalanceRpt: TFrmFinancialBalanceRpt
  Caption = #36130#21153#25910#25903#24179#34913#34920
  ClientHeight = 480
  ClientWidth = 1362
  OnShow = FormShow
  ExplicitWidth = 1378
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1362
    Height = 44
    ExplicitWidth = 1362
    ExplicitHeight = 44
    object lbl1: TLabel
      Left = 20
      Top = 19
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
    object lbldate: TLabel
      Left = 258
      Top = 19
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object Label1: TLabel
      Left = 416
      Top = 19
      Width = 14
      Height = 14
      Caption = #33267
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 82
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
      Left = 300
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 437
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
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
    Top = 89
    Width = 1362
    Height = 391
    ExplicitTop = 89
    ExplicitWidth = 1362
    ExplicitHeight = 391
    inherited GroupBox1: TGroupBox
      Width = 1362
      Height = 391
      ExplicitWidth = 1362
      ExplicitHeight = 391
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1358
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
            FieldName = 'opdate'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #26085#26399
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425#26426#26500
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'daysellpassnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#36807#21435#31080'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellpassprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#36807#21435#31080'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'dayselldaynum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'daysellprenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellpreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'||'#37329#39069
            Width = 60
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'daysellpassdayreturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#36807#21435#31080'('#24403#26085#36864')||'#20154#25968
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'daysellpassdayreturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#36807#21435#31080'('#24403#26085#36864')||'#37329#39069
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayreturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#24403#26085#36864')||'#20154#25968
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayreturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#24403#26085#36864')||'#37329#39069
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayprereturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#23558#26469#36864')||'#20154#25968
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayprereturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#23558#26469#36864')||'#37329#39069
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'daysellpredayreturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#24403#26085#36864')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellpredayreturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#24403#26085#36864')||'#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'daysellprereturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#23558#26469#36864')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellprereturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#23558#26469#36864')||'#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'daysellpassdaycancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#36807#21435#31080'('#24403#26085#24223')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellpassdaycanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#36807#21435#31080'('#24403#26085#24223')||'#37329#39069
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'dayselldaycancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#24403#26085#24223')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'dayselldaycanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#24403#26085#24223')||'#37329#39069
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayprecancenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#23558#26469#24223')||'#20154#25968
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'dayselldayprecanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#21806#24403#26085#31080'('#23558#26469#24223')||'#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'daysellpredaycancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#24403#26085#24223')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellpredaycanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#24403#26085#24223')||'#37329#39069
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'daysellprecancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#23558#26469#24223')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellprecancelprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#39044#21806#31080'('#23558#26469#24223')||'#37329#39069
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'daysellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#23567#35745'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daysellprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'||'#23567#35745'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'passselldaynum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#24403#26085#31080'('#27491#24120#31080')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'passselldayprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#24403#26085#31080'('#27491#24120#31080')||'#37329#39069
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'perselldaynum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23558#26469#21806#24403#26085#31080'('#27491#24120#31080')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'perselldayprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23558#26469#21806#24403#26085#31080'('#27491#24120#31080')||'#37329#39069
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'passreturndaynum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#24403#26085#31080'('#24403#26085#36864')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'passreturndayprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#24403#26085#31080'('#24403#26085#36864')||'#37329#39069
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'passsellpredayreturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#23558#26469#31080'('#24403#26085#36864')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'passsellpredayreturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#23558#26469#31080'('#24403#26085#36864')||'#37329#39069
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'dayreturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#23567#35745'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'dayreturnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#23567#35745'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'passselldaycancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#24403#26085#31080'('#24403#26085#24223')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'passselldaycancelprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#24403#26085#31080'('#24403#26085#24223')||'#37329#39069
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'passsellpredaycancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#23558#26469#31080'('#24403#26085#24223')||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'passsellpredaycancelprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36807#21435#21806#23558#26469#31080'('#24403#26085#24223')||'#37329#39069
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'daycancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#23567#35745'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'daycancelprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#23567#35745'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#37327'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'departprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#37327'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'missnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28431#20056'||'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'missprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28431#20056'||'#31080#27454#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'incomenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25910#25903'||'#20154#25968
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'incomeprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25910#25903'||'#37329#39069
            Width = 50
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
    QueryAddress = 'report/financialBalanceRpt'
    SaveAddress = 'report/financialBalanceRpt'
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
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lastdayfomonth'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_c!compEdate'
        ParamType = ptInput
      end>
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
