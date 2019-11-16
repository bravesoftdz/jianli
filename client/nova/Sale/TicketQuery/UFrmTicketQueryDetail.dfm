inherited FrmTicketQueryDetail: TFrmTicketQueryDetail
  Caption = #29677#27425#21806#31080#35760#24405
  ClientHeight = 490
  ClientWidth = 979
  ExplicitWidth = 985
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 979
    Height = 442
    ExplicitWidth = 979
    ExplicitHeight = 442
    inherited Bevel1: TBevel
      Top = 434
      Width = 945
      ExplicitTop = 383
      ExplicitWidth = 792
    end
    object pnlQuery: TPanel
      Left = 0
      Top = 0
      Width = 979
      Height = 58
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label4: TLabel
        Left = 113
        Top = 26
        Width = 48
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #29677#27425#21495
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 278
        Top = 26
        Width = 64
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #24635#24231#20301#25968
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbl12: TLabel
        Left = 351
        Top = 26
        Width = 8
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '0'
        Color = 15790320
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 445
        Top = 26
        Width = 80
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #24050#21806'('#21512#35745')'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbl13: TLabel
        Left = 537
        Top = 26
        Width = 8
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '0'
        Color = 15790320
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label7: TLabel
        Left = 650
        Top = 26
        Width = 32
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #30041#20301
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbl14: TLabel
        Left = 694
        Top = 26
        Width = 8
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '0'
        Color = 15790320
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label8: TLabel
        Left = 796
        Top = 26
        Width = 32
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #21097#20313
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lbl15: TLabel
        Left = 840
        Top = 26
        Width = 8
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '0'
        Color = 15790320
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lbl101: TLabel
        Left = 165
        Top = 26
        Width = 8
        Height = 16
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '0'
        Color = 15790320
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object nvdbgrdhschedule: TNvDbgridEh
      AlignWithMargins = True
      Left = 2
      Top = 60
      Width = 247
      Height = 380
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsSchedule
      Flat = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = #24494#36719#38597#40657
      FooterFont.Style = []
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      RowHeight = 26
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = #24494#36719#38597#40657
      TitleFont.Style = [fsBold]
      ExpOpenType = AutoOpen
      ShowLineNo = False
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
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'orgname'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #21806#31080#26426#26500
          Width = 111
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'sold'
          Footers = <>
          Title.Caption = #21806#31080#25968
          Width = 47
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'reservation'
          Footers = <>
          Title.Caption = #30041#20301#25968
          Width = 48
        end>
      object RowDetailData: TRowDetailPanelControlEh
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
      end
    end
    object NvDbgridEh1: TNvDbgridEh
      AlignWithMargins = True
      Left = 253
      Top = 60
      Width = 724
      Height = 380
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsDcheduleDetail
      Flat = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = #24494#36719#38597#40657
      FooterFont.Style = []
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      RowHeight = 26
      TabOrder = 2
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = #24494#36719#38597#40657
      TitleFont.Style = [fsBold]
      ExpOpenType = AutoOpen
      ShowLineNo = False
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
          FieldName = 'seatno'
          Footers = <>
          Title.Caption = #24231#21495
          Width = 37
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'organizationname'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #21806#31080#26426#26500
          Width = 110
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'departstationname'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #22987#21457#31449
          Width = 105
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'reachstationname'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #21040#31449
          Width = 100
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'price'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #31080#20215
          Width = 47
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'ticketno'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #31080#21495
          Width = 84
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'tickettype'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #31080#31181
          Width = 52
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'seller'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #21806#31080#21592
          Width = 71
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'remarks'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #22791#27880
          Width = 73
        end>
      object RowDetailData: TRowDetailPanelControlEh
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 442
    Width = 979
    Height = 48
    ExplicitTop = 442
    ExplicitWidth = 979
    ExplicitHeight = 48
    inherited bbtnSave: TBitBtn
      Visible = False
    end
    inherited bbtnClose: TBitBtn
      Visible = False
    end
  end
  inherited ImageList: TImageList
    Left = 8
    Top = 160
  end
  object dsSchedule: TDataSource
    DataSet = jcdsAskScheduleDetail
    Left = 24
    Top = 104
  end
  object jcdsAskScheduleDetail: TjsonClientDataSet
    DataSourceName = 'saleSchedulesDetail1'
    QueryAddress = 'sell/findScheduleDetail'
    SaveAddress = 'sell/findScheduleDetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleDetail.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.departDate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'isnet'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.departStationId'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.reachStationId'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.districtcode'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.flag'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'scheduleDetail.islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.schedulesynccode'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'seatnum'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'residueseatnum'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'soldnum'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'reserved'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 144
    Top = 104
  end
  object jcdsAskDetail: TjsonClientDataSet
    DataSourceName = 'saleSchedulesDetail2'
    QueryAddress = 'sell/findScheduleDetail2'
    SaveAddress = 'sell/findScheduleDetail2'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleDetail.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.departDate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'isnet'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.departStationId'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.reachStationId'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.districtcode'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleDetail.flag'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'scheduleDetail.islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleDetail.schedulesynccode'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 400
    Top = 128
  end
  object dsDcheduleDetail: TDataSource
    DataSet = jcdsAskDetail
    Left = 312
    Top = 96
  end
end
