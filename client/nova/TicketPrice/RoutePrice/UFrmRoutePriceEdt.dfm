inherited FrmRoutePriceEdt: TFrmRoutePriceEdt
  Caption = 'FrmRoutePriceEdt'
  ClientHeight = 459
  ClientWidth = 716
  Position = poScreenCenter
  OnShow = FormShow
  ExplicitWidth = 722
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 716
    Height = 414
    ExplicitWidth = 716
    ExplicitHeight = 414
    inherited Bevel1: TBevel
      Top = 406
      Width = 682
      ExplicitTop = 320
      ExplicitWidth = 762
    end
    object Label1: TLabel
      Left = 38
      Top = 27
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object NovaEdtRoute: TNovaEdit
      Left = 102
      Top = 22
      Width = 290
      Height = 22
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
      DisEnableColor = clRed
      OnChangeColor = 4901849
    end
    object GroupBox1: TGroupBox
      Left = 32
      Top = 64
      Width = 666
      Height = 329
      Caption = #32447#36335#31080#20215#20449#24687
      TabOrder = 1
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 662
        Height = 311
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSchDiscountPrice
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
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
        PrintOptions = [pghOptimalColWidths]
        PrintAutoNewLine = False
        ParentName = 'FrmHandPriceEdt'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'isbaseprice'
            Footers = <>
            ReadOnly = True
            Title.Caption = #22522#30784#31080#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'fromstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #19978#36710#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'fromdate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24320#22987#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'todate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #32467#26463#26085#26399
            Width = 80
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'price'
            Footers = <>
            Title.Caption = #31080#20215
            Width = 63
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'balanceprice'
            Footers = <>
            Title.Caption = #32467#31639#31080#20215
            Width = 72
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object ChkISSavetoStand: TCheckBox
      Left = 410
      Top = 25
      Width = 239
      Height = 17
      Caption = #21516#26102#25226#22522#30784#31080#20215#20445#23384#21040#26631#20934#31080#20215#20013
      TabOrder = 2
    end
  end
  inherited pnlOperation: TPanel
    Top = 414
    Width = 716
    ExplicitTop = 414
    ExplicitWidth = 716
    inherited bbtnSave: TBitBtn
      Left = 218
      Top = 6
      Height = 28
      OnClick = bbtnSaveClick
      ExplicitLeft = 218
      ExplicitTop = 6
      ExplicitHeight = 28
    end
    inherited bbtnClose: TBitBtn
      Left = 360
      Top = 6
      Height = 28
      ExplicitLeft = 360
      ExplicitTop = 6
      ExplicitHeight = 28
    end
  end
  inherited ImageList: TImageList
    Left = 56
    Top = 216
  end
  object dsSchDiscountPrice: TDataSource
    DataSet = jcsdQrySchDiscountPrice
    Left = 536
    Top = 168
  end
  object jcsdQrySchDiscountPrice: TjsonClientDataSet
    DataSourceName = 'results'
    UpdateDataSet = 'routepricelist'
    QueryAddress = 'ticketprice/qryRoutepriceedt'
    SaveAddress = 'ticketprice/saveRoutePriceAll'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'savestandprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 280
    Top = 192
  end
end
