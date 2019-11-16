inherited FrmPackArrive: TFrmPackArrive
  Caption = #34892#21253#20986#24211#32467#31639
  ClientHeight = 606
  ClientWidth = 974
  OnResize = FormResize
  ExplicitWidth = 990
  ExplicitHeight = 644
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 974
    Height = 108
    ExplicitWidth = 974
    ExplicitHeight = 108
    object Label1: TLabel
      Left = 187
      Top = 79
      Width = 56
      Height = 14
      Caption = #25910#35755#21333#21495
    end
    object Label2: TLabel
      Left = 14
      Top = 38
      Width = 56
      Height = 14
      Caption = #25910#35755#26085#26399
    end
    object Label4: TLabel
      Left = 205
      Top = 38
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label6: TLabel
      Left = 380
      Top = 38
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label3: TLabel
      Left = 14
      Top = 79
      Width = 56
      Height = 14
      Caption = #32467#31639#29366#24577
    end
    object NovaPackarriverno: TNovaEdit
      Left = 254
      Top = 76
      Width = 110
      Height = 22
      MaxLength = 50
      TabOrder = 0
      OnKeyPress = NovaPackarrivernoKeyPress
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
      Left = 78
      Top = 35
      Width = 108
      Height = 22
      Date = 42142.780504756940000000
      Time = 42142.780504756940000000
      TabOrder = 1
    end
    object NovaArriverEnddate: TDateTimePicker
      Left = 256
      Top = 35
      Width = 108
      Height = 22
      Date = 42142.780504756940000000
      Time = 42142.780504756940000000
      TabOrder = 2
    end
    object NovaHelpVehicle: TNovaHelp
      Left = 441
      Top = 35
      Width = 121
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
          FieldName = 'vehicleno'
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'vehicleno'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehicleReportHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_v!balanceunitid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!scheduleid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_EQL_r!id'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object chkAutoAdd: TCheckBox
      Left = 384
      Top = 76
      Width = 107
      Height = 17
      Caption = #21152#20837#32467#31639#21015#34920
      TabOrder = 4
    end
    object NvPackbalanceStatus: TNovaCheckedComboBox
      Left = 78
      Top = 76
      Width = 81
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
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
          Value = 'packarriver'
        end
        item
          DataType = ftString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'status'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 974
    ExplicitWidth = 974
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #32467#31639
      ImageIndex = 14
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Caption = #27880#38144
      ImageIndex = 50
      Visible = False
      OnClick = tbtnEditClick
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
    Top = 153
    Width = 974
    Height = 453
    ExplicitTop = 153
    ExplicitWidth = 974
    ExplicitHeight = 453
    object Splitter1: TSplitter [0]
      Left = 485
      Top = 0
      Width = 5
      Height = 453
      ExplicitLeft = 488
      ExplicitTop = 6
      ExplicitHeight = 439
    end
    inherited GroupBox1: TGroupBox
      Left = 490
      Width = 484
      Height = 453
      Caption = #24050#20986#24211#24453#32467#31639#21306
      ExplicitLeft = 490
      ExplicitWidth = 484
      ExplicitHeight = 453
      inherited dbgrdhResult: TNvDbgridEh
        Width = 480
        Height = 435
        DataSource = DataSource1
        FooterRowCount = 1
        PopupMenu = PopupMenu2
        SumList.Active = True
        OnDblClick = dbgrdhResultDblClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'packarriverno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25910#35755#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20214#25968
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'packfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36135#27454
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'balanceby'
            Footers = <>
            Title.Caption = #32467#31639#20154
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'balancetime'
            Footers = <>
            Title.Caption = #32467#31639#26085#26399
            Visible = False
            Width = 80
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 485
      Height = 453
      Align = alLeft
      Caption = #24050#20986#24211#27719#24635
      TabOrder = 1
      object Nvarrivetotal: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 481
        Height = 435
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
        ImeMode = imClose
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = #23435#20307
        TitleFont.Style = [fsBold]
        OnDblClick = NvarrivetotalDblClick
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
            FieldName = 'packarriverno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25910#35755#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20214#25968
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'packfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36135#27454
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'balancemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#32467#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26381#21153#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'balanceby'
            Footers = <>
            Title.Caption = #32467#31639#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'balancetime'
            Footers = <>
            Title.Caption = #32467#31639#26085#26399
            Width = 80
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 176
    Top = 416
  end
  inherited ilToolBarDisable: TImageList
    Left = 208
    Top = 416
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'qryPackArrive'
    QueryAddress = 'pack/qryPackArrive'
    SaveAddress = 'pack/canclePackBalance'
    Params = <
      item
        DataType = ftString
        Name = 'packarriverno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'arriverdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'arriverenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriverid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tflag'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    Left = 376
    Top = 392
    object jcdsResultpackarriverno: TWideStringField
      FieldName = 'packarriverno'
      Size = 100
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 100
    end
    object jcdsResultpackfee: TFloatField
      FieldName = 'packfee'
    end
    object jcdsResultpackprice: TFloatField
      FieldName = 'packprice'
    end
    object jcdsResultpieces: TLargeintField
      FieldName = 'pieces'
    end
    object jcdsResultservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultbalancemoney: TFloatField
      FieldName = 'balancemoney'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 100
    end
    object jcdsResultbalancetime: TWideStringField
      FieldName = 'balancetime'
      Size = 100
    end
    object jcdsResultbalancby: TWideStringField
      FieldName = 'balanceby'
      Size = 100
    end
    object jcdsResultpackstatus: TWideStringField
      FieldName = 'packstatus'
      Size = 100
    end
  end
  inherited dsResult: TDataSource
    Left = 376
    Top = 448
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 888
    Top = 80
  end
  object PopupMenu1: TPopupMenu
    Left = 336
    Top = 288
    object N1: TMenuItem
      Caption = #21152#20837#21040#24453#32467#31639#21306
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = #21152#20837#25152#26377#21040#24453#32467#31639#21306
      OnClick = N3Click
    end
  end
  object DataSource1: TDataSource
    DataSet = jcdsarrivebalances
    Left = 816
    Top = 480
  end
  object PopupMenu2: TPopupMenu
    Left = 560
    Top = 288
    object MenuItem1: TMenuItem
      Caption = #31227#38500#24403#21069
      OnClick = MenuItem1Click
    end
    object N2: TMenuItem
      Caption = #31227#38500#25152#26377
      OnClick = N2Click
    end
  end
  object qrypackarrive: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/qryBalanceByNo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tflag'
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
    Left = 152
    Top = 296
  end
  object jcdsarrivebalances: TjsonClientDataSet
    DataSourceName = 'dataSet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 688
    Top = 384
    object jcdsarrivebalancespackarriverno: TWideStringField
      FieldName = 'packarriverno'
      Size = 100
    end
    object jcdsarrivebalancesroutename: TWideStringField
      FieldName = 'routename'
      Size = 100
    end
    object jcdsarrivebalancespackfee: TFloatField
      FieldName = 'packfee'
    end
    object jcdsarrivebalancespackprice: TFloatField
      FieldName = 'packprice'
    end
    object jcdsarrivebalancespieces: TLargeintField
      FieldName = 'pieces'
    end
    object jcdsarrivebalancesservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object jcdsarrivebalancesid: TLargeintField
      FieldName = 'id'
    end
    object jcdsarrivebalancesbalancemoney: TFloatField
      FieldName = 'balancemoney'
    end
    object jcdsarrivebalancesstatus: TWideStringField
      FieldName = 'status'
      Size = 100
    end
    object jcdsarrivebalancesbalancetime: TWideStringField
      FieldName = 'balancetime'
      Size = 100
    end
    object jcdsarrivebalancesbalanceby: TWideStringField
      FieldName = 'balanceby'
      Size = 100
    end
    object jcdsarrivebalancespackstatus: TWideStringField
      FieldName = 'packstatus'
      Size = 100
    end
  end
end
