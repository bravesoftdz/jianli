inherited FrmModDepartTime: TFrmModDepartTime
  Caption = #20462#25913#37197#23458#31449#21457#36710#26102#38388
  ClientWidth = 462
  ExplicitWidth = 468
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 462
    ExplicitWidth = 462
    inherited Bevel1: TBevel
      Width = 428
      ExplicitWidth = 428
    end
    object Label1: TLabel
      Left = 45
      Top = 32
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object GroupBox1: TGroupBox
      Left = 31
      Top = 80
      Width = 394
      Height = 169
      Caption = #37197#23458#31449#21457#36710#26102#38388
      TabOrder = 0
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 390
        Height = 151
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
        Columns = <
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'scheduleid'
            Footers = <>
            Visible = False
            Width = 78
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object edtNvroute: TNovaEdit
      Left = 110
      Top = 29
      Width = 170
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
    object edtstarttime: TDateTimePicker
      Left = 335
      Top = 24
      Width = 74
      Height = 22
      Date = 40759.000011574070000000
      Format = 'HH:mm'
      Time = 40759.000011574070000000
      Kind = dtkTime
      TabOrder = 2
      Visible = False
    end
  end
  inherited pnlOperation: TPanel
    Width = 462
    ExplicitWidth = 462
    inherited bbtnSave: TBitBtn
      Left = 110
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 110
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 424
    Top = 320
  end
  object jscdQryDepart: TjsonClientDataSet
    DataSourceName = 'datamap'
    UpdateDataSet = 'sslist'
    QueryAddress = 'dispatch/qryDepartTime'
    SaveAddress = 'dispatch/saveDepartTimes'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
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
        Name = 'fromdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = jscdQryDepart
    Left = 184
    Top = 152
  end
end
