object FrmStandardpriceItem: TFrmStandardpriceItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FrmStandardpriceItem'
  ClientHeight = 314
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object pnlEditBox: TPanel
    Left = 0
    Top = 0
    Width = 446
    Height = 269
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 368
    ExplicitHeight = 224
    DesignSize = (
      446
      269)
    object Bevel1: TBevel
      Left = 16
      Top = 264
      Width = 412
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
      ExplicitTop = 207
      ExplicitWidth = 357
    end
    object NvDbgridEh1: TNvDbgridEh
      Left = 16
      Top = 11
      Width = 385
      Height = 238
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
      ReadOnly = True
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
      PrintOptions = [pghOptimalColWidths]
      PrintAutoNewLine = False
      ParentName = 'FrmStandardpriceItem'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'code'
          Footers = <>
          Title.Caption = #39033#30446#32534#30721
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'name'
          Footers = <>
          Title.Caption = #21517#31216
          Width = 194
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
  end
  object pnlOperation: TPanel
    Left = 0
    Top = 269
    Width = 446
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 224
    ExplicitWidth = 368
    object bbtnClose: TBitBtn
      Left = 142
      Top = 8
      Width = 83
      Height = 25
      Caption = '&Q '#20851#38381
      DoubleBuffered = True
      Kind = bkClose
      ParentDoubleBuffered = False
      TabOrder = 0
    end
  end
  object jscdqryStandardPriceItem: TjsonClientDataSet
    DataSourceName = 'standardpriceitemlist'
    QueryAddress = 'ticketprice/qryStandardPriceItem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_s!scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQC_sd!tickettype'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 192
    Top = 144
  end
  object DataSource1: TDataSource
    DataSet = jscdqryStandardPriceItem
    Left = 104
    Top = 144
  end
end
