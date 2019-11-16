inherited FrmQryVehiclebalanced: TFrmQryVehiclebalanced
  Caption = 'FrmQryVehiclebalanced'
  ClientHeight = 385
  ClientWidth = 968
  WindowState = wsNormal
  OnShow = FormShow
  ExplicitWidth = 976
  ExplicitHeight = 419
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 968
    Height = 92
    ExplicitWidth = 968
    ExplicitHeight = 92
    object lbl1: TLabel
      Left = 22
      Top = 26
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl2: TLabel
      Left = 241
      Top = 26
      Width = 56
      Height = 14
      Caption = #32467#24080#26085#26399
    end
    object lbl3: TLabel
      Left = 454
      Top = 26
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl5: TLabel
      Left = 22
      Top = 64
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object Label8: TLabel
      Left = 240
      Top = 64
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object nvcbbNovaCkbOrg: TNovaCheckedComboBox
      Left = 87
      Top = 22
      Width = 133
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
    object dtpBalancedStart: TDateTimePicker
      Left = 306
      Top = 22
      Width = 115
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      TabOrder = 1
    end
    object dtpBalancedEnd: TDateTimePicker
      Left = 478
      Top = 22
      Width = 116
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      TabOrder = 2
    end
    object NovaHelpUnit: TNovaHelp
      Left = 87
      Top = 60
      Width = 133
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
    object NovaHelpVehicle: TNovaHelp
      Left = 306
      Top = 60
      Width = 120
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
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NvDbgridEh2: TNvDbgridEh
      Left = 616
      Top = 10
      Width = 313
      Height = 76
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
      RowDetailPanel.Color = clBtnFace
      TabOrder = 5
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      Visible = False
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
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 968
    ExplicitWidth = 968
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
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
    Top = 137
    Width = 968
    Height = 248
    ExplicitTop = 137
    ExplicitWidth = 968
    ExplicitHeight = 248
    inherited GroupBox1: TGroupBox
      Width = 968
      Height = 248
      ExplicitWidth = 968
      ExplicitHeight = 248
      inherited dbgrdhResult: TNvDbgridEh
        Width = 964
        Height = 230
        DataSource = nil
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        inherited RowDetailData: TRowDetailPanelControlEh
          object NvDbgridEh1: TNvDbgridEh
            Left = 0
            Top = 0
            Width = 0
            Height = 0
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
            ParentName = 'SimpleCRUDForm'
            TitleAlign = taLeftJustify
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 88
    Top = 256
  end
  inherited ilToolBarDisable: TImageList
    Left = 208
    Top = 256
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'balancedlist'
    QueryAddress = 'balance/qryVehicleBalanced'
    Params = <
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceunitid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterOpen = jcdsResultAfterOpen
    Left = 392
    Top = 208
  end
  inherited dsResult: TDataSource
    Left = 304
    Top = 248
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 520
    Top = 248
  end
end
