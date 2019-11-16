inherited FrmOvertimePlaninfo: TFrmOvertimePlaninfo
  Caption = #26410#26469'20'#22825#30340#29677#27425#33829#36816#35745#21010#20449#24687
  ClientHeight = 575
  ClientWidth = 794
  OnCreate = FormCreate
  OnDeactivate = nil
  OnShow = FormShow
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 794
    Height = 530
    ExplicitWidth = 794
    ExplicitHeight = 530
    inherited Bevel1: TBevel
      Top = 522
      Width = 760
      ExplicitTop = 308
      ExplicitWidth = 575
    end
    object Splitter1: TSplitter
      Left = 0
      Top = 379
      Width = 794
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 65
      ExplicitWidth = 218
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 382
      Width = 794
      Height = 148
      Align = alBottom
      Caption = #25191#34892#31080#20215#20449#24687
      TabOrder = 0
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 790
        Height = 130
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsTicketprice
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
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
        PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
        ParentName = 'FrmExecutePrice'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footers = <>
            Title.Caption = #19978#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Footers = <>
            Title.Caption = #20801#35768#21806#31080
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #24050#21806
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#31080#20215
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#31080#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'toplimitprice'
            Footers = <>
            Title.Caption = #19978#38480#20215
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'lowerlimitprice'
            Footers = <>
            Title.Caption = #19979#38480#20215
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'autocancelreserveseatnum'
            Footers = <>
            Title.Caption = #33258#21160#21462#28040#30041#20301#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'fixedreserveseatnum'
            Footers = <>
            Title.Caption = #22266#23450#30041#20301#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'unautocancelreserveseatnum'
            Footers = <>
            Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'residueseatnum'
            Footers = <>
            Title.Caption = #20313#24231
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #20844#37324#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'balancedistance'
            Footers = <>
            Title.Caption = #32467#31639#37324#31243
            Width = 70
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 794
      Height = 379
      Align = alClient
      Caption = #29677#27425#33829#36816#20449#24687
      TabOrder = 1
      object dbgrdhResult: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 790
        Height = 361
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsResult
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
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
        jsonConnection = DMPublic.jcon
        ParentName = 'SimpleCRUDForm'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #26426#26500
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schedulestatus'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24635#24231#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #24050#21806
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'fixedreserveseatnum'
            Footers = <>
            Title.Caption = #22266#23450#30041#20301#25968
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'autocancelreserveseatnum'
            Footers = <>
            Title.Caption = #33258#21160#21462#28040#30041#20301#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'unautocancelreserveseatnum'
            Footers = <>
            Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
            Width = 128
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #19978#36710#21345#20301
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #35745#21010#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'brandname'
            Footers = <>
            Title.Caption = #36710#36742#21378#29260
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #20844#37324#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'driver1'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'1'
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'driver2'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'2'
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'driver3'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'3'
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'steward1'
            Footers = <>
            Title.Caption = #35745#21010#20056#21153#21592
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'isreported'
            Footers = <>
            Title.Caption = #25253#21040
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isbegincheck'
            Footers = <>
            Title.Caption = #24320#26816
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #21457#29677
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'districttypename'
            Footers = <>
            Title.Caption = #36816#34892#21306#22495
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'scheduletypename'
            Footers = <>
            Title.Caption = #29677#27425#31867#22411
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'workwaysname'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'highdistance'
            Footers = <>
            Title.Caption = #39640#36895#37324#31243
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'iscanmixcheck'
            Footers = <>
            Title.Caption = #28151#26816
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'isoriginator'
            Footers = <>
            Title.Caption = #36807#36335#29677#27425
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677#29677#27425
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'isproprietary'
            Footers = <>
            Title.Caption = #26412#31449#19987#33829
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'issaleafterreport'
            Footers = <>
            Title.Caption = #25253#21040#21518#21806#31080
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Footers = <>
            Title.Caption = #20801#35768#21806#31080
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'issellreturnticket'
            Footers = <>
            Title.Caption = #21452#31243#29677#27425
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #27969#27700#29677#27425
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            Title.Caption = #39318#29677#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'spacinginterval'
            Footers = <>
            Title.Caption = #21457#29677#38388#38548
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'endtime'
            Footers = <>
            Title.Caption = #26411#29677#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 150
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 530
    Width = 794
    ExplicitTop = 530
    ExplicitWidth = 794
    inherited bbtnSave: TBitBtn
      Left = 201
      Top = 10
      Visible = False
      ExplicitLeft = 201
      ExplicitTop = 10
    end
    inherited bbtnClose: TBitBtn
      Left = 338
      Height = 26
      ExplicitLeft = 338
      ExplicitHeight = 26
    end
  end
  object jcdsQryScheduleplan: TjsonClientDataSet
    DataSourceName = 'scheduleplanlist'
    QueryAddress = 'ticketprice/qryScheduleplan'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_sp!departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsQryScheduleplanAfterScroll
    Left = 432
    Top = 176
    object jcdsQryScheduleplanid: TLargeintField
      FieldName = 'id'
    end
    object jcdsQryScheduleplanorgname: TWideStringField
      FieldName = 'orgname'
    end
    object jcdsQryScheduleplanroutename: TWideStringField
      FieldName = 'routename'
    end
    object jcdsQryScheduleplancode: TWideStringField
      FieldName = 'code'
      Size = 10
    end
    object jcdsQryScheduleplandistricttype: TWideStringField
      FieldName = 'districttype'
      Size = 10
    end
    object jcdsQryScheduleplandistricttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'districttypename'
      LookupDataSet = jcdsDISTRICTTYPE
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'districttype'
      Lookup = True
    end
    object jcdsQryScheduleplanendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsQryScheduleplanendtime: TWideStringField
      FieldName = 'endtime'
      Size = 10
    end
    object jcdsQryScheduleplanfixedreserveseatnum: TIntegerField
      FieldName = 'fixedreserveseatnum'
    end
    object jcdsQryScheduleplanhighdistance: TIntegerField
      FieldName = 'highdistance'
    end
    object jcdsQryScheduleplaniscanmixcheck: TBooleanField
      FieldName = 'iscanmixcheck'
    end
    object jcdsQryScheduleplanislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsQryScheduleplanisoriginator: TBooleanField
      FieldName = 'isoriginator'
    end
    object jcdsQryScheduleplanisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsQryScheduleplanisproprietary: TBooleanField
      FieldName = 'isproprietary'
    end
    object jcdsQryScheduleplanissaleafterreport: TBooleanField
      FieldName = 'issaleafterreport'
    end
    object jcdsQryScheduleplanissellable: TBooleanField
      FieldName = 'issellable'
    end
    object jcdsQryScheduleplanissellreturnticket: TBooleanField
      FieldName = 'issellreturnticket'
    end
    object jcdsQryScheduleplanorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jcdsQryScheduleplanruntime: TFloatField
      FieldName = 'runtime'
    end
    object jcdsQryScheduleplanscheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsQryScheduleplanscheduletype: TWideStringField
      FieldName = 'scheduletype'
      Size = 10
    end
    object jcdsQryScheduleplanseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsQryScheduleplansoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsQryScheduleplanspacinginterval: TIntegerField
      FieldName = 'spacinginterval'
    end
    object jcdsQryScheduleplanstartstationid: TLargeintField
      FieldName = 'startstationid'
    end
    object jcdsQryScheduleplanstarttime: TWideStringField
      FieldName = 'starttime'
      Size = 10
    end
    object jcdsQryScheduleplanunautocancelreserveseatnum: TIntegerField
      FieldName = 'unautocancelreserveseatnum'
    end
    object jcdsQryScheduleplanworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object jcdsQryScheduleplanworktypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'worktypename'
      LookupDataSet = jcsdWorkType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'worktype'
      Lookup = True
    end
    object jcdsQryScheduleplanworkways: TWideStringField
      FieldName = 'workways'
      Size = 10
    end
    object jcdsQryScheduleplanworkwaysname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'workwaysname'
      LookupDataSet = jcdsworkways
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'workways'
      Lookup = True
    end
    object jcdsQryScheduleplandepartstation: TWideStringField
      FieldName = 'departstation'
    end
    object jcdsQryScheduleplanreachstation: TWideStringField
      FieldName = 'reachstation'
    end
    object jcdsQryScheduleplanbuspark: TWideStringField
      FieldName = 'buspark'
    end
    object jcdsQryScheduleplandeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object jcdsQryScheduleplanisbegincheck: TBooleanField
      FieldName = 'isbegincheck'
    end
    object jcdsQryScheduleplanisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsQryScheduleplanisreported: TBooleanField
      FieldName = 'isreported'
    end
    object jcdsQryScheduleplanstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsQryScheduleplanticketentrance: TWideStringField
      FieldName = 'ticketentrance'
    end
    object jcdsQryScheduleplanautocancelreserveseatnum: TIntegerField
      FieldName = 'autocancelreserveseatnum'
    end
    object jcdsQryScheduleplanscheduletypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'scheduletypename'
      LookupDataSet = jcdstype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'scheduletype'
      Lookup = True
    end
    object jcdsQryScheduleplanrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsQryScheduleplanvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 15
    end
    object jcdsQryScheduleplanbrandname: TWideStringField
      FieldName = 'brandname'
    end
    object jcdsQryScheduleplanbrandmodelid: TLargeintField
      FieldName = 'brandmodelid'
    end
    object jcdsQryScheduleplandriver1: TWideStringField
      FieldName = 'driver1'
    end
    object jcdsQryScheduleplandriver2: TWideStringField
      FieldName = 'driver2'
    end
    object jcdsQryScheduleplandriver3: TWideStringField
      FieldName = 'driver3'
    end
    object jcdsQryScheduleplansteward1: TWideStringField
      FieldName = 'steward1'
    end
    object jcdsQryScheduleplanvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 30
    end
    object jcdsQryScheduleplanschedulestatus: TWideStringField
      FieldKind = fkLookup
      FieldName = 'schedulestatus'
      LookupDataSet = jcdsScheduleStatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object jcdsQryScheduleplandepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsQryScheduleplancreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsQryScheduleplandistance: TIntegerField
      FieldName = 'distance'
    end
  end
  object dsResult: TDataSource
    DataSet = jcdsQryScheduleplan
    Left = 348
    Top = 176
  end
  object jcdsQryTicketprice: TjsonClientDataSet
    DataSourceName = 'ticketpricelist'
    QueryAddress = 'ticketprice/qryTicketprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplan.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 192
    Top = 440
    object jcdsQryTicketpricedepartstation: TWideStringField
      FieldName = 'departstation'
    end
    object jcdsQryTicketpricereachstation: TWideStringField
      FieldName = 'reachstation'
    end
    object jcdsQryTicketpricefullprice: TFloatField
      FieldName = 'fullprice'
    end
    object jcdsQryTicketpricehalfprice: TFloatField
      FieldName = 'halfprice'
    end
    object jcdsQryTicketpriceissellable: TBooleanField
      FieldName = 'issellable'
    end
    object jcdsQryTicketpriceresidueseatnum: TIntegerField
      FieldName = 'residueseatnum'
    end
    object jcdsQryTicketpriceseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsQryTicketpriceseattype: TWideStringField
      FieldName = 'seattype'
      Size = 10
    end
    object jcdsQryTicketpricesoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsQryTicketpricestudentprice: TFloatField
      FieldName = 'studentprice'
    end
    object jcdsQryTicketpricetoplimitprice: TFloatField
      FieldName = 'toplimitprice'
    end
    object jcdsQryTicketpricelowerlimitprice: TFloatField
      FieldName = 'lowerlimitprice'
    end
    object jcdsQryTicketpriceseattypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'seattypename'
      LookupDataSet = jcdsQrySeatType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'seattype'
      Lookup = True
    end
    object jcdsQryTicketpriceruntime: TFloatField
      FieldName = 'runtime'
    end
    object jcdsQryTicketpriceid: TLargeintField
      FieldName = 'id'
    end
    object jcdsQryTicketpriceunautocancelreserveseatnum: TIntegerField
      FieldName = 'unautocancelreserveseatnum'
    end
    object jcdsQryTicketpricefixedreserveseatnum: TIntegerField
      FieldName = 'fixedreserveseatnum'
    end
    object jcdsQryTicketpriceautocancelreserveseatnum: TIntegerField
      FieldName = 'autocancelreserveseatnum'
    end
    object jcdsQryTicketpricestationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object jcdsQryTicketpricefueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object jcdsQryTicketpricedistance: TLargeintField
      FieldName = 'distance'
    end
    object jcdsQryTicketpricebalancedistance: TLargeintField
      FieldName = 'balancedistance'
    end
  end
  object dsTicketprice: TDataSource
    DataSet = jcdsQryTicketprice
    Left = 344
    Top = 440
  end
  object jcdsQrySeatType: TjsonClientDataSet
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
    Left = 480
    Top = 448
  end
  object jcsdWorkType: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'worktype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 240
  end
  object jcdsworkways: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'workways'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 240
  end
  object jcdsDISTRICTTYPE: TjsonClientDataSet
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
        Value = 'route'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'districttype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 240
  end
  object jcdstype: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'scheduletype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 528
    Top = 240
  end
  object jcdsScheduleStatus: TjsonClientDataSet
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
        Value = 'schedulestatus'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'schedulestatus'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 128
    Top = 224
  end
end
