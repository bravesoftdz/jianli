inherited FrmCheckticketInfo: TFrmCheckticketInfo
  Caption = 'FrmCheckticketInfo'
  ClientHeight = 490
  ClientWidth = 879
  OnShow = FormShow
  ExplicitWidth = 885
  ExplicitHeight = 519
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 879
    Height = 445
    ExplicitWidth = 879
    ExplicitHeight = 445
    inherited Bevel1: TBevel
      Top = 437
      Width = 845
      ExplicitTop = 437
      ExplicitWidth = 702
    end
    object lbl1: TLabel
      Left = 40
      Top = 26
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl2: TLabel
      Left = 239
      Top = 26
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object NovaEdtRoute: TNovaEdit
      Left = 105
      Top = 23
      Width = 121
      Height = 22
      Enabled = False
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
    object NovaEdtCode: TNovaEdit
      Left = 287
      Top = 23
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 50
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
    end
    object grp1: TGroupBox
      Left = 12
      Top = 60
      Width = 856
      Height = 361
      Caption = #36710#31080#26816#31080#20449#24687
      TabOrder = 2
      object nvdbgrdh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 852
        Height = 343
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = ds1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imClose
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        UseMultiTitle = True
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
        PrintOptions = [pghOptimalColWidths]
        PrintAutoNewLine = False
        ParentName = 'FrmCheckticketInfo'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'selected'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#21495
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#21495
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatus'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            ReadOnly = True
            Title.Caption = #26816#31080#29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            Title.Caption = #21457#29677#29366#24577
            Visible = False
            Width = 34
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#20215
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'usercode'
            Footers = <>
            ReadOnly = True
            Title.Caption = #26816#31080#24037#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'carrychildnum'
            Footer.ValueType = fvtSum
            Footers = <>
            ReadOnly = True
            Title.Caption = #20813#31080#20799#31461
            Width = 42
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object chkChecked: TCheckBox
      Left = 424
      Top = 26
      Width = 97
      Height = 17
      Caption = '&F2.'#24050#26816
      TabOrder = 3
      OnClick = chkCheckedClick
    end
    object chkNotChecked: TCheckBox
      Left = 504
      Top = 26
      Width = 97
      Height = 17
      Caption = '&F3.'#26410#26816
      TabOrder = 4
      OnClick = chkNotCheckedClick
    end
  end
  inherited pnlOperation: TPanel
    Top = 445
    Width = 879
    ExplicitTop = 445
    ExplicitWidth = 879
    inherited bbtnSave: TBitBtn
      Left = 271
      Top = 6
      Caption = '&S '#26816#31080
      OnClick = bbtnSaveClick
      ExplicitLeft = 271
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 480
      Top = 6
      ExplicitLeft = 480
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 96
    Top = 136
  end
  object ds1: TDataSource
    DataSet = jscdqueryCheckedticket
    Left = 344
    Top = 168
  end
  object jscdqueryCheckedticket: TjsonClientDataSet
    DataSourceName = 'ticketlist'
    QueryAddress = 'checkticket/queryCheckedticket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_t!scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_t!ischecked'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!vehiclereportid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 160
  end
end
