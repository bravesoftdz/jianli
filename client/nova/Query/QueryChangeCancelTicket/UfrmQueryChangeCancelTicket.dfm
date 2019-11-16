inherited frmQueryChangeCancelTicket: TfrmQueryChangeCancelTicket
  Caption = 'frmQueryChangeCancelTicket'
  ClientHeight = 529
  ClientWidth = 847
  OnShow = FormShow
  ExplicitWidth = 863
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 847
    ExplicitWidth = 116
    object lbl4: TLabel
      Left = 212
      Top = 23
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl3: TLabel
      Left = 399
      Top = 23
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label9: TLabel
      Left = 543
      Top = 23
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl1: TLabel
      Left = 12
      Top = 23
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
    object dtpstartdate: TDateTimePicker
      Left = 278
      Top = 19
      Width = 111
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 423
      Top = 19
      Width = 111
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 1
    end
    object nvhelpUserid: TNovaHelp
      Left = 595
      Top = 19
      Width = 133
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
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 78
      Top = 19
      Width = 125
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 847
    ExplicitWidth = 116
    ExplicitHeight = 490
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
    Width = 847
    Height = 262
    ExplicitTop = 548
    ExplicitWidth = 116
    inherited GroupBox1: TGroupBox
      Width = 847
      Height = 262
      ExplicitTop = 6
      ExplicitWidth = 553
      ExplicitHeight = 153
      inherited dbgrdhResult: TNvDbgridEh
        Width = 843
        Height = 244
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.Value = #21512#35745':'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'eticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #30005#23376#31080#25442#31080#25968
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'eticketmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #30005#23376#31080#27454
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#25968
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'cancelmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#27454
            Width = 140
          end>
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 365
    Width = 847
    Height = 164
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 296
    ExplicitWidth = 911
    object Splitter1: TSplitter
      Left = 345
      Top = 0
      Height = 164
      ExplicitLeft = 400
      ExplicitTop = 72
      ExplicitHeight = 100
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 345
      Height = 164
      Align = alLeft
      Caption = #30005#23376#31080#25442#31080#26126#32454
      TabOrder = 0
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 341
        Height = 146
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource2
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
        ImeMode = imClose
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
        ParentName = 'SimpleCRUDForm'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #30005#23376#31080#25442#31080#31080#21495
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #30005#23376#31080#31080#20215
            Width = 140
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 348
      Top = 0
      Width = 357
      Height = 164
      Align = alLeft
      Caption = #24223#31080#26126#32454
      TabOrder = 1
      ExplicitLeft = 490
      object NvDbgridEh2: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 353
        Height = 146
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
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
        ImeMode = imClose
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
        ParentName = 'SimpleCRUDForm'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #24223#31080#31080#21495
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#31080#20215
            Width = 140
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 800
    Top = 72
  end
  inherited ilToolBarDisable: TImageList
    Left = 744
    Top = 80
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'changecancelticketmap'
    QueryAddress = 'query/queryChangeCancelTicket'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sign'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpenddate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 688
    Top = 208
  end
  inherited dsResult: TDataSource
    Left = 640
    Top = 208
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 680
    Top = 104
  end
  object jcdsticketcancel: TjsonClientDataSet
    DataSourceName = 'changecancelticketmap'
    QueryAddress = 'query/queryChangeCancelTicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sign'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpenddate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 640
    Top = 424
  end
  object DataSource1: TDataSource
    DataSet = jcdsticketcancel
    Left = 544
    Top = 424
  end
  object jcdsticketchange: TjsonClientDataSet
    DataSourceName = 'changecancelticketmap'
    QueryAddress = 'query/queryChangeCancelTicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sign'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpenddate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 248
    Top = 456
  end
  object DataSource2: TDataSource
    DataSet = jcdsticketchange
    Left = 176
    Top = 456
  end
end
