inherited FrmUnitRouteVehicleRpt: TFrmUnitRouteVehicleRpt
  AutoSize = True
  Caption = #21457#29677#36816#37327#32479#35745#34920
  ClientHeight = 431
  ClientWidth = 933
  OnShow = FormShow
  ExplicitWidth = 949
  ExplicitHeight = 469
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 933
    Height = 76
    ExplicitWidth = 933
    ExplicitHeight = 76
    object lbl1: TLabel
      Left = 25
      Top = 23
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 277
      Top = 20
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 472
      Top = 21
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 25
      Top = 53
      Width = 56
      Height = 14
      Caption = #32479#35745#26041#24335
    end
    object lbl3: TLabel
      Left = 467
      Top = 53
      Width = 28
      Height = 14
      Caption = #36710#29260
    end
    object lblRun: TLabel
      Left = 276
      Top = 53
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object lbl4: TLabel
      Left = 625
      Top = 53
      Width = 56
      Height = 14
      Caption = #21333#20301#31867#22411
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 92
      Top = 18
      Width = 170
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
      Left = 338
      Top = 17
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 499
      Top = 17
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object chkScheduleorg: TCheckBox
      Left = 798
      Top = 6
      Width = 79
      Height = 18
      Caption = #29677#27425#26426#26500
      Checked = True
      State = cbChecked
      TabOrder = 4
      Visible = False
    end
    object chkSchedule: TCheckBox
      Left = 759
      Top = 17
      Width = 45
      Height = 18
      Caption = #29677#27425
      Checked = True
      State = cbChecked
      TabOrder = 5
      Visible = False
    end
    object chkRoute: TCheckBox
      Left = 698
      Top = 16
      Width = 56
      Height = 18
      Caption = #32447#36335
      Checked = True
      State = cbChecked
      TabOrder = 6
      Visible = False
    end
    object chkUnit: TCheckBox
      Left = 618
      Top = 16
      Width = 74
      Height = 18
      Caption = #32467#31639#21333#20301
      Checked = True
      State = cbChecked
      TabOrder = 7
      Visible = False
    end
    object chkPrintorg: TCheckBox
      Left = 840
      Top = -7
      Width = 82
      Height = 18
      Caption = #25171#21333#26426#26500
      Checked = True
      State = cbChecked
      TabOrder = 8
      Visible = False
    end
    object chkVehicle: TCheckBox
      Left = 818
      Top = 17
      Width = 48
      Height = 18
      Caption = #36710#29260
      Checked = True
      State = cbChecked
      TabOrder = 9
      Visible = False
    end
    object nvcbbgroup: TNovaComboBox
      Left = 92
      Top = 48
      Width = 170
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
      OnChange = nvcbbgroupChange
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
      HelpOptions.HDataSourceName = 'groupbylist'
      HelpOptions.HQueryAddress = 'report/addgroupby'
    end
    object nvhlpVehicle: TNovaHelp
      Left = 499
      Top = 48
      Width = 114
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 10
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
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
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
    object nvcbbType: TNovaCheckedComboBox
      Left = 338
      Top = 48
      Width = 110
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
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
    object cbbtype: TNovaComboBox
      Left = 687
      Top = 48
      Width = 121
      Height = 22
      ImeMode = imClose
      TabOrder = 12
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
      HelpOptions.TableName = 'unit'
      HelpOptions.Columnname = 'type'
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 933
    ExplicitWidth = 933
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
    Top = 121
    Width = 933
    Height = 310
    ExplicitTop = 121
    ExplicitWidth = 933
    ExplicitHeight = 310
    inherited GroupBox1: TGroupBox
      Width = 933
      Height = 310
      ExplicitWidth = 933
      ExplicitHeight = 310
      inherited dbgrdhResult: TNvDbgridEh
        Width = 929
        Height = 292
        Color = clBtnFace
        EvenRowColor = clWhite
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'firstname'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 112
          end
          item
            EditButtons = <>
            FieldName = 'secendname'
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 130
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
            FieldName = 'needschedulenum'
            Footers = <>
            Title.Caption = #24212#21457#29677#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'overtime'
            Footers = <>
            Title.Caption = #21152#29677#25968
            Width = 45
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
            FieldName = 'seats'
            Footers = <>
            Title.Caption = #24635#24231#20301#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatrate'
            Footers = <>
            Title.Caption = #24231#20301#21033#29992#29575
            Width = 57
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
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 41
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
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'routedistance'
            Footers = <>
            Title.Caption = #29677#27425#37324#31243
            Width = 47
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
            FieldName = 'needpeopledistance'
            Footers = <>
            Title.Caption = #35745#21010#21608#36716#37327
          end
          item
            EditButtons = <>
            FieldName = 'rate'
            Footers = <>
            Title.Caption = #23454#36733#29575
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
            Title.Caption = #22266#23450#25187#36153'|'#24494#26426#36153
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
    QueryAddress = 'report/qryUnitRouteVehicleReport'
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
        Name = 'scheduleorg'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printorg'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'unit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'groupby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'districttype'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'carunit'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'type'
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
