inherited FrmViewSchedulestops: TFrmViewSchedulestops
  Left = 0
  Top = 0
  ActiveControl = nvdbgrdhSchedulestops
  BorderStyle = bsDialog
  Caption = #36884#24452#31449#28857
  ClientHeight = 292
  ClientWidth = 430
  KeyPreview = True
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitTop = -15
  ExplicitWidth = 436
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 15
  object nvdbgrdhSchedulestops: TNvDbgridEh
    Left = 0
    Top = 0
    Width = 430
    Height = 292
    Align = alClient
    ColumnDefValues.Title.TitleButton = True
    DataGrouping.GroupLevels = <>
    DataSource = dsSchedulestops
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = GB2312_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -15
    FooterFont.Name = #23435#20307
    FooterFont.Style = []
    ImeMode = imDisable
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ReadOnly = True
    RowDetailPanel.Color = clBtnFace
    TabOrder = 0
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
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
    ParentName = 'FrmViewSchedulestops'
    TitleAlign = taLeftJustify
    Columns = <
      item
        EditButtons = <>
        FieldName = 'departstationname'
        Footers = <>
        Title.Caption = #21457#36710#31449
        Visible = False
      end
      item
        EditButtons = <>
        FieldName = 'reachstationname'
        Footers = <>
        Title.Caption = #21040#36798#31449
        Width = 88
      end
      item
        EditButtons = <>
        FieldName = 'runtime'
        Footers = <>
        Title.Caption = #36816#34892#26102#38388
        Width = 63
      end
      item
        EditButtons = <>
        FieldName = 'distance'
        Footers = <>
        Title.Caption = #37324#31243
        Width = 44
      end
      item
        EditButtons = <>
        FieldName = 'fullprice'
        Footers = <>
        Title.Caption = #20840#31080#20215
        Width = 49
      end
      item
        EditButtons = <>
        FieldName = 'halfprice'
        Footers = <>
        Title.Caption = #21322#31080#20215
        Width = 47
      end
      item
        EditButtons = <>
        FieldName = 'studentprice'
        Footers = <>
        Title.Caption = #23398#29983#31080#20215
        Width = 60
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object jcdsSchedulestops: TjsonClientDataSet
    DataSourceName = 'schedulestops'
    QueryAddress = 'sell/findSchedulestops'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isnet'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulesynccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationcode'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 160
    Top = 72
  end
  object dsSchedulestops: TDataSource
    DataSet = jcdsSchedulestops
    Left = 216
    Top = 104
  end
end
