inherited FrmDeductTypes: TFrmDeductTypes
  Caption = 'FrmDeductTypes'
  ClientHeight = 416
  ClientWidth = 664
  ExplicitWidth = 670
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 664
    Height = 371
    ExplicitWidth = 664
    ExplicitHeight = 371
    inherited Bevel1: TBevel
      Top = 363
      Width = 630
      ExplicitTop = 368
      ExplicitWidth = 542
    end
    object lblroute: TLabel
      Left = 38
      Top = 35
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object nvhlproute: TNovaHelp
      Left = 101
      Top = 31
      Width = 138
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
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
      Params = <>
      notFocusedShowHelp = False
    end
    object GroupBox1: TGroupBox
      Left = 38
      Top = 72
      Width = 587
      Height = 273
      Caption = #25187#36153#26631#20934
      TabOrder = 1
      object dbgrdhResult: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 583
        Height = 255
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = GB2312_CHARSET
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
  end
  inherited pnlOperation: TPanel
    Top = 371
    Width = 664
    ExplicitTop = 371
    ExplicitWidth = 664
    inherited bbtnSave: TBitBtn
      Left = 191
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 191
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 352
      Top = 6
      ExplicitLeft = 352
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 560
    Top = 416
  end
  object jscdQryDeducts: TjsonClientDataSet
    DataSourceName = 'deductitemlist'
    QueryAddress = 'balance/qryStationDeducts'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routeid'
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
    AfterOpen = jscdQryDeductsAfterOpen
    Left = 440
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = jscdQryDeducts
    Left = 344
    Top = 168
  end
  object jscdSaveDeducts: TjsonClientDataSet
    DataSourceName = 'deductitemlist'
    UpdateDataSet = 'drlist'
    SaveAddress = 'balance/saveStationDeducts'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routeid'
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
    AfterOpen = jscdQryDeductsAfterOpen
    Left = 440
    Top = 240
  end
end
