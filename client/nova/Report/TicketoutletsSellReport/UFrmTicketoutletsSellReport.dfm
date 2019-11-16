inherited FrmTicketoutletsSellReport: TFrmTicketoutletsSellReport
  Caption = #21806#31080#28857#29677#32447#21806#31080#24773#20917#34920
  ClientHeight = 476
  ClientWidth = 883
  OnShow = FormShow
  ExplicitWidth = 899
  ExplicitHeight = 514
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 883
    Height = 113
    ExplicitWidth = 883
    ExplicitHeight = 113
    object lbl1: TLabel
      Left = 19
      Top = 20
      Width = 56
      Height = 14
      Caption = #25171#21333#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 225
      Top = 20
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 436
      Top = 20
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label6: TLabel
      Left = 402
      Top = 91
      Width = 56
      Height = 14
      Caption = #25215#36816#21333#20301
    end
    object Label4: TLabel
      Left = 18
      Top = 57
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label5: TLabel
      Left = 20
      Top = 91
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object lbl3: TLabel
      Left = 239
      Top = 91
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object lbl7: TLabel
      Left = 223
      Top = 58
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl14: TLabel
      Left = 436
      Top = 57
      Width = 14
      Height = 14
      Caption = #33267
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 850
      Top = 15
      Width = 121
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpstartdate: TDateTimePicker
      Left = 286
      Top = 17
      Width = 112
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 465
      Top = 17
      Width = 113
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object NovaHelpBalanceUnit: TNovaHelp
      Left = 465
      Top = 87
      Width = 113
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
    object NHelpRoute: TNovaHelp
      Left = 78
      Top = 52
      Width = 135
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
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpVehiclenoHelp: TNovaHelp
      Left = 79
      Top = 88
      Width = 135
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
    object NovaChkPrintOrg: TNovaCheckedComboBox
      Left = 79
      Top = 15
      Width = 135
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhelpTicketoutlets: TNovaHelp
      Left = 286
      Top = 88
      Width = 109
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
          Title.Caption = #21517#31216
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 168
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object dtpBselldate: TDateTimePicker
      Left = 286
      Top = 52
      Width = 112
      Height = 21
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      TabOrder = 8
      OnClick = dtpBselldateClick
    end
    object dtpEselldate: TDateTimePicker
      Left = 465
      Top = 52
      Width = 113
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      TabOrder = 9
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
    Top = 158
    Width = 883
    Height = 318
    ExplicitTop = 158
    ExplicitWidth = 883
    ExplicitHeight = 318
    inherited GroupBox1: TGroupBox
      Width = 883
      Height = 318
      ExplicitWidth = 883
      ExplicitHeight = 318
      inherited dbgrdhResult: TNvDbgridEh
        Width = 879
        Height = 300
        Color = clBtnFace
        EvenRowColor = clWhite
        FooterRowCount = 1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        SumList.Active = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'printorgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25171#21333#26426#26500
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'sellorgname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'ticekoutlesname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 102
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #25215#36816#21333#20301
            Width = 86
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
            FieldName = 'sellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24352#25968
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'sellprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'balanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
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
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#24494#26426#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31354#35843#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
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
            FieldName = 'agentfee'
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23458#36816#20195#29702#36153
            Width = 57
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
    QueryAddress = 'report/TicketoutletsSellReport'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_printorg!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ts!ticketoutletsname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ts!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_s!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ts!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printorgids'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
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
