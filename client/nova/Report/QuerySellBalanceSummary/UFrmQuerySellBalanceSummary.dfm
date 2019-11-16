inherited frmQuerySellbalanceSummary: TfrmQuerySellbalanceSummary
  Caption = 'frmQuerySellbalanceSummary'
  ClientHeight = 386
  ClientWidth = 896
  ExplicitWidth = 912
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 896
    Height = 93
    ExplicitWidth = 896
    ExplicitHeight = 93
    object lbl1: TLabel
      Left = 12
      Top = 24
      Width = 56
      Height = 14
      Caption = #25171#21333#26426#26500
    end
    object lbl2: TLabel
      Left = 250
      Top = 24
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object lbl3: TLabel
      Left = 474
      Top = 24
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl4: TLabel
      Left = 672
      Top = 24
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl5: TLabel
      Left = 12
      Top = 55
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl6: TLabel
      Left = 250
      Top = 55
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbl7: TLabel
      Left = 474
      Top = 55
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object cbbPrintOrgid: TNovaCheckedComboBox
      Left = 78
      Top = 21
      Width = 125
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbbSellOrgid: TNovaCheckedComboBox
      Left = 302
      Top = 21
      Width = 125
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpstartdate: TDateTimePicker
      Left = 536
      Top = 21
      Width = 125
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object dtpenddate: TDateTimePicker
      Left = 697
      Top = 21
      Width = 125
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      Checked = False
      TabOrder = 3
    end
    object nvhlpRoute: TNovaHelp
      Left = 78
      Top = 52
      Width = 125
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 4
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
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpSchedule: TNovaHelp
      Left = 302
      Top = 52
      Width = 125
      Height = 22
      CharCase = ecUpperCase
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
          Title.Caption = #21517#31216
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpVehicle: TNovaHelp
      Left = 536
      Top = 49
      Width = 125
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'brandname'
          Title.Caption = #21378#29260
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 896
    ExplicitWidth = 896
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
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
    inherited tbtn4: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 138
    Width = 896
    Height = 248
    ExplicitTop = 138
    ExplicitWidth = 896
    ExplicitHeight = 248
    inherited GroupBox1: TGroupBox
      Width = 896
      Height = 248
      ExplicitWidth = 896
      ExplicitHeight = 248
      inherited dbgrdhResult: TNvDbgridEh
        Width = 892
        Height = 230
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'printorgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25171#21333#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'sellorgname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'invoicenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#21333#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24352#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ticketvalidatenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = ' '#21806#31080#26377#25928#24352#25968
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'schnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29677#27425#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'printpeople'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25171#21333#20154#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'nonfactnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28431#20056#20154#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#24352#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#24352#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'sellamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'sellvalidateamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#37329#39069'('#26377#25928#31080')'
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'invoiceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#37327#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'nonfactamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28431#20056#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'returnamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'cancelamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'shouxufee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25163#32493#36153
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'revenueamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33829#25910#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutsmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#31449#33829#25910
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31449#21153#36153
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#29123#27833#36153
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#24494#26426#36153
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31354#35843#36153
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#38468#21152#36153
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#37197#27700#36153
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20445#38505#36153
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20854#20182
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23567#35745
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 100
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 78
    Top = 285
  end
  inherited ilToolBarDisable: TImageList
    Left = 155
    Top = 285
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'sellbalancelist'
    QueryAddress = 'report/qrySellBalanceSummary'
    SaveAddress = 'report/qrySellBalanceSummary'
    Params = <
      item
        DataType = ftString
        Name = 'printorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end>
    Left = 240
    Top = 286
  end
  inherited dsResult: TDataSource
    Left = 7
    Top = 287
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 330
    Top = 287
  end
end
