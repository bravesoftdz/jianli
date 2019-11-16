inherited FrmFuelfeegrade: TFrmFuelfeegrade
  Caption = #29123#27833#38468#21152#36153#35774#32622
  ClientHeight = 435
  ClientWidth = 876
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 892
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 413
    Top = 97
    Height = 338
    ExplicitLeft = 176
    ExplicitTop = 168
    ExplicitHeight = 100
  end
  inherited pnlQuery: TPanel
    Width = 876
    Height = 52
    ExplicitWidth = 876
    ExplicitHeight = 52
    object Label1: TLabel
      Left = 14
      Top = 23
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label8: TLabel
      Left = 218
      Top = 23
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 75
      Top = 18
      Width = 120
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
    object NHelpRoute: TNovaHelp
      Left = 281
      Top = 18
      Width = 122
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
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
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 876
    ExplicitWidth = 876
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      OnClick = tbtnEditClick
    end
    inherited tbtnDelete: TToolButton
      OnClick = tbtnDeleteClick
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
      AutoSize = True
      Caption = ''
      ImageIndex = -1
      Visible = False
      ExplicitWidth = 18
    end
    inherited tbtnCancel: TToolButton
      Left = 350
      AutoSize = True
      Caption = ''
      ImageIndex = -1
      Visible = False
      ExplicitLeft = 350
      ExplicitWidth = 18
    end
    inherited ToolButton52: TToolButton
      Left = 368
      ExplicitLeft = 368
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 386
      ExplicitLeft = 386
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 404
      ExplicitLeft = 404
    end
    inherited tbtnInfo: TToolButton
      Left = 412
      ExplicitLeft = 412
    end
    inherited tbtn5: TToolButton
      Left = 482
      ExplicitLeft = 482
    end
    inherited tbtnExcel: TToolButton
      Left = 490
      ExplicitLeft = 490
    end
    inherited tbtnPrinter: TToolButton
      Left = 560
      ExplicitLeft = 560
    end
    inherited tbtn6: TToolButton
      Left = 630
      ExplicitLeft = 630
    end
    inherited tbtnClose: TToolButton
      Left = 638
      ExplicitLeft = 638
    end
  end
  inherited Panel1: TPanel
    Top = 97
    Width = 413
    Height = 338
    Align = alLeft
    ExplicitTop = 97
    ExplicitWidth = 413
    ExplicitHeight = 338
    object Splitter2: TSplitter [0]
      Left = 0
      Top = 177
      Width = 413
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 219
      ExplicitWidth = 113
    end
    inherited GroupBox1: TGroupBox
      Width = 413
      Height = 177
      Caption = #27833#20215#26723#27425#21306#38388
      ExplicitWidth = 413
      ExplicitHeight = 177
      inherited dbgrdhResult: TNvDbgridEh
        Width = 409
        Height = 159
        SumList.Active = True
        UseMultiTitle = True
        OnCellClick = dbgrdhResultCellClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'grade'
            Footers = <>
            Title.Caption = #26723#27425
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'fromprice'
            Footers = <>
            Title.Caption = #27833#20215#21306#38388'|'#36215
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'toprice'
            Footers = <>
            Title.Caption = #27833#20215#21306#38388'|'#27490
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 180
      Width = 413
      Height = 158
      Align = alBottom
      Caption = #33829#36816#37324#31243#29123#27833#36153
      TabOrder = 1
      object ToolBar3: TToolBar
        Left = 2
        Top = 16
        Width = 409
        Height = 29
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'ToolBar1'
        Images = ilToolBar
        TabOrder = 0
        object ToolButton20: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object ToolButton21: TToolButton
          Left = 8
          Top = 0
          Hint = #28155#21152
          Caption = 'ToolButton1'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton21Click
        end
        object ToolButton23: TToolButton
          Left = 39
          Top = 0
          Hint = #20462#25913
          Caption = 'ToolButton2'
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton23Click
        end
        object ToolButton22: TToolButton
          Left = 70
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object ToolButton26: TToolButton
          Left = 78
          Top = 0
          Hint = #27880#38144
          Caption = 'ToolButton8'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton26Click
        end
        object ToolButton25: TToolButton
          Left = 109
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 3
          Style = tbsSeparator
        end
      end
      object NvDbgridEh2: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 409
        Height = 111
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        UseMultiTitle = True
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
        PrintOptions = [pghOptimalColWidths]
        PrintAutoNewLine = False
        ParentName = 'FrmScheduleCyle'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'fromdistance'
            Footers = <>
            Title.Caption = #33829#36816#37324#31243'|'#36215
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'todistance'
            Footers = <>
            Title.Caption = #33829#36816#37324#31243'|'#33267
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'fee'
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object GroupBox2: TGroupBox [4]
    Left = 416
    Top = 97
    Width = 460
    Height = 338
    Align = alClient
    Caption = #24212#29992#32447#36335
    TabOrder = 3
    object NvDbgridEh1: TNvDbgridEh
      Left = 2
      Top = 45
      Width = 456
      Height = 291
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = DataSource3
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -14
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
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
          FieldName = 'grade'
          Footers = <>
          Title.Caption = #26723#27425
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'routename'
          Footer.Value = #21512#35745
          Footer.ValueType = fvtStaticText
          Footers = <>
          Title.Caption = #32447#36335#21517#31216
          Width = 120
        end
        item
          EditButtons = <>
          FieldName = 'vehicletypename'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #36710#22411#21517#31216
          Width = 120
        end
        item
          EditButtons = <>
          FieldName = 'fromdate'
          Footers = <>
          Title.Caption = #24320#22987#26085#26399
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'todate'
          Footers = <>
          Title.Caption = #32467#26463#26085#26399
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'createname'
          Footers = <>
          Title.Caption = #28155#21152#20154
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'createtime'
          Footers = <>
          Title.Caption = #28155#21152#26102#38388
          Width = 140
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object ToolBar1: TToolBar
      Left = 2
      Top = 16
      Width = 456
      Height = 29
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar1'
      Images = ilToolBar
      TabOrder = 1
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton2: TToolButton
        Left = 8
        Top = 0
        Hint = #28155#21152
        Caption = 'ToolButton1'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton2Click
      end
      object ToolButton3: TToolButton
        Left = 39
        Top = 0
        Hint = #20462#25913
        Caption = 'ToolButton2'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton3Click
      end
      object ToolButton4: TToolButton
        Left = 70
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 78
        Top = 0
        Hint = #27880#38144
        Caption = 'ToolButton8'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton5Click
      end
      object ToolButton6: TToolButton
        Left = 109
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 3
        Style = tbsSeparator
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 192
  end
  inherited ilToolBarDisable: TImageList
    Left = 152
    Top = 184
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'datalist'
    QueryAddress = 'ticketprice/qryFuelfeegrade'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 232
  end
  inherited dsResult: TDataSource
    Left = 216
    Top = 184
  end
  object jscddelFuelfeegrade: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delFuelfeegrade'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fuelfeegrade.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 312
    Top = 96
  end
  object jcdsqryDistance: TjsonClientDataSet
    DataSourceName = 'fuelfeegradedetaillist'
    QueryAddress = 'ticketprice/qryFuelfeegradedetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Filtered = True
    Params = <
      item
        DataType = ftBCD
        Name = 'fuelfeegradeid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 200
    Top = 360
  end
  object DataSource1: TDataSource
    DataSet = jcdsqryDistance
    Left = 96
    Top = 360
  end
  object jscdDelfuelfeegradedetail: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delFuelfeegradedetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 280
  end
  object jscdDelDistance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delFuelfeegradedetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 280
    Top = 352
  end
  object jscdqryFuelfeegradeapply: TjsonClientDataSet
    DataSourceName = 'fuelfeegradeapplylist'
    QueryAddress = 'ticketprice/qryFuelfeegradeapply'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_f!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!routeid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 560
    Top = 248
  end
  object DataSource2: TDataSource
    DataSet = jscdqryFuelfeegradeapply
    Left = 664
    Top = 144
  end
  object DataSource3: TDataSource
    DataSet = jscdqryFuelfeegradeapply
    Left = 560
    Top = 184
  end
  object jscdDelFuelfeegradeapply: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delFuelfeegradeapply'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fuelfeegradeapply.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 696
    Top = 240
  end
end
