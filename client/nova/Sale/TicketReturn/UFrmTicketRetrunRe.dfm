inherited FrmTicketRetrunRe: TFrmTicketRetrunRe
  Caption = 'FrmTicketRetrunRe'
  ClientHeight = 536
  ClientWidth = 1204
  OnActivate = FormActivate
  OnShow = FormShow
  ExplicitWidth = 1220
  ExplicitHeight = 575
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1204
    Height = 116
    ExplicitWidth = 1204
    ExplicitHeight = 116
    object lblseatno: TLabel
      Left = 412
      Top = 54
      Width = 42
      Height = 14
      Caption = #24231#20301#21495
    end
    object lblschedule: TLabel
      Left = 226
      Top = 54
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object rbticketno: TRadioButton
      Left = 19
      Top = 20
      Width = 61
      Height = 17
      Caption = #25353#31080#21495
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbticketnoClick
    end
    object rbschedule: TRadioButton
      Left = 18
      Top = 52
      Width = 61
      Height = 17
      Caption = #25353#26085#26399
      TabOrder = 1
      OnClick = rbticketnoClick
    end
    object rbinsureno: TRadioButton
      Left = 18
      Top = 86
      Width = 77
      Height = 17
      Caption = #20445#21333#21495
      TabOrder = 2
      TabStop = True
      OnClick = rbticketnoClick
    end
    object nvedtticketnos: TNovaEdit
      Left = 93
      Top = 17
      Width = 464
      Height = 22
      Hint = #36755#20837#22810#24352#31080#21495#35831#29992','#25110'-'#20998#38548#31526
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyUp = nvedtticketnosKeyUp
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
    object dtpdepartdate: TDateTimePicker
      Left = 93
      Top = 49
      Width = 112
      Height = 22
      Date = 40708.630482696760000000
      Time = 40708.630482696760000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 4
    end
    object nvhelpschedule: TNovaHelp
      Left = 270
      Top = 50
      Width = 113
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 5
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
          Title.Caption = #29677#27425#21495
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'endstationname'
          Title.Caption = #32456#28857#31449
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #22987#21457#26102#38388
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedtseatno: TNovaEdit
      Left = 459
      Top = 50
      Width = 96
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      NumbersOnly = True
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
    end
    object nvedtInsurenos: TNovaEdit
      Left = 93
      Top = 83
      Width = 465
      Height = 22
      Hint = #36755#20837#22810#24352#31080#21495#35831#29992','#25110'-'#20998#38548#31526
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnKeyUp = nvedtticketnosKeyUp
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
    object gbreturnvoucher: TGroupBox
      AlignWithMargins = True
      Left = 714
      Top = 49
      Width = 343
      Height = 64
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Caption = #24403#21069#36864#31080#20973#35777#21495
      TabOrder = 8
      object lblticketno: TLabel
        Left = 2
        Top = 16
        Width = 146
        Height = 46
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = '012345678912'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 292
        Top = 16
        Width = 16
        Height = 46
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Alignment = taCenter
        Caption = #24352
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 22
      end
      object lbl3: TLabel
        Left = 148
        Top = 16
        Width = 24
        Height = 46
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20313
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 142
      end
      object lblleaveticketnum: TLabel
        Left = 172
        Top = 16
        Width = 120
        Height = 46
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Alignment = taCenter
        Caption = '012345678912'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 22
      end
    end
    object pnllastmoney: TPanel
      Left = 663
      Top = 9
      Width = 354
      Height = 39
      BevelOuter = bvNone
      TabOrder = 9
      Visible = False
      object lbl1: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 8
        Width = 32
        Height = 31
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = #31080#27454
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 22
      end
      object lbllastmoney: TLabel
        AlignWithMargins = True
        Left = 32
        Top = 8
        Width = 65
        Height = 31
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '1050.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 24
      end
      object lbl4: TLabel
        AlignWithMargins = True
        Left = 97
        Top = 8
        Width = 48
        Height = 31
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = #25163#32493#36153
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 22
      end
      object lblreceipt: TLabel
        AlignWithMargins = True
        Left = 145
        Top = 8
        Width = 65
        Height = 31
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '1050.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 24
      end
      object lbl5: TLabel
        AlignWithMargins = True
        Left = 210
        Top = 8
        Width = 32
        Height = 31
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = #36864#27454
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 22
      end
      object lblchange: TLabel
        AlignWithMargins = True
        Left = 242
        Top = 0
        Width = 116
        Height = 39
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = '1050.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -29
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1204
    ExplicitWidth = 1204
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #36864#31080
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Caption = #36131#20219#36864#31080
      ImageIndex = 1
      OnClick = tbtnInsertClick
    end
    inherited tbtnDelete: TToolButton
      Caption = #29305#26435#36864#31080
      ImageIndex = 1
      OnClick = tbtnInsertClick
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtnSave: TToolButton
      Caption = #31614#25163#32493#36153
      ImageIndex = 15
      OnClick = tbtnSaveClick
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
    Top = 161
    Width = 1204
    Height = 375
    ExplicitTop = 161
    ExplicitWidth = 1204
    ExplicitHeight = 375
    inherited GroupBox1: TGroupBox
      Width = 1204
      Height = 375
      ExplicitWidth = 1204
      ExplicitHeight = 375
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1200
        Height = 357
        FooterRowCount = 1
        ReadOnly = False
        SumList.Active = True
        OnKeyUp = dbgrdhResultKeyUp
        Columns = <
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isselected'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36864#36710#31080
            Width = 51
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isreturninsure'
            Footers = <>
            Title.Caption = #36864#20445#38505
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            ReadOnly = True
            Title.Caption = #26816#31080
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
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
            FieldName = 'charges'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25163#32493#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'rate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36153#29575
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29366#24577
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footers = <>
            ReadOnly = True
            Title.Caption = #26381#21153#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insuranceno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#29677
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            ReadOnly = True
            Title.Caption = #27969#27700
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'premium'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#36153
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20184#27454#26041#24335
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'signcharges'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31614#31080#36153#29575
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'signbyname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31614#31080#20154
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'signreason'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31614#31080#21407#22240
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'signtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31614#31080#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36141#31080#20154
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'insurancepaymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#38505#20184#27454#26041#24335
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sellwayname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#26041#24335
            Visible = False
            Width = 80
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
    Left = 360
    Top = 360
  end
  inherited ilToolBarDisable: TImageList
    Left = 464
    Top = 360
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketreturnquery'
    QueryAddress = 'returnticket/find'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQD_tsl!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_tsl!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_isr!insuranceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sc!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQR_tsl!seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_tsl!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_tsl!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_isr!insuranceno'
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
    Left = 96
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 296
    Top = 360
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 600
    Top = 352
  end
  object tmrleaveticketnum: TTimer
    Enabled = False
    OnTimer = tmrleaveticketnumTimer
    Left = 632
    Top = 200
  end
  object tmrRefreshBill: TTimer
    Interval = 5000
    OnTimer = tmrRefreshBillTimer
    Left = 552
    Top = 200
  end
  object jsoncdsticketreturn: TjsonClientDataSet
    DataSourceName = 'ticketreturnempty'
    UpdateDataSet = 'ticketreturns'
    QueryAddress = 'returnticket/findEmpty'
    SaveAddress = 'returnticket/return'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'vipcardno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'vipgrade'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'vipmoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'vippoint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'canprint'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 265
    Top = 209
  end
  object jcdsgetticketreturnrate: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/getticketreturnrate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departdatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'islinework'
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
      end
      item
        DataType = ftFloat
        Name = 'returnrate'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 384
    Top = 216
  end
  object jcdsfindticketfee: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'returnticket/findticketfee'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'isselfschedule'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketsellid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketfee'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 120
    Top = 360
  end
  object qryjcdseticket: TjsonClientDataSet
    DataSourceName = 'ticketcancelquery'
    QueryAddress = 'cancelticket/eticket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQS_ts!id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 480
    Top = 288
  end
end
