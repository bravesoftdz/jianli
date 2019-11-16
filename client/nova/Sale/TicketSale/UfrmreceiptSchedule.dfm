object frmreceiptSchedule: TfrmreceiptSchedule
  Left = 0
  Top = 0
  Width = 581
  Height = 215
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object nvdbgrdhticketbuffer: TNvDbgridEh
    Left = 0
    Top = 0
    Width = 581
    Height = 215
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabStop = False
    Align = alClient
    AllowedOperations = [alopDeleteEh]
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsTicketBuffer
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = ANSI_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -15
    FooterFont.Name = #24494#36719#38597#40657
    FooterFont.Style = []
    ImeMode = imClose
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ReadOnly = True
    RowDetailPanel.Color = clBtnFace
    SumList.Active = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = #24494#36719#38597#40657
    TitleFont.Style = []
    ExpOpenType = AutoOpen
    AutoSetMultiSelect = False
    AutoSetCtrlKey = True
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
    ParentName = 'FrmSellTicket'
    TitleAlign = taLeftJustify
    Columns = <
      item
        EditButtons = <>
        FieldName = 'departdate'
        Footer.Value = #21512#35745
        Footer.ValueType = fvtStaticText
        Footers = <>
        Title.Caption = #21457#36710#26085#26399
        Width = 88
      end
      item
        EditButtons = <>
        FieldName = 'departtime'
        Footer.ValueType = fvtCount
        Footers = <>
        Title.Caption = #21457#36710#26102#38388
        Width = 63
      end
      item
        EditButtons = <>
        FieldName = 'schedulecode'
        Footers = <>
        Title.Caption = #29677#27425#21495
        Width = 52
      end
      item
        EditButtons = <>
        FieldName = 'departstationname'
        Footers = <>
        Title.Caption = #21457#36710#31449
        Visible = False
        Width = 59
      end
      item
        EditButtons = <>
        FieldName = 'reachstationname'
        Footers = <>
        Title.Caption = #21040#31449
        Width = 76
      end
      item
        EditButtons = <>
        FieldName = 'price'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = #31080#20215
        Width = 62
      end
      item
        EditButtons = <>
        FieldName = 'tickettypename'
        Footers = <>
        Title.Caption = #31080#31181
        Width = 48
      end
      item
        EditButtons = <>
        FieldName = 'ticketnum'
        Footers = <>
        Title.Caption = #31080#25968
        Width = 49
      end
      item
        EditButtons = <>
        FieldName = 'tickettype'
        Footers = <>
        Title.Caption = #31080#31181#20195#30721
        Visible = False
        Width = 67
      end>
    object RowDetailData: TRowDetailPanelControlEh
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
    end
  end
  object dsTicketBuffer: TDataSource
    AutoEdit = False
    DataSet = dsreceipschedule
    Left = 208
    Top = 520
  end
  object dsreceipschedule: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 32
    object dsreceipscheduledepartdate: TDateField
      FieldName = 'departdate'
    end
    object dsreceipscheduledeparttime: TStringField
      FieldName = 'departtime'
    end
    object dsreceipscheduleschedulecode: TStringField
      FieldName = 'schedulecode'
    end
    object dsreceipscheduledepartstationname: TStringField
      FieldName = 'departstationname'
    end
    object dsreceipschedulereachstationname: TStringField
      FieldName = 'reachstationname'
    end
    object dsreceipscheduleprice: TCurrencyField
      FieldName = 'price'
    end
    object dsreceipscheduleticketnum: TStringField
      FieldName = 'ticketnum'
    end
    object dsreceipscheduletickettype: TStringField
      FieldName = 'tickettype'
      Size = 10
    end
    object dsreceipscheduletickettypename: TStringField
      FieldName = 'tickettypename'
      Size = 10
    end
  end
end
