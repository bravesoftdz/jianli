inherited FrmHandHolidaypriceItem: TFrmHandHolidaypriceItem
  Caption = 'FrmHandHolidaypriceItem'
  ClientHeight = 365
  ClientWidth = 444
  OnShow = FormShow
  ExplicitWidth = 450
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 444
    Height = 320
    ExplicitWidth = 444
    ExplicitHeight = 320
    inherited Bevel1: TBevel
      Top = 312
      Width = 410
      ExplicitTop = 280
      ExplicitWidth = 410
    end
    object NvDbgridEh1: TNvDbgridEh
      Left = 25
      Top = 21
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
      Left = 40
      Top = 288
      Width = 257
      Height = 17
      Caption = #21516#26102#22797#21046#21040#20854#20182#29677#27425#35813#20572#38752#28857
      TabOrder = 1
    end
  end
  inherited pnlOperation: TPanel
    Top = 320
    Width = 444
    ExplicitTop = 320
    ExplicitWidth = 444
    inherited bbtnSave: TBitBtn
      Left = 103
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 103
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 245
      Top = 6
      ExplicitLeft = 245
      ExplicitTop = 6
    end
  end
  object DataSource1: TDataSource
    DataSet = jscdqryTicketPriceItem
    Left = 104
    Top = 144
  end
  object jscdqryTicketPriceItem: TjsonClientDataSet
    DataSourceName = 'itemlist'
    UpdateDataSet = 'hpilist'
    QueryAddress = 'ticketprice/qryHandholidaypriceitem'
    SaveAddress = 'ticketprice/saveHandholidaypriceitem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'handholidaypriceid'
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
    Left = 192
    Top = 144
  end
end
