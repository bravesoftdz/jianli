object FrmDptotherDetail: TFrmDptotherDetail
  Left = 0
  Top = 0
  Caption = 'FrmDptotherDetail'
  ClientHeight = 362
  ClientWidth = 1184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object nvdbgrdhdbgrdh1: TNvDbgridEh
    Left = 0
    Top = 0
    Width = 1184
    Height = 362
    Align = alClient
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsResult
    Flat = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    FooterRowCount = 1
    ParentFont = False
    ReadOnly = True
    RowDetailPanel.Color = clBtnFace
    SumList.Active = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
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
    TitleAlign = taLeftJustify
    Columns = <
      item
        EditButtons = <>
        FieldName = 'id'
        Footers = <>
        Visible = False
        Width = 37
      end
      item
        EditButtons = <>
        FieldName = 'departinvoicesno'
        Footer.Value = #21512#35745
        Footer.ValueType = fvtStaticText
        Footers = <>
        Title.Caption = #21333#21495
        Width = 90
      end
      item
        EditButtons = <>
        FieldName = 'schedulename'
        Footer.ValueType = fvtCount
        Footers = <>
        Title.Caption = #29677#27425
        Width = 72
      end
      item
        EditButtons = <>
        FieldName = 'reachstationname'
        Footers = <>
        Title.Caption = #21040#36798#31449
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'departdate'
        Footers = <>
        Title.Caption = #21457#36710#26085#26399
        Width = 90
      end
      item
        EditButtons = <>
        FieldName = 'departtime'
        Footers = <>
        Title.Caption = #21457#36710#26102#38388
        Width = 73
      end
      item
        EditButtons = <>
        FieldName = 'ticketname'
        Footers = <>
        Title.Caption = #36710#31181
        Width = 54
      end
      item
        EditButtons = <>
        FieldName = 'ticketnum'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #26816#31080#25968
        Width = 58
      end
      item
        EditButtons = <>
        FieldName = 'price'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #31080#20215
      end
      item
        EditButtons = <>
        FieldName = 'balanceprice'
        Footer.ValueType = fvtFieldValue
        Footers = <>
        Title.Caption = #32467#31639#31080#20215
        Width = 85
      end
      item
        EditButtons = <>
        FieldName = 'totalamount'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #24635#31080#20215
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'stationservicefee'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #31449#21153#36153
        Width = 74
      end
      item
        EditButtons = <>
        FieldName = 'agentfee'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #23458#36816#20195#29702#36153
        Width = 94
      end
      item
        EditButtons = <>
        FieldName = 'balanceamount'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #32467#31639#37329#39069'  '
        Width = 86
      end
      item
        EditButtons = <>
        FieldName = 'othterfee'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #20854#23427#36153#29992
        Width = 73
      end
      item
        EditButtons = <>
        FieldName = 'distance'
        Footers = <>
        Title.Caption = #37324#31243
        Width = 67
      end
      item
        EditButtons = <>
        FieldName = 'statusname'
        Footers = <>
        Title.Caption = #36816#37327#21333#29366#24577
        Width = 93
      end
      item
        EditButtons = <>
        FieldName = 'createname'
        Footers = <>
        Title.Caption = #21019#24314#20154
        Width = 96
      end
      item
        EditButtons = <>
        FieldName = 'createtime'
        Footers = <>
        Title.Caption = #21019#24314#26102#38388
        Width = 140
      end
      item
        EditButtons = <>
        FieldName = 'updatename'
        Footers = <>
        Title.Caption = #20462#25913#20154
        Width = 90
      end
      item
        EditButtons = <>
        FieldName = 'updatetime'
        Footers = <>
        Title.Caption = #20462#25913#26102#38388
        Visible = False
        Width = 140
      end
      item
        EditButtons = <>
        FieldName = 'fromstationname'
        Footers = <>
        Title.Caption = #19978#36710#31449
        Width = 80
      end>
    object RowDetailData: TRowDetailPanelControlEh
      object mmo: TMemo
        Left = -185
        Top = -89
        Width = 185
        Height = 89
        ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
    end
  end
  object jcdsQrydepartinvoicesotherdetail: TjsonClientDataSet
    DataSourceName = 'otherdetailMap'
    QueryAddress = 'checkticket/querydepartinvoicesotherdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_t!departinvoicesotherid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 56
  end
  object dsResult: TDataSource
    DataSet = jcdsQrydepartinvoicesotherdetail
    Left = 312
    Top = 80
  end
end
