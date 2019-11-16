inherited FrmTicketCancel: TFrmTicketCancel
  ActiveControl = nvedtticketnos
  Caption = #24223#31080#24223#20445#38505
  ClientHeight = 453
  ClientWidth = 891
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 907
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 891
    Height = 87
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitWidth = 891
    ExplicitHeight = 87
    object pnlleft: TPanel
      Left = 0
      Top = 0
      Width = 87
      Height = 87
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object rbticketno: TRadioButton
        Left = 10
        Top = 8
        Width = 61
        Height = 17
        Caption = #25353#31080#21495
        TabOrder = 2
        OnClick = rbticketnoClick
      end
      object rbschedule: TRadioButton
        Left = 10
        Top = 37
        Width = 61
        Height = 17
        Caption = #25353#26085#26399
        TabOrder = 1
        OnClick = rbticketnoClick
      end
      object rbinsureno: TRadioButton
        Left = 10
        Top = 66
        Width = 77
        Height = 17
        Caption = #25353#20445#21333#21495
        TabOrder = 0
        OnClick = rbticketnoClick
      end
    end
    object pnlinput: TPanel
      Left = 87
      Top = 0
      Width = 804
      Height = 87
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlticketno: TPanel
        Left = 0
        Top = 0
        Width = 804
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object nvedtticketnos: TNovaEdit
          Left = 1
          Top = 6
          Width = 413
          Height = 22
          Hint = #36755#20837#22810#24352#31080#21495#35831#29992','#25110'-'#20998#38548#31526
          CharCase = ecUpperCase
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnKeyPress = nvedtticketnosKeyPress
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
      object pnlschedule: TPanel
        Left = 0
        Top = 33
        Width = 804
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object lblschedule: TLabel
          Left = 108
          Top = 7
          Width = 28
          Height = 14
          Caption = #29677#27425
        end
        object lblseatno: TLabel
          Left = 294
          Top = 7
          Width = 42
          Height = 14
          Caption = #24231#20301#21495
        end
        object dtpdepartdate: TDateTimePicker
          Left = 0
          Top = 3
          Width = 98
          Height = 22
          Date = 40708.630482696760000000
          Time = 40708.630482696760000000
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 0
        end
        object nvedtseatno: TNovaEdit
          Left = 338
          Top = 4
          Width = 76
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          NumbersOnly = True
          TabOrder = 1
          OnKeyPress = nvedtseatnoKeyPress
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
        object nvhelpschedule: TNovaHelp
          Left = 142
          Top = 4
          Width = 138
          Height = 22
          CharCase = ecUpperCase
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          TabOrder = 2
          OnKeyPress = nvhelpscheduleKeyPress
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
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'ScheduleRHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
      end
      object pnlinsurenos: TPanel
        Left = 0
        Top = 62
        Width = 804
        Height = 28
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object nvedtInsurenos: TNovaEdit
          Left = 0
          Top = 3
          Width = 414
          Height = 22
          Hint = #36755#20837#22810#24352#31080#21495#35831#29992','#25110'-'#20998#38548#31526
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnKeyPress = nvedtticketnosKeyPress
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
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 891
    ExplicitWidth = 891
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 88
      ExplicitHeight = 49
    end
    inherited tbtnInsert: TToolButton
      AutoSize = True
      Visible = False
      ExplicitWidth = 39
    end
    inherited tbtnEdit: TToolButton
      Left = 117
      AutoSize = True
      Visible = False
      ExplicitLeft = 117
      ExplicitWidth = 39
    end
    inherited tbtnDelete: TToolButton
      Left = 156
      AutoSize = True
      Visible = False
      ExplicitLeft = 156
      ExplicitWidth = 39
    end
    inherited ToolButton50: TToolButton
      Left = 195
      ImageIndex = 4
      ExplicitLeft = 195
      ExplicitWidth = 31
    end
    inherited ToolButton51: TToolButton
      Left = 226
      Caption = #24223#31080
      ImageIndex = 4
      Visible = True
      OnClick = ToolButton51Click
      ExplicitLeft = 226
      ExplicitWidth = 39
    end
    inherited tbtn3: TToolButton
      Left = 265
      ExplicitLeft = 265
    end
    inherited tbtnSave: TToolButton
      Left = 273
      AutoSize = True
      Visible = False
      ExplicitLeft = 273
      ExplicitWidth = 39
    end
    inherited tbtnCancel: TToolButton
      Left = 312
      AutoSize = True
      Visible = False
      ExplicitLeft = 312
      ExplicitWidth = 39
    end
    inherited ToolButton52: TToolButton
      Left = 351
      Caption = #29305#26435#24223#31080
      ImageIndex = 4
      Visible = True
      OnClick = ToolButton51Click
      ExplicitLeft = 351
      ExplicitWidth = 67
    end
    inherited ToolButton53: TToolButton
      Left = 418
      ExplicitLeft = 418
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 436
      ExplicitLeft = 436
    end
    inherited tbtnInfo: TToolButton
      Left = 444
      AutoSize = True
      Caption = ' '#35828#26126' '
      ExplicitLeft = 444
      ExplicitWidth = 53
    end
    inherited tbtn5: TToolButton
      Left = 497
      ExplicitLeft = 497
    end
    inherited tbtnExcel: TToolButton
      Left = 505
      AutoSize = True
      ExplicitLeft = 505
      ExplicitWidth = 74
    end
    inherited tbtnPrinter: TToolButton
      Left = 579
      AutoSize = True
      ExplicitLeft = 579
      ExplicitWidth = 39
    end
    inherited tbtn6: TToolButton
      Left = 618
      ExplicitLeft = 618
    end
    inherited tbtnClose: TToolButton
      Left = 626
      AutoSize = True
      ExplicitLeft = 626
      ExplicitWidth = 39
    end
  end
  inherited Panel1: TPanel
    Top = 132
    Width = 891
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 132
    ExplicitWidth = 891
    inherited GroupBox1: TGroupBox
      Left = 208
      Width = 683
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitLeft = 208
      ExplicitWidth = 683
      inherited dbgrdhResult: TNvDbgridEh
        Width = 679
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ReadOnly = False
        OnDrawColumnCell = dbgrdhResultDrawColumnCell
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            AlwaysShowEditButton = True
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isselected'
            Footers = <>
            Title.Caption = #24223#36710#31080
            Width = 51
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = True
            EditButtons = <>
            FieldName = 'iscancelinsure'
            Footers = <>
            Title.Caption = #24223#20445#38505
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#21495
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24050#26816
            Width = 34
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#27454#25903#20184#26041#24335
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#20215
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footers = <>
            Title.Caption = #26381#21153#36153
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#21495
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#31080#29366#24577
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'insuranceno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#21333#21495
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24050#21457#29677
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            ReadOnly = True
            Title.Caption = #27969#27700#29677
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            ReadOnly = True
            Title.Caption = #23458#25143#22995#21517
            Width = 61
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
            FieldName = 'tickettypeprintname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#31080#31867#22411
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insurancepaymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#36153#25903#20184#26041#24335
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'sellwayname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#26041#24335
            Width = 61
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
        end
      end
    end
    object pnlvip: TPanel
      Left = 0
      Top = 0
      Width = 208
      Height = 321
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object lbl10: TLabel
        Left = 16
        Top = 183
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #21345#20869#31215#20998
      end
      object lblviplastamount: TLabel
        Left = 80
        Top = 178
        Width = 65
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '1800.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl11: TLabel
        Left = 16
        Top = 211
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #26412#27425#31215#20998
        Visible = False
      end
      object lbl13: TLabel
        Left = 16
        Top = 155
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #21345#20869#20313#39069
      end
      object lblvipamount: TLabel
        Left = 80
        Top = 206
        Width = 20
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '20'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lbl6: TLabel
        Left = 27
        Top = 238
        Width = 70
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #36141#31080#21518#20313#39069
        Visible = False
      end
      object lblviplastmoney: TLabel
        Left = 80
        Top = 150
        Width = 65
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '1800.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl8: TLabel
        Left = 24
        Top = 253
        Width = 70
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #36141#31080#21518#31215#20998
        Visible = False
      end
      object lblvipnewamount: TLabel
        Left = 103
        Top = 248
        Width = 26
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '20'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -21
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblvipnewmoney: TLabel
        Left = 106
        Top = 234
        Width = 84
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '1800.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -21
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object bvlvip: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 145
        Width = 212
        Height = 3
        Margins.Left = 10
        Margins.Right = 10
        Shape = bsTopLine
      end
      object lbl14: TLabel
        Left = 30
        Top = 65
        Width = 42
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'IC'#21345#21495
      end
      object lbl15: TLabel
        Left = 16
        Top = 37
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'IC'#21345#31867#22411
      end
      object lbl16: TLabel
        Left = 16
        Top = 92
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #39038#23458#22995#21517
      end
      object lbl17: TLabel
        Left = 16
        Top = 120
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #39038#23458#30005#35805
      end
      object lblvipname: TLabel
        Left = 80
        Top = 87
        Width = 34
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #24352#19977
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblvipcardno: TLabel
        Left = 80
        Top = 60
        Width = 80
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '88888888'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblvipcardtype: TLabel
        Left = 80
        Top = 32
        Width = 34
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #37329#21345
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblviptel: TLabel
        Left = 80
        Top = 115
        Width = 110
        Height = 24
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '13812345678'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnclearvipinfo: TBitBtn
        Left = 16
        Top = 5
        Width = 103
        Height = 25
        Caption = '&C'#28165#31354'VIP'#20449#24687
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnclearvipinfoClick
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 120
    Top = 240
  end
  inherited ilToolBarDisable: TImageList
    Left = 192
    Top = 240
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketcancelquery'
    QueryAddress = 'cancelticket/find'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQS_tsl!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_tsl!departdate'
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
      end>
    Left = 272
    Top = 240
  end
  inherited dsResult: TDataSource
    OnDataChange = dsResultDataChange
    Left = 56
    Top = 240
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 248
  end
  object jsoncdsticketcancel: TjsonClientDataSet
    DataSourceName = 'ticketcancelempty'
    UpdateDataSet = 'ticketcancels'
    QueryAddress = 'cancelticket/findEmpty'
    SaveAddress = 'cancelticket/cancel'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
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
    Left = 617
    Top = 265
  end
  object jcdsvipinfo: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'VipHelp'
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_v!vipcardno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_v!status'
        ParamType = ptInput
        Value = '0'
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 200
  end
end
