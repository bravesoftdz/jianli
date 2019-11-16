object frmticketsInfo: TfrmticketsInfo
  Left = 0
  Top = 0
  Caption = #36816#37327#21333#26126#32454
  ClientHeight = 505
  ClientWidth = 859
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grp3: TGroupBox
    Left = 0
    Top = 0
    Width = 859
    Height = 505
    Align = alClient
    TabOrder = 0
    object dbgrdhResult: TNvDbgridEh
      Left = 2
      Top = 15
      Width = 855
      Height = 488
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsResult
      Flat = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      ImeMode = imClose
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = #23435#20307
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      ExpOpenType = AutoOpen
      AutoSetMultiSelect = False
      AutoSetCtrlKey = False
      PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
      PrintInfo.TitleFont.Color = clWindowText
      PrintInfo.TitleFont.Height = -21
      PrintInfo.TitleFont.Name = #23435#20307
      PrintInfo.TitleFont.Style = [fsBold]
      PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
      PrintInfo.GridHeadFont.Color = clWindowText
      PrintInfo.GridHeadFont.Height = -32
      PrintInfo.GridHeadFont.Name = #23435#20307
      PrintInfo.GridHeadFont.Style = [fsBold]
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
      jsonConnection = DMPublic.jcon
      AutoGridAdject = True
      AutoGridSave = True
      AutoAPPPopuMenu = True
      ParentName = 'SimpleCRUDForm'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'orgname'
          Footer.Value = #21512#35745
          Footer.ValueType = fvtStaticText
          Footers = <>
          Title.Caption = #21806#31080#26426#26500
          Width = 94
        end
        item
          EditButtons = <>
          FieldName = 'ticketno'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #31080#21495
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'departdate'
          Footers = <>
          Title.Caption = #21457#36710#26085#26399
          Visible = False
          Width = 77
        end
        item
          EditButtons = <>
          FieldName = 'departtime'
          Footers = <>
          Title.Caption = #21457#36710#26102#38388
          Width = 45
        end
        item
          EditButtons = <>
          FieldName = 'schedulecode'
          Footers = <>
          Title.Caption = #29677#27425#21495
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'seatno'
          Footers = <>
          Title.Caption = #24231#20301#21495
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'dpartname'
          Footers = <>
          Title.Caption = #21457#36710#31449
          Width = 95
        end
        item
          EditButtons = <>
          FieldName = 'reachname'
          Footers = <>
          Title.Caption = #21040#36798#31449
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'routename'
          Footers = <>
          Title.Caption = #32447#36335
          Width = 113
        end
        item
          EditButtons = <>
          FieldName = 'ticketstatusname'
          Footers = <>
          Title.Caption = #36710#31080#29366#24577
          Visible = False
          Width = 47
        end
        item
          EditButtons = <>
          FieldName = 'sellname'
          Footers = <>
          Title.Caption = #21806#31080#21592
          Width = 62
        end
        item
          EditButtons = <>
          FieldName = 'selltime'
          Footers = <>
          Title.Caption = #21806#31080#26102#38388
          Width = 140
        end
        item
          EditButtons = <>
          FieldName = 'ticketprice'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #23454#38469#36141#31080#20215
          Width = 65
        end
        item
          EditButtons = <>
          FieldName = 'fullprice'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #20840#31080#20215
          Width = 54
        end
        item
          EditButtons = <>
          FieldName = 'moreprice'
          Footers = <>
          Title.Caption = #31080#20215#24046
          Width = 46
        end
        item
          EditButtons = <>
          FieldName = 'tickettypename'
          Footers = <>
          Title.Caption = #36710#31080#31867#22411
          Width = 48
        end
        item
          EditButtons = <>
          FieldName = 'sellwayname'
          Footers = <>
          Title.Caption = #21806#31080#36884#24452
          Visible = False
          Width = 69
        end
        item
          EditButtons = <>
          FieldName = 'stationservicefee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#31449#21153#36153
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'computefee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#24494#26426#36153
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'coolairfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#31354#35843#36153
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'fueladditionfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#29123#27833#36153
          Width = 54
        end
        item
          EditButtons = <>
          FieldName = 'waterfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#37197#27700#36153
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'additionfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
          Width = 53
        end
        item
          EditButtons = <>
          FieldName = 'insurefee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#20445#38505#36153
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'otherfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#20854#20182
          Width = 39
        end
        item
          EditButtons = <>
          FieldName = 'subtotal'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #22266#23450#25187#36153'||'#23567#35745
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'servicefee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #35746'/'#34917#31080#26381#21153#36153
          Width = 76
        end
        item
          EditButtons = <>
          FieldName = 'serviceprice'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #36141#31080#26381#21153#36153
          Width = 54
        end
        item
          EditButtons = <>
          FieldName = 'sellip'
          Footers = <>
          Title.Caption = #21806#31080#30005#33041'IP'
          Width = 116
        end
        item
          EditButtons = <>
          FieldName = 'ticketoutletname'
          Footers = <>
          Title.Caption = #21806#31080#28857
          Width = 77
        end
        item
          EditButtons = <>
          FieldName = 'islocal'
          Footers = <>
          Title.Caption = #26159#21542#24322#31449#31080
          Visible = False
          Width = 57
        end
        item
          EditButtons = <>
          FieldName = 'islinework'
          Footers = <>
          Title.Caption = #26159#21542#27969#27700#29677
          Width = 53
        end
        item
          EditButtons = <>
          FieldName = 'isovertime'
          Footers = <>
          Title.Caption = #21152#29677#29677#27425
          Width = 51
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
          FieldName = 'buspark'
          Footers = <>
          Title.Caption = #19978#36710#21345#20301
          Width = 45
        end
        item
          EditButtons = <>
          FieldName = 'returnbyname'
          Footers = <>
          Title.Caption = #36864#31080#20154
          Visible = False
          Width = 68
        end
        item
          EditButtons = <>
          FieldName = 'returntime'
          Footers = <>
          Title.Caption = #36864#31080#26102#38388
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'returnwayname'
          Footers = <>
          Title.Caption = #36864#31080#36884#24452
          Visible = False
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'returnamount'
          Footers = <>
          Title.Caption = #36864#31080#37329#39069
          Visible = False
          Width = 69
        end
        item
          EditButtons = <>
          FieldName = 'ticketentrance'
          Footers = <>
          Title.Caption = #26816#31080#21475
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'ischecked'
          Footers = <>
          Title.Caption = #26159#21542#24050#26816#31080
          Visible = False
          Width = 53
        end
        item
          EditButtons = <>
          FieldName = 'checkedname'
          Footers = <>
          Title.Caption = #26816#31080#21592
          Width = 54
        end
        item
          EditButtons = <>
          FieldName = 'checkstationname'
          Footers = <>
          Title.Caption = #26816#31080#28857
          Width = 65
        end
        item
          EditButtons = <>
          FieldName = 'checktime'
          Footers = <>
          Title.Caption = #26816#31080#26102#38388
          Width = 140
        end
        item
          EditButtons = <>
          FieldName = 'vehicletypename'
          Footers = <>
          Title.Caption = #36710#22411
          Width = 65
        end
        item
          EditButtons = <>
          FieldName = 'vehiclebrandmodelname'
          Footers = <>
          Title.Caption = #36710#36742#21697#29260#22411#21495
          Width = 101
        end
        item
          EditButtons = <>
          FieldName = 'customername'
          Footers = <>
          Title.Caption = #39038#23458#22995#21517
          Width = 68
        end
        item
          EditButtons = <>
          FieldName = 'paymethodname'
          Footers = <>
          Title.Caption = #25903#20184#26041#24335
          Visible = False
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'carrychildnum'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #24102#20799#31461#25968
          Width = 45
        end
        item
          EditButtons = <>
          FieldName = 'hticketoutlesname'
          Footers = <>
          Title.Caption = #20195#21806#28857#21517#31216
          Width = 92
        end
        item
          EditButtons = <>
          FieldName = 'houtletsaddress'
          Footers = <>
          Title.Caption = #20195#21806#28857#22320#22336
          Width = 92
        end
        item
          EditButtons = <>
          FieldName = 'isdepartinvoices'
          Footers = <>
          Title.Caption = #26159#21542#24050#24320#36816#37327#21333
          Visible = False
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'departinvoicesno'
          Footers = <>
          Title.Caption = #36816#37327#21333#21495
          Visible = False
          Width = 83
        end
        item
          EditButtons = <>
          FieldName = 'departinvoicesbyname'
          Footers = <>
          Title.Caption = #24320#20855#36816#37327#21333#20154
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'departinvoicestime'
          Footers = <>
          Title.Caption = #24320#36816#37327#21333#26102#38388
          Visible = False
          Width = 145
        end
        item
          EditButtons = <>
          FieldName = 'printorgname'
          Footers = <>
          Title.Caption = #21462#31080#28857
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'printname'
          Footers = <>
          Title.Caption = #21462#31080#25171#21360#20154
          Width = 60
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object dsResult: TDataSource
    DataSet = jcdsTicketinfo
    Left = 152
    Top = 88
  end
  object jcdsTicketinfo: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/queryTicketInfo'
    SaveAddress = 'query/queryTicketInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 216
    Top = 88
    object wdstrngfldResultdpartname: TWideStringField
      FieldName = 'dpartname'
    end
    object wdstrngfldResultreachname: TWideStringField
      FieldName = 'reachname'
    end
    object wdstrngfldResultsellname: TWideStringField
      FieldName = 'sellname'
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 30
    end
    object wdstrngfldResultpaymethod: TWideStringField
      FieldName = 'paymethod'
      Size = 10
    end
    object wdstrngfldResultsellway: TWideStringField
      FieldName = 'sellway'
      Size = 10
    end
    object wdstrngfldResultticketno: TWideStringField
      FieldName = 'ticketno'
      Size = 30
    end
    object dtfldResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object intgrfldResultseatno: TIntegerField
      FieldName = 'seatno'
    end
    object blnfldResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object intgrfldResultcarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object lrgntfldResultdistance: TLargeintField
      FieldName = 'distance'
    end
    object fltfldResultfullprice: TFloatField
      FieldName = 'fullprice'
    end
    object fltfldResultfueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object fltfldResultticketprice: TFloatField
      FieldName = 'ticketprice'
    end
    object wdstrngfldResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 60
    end
    object wdstrngfldResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 60
    end
    object wdstrngfldResultticketoutletname: TWideStringField
      FieldName = 'ticketoutletname'
    end
    object wdstrngfldResultsellip: TWideStringField
      FieldName = 'sellip'
      Size = 40
    end
    object wdstrngfldResultcustomername: TWideStringField
      FieldName = 'customername'
      Size = 30
    end
    object wdstrngfldResulthticketoutlesname: TWideStringField
      FieldName = 'hticketoutlesname'
      Size = 30
    end
    object wdstrngfldResulthoutletsaddress: TWideStringField
      FieldName = 'houtletsaddress'
      Size = 60
    end
    object wdstrngfldResultcheckedname: TWideStringField
      FieldName = 'checkedname'
      Size = 40
    end
    object wdstrngfldResultcheckstationname: TWideStringField
      FieldName = 'checkstationname'
      Size = 30
    end
    object wdstrngfldResultdepartinvoicesbyname: TWideStringField
      FieldName = 'departinvoicesbyname'
      Size = 40
    end
    object fltfldResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsTicketinfovehiclebrandmodelname: TWideStringField
      FieldName = 'vehiclebrandmodelname'
      Size = 30
    end
    object dtmfldResultchecktime: TDateTimeField
      FieldName = 'checktime'
    end
    object wdstrngfldResulttickettypename: TWideStringField
      FieldName = 'tickettypename'
    end
    object jcdsTicketinfocomputefee: TFloatField
      FieldName = 'computefee'
    end
    object jcdsTicketinfocoolairfee: TFloatField
      FieldName = 'coolairfee'
    end
    object jcdsTicketinfoadditionfee: TFloatField
      FieldName = 'additionfee'
    end
    object fltfldResultservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object fltfldResultwaterfee: TFloatField
      FieldName = 'waterfee'
    end
    object fltfldResultserviceprice: TFloatField
      FieldName = 'serviceprice'
    end
    object fltfldResultinsurefee: TFloatField
      FieldName = 'insurefee'
    end
    object fltfldResultsubtotal: TFloatField
      FieldName = 'subtotal'
    end
    object jcdsTicketinfomoreprice: TFloatField
      FieldName = 'moreprice'
    end
    object jcdsTicketinfoselltime: TDateTimeField
      FieldName = 'selltime'
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 60
    end
    object blnfldResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object wdstrngfldResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 30
    end
  end
  object jcdsPaymethod: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'paymethod'
      end>
    RemoteServer = DMPublic.jcon
    Left = 312
    Top = 88
  end
  object jcdsSellway: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'sellway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 416
    Top = 88
  end
end
