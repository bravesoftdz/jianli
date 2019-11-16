inherited FrmOrgInvoinceDetail: TFrmOrgInvoinceDetail
  Caption = #23458#36816#31449#21010#25320#26126#32454#34920
  ClientHeight = 399
  ClientWidth = 1031
  OnShow = FormShow
  ExplicitWidth = 1047
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1031
    Height = 106
    ExplicitWidth = 1031
    ExplicitHeight = 106
    object lbl1: TLabel
      Left = 39
      Top = 21
      Width = 28
      Height = 14
      Caption = #26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 240
      Top = 18
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 496
      Top = 19
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label4: TLabel
      Left = 11
      Top = 48
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label5: TLabel
      Left = 243
      Top = 81
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label7: TLabel
      Left = 240
      Top = 49
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object Label2: TLabel
      Left = 14
      Top = 81
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object Label3: TLabel
      Left = 468
      Top = 48
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbltype: TLabel
      Left = 454
      Top = 80
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#22411
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 75
      Top = 15
      Width = 138
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
    object dtpstartdate: TDateTimePicker
      Left = 304
      Top = 15
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 516
      Top = 14
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object NHelpRoute: TNovaHelp
      Left = 75
      Top = 44
      Width = 138
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 3
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpVehiclenoHelp: TNovaHelp
      Left = 304
      Top = 77
      Width = 119
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 7
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
    object NovaHelpBalanceUnit: TNovaHelp
      Left = 302
      Top = 44
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpUnit: TNovaHelp
      Left = 75
      Top = 77
      Width = 138
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 516
      Top = 44
      Width = 136
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
          Title.Caption = #29677#27425#21495
          Width = 70
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
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbChecktype: TNovaCheckedComboBox
      Left = 516
      Top = 77
      Width = 155
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'vehicle'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'type'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1031
    ExplicitWidth = 1031
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
    Top = 151
    Width = 1031
    Height = 248
    ExplicitTop = 151
    ExplicitWidth = 1031
    ExplicitHeight = 248
    inherited GroupBox1: TGroupBox
      Width = 1031
      Height = 248
      ExplicitWidth = 1031
      ExplicitHeight = 248
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1027
        Height = 230
        Color = clBtnFace
        FooterRowCount = 1
        SumList.Active = True
        SumList.VirtualRecords = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32447#36335
            Width = 129
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'invoinceno'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32467#31639#21333#21495
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 132
          end
          item
            EditButtons = <>
            FieldName = 'balaceunitname'
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'printtime'
            Footers = <>
            Title.Caption = #25171#21333#26102#38388
            Width = 102
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #36816#33829#31867#22411
            Width = 102
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
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31449#21153#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#29123#27833#36153
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#25187#36153'1'
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#38468#21152#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31354#35843#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#37197#27700#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20445#38505#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20854#20182
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23567#35745
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'basefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22522#26412#36816#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'peopledistance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21608#36716#37327
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'remark'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 54
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 136
    Top = 248
  end
  inherited ilToolBarDisable: TImageList
    Left = 200
    Top = 248
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryInvoincesDetail'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_dv!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_dv!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u2!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u1!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_v!type'
        ParamType = ptInput
      end>
    Left = 288
    Top = 248
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 240
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 376
    Top = 256
  end
end
