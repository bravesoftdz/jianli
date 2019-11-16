inherited FrmNoTicketCheck: TFrmNoTicketCheck
  Caption = #26080#31080#26681#26816#31080#20449#24687
  ClientHeight = 379
  ClientWidth = 494
  OnShow = FormShow
  ExplicitWidth = 500
  ExplicitHeight = 411
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 494
    Height = 334
    ExplicitTop = 3
    inherited Bevel1: TBevel
      Top = 326
      Width = 460
    end
    object Label1: TLabel
      Left = 40
      Top = 32
      Width = 56
      Height = 14
      Caption = #36873#20013#31080#25968
    end
    object NovaEdtTickets: TNovaEdit
      Left = 111
      Top = 29
      Width = 104
      Height = 22
      Enabled = False
      MaxLength = 50
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
      Left = 40
      Top = 68
      Width = 417
      Height = 245
      Caption = #25253#21040#36710#36742
      TabOrder = 1
      object nvdbgrdhcodelist: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 413
        Height = 227
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
        FooterRowCount = 1
        ImeMode = imClose
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
        PrintInfo.PageSize.BottomMargin = 1.000000000000000000
        PrintInfo.PageSize.LeftMargin = 1.000000000000000000
        PrintInfo.PageSize.RightMargin = 1.000000000000000000
        PrintInfo.PageSize.TopMargin = 1.000000000000000000
        PrintOptions = [pghOptimalColWidths]
        PrintAutoNewLine = False
        ParentName = 'Frmvehicleregister'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36710#29260#21495#30721
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'reporttime'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25253#21040#26102#38388
            Width = 184
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 334
    Width = 494
    inherited bbtnSave: TBitBtn
      Left = 159
      Top = 6
      Caption = '&S '#30830#23450
      OnClick = bbtnSaveClick
      ExplicitLeft = 159
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 296
      Top = 6
      ExplicitLeft = 296
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 520
    Top = 376
  end
  object jscdQryReportVehicle: TjsonClientDataSet
    DataSourceName = 'reportvehiclelist'
    QueryAddress = 'checkticket/qryReportvehicles'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 144
  end
  object DataSource1: TDataSource
    DataSet = jscdQryReportVehicle
    Left = 256
    Top = 200
  end
  object jscdCheckTickets: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/CheckBynotickets'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
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
    Left = 144
    Top = 200
  end
end
