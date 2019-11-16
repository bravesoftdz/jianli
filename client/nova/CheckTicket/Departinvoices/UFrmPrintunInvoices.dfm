inherited FrmPrintunInvoices: TFrmPrintunInvoices
  Caption = 'FrmPrintunInvoices'
  ClientHeight = 389
  ClientWidth = 811
  OnShow = FormShow
  ExplicitWidth = 827
  ExplicitHeight = 427
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 811
    Height = 59
    ExplicitWidth = 811
    ExplicitHeight = 59
    object Label2: TLabel
      Left = 17
      Top = 25
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl1: TLabel
      Left = 366
      Top = 25
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object lbl3: TLabel
      Left = 198
      Top = 25
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object dtpstartdate: TDateTimePicker
      Left = 78
      Top = 19
      Width = 102
      Height = 22
      Date = 40698.000000000000000000
      Time = 40698.000000000000000000
      TabOrder = 0
    end
    object nvhlpcode: TNovaHelp
      Left = 430
      Top = 22
      Width = 104
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
      OnChange = nvhlpcodeChange
      OnIdChange = nvhlpcodeIdChange
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
          Title.Caption = #36710#29260#21495
          Width = 120
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpschedule: TNovaHelp
      Left = 232
      Top = 22
      Width = 102
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #29677#27425
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 811
    ExplicitWidth = 811
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #34917#24320
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      AutoSize = True
      Caption = ''
      Visible = False
      ExplicitWidth = 31
    end
    inherited tbtnDelete: TToolButton
      Left = 179
      AutoSize = True
      Caption = ''
      Visible = False
      ExplicitLeft = 179
      ExplicitWidth = 31
    end
    inherited ToolButton50: TToolButton
      Left = 210
      ExplicitLeft = 210
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 228
      ExplicitLeft = 228
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 246
      Visible = False
      ExplicitLeft = 246
    end
    inherited tbtnSave: TToolButton
      Left = 254
      AutoSize = True
      Caption = ''
      Visible = False
      ExplicitLeft = 254
      ExplicitWidth = 31
    end
    inherited tbtnCancel: TToolButton
      Left = 285
      AutoSize = True
      Caption = ''
      Visible = False
      ExplicitLeft = 285
      ExplicitWidth = 31
    end
    inherited ToolButton52: TToolButton
      Left = 316
      ExplicitLeft = 316
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 334
      ExplicitLeft = 334
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 352
      ExplicitLeft = 352
    end
    inherited tbtnInfo: TToolButton
      Left = 360
      ExplicitLeft = 360
    end
    inherited tbtn5: TToolButton
      Left = 430
      ExplicitLeft = 430
    end
    inherited tbtnExcel: TToolButton
      Left = 438
      ExplicitLeft = 438
    end
    inherited tbtnPrinter: TToolButton
      Left = 508
      ExplicitLeft = 508
    end
    inherited tbtn6: TToolButton
      Left = 578
      ExplicitLeft = 578
    end
    inherited tbtnClose: TToolButton
      Left = 586
      ExplicitLeft = 586
    end
  end
  inherited Panel1: TPanel
    Top = 104
    Width = 811
    Height = 285
    ExplicitTop = 104
    ExplicitWidth = 811
    ExplicitHeight = 285
    inherited GroupBox1: TGroupBox
      Width = 811
      Height = 285
      ExplicitWidth = 811
      ExplicitHeight = 285
      inherited dbgrdhResult: TNvDbgridEh
        Width = 807
        Height = 267
        FooterRowCount = 1
        ReadOnly = False
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'isselect'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36873#25321
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Width = 100
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
            FieldName = 'departtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#21495
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25253#21040#36710#36742
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'sellbyname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#21592
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 168
    Top = 296
  end
  inherited ilToolBarDisable: TImageList
    Left = 248
    Top = 296
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'departinvoicesMap'
    QueryAddress = 'checkticket/qryunchecktickets'
    Params = <
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 216
    Top = 176
  end
  inherited dsResult: TDataSource
    Left = 64
    Top = 296
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 528
    Top = 312
  end
  object jcdsResultSave: TjsonClientDataSet
    DataSourceName = 'departinvoicesMap'
    QueryAddress = 'checkticket/printjcDepartinvoies'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketids'
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
    Left = 344
    Top = 184
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
    Left = 496
    Top = 232
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
    Left = 600
    Top = 240
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
    Left = 496
    Top = 168
  end
end
