inherited FrmVehicleIncome: TFrmVehicleIncome
  Caption = #36710#36742#21010#25320#27719#24635#34920
  ClientHeight = 431
  ClientWidth = 883
  OnShow = FormShow
  ExplicitWidth = 899
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 883
    Height = 108
    ExplicitWidth = 883
    ExplicitHeight = 108
    object lbl1: TLabel
      Left = 25
      Top = 23
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 228
      Top = 20
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 487
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label6: TLabel
      Left = 230
      Top = 52
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object lbltype: TLabel
      Left = 230
      Top = 84
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#22411
    end
    object Label4: TLabel
      Left = 25
      Top = 52
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label7: TLabel
      Left = 454
      Top = 52
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object Label5: TLabel
      Left = 26
      Top = 84
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label2: TLabel
      Left = 686
      Top = 20
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object Label3: TLabel
      Left = 441
      Top = 83
      Width = 70
      Height = 14
      Caption = #24320#36816#37327#21333#20301
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lblRun: TLabel
      Left = 686
      Top = 52
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 90
      Top = 17
      Width = 121
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
      Left = 292
      Top = 17
      Width = 126
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 517
      Top = 16
      Width = 136
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object NovaHelpBalanceUnit: TNovaHelp
      Left = 293
      Top = 48
      Width = 125
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
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbbType: TNovaComboBox
      Left = 292
      Top = 80
      Width = 126
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 4
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
      HelpOptions.TableName = 'vehicle'
      HelpOptions.Columnname = 'type'
      HelpOptions.DisAll = True
    end
    object NHelpRoute: TNovaHelp
      Left = 89
      Top = 48
      Width = 122
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
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
    object NovaHelpUnit: TNovaHelp
      Left = 516
      Top = 48
      Width = 137
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
    object NovaHelpVehiclenoHelp: TNovaHelp
      Left = 90
      Top = 79
      Width = 121
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
    object cbbOvertime: TComboBox
      Left = 748
      Top = 17
      Width = 110
      Height = 22
      Style = csDropDownList
      TabOrder = 8
      Items.Strings = (
        ''
        #27491#29677
        #21152#29677)
    end
    object NovaChkPrintOrg: TNovaCheckedComboBox
      Left = 517
      Top = 79
      Width = 136
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbbType: TNovaCheckedComboBox
      Left = 748
      Top = 48
      Width = 110
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
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
          Value = 'route'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'districttype'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 883
    ExplicitWidth = 883
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
    Top = 153
    Width = 883
    Height = 278
    ExplicitTop = 153
    ExplicitWidth = 883
    ExplicitHeight = 278
    inherited GroupBox1: TGroupBox
      Width = 883
      Height = 278
      ExplicitWidth = 883
      ExplicitHeight = 278
      inherited dbgrdhResult: TNvDbgridEh
        Width = 879
        Height = 260
        Color = clBtnFace
        EvenRowColor = clWhite
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footers = <>
            Title.Caption = #29677#32447
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'balancename'
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495#30721
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'invoicesnonum'
            Footers = <>
            Title.Caption = #36816#37327#21333#24352#25968
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'schedulenum'
            Footers = <>
            Title.Caption = #29677#27425#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footers = <>
            Title.Caption = #20154#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footers = <>
            Title.Caption = #21806#31080#37329#39069
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'basemount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22522#26412#36816#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'income'
            Footers = <>
            Title.Caption = #36710#31449#25910#20837
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'peopledistance'
            Footers = <>
            Title.Caption = #21608#36716#37327
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #32447#36335#20844#37324
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'totaldistance'
            Footers = <>
            Title.Caption = #21512#35745#37324#31243
            Title.Hint = #29677#27425#25968'*'#32447#36335#20844#37324
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31449#21153#36153
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#29123#27833#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#25187#36153'1'
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31354#35843#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#38468#21152#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#37197#27700#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20445#38505#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20854#20182
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23567#35745
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 88
    Top = 216
  end
  inherited ilToolBarDisable: TImageList
    Left = 176
    Top = 224
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryVehicleIncome'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
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
        Name = 'filter_EQL_u1!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_v!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u2!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_s!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_s!districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printorgids'
        ParamType = ptInput
      end>
    Left = 272
    Top = 240
  end
  inherited dsResult: TDataSource
    Left = 496
    Top = 224
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 240
  end
end
