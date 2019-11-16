inherited FrmTicketoutletsPriceEdt: TFrmTicketoutletsPriceEdt
  Caption = #21806#31080#28857#31080#20215#24046#39069#35774#32622
  ClientHeight = 549
  ClientWidth = 909
  OnShow = FormShow
  ExplicitTop = -27
  ExplicitWidth = 915
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 909
    Height = 504
    ExplicitWidth = 909
    ExplicitHeight = 504
    inherited Bevel1: TBevel
      Top = 496
      Width = 875
      ExplicitTop = 404
      ExplicitWidth = 592
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 153
      Width = 909
      Height = 337
      Align = alTop
      Caption = #24179#26102#30828#35843#31080#20215#20449#24687
      TabOrder = 0
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 905
        Height = 319
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dshandprice
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
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            ReadOnly = True
            Title.Caption = #19978#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicletype'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#22411
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'brandname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21378#29260
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20840#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21322#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            ReadOnly = True
            Title.Caption = #23398#29983#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'difprice'
            Footers = <>
            Title.Caption = #21806#31080#28857#31080#20215#24046#39069
            Width = 111
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            Title.Caption = #24320#22987#26085#26399
          end
          item
            EditButtons = <>
            FieldName = 'endtime'
            Footers = <>
            Title.Caption = #32467#26463#26085#26399
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 909
      Height = 153
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 277
        Top = 21
        Width = 56
        Height = 14
        Caption = #33829#36816#32447#36335
      end
      object Label2: TLabel
        Left = 508
        Top = 60
        Width = 42
        Height = 14
        Caption = #29677#27425#21495
      end
      object Label3: TLabel
        Left = 34
        Top = 60
        Width = 56
        Height = 14
        Caption = #33829#36816#36710#22411
      end
      object lbl1: TLabel
        Left = 48
        Top = 94
        Width = 42
        Height = 14
        Caption = #24231#20301#21495
      end
      object Label4: TLabel
        Left = 248
        Top = 62
        Width = 8
        Height = 16
        Caption = '*'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object lblvehiclebrandmodelid: TLabel
        Left = 277
        Top = 60
        Width = 56
        Height = 14
        Caption = #21697#29260#22411#21495
      end
      object lbl3: TLabel
        Left = 48
        Top = 23
        Width = 42
        Height = 14
        Caption = #21806#31080#28857
      end
      object lbl2: TLabel
        Left = 508
        Top = 21
        Width = 56
        Height = 14
        Caption = #24320#22987#26085#26399
      end
      object lbl4: TLabel
        Left = 704
        Top = 21
        Width = 56
        Height = 14
        Caption = #32467#26463#26085#26399
      end
      object NovaEdtRoute: TNovaEdit
        Left = 339
        Top = 18
        Width = 145
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
      object NovaEditSchedule: TNovaEdit
        Left = 555
        Top = 56
        Width = 145
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
      object NovaCbbVehicletype: TNovaHComboBox
        Left = 96
        Top = 56
        Width = 145
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        TabOrder = 2
        OnChange = NovaCbbVehicletypeChange
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
        HelpOptions.HDataSourceName = 'vehiclettypelist'
        HelpOptions.HQueryAddress = 'ticketprice/qryScheduleVehicletype'
        HelpOptions.AutoSelectFirst = True
        HelpOptions.displayFieldname = 'name'
        Params = <
          item
            DataType = ftString
            Name = 'scheduleid'
            ParamType = ptInput
          end>
      end
      object mmoSeats: TMemo
        Left = 94
        Top = 91
        Width = 390
        Height = 56
        Enabled = False
        TabOrder = 3
      end
      object NvHcbbVehiclebrandmodel: TNovaHComboBox
        Left = 339
        Top = 56
        Width = 145
        Height = 22
        ImeMode = imClose
        TabOrder = 4
        OnChange = NvHcbbVehiclebrandmodelChange
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
            Value = 'VehiclebrandmodelHelp'
          end
          item
            DataType = ftString
            Name = 'filter_EQL_t!vehicletypeid'
            ParamType = ptInput
          end>
      end
      object chkiscopyvehicletype: TCheckBox
        Left = 508
        Top = 107
        Width = 192
        Height = 17
        Caption = #21516#26102#22797#21046#21040#26412#29677#27425#20854#20182#36710#22411
        TabOrder = 5
      end
      object nvhelpTicketoutlets: TNovaHelp
        Left = 96
        Top = 18
        Width = 145
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
        ReadOnly = True
        TabOrder = 6
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #21517#31216
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 70
            Visible = True
          end>
        HelpOptions.HelpHeight = 160
        HelpOptions.HelpWidth = 168
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'TicketoutletHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object CheckBox1: TCheckBox
        Left = 508
        Top = 130
        Width = 192
        Height = 17
        Caption = #21516#26102#22797#21046#21040#26412#32447#36335#20854#20182#29677#27425
        TabOrder = 7
        Visible = False
      end
      object dtpFromDate: TDateTimePicker
        Left = 570
        Top = 18
        Width = 115
        Height = 22
        Date = 40614.716442233800000000
        Time = 40614.716442233800000000
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 8
      end
      object EndDate: TDateTimePicker
        Left = 766
        Top = 18
        Width = 107
        Height = 22
        Date = 55153.716442233800000000
        Time = 55153.716442233800000000
        TabOrder = 9
      end
      object chkdate: TCheckBox
        Left = 508
        Top = 84
        Width = 192
        Height = 17
        Caption = #26159#21542#20445#23384#26085#26399
        Checked = True
        State = cbChecked
        TabOrder = 10
        OnClick = chkdateClick
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 504
    Width = 909
    ExplicitTop = 504
    ExplicitWidth = 909
    inherited bbtnSave: TBitBtn
      Left = 239
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 239
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 384
      Top = 6
      ExplicitLeft = 384
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 496
    Top = 208
  end
  object jcsdQryHandprice2: TjsonClientDataSet
    DataSourceName = 'ticketoutletpricelist'
    UpdateDataSet = 'ticketoutletsprices'
    QueryAddress = 'ticketprice/queryEditticketoutletsprice'
    SaveAddress = 'ticketprice/saveTicketoutletsprice'
    AutoActive = False
    AutoCopyRecord = False
    CanInsert = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketoutletsprice.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'iscopyvehicletype'
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
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.starttime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsprice.endtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'getDateTime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'saveorupdateflag'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcsdQryHandprice2AfterScroll
    Left = 384
    Top = 208
    object jcsdQryHandprice2id: TLargeintField
      FieldName = 'id'
    end
    object jcsdQryHandprice2scheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcsdQryHandprice2departstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcsdQryHandprice2reachstationid: TLargeintField
      FieldName = 'reachstationid'
    end
    object jcsdQryHandprice2vehicletypeid: TLargeintField
      FieldName = 'vehicletypeid'
    end
    object jcsdQryHandprice2vehiclebrandmodelid: TLargeintField
      FieldName = 'vehiclebrandmodelid'
    end
    object jcsdQryHandprice2seattype: TWideStringField
      FieldName = 'seattype'
      Size = 10
    end
    object jcsdQryHandprice2seattypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'seattypename'
      LookupDataSet = jcdsQrySeatTypes
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'seattype'
      Lookup = True
    end
    object jcsdQryHandprice2fullprice: TFloatField
      FieldName = 'fullprice'
      OnChange = jcsdQryHandprice2fullpriceChange
    end
    object jcsdQryHandprice2halfprice: TFloatField
      FieldName = 'halfprice'
      OnChange = jcsdQryHandprice2halfpriceChange
    end
    object jcsdQryHandprice2studentprice: TFloatField
      FieldName = 'studentprice'
    end
    object jcsdQryHandprice2toplimitprice: TFloatField
      FieldName = 'toplimitprice'
    end
    object jcsdQryHandprice2lowerlimitprice: TFloatField
      FieldName = 'lowerlimitprice'
    end
    object jcsdQryHandprice2createby: TLargeintField
      FieldName = 'createby'
    end
    object wdstrngfldQryHandpricebrandname: TWideStringField
      FieldName = 'brandname'
      Size = 30
    end
    object wdstrngfldQryHandpricedepartstation: TWideStringField
      FieldName = 'departstation'
      Size = 50
    end
    object wdstrngfldQryHandpricereachstation: TWideStringField
      FieldName = 'reachstation'
      Size = 50
    end
    object wdstrngfldQryHandpricevehicletype: TWideStringField
      FieldName = 'vehicletype'
      Size = 50
    end
    object jcsdQryHandprice2difprice: TFloatField
      FieldName = 'difprice'
    end
    object jcsdQryHandprice2starttime: TDateField
      FieldName = 'starttime'
    end
    object jcsdQryHandprice2endtime: TDateField
      FieldName = 'endtime'
    end
  end
  object dshandprice: TDataSource
    DataSet = jcsdQryHandprice2
    Left = 80
    Top = 208
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
    Top = 208
  end
  object jcsdQrySeats: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/qryScheduleSeatno'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seattype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatnos'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 184
    Top = 208
  end
end
