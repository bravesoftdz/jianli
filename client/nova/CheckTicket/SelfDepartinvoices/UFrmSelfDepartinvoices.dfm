inherited FrmSelfDepartinvoices: TFrmSelfDepartinvoices
  Caption = 'FrmSelfDepartinvoices'
  ClientHeight = 455
  ClientWidth = 869
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  ExplicitWidth = 885
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 869
    ExplicitWidth = 869
    object Label2: TLabel
      Left = 17
      Top = 27
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 200
      Top = 27
      Width = 42
      Height = 14
      Caption = #26816#31080#21475
    end
    object Label7: TLabel
      Left = 338
      Top = 27
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object DpDepartDate: TDateTimePicker
      Left = 79
      Top = 22
      Width = 104
      Height = 24
      Date = 40333.738843125000000000
      Time = 40333.738843125000000000
      TabOrder = 0
    end
    object NovaHCobEntrance: TNovaCheckedComboBox
      Left = 249
      Top = 22
      Width = 75
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'entrancelist'
      HelpOptions.HQueryAddress = 'checkticket/qryTicketentrance'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'ip'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'orgid'
          ParamType = ptInput
        end>
    end
    object dtpfromdatetime: TDateTimePicker
      Left = 398
      Top = 22
      Width = 79
      Height = 22
      Date = 37571.000162037000000000
      Format = 'HH:mm'
      Time = 37571.000162037000000000
      ShowCheckbox = True
      Checked = False
      Kind = dtkTime
      TabOrder = 2
    end
    object ChkIsReproted: TCheckBox
      Left = 494
      Top = 23
      Width = 66
      Height = 19
      Caption = #24050#25253#21040
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object ChkIsdepart: TCheckBox
      Left = 565
      Top = 24
      Width = 66
      Height = 17
      Caption = #26410#21457#29677
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object NovaEdtCardNo: TNovaEdit
      Left = 653
      Top = 21
      Width = 170
      Height = 22
      MaxLength = 50
      TabOrder = 5
      Visible = False
      OnChange = NovaEdtCardNoChange
      OnKeyDown = NovaEdtCardNoKeyDown
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
  end
  inherited tlbShortCut: TToolBar
    Width = 869
    ExplicitWidth = 869
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #21457#29677#25171#21360
      ImageIndex = 17
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Visible = False
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
  end
  inherited Panel1: TPanel
    Width = 869
    Height = 352
    ExplicitWidth = 869
    ExplicitHeight = 352
    inherited GroupBox1: TGroupBox
      Width = 869
      Height = 352
      ExplicitWidth = 869
      ExplicitHeight = 352
      inherited dbgrdhResult: TNvDbgridEh
        Tag = -99
        Top = 49
        Width = 865
        Height = 301
        Font.Charset = GB2312_CHARSET
        Font.Height = -16
        FooterRowCount = 1
        RowHeight = 30
        SumList.Active = True
        TitleHeight = 30
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36816#33829#32447#36335
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #25253#21040#36710#21495
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 80
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24231#20301#25968
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 60
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'soldeatnum'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            Footers = <>
            Title.Caption = #24050#21806
            Title.Color = clMoneyGreen
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clBlue
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 60
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'carrychildnum'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = []
            Footers = <>
            Title.Caption = #20813#31080#20799#31461
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 51
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'checkeds'
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            Footer.Font.Charset = ANSI_CHARSET
            Footer.Font.Color = clBlue
            Footer.Font.Height = -15
            Footer.Font.Name = #23435#20307
            Footer.Font.Style = []
            Footers = <>
            Title.Caption = #24050#26816
            Title.Color = clWindow
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clBlue
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'reporttime'
            Footers = <>
            Title.Caption = #25253#29677#26102#38388
            Width = 160
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #21457#29677#29366#24577
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schedulestatus'
            Footers = <>
            Title.Caption = #29677#27425#29366#24577
            Title.Font.Charset = GB2312_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -16
            Title.Font.Name = #23435#20307
            Title.Font.Style = [fsBold]
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'driver1'
            Footers = <>
            Title.Caption = #39550#39542#21592'1'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'driver2'
            Footers = <>
            Title.Caption = #39550#39542#21592'2'
            Width = 70
          end>
      end
      object Panel2: TPanel
        Left = 2
        Top = 16
        Width = 865
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        Color = clCaptionText
        ParentBackground = False
        TabOrder = 1
        object lbl2: TLabel
          Left = 459
          Top = 0
          Width = 11
          Height = 33
          Align = alLeft
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -20
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 20
        end
        object lblBillnum: TLabel
          AlignWithMargins = True
          Left = 337
          Top = 3
          Width = 33
          Height = 27
          Align = alLeft
          Caption = '100'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -19
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 19
        end
        object lblBillno: TLabel
          AlignWithMargins = True
          Left = 142
          Top = 3
          Width = 88
          Height = 27
          Align = alLeft
          Caption = '88888888'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -19
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 19
        end
        object Label4: TLabel
          AlignWithMargins = True
          Left = 236
          Top = 3
          Width = 95
          Height = 27
          Align = alLeft
          Caption = #21097#20313#24352#25968#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 19
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 133
          Height = 27
          Align = alLeft
          Caption = #24403#21069#32467#31639#21333#21495#65306
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 19
        end
        object Label5: TLabel
          AlignWithMargins = True
          Left = 376
          Top = 3
          Width = 80
          Height = 27
          Align = alLeft
          Caption = #25552#31034#20449#24687#65306
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitHeight = 16
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 360
    Top = 408
  end
  inherited ilToolBarDisable: TImageList
    Left = 424
    Top = 408
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'planlist'
    QueryAddress = 'checkticket/qryScheduleplanbyself'
    Params = <
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reportorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ta!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isreported'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isdeparted'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GES_ss!departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_vr!isdeparted'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 232
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResultseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsResultsoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsResultschedulestatus: TWideStringField
      FieldKind = fkLookup
      FieldName = 'schedulestatus'
      LookupDataSet = jcdsScheduleStatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Size = 50
      Lookup = True
    end
    object jcdsResultisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsResultvehiclereportid: TLargeintField
      FieldName = 'vehiclereportid'
    end
    object jcdsResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jcdsResultcarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object jcdsResultcheckeds: TIntegerField
      FieldName = 'checkeds'
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultdepartstation: TWideStringField
      FieldName = 'departstation'
      Size = 40
    end
    object jcdsResultendstation: TWideStringField
      FieldName = 'endstation'
      Size = 40
    end
    object jcdsResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 40
    end
    object jcdsResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 40
    end
    object jcdsResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 40
    end
    object jcdsResultbrandname: TWideStringField
      FieldName = 'brandname'
      Size = 40
    end
    object jcdsResultmodelcode: TWideStringField
      FieldName = 'modelcode'
    end
    object jcdsResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsResultisreported: TBooleanField
      FieldName = 'isreported'
    end
    object jcdsResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object jcdsResultschtype: TWideStringField
      FieldName = 'schtype'
      Size = 10
    end
    object jcdsResultdistance: TIntegerField
      FieldName = 'distance'
    end
    object jcdsResultplanvehiclebrandmodelid: TLargeintField
      FieldName = 'planvehiclebrandmodelid'
    end
    object jcdsResultreporttime: TDateTimeField
      FieldName = 'reporttime'
    end
    object jcdsResultdriver1: TWideStringField
      FieldName = 'driver1'
      Size = 100
    end
    object jcdsResultdriver2: TWideStringField
      FieldName = 'driver2'
      Size = 100
    end
  end
  inherited dsResult: TDataSource
    Left = 248
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 720
    Top = 248
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
    Left = 496
    Top = 232
  end
  object jscdSchDepartinvoice: TjsonClientDataSet
    DataSourceName = 'dateset'
    SaveAddress = 'checkticket/schDepartinvoice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
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
    Left = 336
    Top = 296
  end
  object tmrFlash: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tmrFlashTimer
    Left = 72
    Top = 224
  end
  object jcdsDepartinvoice: TjsonClientDataSet
    DataSourceName = 'invoiceslist'
    QueryAddress = 'checkticket/vehicleDepartinvoice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'iscomputeno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isreprint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
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
    Left = 496
    Top = 304
  end
  object jscdQryDeductfees: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryDeductfees'
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
    Left = 608
    Top = 320
  end
  object jcdsQryDetail: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryInvoicesDetailPrintInfo'
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
    Left = 616
    Top = 224
  end
  object jcdsOthersells: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'checkticket/qryOthersellmessage'
    SaveAddress = 'checkticket/qryOthersellmessage'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'othersells'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 152
    Top = 248
  end
  object jscdqryScheduleReport: TjsonClientDataSet
    DataSourceName = 'invoiceslist'
    QueryAddress = 'checkticket/qryScheduleReport'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'reportorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cardno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 696
    Top = 64
  end
end
