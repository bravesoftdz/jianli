object FrmQryBanlancedetailPrint: TFrmQryBanlancedetailPrint
  Left = 0
  Top = 0
  HelpType = htKeyword
  Caption = #26597#30475#36335#21333#32467#31639#27719#24635#26126#32454
  ClientHeight = 333
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object nvdbgrdhResultPrint: TNvDbgridEh
    Left = 0
    Top = 0
    Width = 576
    Height = 333
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
    SumList.Active = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = #23435#20307
    TitleFont.Style = [fsBold]
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
        FieldName = 'fromstationname'
        Footers = <>
        Title.Caption = #19978#36710#31449
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'reachstationname'
        Footers = <>
        Title.Caption = #21040#36798#31449
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'ticketnum'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #20154#25968
        Width = 70
      end
      item
        EditButtons = <>
        FieldName = 'totalamount'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #37329#39069
        Width = 70
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
        FieldName = 'agentfee'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #20195#29702#36153
        Width = 70
      end
      item
        EditButtons = <>
        FieldName = 'balanceamount'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #23454#32467#37329#39069
        Width = 70
      end>
    object RowDetailData: TRowDetailPanelControlEh
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
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeMode = imDisable
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
  object dsResult: TDataSource
    DataSet = jcdsResultdetailPrint
    Left = 72
    Top = 175
  end
  object jcdsResultdetailPrint: TjsonClientDataSet
    DataSourceName = 'balancedetailprintlist'
    QueryAddress = 'balance/qryBalancedetailPrint'
    SaveAddress = 'balance/qryBalancedetailPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balanceid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 233
    Top = 185
  end
end
