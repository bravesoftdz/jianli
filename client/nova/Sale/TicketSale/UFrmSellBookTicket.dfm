inherited FrmSellBookTicket: TFrmSellBookTicket
  Caption = 'FrmSellBookTicket'
  ClientWidth = 841
  OnCreate = FormCreate
  ExplicitWidth = 857
  PixelsPerInch = 96
  TextHeight = 16
  inherited splbufferticket: TSplitter
    Width = 841
    ExplicitWidth = 841
  end
  inherited gbticketbuffer: TGroupBox
    Width = 841
    ExplicitWidth = 841
    inherited spl1: TSplitter
      Left = 546
      ExplicitLeft = 546
    end
    inherited nvdbgrdhticketbuffer: TNvDbgridEh
      Width = 544
    end
    inherited nvdbgrdhInsureBuffer: TNvDbgridEh
      Left = 548
    end
  end
  inherited pnlmain: TPanel
    Width = 841
    ExplicitWidth = 841
    inherited gbContextHit: TGroupBox
      Width = 841
      ExplicitWidth = 841
      inherited lblContextHint: TLabel
        Width = 837
      end
    end
    inherited gbseatplan: TGroupBox
      Width = 841
      ExplicitWidth = 841
      inherited pnlseatplan: TPanel
        Width = 572
        ExplicitWidth = 572
        inherited scrlbxSeatPlan: TScrollBox
          Width = 572
          ExplicitWidth = 572
        end
      end
    end
    inherited pnlhint: TPanel
      Width = 841
      ExplicitWidth = 841
      inherited gbTicketnos: TGroupBox
        inherited lbl2: TLabel
          Height = 21
        end
        inherited lblleaveticketnum: TLabel
          Height = 21
        end
      end
      inherited gbinsureno: TGroupBox
        inherited lblinsureno: TLabel
          Height = 21
        end
        inherited lbl7: TLabel
          Height = 21
        end
        inherited lblleaveinsurenum: TLabel
          Height = 21
        end
        inherited lbl12: TLabel
          Height = 21
        end
      end
      inherited pnllastmoney: TPanel
        Left = 521
        ExplicitLeft = 521
        inherited lbl1: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
        end
        inherited lbllastmoney: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
        end
        inherited lbl4: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
        end
        inherited lblreceipt: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
        end
        inherited lbl5: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
        end
        inherited lblchange: TLabel
          Height = 43
        end
      end
    end
    inherited pnlinput: TPanel
      Width = 841
      ExplicitWidth = 841
      inherited gbamount: TGroupBox
        Left = 625
        TabOrder = 4
        ExplicitLeft = 625
      end
      inherited gbTakeKid: TGroupBox
        Left = 823
        TabOrder = 5
        ExplicitLeft = 823
      end
      inherited gb3: TGroupBox
        Visible = False
      end
      object grpcustomer: TGroupBox
        Left = 420
        Top = 0
        Width = 205
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #35746#31080#20154
        TabOrder = 3
        object nvedtCERTIFICATENO: TNovaEdit
          Left = 95
          Top = 16
          Width = 107
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          MaxLength = 50
          TabOrder = 1
          OnKeyDown = nvedtCERTIFICATENOKeyDown
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
        object nvcbbCERTIFICATETYPE: TNovaComboBox
          Left = 3
          Top = 16
          Width = 89
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          ImeMode = imClose
          TabOrder = 0
          OnChange = nvcbbCERTIFICATETYPEChange
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
          HelpOptions.HDataSourceName = 'diclist'
          HelpOptions.HQueryAddress = 'system/querydictionary'
          HelpOptions.TableName = 'customer'
          HelpOptions.Columnname = 'certificatetype'
          HelpOptions.IsDebug = True
        end
      end
    end
    inherited pnlschedule: TPanel
      Width = 841
      ExplicitWidth = 841
      object nvdbgrdhseatreserve: TNvDbgridEh
        AlignWithMargins = True
        Left = 203
        Top = 0
        Width = 623
        Height = 174
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Color = clMoneyGreen
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSeatreserve
        Flat = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        FooterColor = clWhite
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #24494#36719#38597#40657
        FooterFont.Style = []
        ImeMode = imDisable
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        RowDetailPanel.Color = clBtnFace
        RowHeight = 26
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = [fsBold]
        OnDrawColumnCell = nvdbgrdhseatreserveDrawColumnCell
        OnGetCellParams = nvdbgrdhseatreserveGetCellParams
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
        ParentName = 'FrmSellTicket'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'isselect'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'istakekid'
            Footers = <>
            Title.Caption = #24102#20799#31461
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'carrychildnum'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24102#20799#31461#25968
            Visible = False
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'sellstatename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#29366#24577
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#31181
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#20215
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'certiticatetypename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #35777#20214#31867#22411
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #35777#20214#21495#30721
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            ReadOnly = True
            Title.Caption = #39038#23458#22995#21517
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #32447#36335
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#31449
            Width = 64
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#21495
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'isautocancel'
            Footers = <>
            ReadOnly = True
            Title.Caption = #33258#21160#21462#28040
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'serviceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            ReadOnly = True
            Title.Caption = #26381#21153#36153
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'reservename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #30041#31080#20154
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'reservetime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #30041#31080#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            ReadOnly = True
            Title.Caption = #37324#31243
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21152#29677
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletname'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #30041#31080#28857
            Width = 64
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            ReadOnly = True
            Title.Caption = #26816#31080#21475
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            ReadOnly = True
            Title.Caption = #19978#36710#21345#20301
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'autocanceltime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #33258#21160#21462#28040#26102#38388
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'canceltime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21462#28040#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#25152#23646#26426#26500
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'planvehicletypecustomname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #35745#21010#36710#22411
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'planvehicleno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #35745#21010#36710#29260
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'planunitname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #35745#21010#36710#23646#21333#20301
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'planbrandmodel'
            Footers = <>
            ReadOnly = True
            Title.Caption = #35745#21010#36710#36742#21697#29260#22411#21495
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrancename'
            Footers = <>
            Title.Caption = #26816#31080#33258#23450#20041#21517#31216
            Width = 80
          end>
        object RowDetailData: TRowDetailPanelControlEh
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
        end
      end
    end
  end
  inherited pnlreceipt: TPanel
    inherited pnlJJInsureHint: TPanel
      inherited lblJJInsureMoney: TLabel
        Height = 18
      end
    end
  end
  object jsoncdsquerycustomer: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 456
    Top = 264
  end
  object jcdsSeatreserve: TjsonClientDataSet
    DataSourceName = 'seatreserves'
    QueryAddress = 'sell/qryseatreserve'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_c!certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_t!sellstate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 824
    Top = 184
    object jcdsSeatreserveisselect: TBooleanField
      FieldName = 'isselect'
    end
    object jcdsSeatreserveid: TLargeintField
      FieldName = 'id'
    end
    object jcdsSeatreserveorgname: TWideStringField
      FieldName = 'orgname'
    end
    object jcdsSeatreserveticketoutletname: TWideStringField
      FieldName = 'ticketoutletname'
    end
    object jcdsSeatreserveroutename: TWideStringField
      FieldName = 'routename'
    end
    object jcdsSeatreserveschedulecode: TWideStringField
      FieldName = 'schedulecode'
    end
    object jcdsSeatreservereachstationname: TWideStringField
      FieldName = 'reachstationname'
    end
    object jcdsSeatreservedeparttime: TWideStringField
      FieldName = 'departtime'
    end
    object jcdsSeatreservesellstate: TWideStringField
      FieldName = 'sellstate'
    end
    object jcdsSeatreservefullprice: TCurrencyField
      FieldName = 'fullprice'
    end
    object jcdsSeatreserveserviceprice: TCurrencyField
      FieldName = 'serviceprice'
    end
    object jcdsSeatreservereservename: TWideStringField
      FieldName = 'reservename'
    end
    object jcdsSeatreservecustomername: TWideStringField
      FieldName = 'customername'
    end
    object jcdsSeatreservecertificatetype: TWideStringField
      FieldName = 'certificatetype'
    end
    object jcdsSeatreservecertificateno: TWideStringField
      FieldName = 'certificateno'
    end
    object jcdsSeatreservefamilyphone: TWideStringField
      FieldName = 'familyphone'
    end
    object jcdsSeatreservemobilephone: TWideStringField
      FieldName = 'mobilephone'
    end
    object jcdsSeatreservecustomerid: TLargeintField
      FieldName = 'customerid'
    end
    object jcdsSeatreservescheduleplanid: TLargeintField
      FieldName = 'scheduleplanid'
    end
    object jcdsSeatreservesellstatename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'sellstatename'
      LookupDataSet = jcdsResultstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'sellstate'
      Lookup = True
    end
    object jcdsSeatreservecertiticatetypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certiticatetypename'
      LookupDataSet = jcdsResultcustomtype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Lookup = True
    end
    object jcdsSeatreservedepartdate: TDateTimeField
      FieldName = 'departdate'
    end
    object jcdsSeatreserveautocanceltime: TDateTimeField
      FieldName = 'autocanceltime'
    end
    object jcdsSeatreservecanceltime: TDateTimeField
      FieldName = 'canceltime'
    end
    object jcdsSeatreservecreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsSeatreserveupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsSeatreservereservetime: TDateTimeField
      FieldName = 'reservetime'
    end
    object jcdsSeatreserveisautocancel: TBooleanField
      FieldName = 'isautocancel'
    end
    object jcdsSeatreserveistakekid: TBooleanField
      FieldName = 'istakekid'
    end
    object jcdsSeatreservecarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object jcdsSeatreserveticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 50
    end
    object jcdsSeatreservebuspark: TWideStringField
      FieldName = 'buspark'
      Size = 50
    end
    object jcdsSeatreserveplanvehicletype: TWideStringField
      FieldName = 'planvehicletype'
      Size = 50
    end
    object jcdsSeatreserveplanvehiclegrade: TWideStringField
      FieldName = 'planvehiclegrade'
      Size = 50
    end
    object jcdsSeatreserveplanvehicletypecustomname: TWideStringField
      FieldName = 'planvehicletypecustomname'
      Size = 50
    end
    object jcdsSeatreserveplanvheicletypeid: TLargeintField
      FieldName = 'planvheicletypeid'
    end
    object jcdsSeatreserveplanvehicleno: TWideStringField
      FieldName = 'planvehicleno'
    end
    object jcdsSeatreserveplanvehicleid: TLargeintField
      FieldName = 'planvehicleid'
    end
    object jcdsSeatreserveplanunitname: TWideStringField
      FieldName = 'planunitname'
      Size = 60
    end
    object jcdsSeatreserveplanunitid: TLargeintField
      FieldName = 'planunitid'
    end
    object jcdsSeatreserveplanbrandmodel: TWideStringField
      FieldName = 'planbrandmodel'
      Size = 50
    end
    object jcdsSeatreserveplanbrandmodelid: TLargeintField
      FieldName = 'planbrandmodelid'
    end
    object jcdsSeatreservestationservicefee: TCurrencyField
      FieldName = 'stationservicefee'
    end
    object jcdsSeatreservefueladditionfee: TCurrencyField
      FieldName = 'fueladditionfee'
    end
    object jcdsSeatreservetoplimitprice: TCurrencyField
      FieldName = 'toplimitprice'
    end
    object jcdsSeatreservedistance: TIntegerField
      FieldName = 'distance'
    end
    object jcdsSeatreserveseattype: TWideStringField
      FieldName = 'seattype'
      Size = 10
    end
    object jcdsSeatreserveisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsSeatreserveislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsSeatreserveworkways: TWideStringField
      FieldName = 'workways'
      Size = 10
    end
    object jcdsSeatreserveendstationname: TWideStringField
      FieldName = 'endstationname'
      Size = 30
    end
    object jcdsSeatreservestartstationname: TWideStringField
      FieldName = 'startstationname'
      Size = 30
    end
    object jcdsSeatreservereachstationsecondname: TWideStringField
      FieldName = 'reachstationsecondname'
      Size = 30
    end
    object jcdsSeatreservescheduleremarks: TWideStringField
      FieldName = 'scheduleremarks'
      Size = 50
    end
    object jcdsSeatreservedepartstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcdsSeatreservereachstationid: TLargeintField
      FieldName = 'reachstationid'
    end
    object jcdsSeatreserveorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jcdsSeatreservescheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsSeatreservetickettype: TWideStringField
      FieldName = 'tickettype'
      Size = 10
    end
    object jcdsSeatreserveprice: TCurrencyField
      FieldName = 'price'
    end
    object jcdsSeatreserveseatno: TIntegerField
      FieldName = 'seatno'
    end
    object jcdsSeatreservehalfprice: TCurrencyField
      FieldName = 'halfprice'
    end
    object jcdsSeatreservestudentprice: TCurrencyField
      FieldName = 'studentprice'
    end
    object jcdsSeatreservedepartstationname: TWideStringField
      FieldName = 'departstationname'
      Size = 30
    end
    object jcdsSeatreserveisroundtrip: TBooleanField
      FieldName = 'isroundtrip'
    end
    object jcdsSeatreservereturntripvaliddays: TIntegerField
      FieldName = 'returntripvaliddays'
    end
    object jcdsSeatreserveticketentrancename: TWideStringField
      FieldName = 'ticketentrancename'
      Size = 100
    end
  end
  object dsSeatreserve: TDataSource
    DataSet = jcdsSeatreserve
    OnDataChange = dsSeatreserveDataChange
    Left = 820
    Top = 120
  end
  object jcdsResultstatus: TjsonClientDataSet
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
        Value = 'seatreserve'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'sellstate'
      end>
    RemoteServer = DMPublic.jcon
    Left = 712
    Top = 336
  end
  object jcdsResultcustomtype: TjsonClientDataSet
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
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'certificatetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 832
    Top = 336
  end
end
