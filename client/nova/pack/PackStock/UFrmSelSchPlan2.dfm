inherited FrmSelSchPlan2: TFrmSelSchPlan2
  Caption = #34892#21253#31614#21457
  ClientHeight = 416
  ClientWidth = 1005
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 1021
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1005
    Height = 84
    ExplicitWidth = 1005
    ExplicitHeight = 84
    object lbldate: TLabel
      Left = 18
      Top = 23
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lblroute: TLabel
      Left = 417
      Top = 23
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lblschedule: TLabel
      Left = 231
      Top = 23
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object lblstation: TLabel
      Left = 19
      Top = 59
      Width = 56
      Height = 14
      Caption = #25253#21040#36710#36742
    end
    object Label2: TLabel
      Left = 203
      Top = 59
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object dtpstartdate: TDateTimePicker
      Left = 82
      Top = 20
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 0
      OnChange = dtpstartdateChange
    end
    object nvhlproute: TNovaHelp
      Left = 479
      Top = 20
      Width = 138
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 1
      OnIdChange = nvhlprouteIdChange
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
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 140
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'departdate'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object nvhlpunit: TNovaHelp
      Left = 265
      Top = 56
      Width = 125
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 25
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
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
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
    object GroupBox3: TGroupBox
      Left = 772
      Top = 16
      Width = 233
      Height = 59
      Caption = #24403#21069#31614#21457#21333#21495
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object lbpackbill: TLabel
        Left = 3
        Top = 32
        Width = 96
        Height = 16
        Caption = '000000000000'
      end
      object Label5: TLabel
        Left = 120
        Top = 32
        Width = 64
        Height = 16
        Caption = #21097#20313#24352#25968
      end
      object lbbillnum: TLabel
        Left = 190
        Top = 32
        Width = 8
        Height = 16
        Caption = '0'
      end
    end
    object nvhlpScheduleHelp: TNovaHelp
      Left = 265
      Top = 20
      Width = 126
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 4
      OnChange = nvhlpScheduleHelpChange
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
    object nvhlpVehicle: TNovaHelp
      Left = 85
      Top = 56
      Width = 112
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 5
      OnChange = nvhlpVehicleChange
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1005
    ExplicitWidth = 1005
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      AlignWithMargins = True
      Caption = #31614#21457
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
    inherited tbtnExcel: TToolButton
      Visible = False
    end
    inherited tbtnPrinter: TToolButton
      Visible = False
    end
    inherited tbtn6: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 129
    Width = 1005
    Height = 287
    ExplicitTop = 129
    ExplicitWidth = 1005
    ExplicitHeight = 287
    inherited GroupBox1: TGroupBox
      Width = 1005
      Height = 287
      Caption = #31614#21457#29677#27425
      ExplicitWidth = 1005
      ExplicitHeight = 287
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1001
        Height = 269
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ischoose'
            Footers = <>
            Title.Caption = #36873#25321
            Visible = False
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #26159#21542#24050#21457#29677
            Title.EndEllipsis = True
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'name1'
            Footers = <>
            Title.Caption = #39550#39542#21592
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #33829#36816#21333#20301
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'vehiclereportid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'scheduleid'
            Footers = <>
            Visible = False
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object GroupBox2: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 0
              Align = alClient
              Caption = #26597#35810#32467#26524
              TabOrder = 0
              object NvDbgridEh1: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 1104
                Height = 324
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
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                RowHeight = 30
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -15
                TitleFont.Name = #23435#20307
                TitleFont.Style = [fsBold]
                UseMultiTitle = True
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
                AutoGridAdject = True
                AutoGridSave = True
                AutoAPPPopuMenu = True
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
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
    Left = 440
    Top = 312
  end
  inherited ilToolBarDisable: TImageList
    Left = 736
    Top = 256
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'pack/querystockschedule'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQD_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sp!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vr!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end>
    ReadOnly = True
    Left = 88
    Top = 192
  end
  inherited dsResult: TDataSource
    Left = 152
    Top = 256
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 560
    Top = 256
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
    Left = 228
    Top = 216
  end
  object tmGetCurInvoinNo: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmGetCurInvoinNoTimer
    Left = 712
    Top = 56
  end
  object jcdsupdatepackschedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/choosenSenderPack'
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
        Name = 'packid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
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
        Name = 'pknos'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 476
    Top = 184
  end
end
