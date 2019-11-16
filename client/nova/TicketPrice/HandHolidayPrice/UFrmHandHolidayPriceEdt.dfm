inherited FrmHandHolidayPriceEdt: TFrmHandHolidayPriceEdt
  Caption = 'FrmHandHolidayPriceEdt'
  ClientHeight = 492
  ClientWidth = 832
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 838
  ExplicitHeight = 521
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 832
    Height = 447
    ExplicitWidth = 832
    ExplicitHeight = 447
    inherited Bevel1: TBevel
      Top = 439
      Width = 798
      ExplicitTop = 416
      ExplicitWidth = 709
    end
    object Label1: TLabel
      Left = 32
      Top = 33
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label2: TLabel
      Left = 262
      Top = 32
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label3: TLabel
      Left = 448
      Top = 32
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#22411
    end
    object Label4: TLabel
      Left = 60
      Top = 72
      Width = 28
      Height = 14
      Caption = #33410#26085
    end
    object Label5: TLabel
      Left = 248
      Top = 72
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object Label6: TLabel
      Left = 448
      Top = 72
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object NovaEditSchedule: TNovaEdit
      Left = 310
      Top = 29
      Width = 121
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
    object NovaEdtRoute: TNovaEdit
      Left = 94
      Top = 29
      Width = 147
      Height = 22
      MaxLength = 50
      ReadOnly = True
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
    object NvCcbVehileType: TNovaCheckedComboBox
      Left = 510
      Top = 29
      Width = 145
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      OnCheckClick = NvCcbVehileTypeCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'vehiclettypelist'
      HelpOptions.HQueryAddress = 'ticketprice/qryholidayVehicletype'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'scheduleid'
          ParamType = ptInput
        end>
    end
    object GroupBox1: TGroupBox
      Left = 15
      Top = 104
      Width = 802
      Height = 329
      Caption = #33410#26085#31080#20215#20449#24687
      TabOrder = 3
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 798
        Height = 311
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsholidayprice
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
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
            FieldName = 'departstation'
            Footers = <>
            ReadOnly = True
            Title.Caption = #19978#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'vehicletype'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#22411
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#31867#22411
            Width = 68
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#20215
            Width = 60
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#20215
            Width = 60
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 60
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'toplimitprice'
            Footers = <>
            Title.Caption = #19978#38480#20215
            Width = 55
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'lowerlimitprice'
            Footers = <>
            Title.Caption = #19979#38480#20215
            Width = 54
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object DateTpFromDate: TDateTimePicker
      Left = 310
      Top = 69
      Width = 115
      Height = 22
      Date = 40614.716442233800000000
      Time = 40614.716442233800000000
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 4
      OnChange = DateTpFromDateChange
    end
    object DateTpEndDate: TDateTimePicker
      Left = 510
      Top = 69
      Width = 107
      Height = 22
      Date = 40614.716442233800000000
      Time = 40614.716442233800000000
      TabOrder = 5
      OnChange = DateTpEndDateChange
    end
    object NovaHcbbHoliday: TNovaHComboBox
      Left = 94
      Top = 69
      Width = 147
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 6
      OnChange = NovaHcbbHolidayChange
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'HolidayHelp'
        end
        item
          DataType = ftString
          Name = 'filter_GED_t!enddate'
          ParamType = ptInput
        end>
    end
    object chkIsSameRoute: TCheckBox
      Left = 623
      Top = 72
      Width = 179
      Height = 17
      Caption = #21516#26102#22797#21046#26412#32447#36335#20854#20182#29677#27425
      TabOrder = 7
    end
  end
  inherited pnlOperation: TPanel
    Top = 447
    Width = 832
    ExplicitTop = 447
    ExplicitWidth = 832
    inherited bbtnSave: TBitBtn
      Left = 248
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 248
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 408
      Top = 6
      ExplicitLeft = 408
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 176
    Top = 208
  end
  object jscdQryVehicleType: TjsonClientDataSet
    DataSourceName = 'vehiclettypelist'
    QueryAddress = 'ticketprice/qryholidayVehicletype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 216
  end
  object jcsdQryDepartStation: TjsonClientDataSet
    DataSourceName = 'schedulestoplist'
    QueryAddress = 'ticketprice/qryScheduleDepartStop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isdepart'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 424
    Top = 272
  end
  object jcdsQryStopStation: TjsonClientDataSet
    DataSourceName = 'schedulestoplist'
    QueryAddress = 'ticketprice/qryScheduleReachStop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isdepart'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 552
    Top = 336
  end
  object dsholidayprice: TDataSource
    DataSet = jcsdQryHolidayHandprice
    Left = 72
    Top = 192
  end
  object jcdsQrySeatTypes: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'handprice'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'seattype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 280
  end
  object jcsdQryHolidayHandprice: TjsonClientDataSet
    DataSourceName = 'handholidaypricelist'
    UpdateDataSet = 'handholidayprices'
    QueryAddress = 'ticketprice/qryedthandholidayprice'
    SaveAddress = 'ticketprice/savehandholidayprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'holiday.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletypeids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'savesameroute'
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
    Left = 176
    Top = 328
    object jcsdQryHolidayHandpriceid: TLargeintField
      FieldName = 'id'
    end
    object jcsdQryHolidayHandpriceholidayid: TLargeintField
      FieldName = 'holidayid'
    end
    object jcsdQryHolidayHandpricestartdate: TDateField
      FieldName = 'startdate'
    end
    object jcsdQryHolidayHandpriceenddate: TDateField
      FieldName = 'enddate'
    end
    object jcsdQryHolidayHandpricescheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcsdQryHolidayHandpricevehicletypeid: TLargeintField
      FieldName = 'vehicletypeid'
    end
    object jcsdQryHolidayHandpricevehicletype: TWideStringField
      FieldKind = fkLookup
      FieldName = 'vehicletype'
      LookupDataSet = jscdQryVehicleType
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'vehicletypeid'
      Lookup = True
    end
    object jcsdQryHolidayHandpricevehiclebrandmodelid: TLargeintField
      FieldName = 'vehiclebrandmodelid'
    end
    object jcsdQryHolidayHandpricedepartstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcsdQryHolidayHandpricedepartstation: TWideStringField
      FieldKind = fkLookup
      FieldName = 'departstation'
      LookupDataSet = jcsdQryDepartStation
      LookupKeyFields = 'stationid'
      LookupResultField = 'stationname'
      KeyFields = 'departstationid'
      Lookup = True
    end
    object jcsdQryHolidayHandpricereachstationid: TLargeintField
      FieldName = 'reachstationid'
    end
    object jcsdQryHolidayHandpricereachstation: TWideStringField
      FieldKind = fkLookup
      FieldName = 'reachstation'
      LookupDataSet = jcdsQryStopStation
      LookupKeyFields = 'stationid'
      LookupResultField = 'stationname'
      KeyFields = 'reachstationid'
      Lookup = True
    end
    object jcsdQryHolidayHandpriceseattype: TWideStringField
      FieldName = 'seattype'
      Size = 10
    end
    object jcsdQryHolidayHandpriceseattypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'seattypename'
      LookupDataSet = jcdsQrySeatTypes
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'seattype'
      Lookup = True
    end
    object jcsdQryHolidayHandpriceseats: TWideStringField
      FieldName = 'seats'
      Size = 100
    end
    object jcsdQryHolidayHandpricefullprice: TFloatField
      FieldName = 'fullprice'
      OnChange = jcsdQryHolidayHandpricefullpriceChange
    end
    object jcsdQryHolidayHandpricehalfprice: TFloatField
      FieldName = 'halfprice'
      OnChange = jcsdQryHolidayHandpricehalfpriceChange
    end
    object jcsdQryHolidayHandpricestudentprice: TFloatField
      FieldName = 'studentprice'
      OnChange = jcsdQryHolidayHandpricestudentpriceChange
    end
    object jcsdQryHolidayHandpricetoplimitprice: TFloatField
      FieldName = 'toplimitprice'
    end
    object jcsdQryHolidayHandpricelowerlimitprice: TFloatField
      FieldName = 'lowerlimitprice'
    end
    object jcsdQryHolidayHandpricecreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcsdQryHolidayHandpricemoreprice: TFloatField
      FieldName = 'moreprice'
    end
  end
end
