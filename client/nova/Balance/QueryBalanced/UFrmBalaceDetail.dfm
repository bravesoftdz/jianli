object frmBalaceDetail: TfrmBalaceDetail
  Left = 0
  Top = 0
  Caption = #32467#31639#21333#26126#32454
  ClientHeight = 488
  ClientWidth = 1031
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
    Width = 1031
    Height = 488
    Align = alClient
    TabOrder = 0
    object nvdbgrdhResult: TNvDbgridEh
      Left = 2
      Top = 15
      Width = 1027
      Height = 471
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
      ImeMode = imDisable
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
      ParentName = 'SimpleCRUDForm'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'id'
          Footers = <>
          Visible = False
          Width = 55
        end
        item
          EditButtons = <>
          FieldName = 'departinvoicesno'
          Footer.DisplayFormat = #21512#35745
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #32467#31639#21333#21495
          Width = 81
        end
        item
          EditButtons = <>
          FieldName = 'balanceunitname'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #32467#31639#21333#20301
          Width = 139
        end
        item
          EditButtons = <>
          FieldName = 'routename'
          Footers = <>
          Title.Caption = #33829#36816#32447#36335
          Width = 175
        end
        item
          EditButtons = <>
          FieldName = 'schedulecode'
          Footers = <>
          Title.Caption = #29677#27425#21495
          Width = 74
        end
        item
          EditButtons = <>
          FieldName = 'departdate'
          Footers = <>
          Title.Caption = #21457#36710#26085#26399
          Width = 85
        end
        item
          EditButtons = <>
          FieldName = 'departtime'
          Footers = <>
          Title.Caption = #21457#36710#26102#38388
          Width = 69
        end
        item
          EditButtons = <>
          FieldName = 'balanceamount'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #32467#31639#37329#39069
          Width = 71
        end
        item
          EditButtons = <>
          FieldName = 'totalamount'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #24635#31080#20215
          Width = 54
        end
        item
          EditButtons = <>
          FieldName = 'moreprice'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #20215#24046
          Width = 60
        end
        item
          EditButtons = <>
          FieldName = 'stationservicefee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #31449#21153#36153
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'fueladditionfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #29123#27833#38468#21152#36153
          Width = 82
        end
        item
          EditButtons = <>
          FieldName = 'agentfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #23458#36816#20195#29702#36153
          Width = 80
        end
        item
          EditButtons = <>
          FieldName = 'othterfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #20854#20182#25187#36153
          Width = 68
        end
        item
          EditButtons = <>
          FieldName = 'seatnum'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #20056#23458#24231#20301#25968
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'ticketnum'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #26816#31080#25968
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'unitname'
          Footers = <>
          Title.Caption = #36710#23646#21333#20301
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'supplyticketnum'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #34917#24405#31080#25968
          Visible = False
          Width = 67
        end
        item
          EditButtons = <>
          FieldName = 'supplyamount'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #34917#24405#31080#20215#24635#39069
          Visible = False
          Width = 95
        end
        item
          EditButtons = <>
          FieldName = 'supplybalanceamount'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #34917#24405#32467#31639#37329#39069
          Visible = False
          Width = 96
        end
        item
          EditButtons = <>
          FieldName = 'departstationname'
          Footers = <>
          Title.Caption = #21457#36710#31449
          Width = 104
        end
        item
          EditButtons = <>
          FieldName = 'worktypename'
          Footers = <>
          Title.Caption = #33829#36816#31867#21035
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 'typename'
          Footers = <>
          Title.Caption = #29677#27425#31867#21035
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'vehicleno'
          Footers = <>
          Title.Caption = #33829#36816#36710#36742
          Width = 71
        end
        item
          EditButtons = <>
          FieldName = 'vehicletypname'
          Footers = <>
          Title.Caption = #36710#22411
          Width = 99
        end
        item
          EditButtons = <>
          FieldName = 'orgname'
          Footers = <>
          Title.Caption = #25152#23646#26426#26500
          Width = 110
        end
        item
          EditButtons = <>
          FieldName = 'printip'
          Footers = <>
          Title.Caption = #24320#21333#26426#31080'IP'
          Width = 119
        end
        item
          EditButtons = <>
          FieldName = 'printbyname'
          Footers = <>
          Title.Caption = #25171#21333#21592
          Width = 59
        end
        item
          EditButtons = <>
          FieldName = 'printtime'
          Footers = <>
          Title.Caption = #24320#21333#26102#38388
          Width = 140
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'd1name'
          Footers = <>
          Title.Caption = #39550#39542#21592'1'
          Visible = False
          Width = 79
        end
        item
          EditButtons = <>
          FieldName = 'd2name'
          Footers = <>
          Title.Caption = #39550#39542#21592'2'
          Visible = False
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'd3name'
          Footers = <>
          Title.Caption = #39550#39542#21592'3'
          Visible = False
          Width = 81
        end
        item
          EditButtons = <>
          FieldName = 'd4name'
          Footers = <>
          Title.Caption = #39550#39542#21592'4'
          Visible = False
          Width = 66
        end
        item
          EditButtons = <>
          FieldName = 's1name'
          Footers = <>
          Title.Caption = #20056#21153#21592'1'
          Visible = False
          Width = 62
        end
        item
          EditButtons = <>
          FieldName = 's2name'
          Footers = <>
          Title.Caption = #20056#21153#21592'2'
          Visible = False
          Width = 63
        end
        item
          EditButtons = <>
          FieldName = 'type'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'worktype'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
        object pnl1: TPanel
          Left = 0
          Top = 0
          Width = 0
          Height = 0
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          TabOrder = 0
          object grp1: TGroupBox
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            Caption = #26597#35810#32467#26524
            TabOrder = 0
            object nvdbgrdh1: TNvDbgridEh
              Left = 2
              Top = 16
              Width = 1295
              Height = 229
              Align = alClient
              ColumnDefValues.Title.TitleButton = True
              DataGrouping.GroupLevels = <>
              Flat = False
              FooterColor = clWindow
              FooterFont.Charset = ANSI_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -14
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              ImeMode = imDisable
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
              ReadOnly = True
              RowDetailPanel.Color = clBtnFace
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
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
              jsonConnection = DMPublic.jcon
              ParentName = 'SimpleCRUDForm'
              TitleAlign = taLeftJustify
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'orgname'
                  Footers = <>
                  Title.Caption = #26426#26500
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'routename'
                  Footers = <>
                  Title.Caption = #33829#36816#32447#36335
                  Width = 95
                end
                item
                  EditButtons = <>
                  FieldName = 'status'
                  Footers = <>
                  Visible = False
                  Width = 76
                end
                item
                  EditButtons = <>
                  FieldName = 'unitname'
                  Footers = <>
                  Title.Caption = #33829#36816#21333#20301
                  Width = 97
                end
                item
                  EditButtons = <>
                  FieldName = 'vehicletypename'
                  Footers = <>
                  Title.Caption = #36710#22411
                  Width = 112
                end
                item
                  EditButtons = <>
                  FieldName = 'seatnum'
                  Footers = <>
                  Title.Caption = #24231#20301#25968
                  Width = 53
                end
                item
                  EditButtons = <>
                  FieldName = 'soldeatnum'
                  Footers = <>
                  Title.Caption = #24050#21806
                  Width = 42
                end
                item
                  EditButtons = <>
                  FieldName = 'distance'
                  Footers = <>
                  Title.Caption = #20844#37324#25968
                  Width = 98
                end
                item
                  EditButtons = <>
                  FieldName = 'autocancelreserveseatnum'
                  Footers = <>
                  Title.Caption = #33258#21160#21462#28040#30041#20301#25968
                  Width = 110
                end
                item
                  EditButtons = <>
                  FieldName = 'unautocancelreserveseatnum'
                  Footers = <>
                  Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
                  Width = 124
                end
                item
                  EditButtons = <>
                  FieldName = 'runtime'
                  Footers = <>
                  Title.Caption = #36816#34892#26102#38388
                  Width = 61
                end
                item
                  EditButtons = <>
                  FieldName = 'departdate'
                  Footers = <>
                  Title.Caption = #21457#36710#26085#26399
                  Width = 83
                end
                item
                  EditButtons = <>
                  FieldName = 'departtime'
                  Footers = <>
                  Title.Caption = #21457#36710#26102#38388
                  Width = 68
                end
                item
                  EditButtons = <>
                  FieldName = 'highdistance'
                  Footers = <>
                  Title.Caption = #39640#36895#37324#31243
                end
                item
                  EditButtons = <>
                  FieldName = 'isovertime'
                  Footers = <>
                  Title.Caption = #26159#21542#21152#29677
                  Width = 62
                end
                item
                  EditButtons = <>
                  FieldName = 'islinework'
                  Footers = <>
                  Title.Caption = #26159#21542#27969#27700#29677
                  Width = 62
                end
                item
                  EditButtons = <>
                  FieldName = 'worktype'
                  Footers = <>
                  Title.Caption = #33829#36816#31867#21035
                  Width = 65
                end
                item
                  EditButtons = <>
                  FieldName = 'workways'
                  Footers = <>
                  Width = 81
                end
                item
                  EditButtons = <>
                  FieldName = 'districttype'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'isproprietary'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'issellreturnticket'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'endtime'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'isoriginator'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'issaleafterrepor'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'iscanmixcheck'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'statusname'
                  Footers = <>
                  Title.Caption = #29677#27425#29366#24577
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
        end
      end
    end
  end
  object dsResult: TDataSource
    DataSet = jcdsResultdetial
    Left = 56
    Top = 248
  end
  object jcdsResultdetial: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/DepartinvoicesStuation'
    SaveAddress = 'query/DepartinvoicesStuation'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ds!balance.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 248
    object lrgntfldResultid: TLargeintField
      FieldName = 'id'
    end
    object wdstrngfldResultdepartstationname: TWideStringField
      FieldName = 'departstationname'
      Size = 50
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 50
    end
    object wdstrngfldResultstatus: TWideStringField
      FieldName = 'status'
      Size = 30
    end
    object dtfldResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 30
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 50
    end
    object wdstrngfldResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 50
    end
    object wdstrngfldResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 50
    end
    object wdstrngfldResultvehicletypname: TWideStringField
      FieldName = 'vehicletypname'
      Size = 50
    end
    object lrgntfldResultticketnum: TLargeintField
      FieldName = 'ticketnum'
    end
    object fltfldResulttotalamount: TFloatField
      FieldName = 'totalamount'
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object wdstrngfldResultprintip: TWideStringField
      FieldName = 'printip'
      Size = 40
    end
    object wdstrngfldResultprintbyname: TWideStringField
      FieldName = 'printbyname'
      Size = 50
    end
    object dtmfldResultprinttime: TDateTimeField
      FieldName = 'printtime'
    end
    object lrgntfldResultsupplyticketnum: TLargeintField
      FieldName = 'supplyticketnum'
    end
    object fltfldResultsupplyamount: TFloatField
      FieldName = 'supplyamount'
    end
    object fltfldResultsupplybalanceamount: TFloatField
      FieldName = 'supplybalanceamount'
    end
    object wdstrngfldResultd1name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'd1name'
      Size = 50
      Calculated = True
    end
    object wdstrngfldResultd2name: TWideStringField
      FieldName = 'd2name'
      Size = 50
    end
    object wdstrngfldResultd3name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'd3name'
      Size = 50
      Calculated = True
    end
    object wdstrngfldResultd4name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'd4name'
      Size = 50
      Calculated = True
    end
    object wdstrngfldResults1name: TWideStringField
      FieldName = 's1name'
      Size = 50
    end
    object wdstrngfldResults2name: TWideStringField
      FieldKind = fkCalculated
      FieldName = 's2name'
      Size = 50
      Calculated = True
    end
    object wdstrngfldResulttype: TWideStringField
      FieldName = 'type'
      Size = 10
    end
    object wdstrngfldResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object wdstrngfldResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
      Size = 50
    end
    object lrgntfldResultseatnum: TLargeintField
      FieldName = 'seatnum'
    end
    object fltfldResultfueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object fltfldResultothterfee: TFloatField
      FieldName = 'othterfee'
    end
    object fltfldResultagentfee: TFloatField
      FieldName = 'agentfee'
    end
    object fltfldResultbalanceamount: TFloatField
      FieldName = 'balanceamount'
    end
    object wdstrngfldResultbalanceunitname: TWideStringField
      FieldName = 'balanceunitname'
    end
    object fltfldResultmoreprice: TFloatField
      FieldName = 'moreprice'
    end
    object wdstrngfldResultdetialworktypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'worktypename'
      LookupDataSet = jcdsWorktkypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'worktype'
      Size = 10
      Lookup = True
    end
    object wdstrngfldResultdetialtypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdstypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Size = 10
      Lookup = True
    end
  end
  object jcdsWorktkypename: TjsonClientDataSet
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
    RemoteServer = DMPublic.jcon
    Left = 423
    Top = 248
  end
  object jcdstypename: TjsonClientDataSet
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
    RemoteServer = DMPublic.jcon
    Left = 512
    Top = 248
  end
end
