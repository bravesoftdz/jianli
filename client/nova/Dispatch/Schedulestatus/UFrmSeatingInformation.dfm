inherited FrmSeatingInformation: TFrmSeatingInformation
  Caption = #24231#20301#20449#24687
  ClientHeight = 502
  ClientWidth = 706
  OnShow = FormShow
  ExplicitWidth = 712
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 706
    Height = 471
    ExplicitWidth = 706
    ExplicitHeight = 471
    inherited Bevel1: TBevel
      Top = 423
      Width = 74
      Height = 0
      ExplicitTop = 473
      ExplicitWidth = 700
      ExplicitHeight = 0
    end
    object lbldate: TLabel
      Left = 18
      Top = 23
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lblschedule: TLabel
      Left = 366
      Top = 23
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object Label1: TLabel
      Left = 518
      Top = 23
      Width = 28
      Height = 14
      Caption = #26102#38388
    end
    object lblroute: TLabel
      Left = 191
      Top = 23
      Width = 56
      Height = 14
      Caption = #36816#34892#32447#36335
    end
    object NovaEdtDepartTime: TNovaEdit
      Left = 562
      Top = 20
      Width = 99
      Height = 22
      Enabled = False
      MaxLength = 50
      ReadOnly = True
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
      DisEnableType = False
      DisEnableColor = clRed
      OnChangeColor = 4901849
    end
    object dtpstartdate: TDateTimePicker
      Left = 80
      Top = 20
      Width = 99
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      Enabled = False
      ParseInput = True
      TabOrder = 1
    end
    object edtroute: TNovaHelp
      Left = 251
      Top = 20
      Width = 99
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
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
      DisEnableType = False
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
          FieldName = 'endstationcode'
          Title.Caption = #25805#20316#30721
          Width = 120
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 270
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edtschedule: TNovaHelp
      Left = 400
      Top = 20
      Width = 99
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
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
      DisEnableType = False
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #29677#27425
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'code'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'schedulemap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'dispatch/qryRouteschedule'
      Params = <
        item
          DataType = ftBCD
          Name = 'filter_EQL_r!id'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_LIKES_t!code'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 48
      Width = 820
      Height = 417
      Align = alCustom
      TabOrder = 4
      object pnlpicture: TPanel
        Left = 2
        Top = 16
        Width = 326
        Height = 399
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dbgrdhResult: TNvDbgridEh
          Left = 0
          Top = 0
          Width = 326
          Height = 399
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsResult
          Flat = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -15
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          ImeMode = imClose
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = #23435#20307
          TitleFont.Style = [fsBold]
          OnGetCellParams = dbgrdhResultGetCellParams
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
              FieldName = 'seatno'
              Font.Charset = ANSI_CHARSET
              Font.Color = clPurple
              Font.Height = -17
              Font.Name = #23435#20307
              Font.Style = []
              Footers = <>
              Title.Caption = #24231#20301#21495
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'orgname'
              Footers = <>
              Title.Caption = '  '#21806#31080#21333#20301
              Width = 100
            end
            item
              EditButtons = <>
              FieldName = 'tostationname'
              Footers = <>
              Title.Caption = #21040#31449'('#31080#31181')'
              Width = 85
            end
            item
              EditButtons = <>
              FieldName = 'status'
              Footers = <>
              Title.Caption = #29366' '#24577
              Width = 50
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object NvDbgridEh1: TNvDbgridEh
        Left = 328
        Top = 16
        Width = 490
        Height = 399
        Align = alRight
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
        Flat = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -15
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = #23435#20307
        TitleFont.Style = [fsBold]
        OnGetCellParams = NvDbgridEh1GetCellParams
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
            FieldName = 'seatno'
            Font.Charset = ANSI_CHARSET
            Font.Color = clPurple
            Font.Height = -17
            Font.Name = #23435#20307
            Font.Style = []
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = '  '#21806#31080#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'tostationname'
            Footers = <>
            Title.Caption = #21040#31449'('#31080#31181')'
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #29366' '#24577
            Width = 50
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 471
    Width = 706
    Height = 31
    ExplicitTop = 471
    ExplicitWidth = 706
    ExplicitHeight = 31
    inherited bbtnSave: TBitBtn
      Left = 16
      Top = 6
      Visible = False
      ExplicitLeft = 16
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 282
      Top = 6
      Width = 79
      Height = 27
      Align = alCustom
      ExplicitLeft = 282
      ExplicitTop = 6
      ExplicitWidth = 79
      ExplicitHeight = 27
    end
  end
  inherited ImageList: TImageList
    Left = 96
    Top = 336
  end
  object jcdsQrySeatstatusdetail: TjsonClientDataSet
    DataSourceName = 'list1'
    QueryAddress = 'checkticket/qrySeatstatusdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ss!scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQD_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 232
  end
  object dsResult: TDataSource
    DataSet = jcdsQrySeatstatusdetail
    Left = 104
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = jcdsQrySeatstatusdetailend
    Left = 488
    Top = 160
  end
  object jcdsQrySeatstatusdetailend: TjsonClientDataSet
    DataSourceName = 'list2'
    QueryAddress = 'checkticket/qrySeatstatusdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ss!scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQD_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 560
    Top = 280
  end
end
