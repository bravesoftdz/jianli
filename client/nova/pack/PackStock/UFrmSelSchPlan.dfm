inherited FrmSelSchPlan: TFrmSelSchPlan
  Caption = #34892#21253#31614#21457
  ClientHeight = 559
  ClientWidth = 936
  Position = poScreenCenter
  WindowState = wsNormal
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 952
  ExplicitHeight = 597
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel [0]
    Left = 210
    Top = 26
    Width = 56
    Height = 14
    Caption = #25253#21040#36710#36742
  end
  inherited pnlQuery: TPanel
    Width = 936
    Height = 67
    ExplicitWidth = 936
    ExplicitHeight = 67
    object lbldate: TLabel
      Left = 26
      Top = 28
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lblstation: TLabel
      Left = 210
      Top = 26
      Width = 56
      Height = 14
      Caption = #25253#21040#36710#36742
    end
    object lblpackno: TLabel
      Left = 399
      Top = 27
      Width = 56
      Height = 14
      Caption = #34892#21253#21333#21495
    end
    object lbl2: TLabel
      Left = 610
      Top = 26
      Width = 56
      Height = 14
      Caption = #35745#21010#29677#27425
    end
    object dtpstartdate: TDateTimePicker
      Left = 88
      Top = 24
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 0
      OnChange = dtpstartdateChange
    end
    object nvhlpVehicle: TNovaHelp
      Left = 272
      Top = 24
      Width = 112
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
          FieldName = 'vehicleno'
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'schcode'
          Title.Caption = #29677#27425#21495
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'vehicleno'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'schedulelist'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'pack/qrysendVehicle'
      Params = <
        item
          DataType = ftString
          Name = 'departdate'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object nvedtpackno: TNovaEdit
      Left = 461
      Top = 24
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 2
      OnKeyDown = showPackInfo
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
    object nvhlpScheduleHelp: TNovaHelp
      Left = 672
      Top = 24
      Width = 112
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
          FieldName = 'code'
          Title.Caption = #29677#27425#21495
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'code'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'schedulelist'
      HelpOptions.HelpType = 'scheduleplanHelp'
      HelpOptions.HQueryAddress = 'pack/qrysendSchedulePlan'
      Params = <
        item
          DataType = ftString
          Name = 'departdate'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 936
    ExplicitWidth = 936
    inherited tbtnFilter: TToolButton
      Caption = ' &F.'#26597#35810' '
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = '  '#31614#21457'   '
      ImageIndex = 43
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
    inherited tbtnSave: TToolButton
      AutoSize = True
      Visible = False
      ExplicitWidth = 39
    end
    inherited tbtnCancel: TToolButton
      Left = 371
      AutoSize = True
      Caption = ''
      Visible = False
      ExplicitLeft = 371
      ExplicitWidth = 31
    end
    inherited ToolButton52: TToolButton
      Left = 402
      ExplicitLeft = 402
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 420
      ExplicitLeft = 420
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 438
      Visible = False
      ExplicitLeft = 438
    end
    inherited tbtnInfo: TToolButton
      Left = 446
      Visible = False
      ExplicitLeft = 446
    end
    inherited tbtn5: TToolButton
      Left = 516
      Visible = False
      ExplicitLeft = 516
    end
    inherited tbtnExcel: TToolButton
      Left = 524
      Visible = False
      ExplicitLeft = 524
    end
    inherited tbtnPrinter: TToolButton
      Left = 594
      Visible = False
      ExplicitLeft = 594
    end
    inherited tbtn6: TToolButton
      Left = 664
      Visible = False
      ExplicitLeft = 664
    end
    inherited tbtnClose: TToolButton
      Left = 672
      ExplicitLeft = 672
    end
  end
  inherited Panel1: TPanel
    Top = 201
    Width = 936
    Height = 358
    ExplicitTop = 201
    ExplicitWidth = 936
    ExplicitHeight = 358
    inherited GroupBox1: TGroupBox
      Width = 936
      Height = 358
      Caption = #31614#21457#34892#21253#20449#24687
      ExplicitWidth = 936
      ExplicitHeight = 358
      inherited dbgrdhResult: TNvDbgridEh
        Width = 932
        Height = 340
        DataSource = DataSource1
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ischoose'
            Footers = <>
            Visible = False
            Width = 133
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #34892#21253#21333#21495
            Width = 114
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #20184#27454#26041#24335
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'signtime'
            Footers = <>
            Title.Caption = #31614#21457#26102#38388
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'signby'
            Footers = <>
            Title.Caption = #31614#21457#20154
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20214#25968
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Caption = #36135#29289#21517#31216
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'shipprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25176#36816#36153
          end
          item
            EditButtons = <>
            FieldName = 'packfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21253#35013#36153
          end
          item
            EditButtons = <>
            FieldName = 'handfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #35013#21368#36153
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'insuredamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#20215#37329#39069
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'transitfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20013#36716#36153
          end
          item
            EditButtons = <>
            FieldName = 'insurancefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#20215#36153
          end
          item
            EditButtons = <>
            FieldName = 'insurance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153
          end
          item
            EditButtons = <>
            FieldName = 'deliveryfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36865#36135#36153
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#36153#29992
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21512#35745#37329#39069
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'packedname'
            Footers = <>
            Title.Caption = #21253#35013
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #21457#36135#31449
            Visible = False
            Width = 152
          end
          item
            EditButtons = <>
            FieldName = 'payvalue'
            Footers = <>
            Title.Caption = #30446#30340#22320
            Visible = False
            Width = 161
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Visible = False
            Width = 134
          end
          item
            EditButtons = <>
            FieldName = 'weight'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37325#37327
          end>
      end
    end
  end
  object GroupBox3: TGroupBox [4]
    Left = 0
    Top = 112
    Width = 936
    Height = 89
    Align = alTop
    Caption = #29677#27425#20449#24687
    TabOrder = 3
    object NvDbgridEh2: TNvDbgridEh
      Left = 2
      Top = 16
      Width = 932
      Height = 71
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
          FieldName = 'departdate'
          Footers = <>
          Title.Caption = #21457#36710#26085#26399
          Width = 104
        end
        item
          EditButtons = <>
          FieldName = 'code'
          Footers = <>
          Title.Caption = #29677#27425#21495
          Width = 88
        end
        item
          EditButtons = <>
          FieldName = 'departtime'
          Footers = <>
          Title.Caption = #21457#36710#26102#38388
          Width = 103
        end
        item
          EditButtons = <>
          FieldName = 'vehicleno'
          Footers = <>
          Title.Caption = #36710#29260#21495
          Width = 94
        end
        item
          EditButtons = <>
          FieldName = 'unitname'
          Footers = <>
          Title.Caption = #33829#36816#21333#20301
          Width = 138
        end
        item
          EditButtons = <>
          FieldName = 'mobilephone'
          Footers = <>
          Title.Caption = #39550#39542#21592#30005#35805
          Width = 139
        end
        item
          EditButtons = <>
          FieldName = 'pieces'
          Footers = <>
          Title.Caption = ' '#20214#25968
          Width = 53
        end
        item
          EditButtons = <>
          FieldName = 'totalfee'
          Footers = <>
          Title.Caption = #32467#31639#37329#39069
          Width = 114
        end
        item
          EditButtons = <>
          FieldName = 'isdeparted'
          Footers = <>
          Title.Caption = #26159#21542#24050#21457#29677
          Title.EndEllipsis = True
          Visible = False
          Width = 94
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Footers = <>
          Title.Caption = #29366#24577
          Visible = False
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'collectstatus'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'vehiclereportid'
          Footers = <>
          Visible = False
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'scheduleid'
          Footers = <>
          Visible = False
          Width = 75
        end>
      object RowDetailData: TRowDetailPanelControlEh
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 0
          Height = 0
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          TabOrder = 0
          object GroupBox4: TGroupBox
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            Caption = #26597#35810#32467#26524
            TabOrder = 0
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 688
    Top = 408
  end
  inherited ilToolBarDisable: TImageList
    Left = 768
    Top = 408
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'pack/querystockschedule'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sd!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sd!routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vep!reportorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isreported'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_vep!isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_p!packno'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 64
    Top = 304
  end
  inherited dsResult: TDataSource
    DataSet = jscdQrySch
    Left = 264
    Top = 168
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 592
    Top = 400
  end
  object jcdsupdatepackschedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/senderpack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'flag_pack'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 524
    Top = 152
  end
  object jcdsupdateBillinuse: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/updateBillinuse'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'billinusestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinusenextno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billtypecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinusenextform'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 716
    Top = 144
  end
  object tmGetCurInvoinNo: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmGetCurInvoinNoTimer
    Left = 64
    Top = 416
  end
  object jscdQrySch: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'pack/querystockschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQD_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vr!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sp!id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jscdQrySchAfterScroll
    Left = 168
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = jscdquerystockSendPack
    Left = 392
    Top = 416
  end
  object jscdquerystockSendPack: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'pack/querystockSendPack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag_pack'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 328
  end
end
