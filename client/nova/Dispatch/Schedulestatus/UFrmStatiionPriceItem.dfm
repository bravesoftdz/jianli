inherited FrmStatiionPriceItem: TFrmStatiionPriceItem
  Caption = 'FrmStatiionPriceItem'
  ClientHeight = 399
  ClientWidth = 489
  OnShow = FormShow
  ExplicitWidth = 495
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 489
    Height = 354
    inherited Bevel1: TBevel
      Top = 346
      Width = 455
    end
    object Label1: TLabel
      Left = 34
      Top = 22
      Width = 406
      Height = 14
      Caption = #35828#26126#65306#20462#25913#31080#20215#20998#39033#30340#20540#19981#20250#25913#21464#35813#31449#28857#30340#31080#20215#65292#21482#25913#21464#22522#30784#36816#20215
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object NvDbgridEh1: TNvDbgridEh
      Left = 31
      Top = 42
      Width = 368
      Height = 246
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
      FooterRowCount = 1
      ImeMode = imClose
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      ExpOpenType = AutoOpen
      AutoSetMultiSelect = False
      AutoSetCtrlKey = False
      PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
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
      ParentName = 'FrmStandardpriceItem'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'code'
          Footers = <>
          ReadOnly = True
          Title.Caption = #39033#30446#32534#30721
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'name'
          Footers = <>
          ReadOnly = True
          Title.Caption = #21517#31216
          Width = 182
        end
        item
          EditButtons = <>
          FieldName = 'price'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #35745#31639#20540
          Width = 60
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object chkCopyOtherSch: TCheckBox
      Left = 31
      Top = 305
      Width = 257
      Height = 17
      Caption = #21516#26102#22797#21046#21040#20854#20182#29677#27425#35813#20572#38752#31449#28857
      TabOrder = 1
    end
  end
  inherited pnlOperation: TPanel
    Top = 354
    Width = 489
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jscdqryTicketPriceItem: TjsonClientDataSet
    DataSourceName = 'itemlist'
    UpdateDataSet = 'tpitemlist'
    QueryAddress = 'ticketprice/qryTicketpriceItem'
    SaveAddress = 'ticketprice/saveTicketpriceitem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketpriceid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'iscopyothersch'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 184
    Top = 128
  end
  object DataSource1: TDataSource
    DataSet = jscdqryTicketPriceItem
    Left = 104
    Top = 144
  end
end
