inherited FrmQryStationUnitBalance: TFrmQryStationUnitBalance
  Caption = 'FrmQryStationUnitBalance'
  ClientHeight = 423
  ExplicitWidth = 1140
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Height = 78
    ExplicitWidth = 116
    ExplicitHeight = 78
    object lbl1: TLabel
      Left = 14
      Top = 16
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
      Left = 212
      Top = 16
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 402
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 49
      Top = 13
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
      Left = 276
      Top = 13
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 427
      Top = 13
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object NvRadioUnit: TRadioButton
      Left = 14
      Top = 52
      Width = 86
      Height = 17
      Caption = #36710#23646#21333#20301
      TabOrder = 3
      OnClick = NvRadioUnitClick
    end
    object NvRadioVehicleno: TRadioButton
      Left = 254
      Top = 52
      Width = 67
      Height = 17
      Caption = #36710#29260#21495
      TabOrder = 4
      OnClick = NvRadioUnitClick
    end
    object NovaHelpUnit: TNovaHelp
      Left = 120
      Top = 49
      Width = 115
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
          Title.Caption = #21333#20301#21517#31216
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
      HelpOptions.HelpHeight = 200
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
    object edtvehicleno: TNovaHelp
      Left = 332
      Top = 49
      Width = 115
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
          Title.Caption = #36710#29260#21495
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25253#21040#21345
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    ExplicitWidth = 116
    ExplicitHeight = 490
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
    Top = 123
    Height = 300
    ExplicitTop = 568
    ExplicitWidth = 116
    ExplicitHeight = 305
    inherited GroupBox1: TGroupBox
      Height = 300
      ExplicitWidth = 116
      ExplicitHeight = 305
      inherited dbgrdhResult: TNvDbgridEh
        Height = 282
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footer.Value = #21512#35745':'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#21333#24352#25968
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'stationfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'cleanfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23433#26816#21355#29983#36153
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'advfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23459#20256#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'otherfee1'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#36153'1'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'otherfee2'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#36153'2'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'truebalanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#32467#37329#39069
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 856
    Top = 56
  end
  inherited ilToolBarDisable: TImageList
    Left = 856
    Top = 8
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/qryStationUnitBalance'
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
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
        Name = 'unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sign'
        ParamType = ptInput
      end>
    Left = 680
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 624
    Top = 256
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 736
    Top = 296
  end
end
