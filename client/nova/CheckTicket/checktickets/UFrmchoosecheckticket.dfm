inherited Frmchoosecheckticket: TFrmchoosecheckticket
  Caption = #36873#25321#35201#26816#36710#31080
  ClientHeight = 354
  ClientWidth = 650
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 656
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 650
    Height = 309
    ExplicitWidth = 650
    ExplicitHeight = 309
    inherited Bevel1: TBevel
      Top = 301
      Width = 616
      ExplicitTop = 301
      ExplicitWidth = 616
    end
    object dbgrdhResult: TNvDbgridEh
      Left = 0
      Top = 0
      Width = 650
      Height = 309
      Align = alClient
      Color = clWhite
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
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -16
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      ImeMode = imDisable
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
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
          FieldName = 'ticketsellid'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'ticketno'
          Footers = <>
          Title.Caption = #31080#21495
          Width = 89
        end
        item
          EditButtons = <>
          FieldName = 'departdate'
          Footer.Value = #21512#35745
          Footer.ValueType = fvtStaticText
          Footers = <>
          Title.Caption = #21457#36710#26085#26399
          Width = 97
        end
        item
          EditButtons = <>
          FieldName = 'tostation'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #21040#31449
          Width = 97
        end
        item
          EditButtons = <>
          FieldName = 'schedulecode'
          Footers = <>
          Title.Caption = #29677#27425#21495
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'seatno'
          Footers = <>
          Title.Caption = #24231#20301#21495
          Width = 71
        end
        item
          EditButtons = <>
          FieldName = 'ticketstatus'
          Footers = <>
          Title.Caption = #36710#31080#29366#24577
          Width = 120
        end
        item
          EditButtons = <>
          FieldName = 'scheduleplanid'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 309
    Width = 650
    ExplicitTop = 309
    ExplicitWidth = 650
    inherited bbtnSave: TBitBtn
      Caption = '&'#20445#23384
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 376
    Top = 16
  end
  object jcdsQryDetail: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryInvoicesDetailPrintInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 344
  end
  object jcdsqrymulticketnodetail: TjsonClientDataSet
    DataSourceName = 'multicketdetiallist'
    QueryAddress = 'checkticket/qrymultiticketdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate1'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 200
  end
  object dsResult: TDataSource
    DataSet = jcdsqrymulticketnodetail
    Left = 152
    Top = 152
  end
end
