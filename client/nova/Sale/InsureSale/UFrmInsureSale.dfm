inherited FrmInsureSale: TFrmInsureSale
  ActiveControl = nvedtticketnos
  Caption = 'FrmInsureSale'
  ClientHeight = 453
  ClientWidth = 1255
  OnActivate = FormActivate
  OnShow = FormShow
  ExplicitWidth = 1271
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1255
    Height = 82
    ExplicitWidth = 1255
    ExplicitHeight = 82
    object pnlleft: TPanel
      Left = 0
      Top = 0
      Width = 74
      Height = 82
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object rbticketno: TRadioButton
        Left = 10
        Top = 17
        Width = 61
        Height = 17
        Caption = #25353#31080#21495
        TabOrder = 0
        OnClick = rbticketnoClick
      end
      object rbschedule: TRadioButton
        Left = 10
        Top = 54
        Width = 98
        Height = 17
        Caption = #25353#26085#26399
        TabOrder = 1
        OnClick = rbticketnoClick
      end
    end
    object pnlinput: TPanel
      Left = 74
      Top = 0
      Width = 1181
      Height = 82
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlticketno: TPanel
        Left = 0
        Top = 0
        Width = 1181
        Height = 42
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          1181
          42)
        object nvedtticketnos: TNovaEdit
          Left = 5
          Top = 14
          Width = 200
          Height = 22
          Hint = #36755#20837#22810#24352#31080#21495#35831#29992','#25110'-'#20998#38548#31526
          Anchors = [akLeft, akTop, akRight]
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
        Top = 42
        Width = 1181
        Height = 40
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object lblschedule: TLabel
          Left = 115
          Top = 15
          Width = 28
          Height = 14
          Caption = #29677#27425
        end
        object lblseatno: TLabel
          Left = 301
          Top = 15
          Width = 42
          Height = 14
          Caption = #24231#20301#21495
        end
        object dtpdepartdate: TDateTimePicker
          Left = 5
          Top = 11
          Width = 98
          Height = 22
          Date = 40708.630482696760000000
          Time = 40708.630482696760000000
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 0
        end
        object nvedtseatno: TNovaEdit
          Left = 345
          Top = 12
          Width = 71
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          TabOrder = 1
          OnKeyPress = nvedtseatnoKeyPress
          ValueType = ssNumber
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
          Left = 149
          Top = 12
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
        object gbinsureno: TGroupBox
          Left = 927
          Top = 0
          Width = 254
          Height = 40
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alRight
          Caption = #24403#21069#20445#21333#21495
          TabOrder = 3
          object lblinsureno: TLabel
            Left = 2
            Top = 16
            Width = 108
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            Alignment = taCenter
            Caption = '012345678912'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = #24494#36719#38597#40657
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
          object lbl7: TLabel
            Left = 110
            Top = 16
            Width = 15
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            Alignment = taRightJustify
            Caption = #20313
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #24494#36719#38597#40657
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
          object lblleaveinsurenum: TLabel
            Left = 125
            Top = 16
            Width = 108
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            Alignment = taCenter
            Caption = '012345678912'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -15
            Font.Name = #24494#36719#38597#40657
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
          object lbl12: TLabel
            Left = 233
            Top = 16
            Width = 15
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            Alignment = taCenter
            Caption = #24352
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #24494#36719#38597#40657
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
        end
      end
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1255
    ExplicitWidth = 1255
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = '&S.'#21806#20445#38505
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Visible = False
    end
    inherited ToolButton50: TToolButton
      ImageIndex = 4
      ExplicitWidth = 31
    end
    inherited ToolButton51: TToolButton
      Left = 319
      ImageIndex = 4
      ExplicitLeft = 319
      ExplicitWidth = 31
    end
    inherited tbtn3: TToolButton
      Left = 350
      Visible = False
      ExplicitLeft = 350
    end
    inherited tbtnSave: TToolButton
      Left = 358
      Visible = False
      ExplicitLeft = 358
    end
    inherited tbtnCancel: TToolButton
      Left = 428
      Visible = False
      ExplicitLeft = 428
    end
    inherited ToolButton52: TToolButton
      Left = 498
      ImageIndex = 4
      ExplicitLeft = 498
      ExplicitWidth = 31
    end
    inherited ToolButton53: TToolButton
      Left = 529
      ExplicitLeft = 529
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 547
      ExplicitLeft = 547
    end
    inherited tbtnInfo: TToolButton
      Left = 555
      ExplicitLeft = 555
    end
    inherited tbtn5: TToolButton
      Left = 625
      ExplicitLeft = 625
    end
    inherited tbtnExcel: TToolButton
      Left = 633
      ExplicitLeft = 633
    end
    inherited tbtnPrinter: TToolButton
      Left = 703
      ExplicitLeft = 703
    end
    inherited tbtn6: TToolButton
      Left = 773
      ExplicitLeft = 773
    end
    inherited tbtnClose: TToolButton
      Left = 781
      ExplicitLeft = 781
    end
  end
  inherited Panel1: TPanel
    Top = 127
    Width = 1255
    Height = 326
    ExplicitTop = 127
    ExplicitWidth = 1255
    ExplicitHeight = 326
    inherited GroupBox1: TGroupBox
      Width = 1255
      Height = 326
      ExplicitWidth = 1255
      ExplicitHeight = 326
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1251
        Height = 308
        ReadOnly = False
        OnKeyDown = dbgrdhResultKeyDown
        Columns = <
          item
            AlwaysShowEditButton = True
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isselected'
            Footers = <>
            Title.Caption = #36873#20013
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
            FieldName = 'departdate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Width = 48
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
            FieldName = 'ischecked'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24050#26816
            Width = 34
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
            Title.Caption = #27969#27700#29677#27425
            Width = 61
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
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#21495
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#31080#29366#24577
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'insuranceno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#21333#21495
            Width = 122
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
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 60
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
            FieldName = 'paymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#27454#25903#20184#26041#24335
            Width = 92
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
    DataSourceName = 'tickets'
    QueryAddress = 'insurancesell/findTicket'
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
    Left = 347
    Top = 277
  end
  object tmrleaveinsurenum: TTimer
    Enabled = False
    OnTimer = tmrleaveinsurenumTimer
    Left = 415
    Top = 194
  end
  object tmrRefreshBill: TTimer
    OnTimer = tmrRefreshBillTimer
    Left = 512
    Top = 208
  end
end
