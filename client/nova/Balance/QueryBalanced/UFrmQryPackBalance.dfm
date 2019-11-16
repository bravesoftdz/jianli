inherited FrmQryPackBalance: TFrmQryPackBalance
  Caption = #34892#21253#24050#32467#36134#26597#35810
  ClientHeight = 484
  ClientWidth = 933
  ExplicitWidth = 949
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 933
    Height = 100
    ExplicitWidth = 933
    ExplicitHeight = 100
    object Label1: TLabel
      Left = 221
      Top = 67
      Width = 56
      Height = 14
      Caption = #32467#36134#21333#21495
    end
    object Label2: TLabel
      Left = 27
      Top = 28
      Width = 56
      Height = 14
      Caption = #32467#36134#26085#26399
    end
    object Label4: TLabel
      Left = 218
      Top = 28
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label3: TLabel
      Left = 383
      Top = 28
      Width = 70
      Height = 14
      Caption = #32467#36134#21333#29366#24577
    end
    object Label5: TLabel
      Left = 27
      Top = 67
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object Label7: TLabel
      Left = 577
      Top = 28
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object NovaPackBalanceno: TNovaEdit
      Left = 292
      Top = 64
      Width = 110
      Height = 22
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
    end
    object NovaArriverStartdate: TDateTimePicker
      Left = 94
      Top = 25
      Width = 108
      Height = 22
      Date = 42142.780504756940000000
      Time = 42142.780504756940000000
      TabOrder = 1
    end
    object NovaArriverEnddate: TDateTimePicker
      Left = 253
      Top = 25
      Width = 108
      Height = 22
      Date = 42142.780504756940000000
      Time = 42142.780504756940000000
      TabOrder = 2
    end
    object NvPackbalanceStatus: TNovaCheckedComboBox
      Left = 472
      Top = 25
      Width = 85
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'packbalance'
        end
        item
          DataType = ftString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'status'
        end>
    end
    object novabalancetype: TNovaComboBox
      Left = 94
      Top = 64
      Width = 108
      Height = 22
      ImeMode = imClose
      TabOrder = 4
      Items.Strings = (
        #20840#37096
        #20986#24211#32467#31639
        #21069#21488#32467#31639)
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
    end
    object NovaHelpUnit: TNovaHelp
      Left = 642
      Top = 25
      Width = 143
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
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 933
    ExplicitWidth = 933
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #27880#38144
      ImageIndex = 50
      OnClick = tbtnInsertClick
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
  end
  inherited Panel1: TPanel
    Top = 145
    Width = 933
    Height = 339
    ExplicitTop = 145
    ExplicitWidth = 933
    ExplicitHeight = 339
    object Splitter1: TSplitter [0]
      Left = 697
      Top = 0
      Height = 339
      ExplicitLeft = 577
      ExplicitTop = 6
    end
    inherited GroupBox1: TGroupBox
      Width = 697
      Height = 339
      Align = alLeft
      ExplicitWidth = 697
      ExplicitHeight = 339
      inherited dbgrdhResult: TNvDbgridEh
        Width = 693
        Height = 321
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'packbalanceno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32467#36134#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'datatype'
            Footers = <>
            Title.Caption = #32467#36134#21333#31867#22411
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #32467#36134#21333#29366#24577
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'packnos'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#25454#24352#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20214#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36135#27454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packbalancemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#24080#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balancby'
            Footers = <>
            Title.Caption = #32467#36134#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balancetime'
            Footers = <>
            Title.Caption = #32467#36134#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'cancelby'
            Footers = <>
            Title.Caption = #27880#38144#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'cleartime'
            Footers = <>
            Title.Caption = #27880#38144#26102#38388
            Width = 80
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 700
      Top = 0
      Width = 233
      Height = 339
      Align = alClient
      Caption = #26126#32454
      TabOrder = 1
      ExplicitLeft = 475
      ExplicitWidth = 458
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 229
        Height = 321
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = ds
        Flat = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ParentFont = False
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = [fsBold]
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
        PrintOptions = [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]
        PrintAutoNewLine = False
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'pdate'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25910#35755'/'#21457#36135#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'pno'
            Footers = <>
            Title.Caption = #31080#25454#21333#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'station'
            Footers = <>
            Title.Caption = #21457#36135'/'#32456#21040#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20214#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36135#27454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'datatype'
            Footers = <>
            Title.Caption = #25968#25454#31867#22411
            Width = 80
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 776
    Top = 104
  end
  inherited ilToolBarDisable: TImageList
    Left = 864
    Top = 104
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'packBalanced'
    QueryAddress = 'pack/queryPackBalanced'
    SaveAddress = 'pack/cancelPackBalanced'
    Params = <
      item
        DataType = ftString
        Name = 'senddepartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sendenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalanceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'datatype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'unitname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalanceid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 400
    Top = 328
  end
  inherited dsResult: TDataSource
    Left = 344
    Top = 328
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 840
    Top = 40
  end
  object ds: TDataSource
    DataSet = jcdsdetail
    Left = 760
    Top = 280
  end
  object jcdsdetail: TjsonClientDataSet
    DataSourceName = 'packBalanced'
    QueryAddress = 'pack/qryDetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packbalanceid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 712
    Top = 280
  end
end
