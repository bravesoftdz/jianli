inherited FrmQryDepartSchedules: TFrmQryDepartSchedules
  Caption = #36816#37327#21592#36816#37327#21488#36134
  ClientHeight = 441
  ClientWidth = 1012
  OnShow = FormShow
  ExplicitWidth = 1028
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1012
    Height = 104
    ExplicitWidth = 1012
    ExplicitHeight = 104
    object lbl1: TLabel
      Left = 18
      Top = 14
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
    object lbl11: TLabel
      Left = 228
      Top = 14
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 463
      Top = 16
      Width = 14
      Height = 14
      Caption = #33267
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 437
      Top = 46
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 17
      Top = 75
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object lbl4: TLabel
      Left = 227
      Top = 46
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 228
      Top = 75
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label9: TLabel
      Left = 437
      Top = 77
      Width = 42
      Height = 14
      Caption = #25171#21333#21592
    end
    object lbl7: TLabel
      Left = 616
      Top = 46
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object Label2: TLabel
      Left = 4
      Top = 46
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
      Left = 612
      Top = 14
      Width = 56
      Height = 14
      Caption = #25152#23646#21306#22495
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 292
      Top = 11
      Width = 133
      Height = 22
      Date = 40544.000011574070000000
      Time = 40544.000011574070000000
      Checked = False
      TabOrder = 0
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 489
      Top = 11
      Width = 110
      Height = 22
      Date = 40413.999988425930000000
      Time = 40413.999988425930000000
      TabOrder = 1
    end
    object nvhelpUnit: TNovaHelp
      Left = 81
      Top = 73
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 170
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpVehicle: TNovaHelp
      Left = 292
      Top = 73
      Width = 133
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
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = 'IC'#21345#21495
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
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpUserid: TNovaHelp
      Left = 489
      Top = 73
      Width = 109
      Height = 22
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
          Width = 70
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
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedtTicketno: TNovaEdit
      Left = 674
      Top = 41
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 4
      ValueType = ssTicket
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
    object chkIsovertime: TCheckBox
      Left = 689
      Top = 78
      Width = 45
      Height = 18
      Caption = #21152#29677
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkIsnotovertime: TCheckBox
      Left = 624
      Top = 79
      Width = 48
      Height = 17
      Caption = #27491#29677
      Checked = True
      State = cbChecked
      TabOrder = 8
    end
    object nvhlpschedule: TNovaHelp
      Left = 489
      Top = 41
      Width = 109
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          FieldName = 'name'
          Title.Caption = #29677#27425
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlproute: TNovaHelp
      Left = 292
      Top = 41
      Width = 133
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
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
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 55
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbbdepart: TNovaCheckedComboBox
      Left = 80
      Top = 41
      Width = 126
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 80
      Top = 9
      Width = 126
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbbType: TNovaCheckedComboBox
      Left = 674
      Top = 9
      Width = 102
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
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
    Width = 1012
    ExplicitWidth = 1012
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
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
  end
  inherited Panel1: TPanel
    Top = 149
    Width = 1012
    Height = 292
    ExplicitTop = 149
    ExplicitWidth = 1012
    ExplicitHeight = 292
    inherited GroupBox1: TGroupBox
      Width = 1012
      Height = 292
      ExplicitWidth = 1012
      ExplicitHeight = 292
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1008
        Height = 274
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36816#37327#21333#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'printbyname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25171#21333#21592
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #36710#27425
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #26102#38388
            Width = 40
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'districttypename'
            Footers = <>
            Title.Caption = #25152#23646#21306#22495
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'rname'
            Footers = <>
            Title.Caption = #36215#27490#31449#21517
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'printtime'
            Footers = <>
            Title.Caption = #25171#21360#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'peopledistance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21608#36716#37327
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#37327#37329#39069
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'fullnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968'|'#20840#31080
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'halfnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968'|'#21322#31080
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968'|'#23567#35745
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'shortnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20844#37324#20154#25968'|100'#20197#19979
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'middlenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20844#37324#20154#25968'|100-200'
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'longnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20844#37324#20154#25968'|200'#20197#19978
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'totalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20844#37324#20154#25968'|'#21512#35745
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23458#36816#20195#29702#36153
            Width = 90
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
            Title.Caption = #22266#23450#25187#36153'|'#25187#36153'1'
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
            Title.Caption = #22266#23450#25187#36153'|'#27700#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20445#38505#36153
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20854#20182
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'jbffee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#21152#29677#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'allcountfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#21512#35745
            Width = 60
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 120
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Left = 184
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryDepartInvoinces'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ds!departinvoicesno'
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
        Name = 'filter_EQL_v!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
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
        Name = 'filter_EQL_ds!printby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_s!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ds!printorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ddc!orderno'
        ParamType = ptInput
      end>
    Left = 384
    Top = 232
  end
  inherited dsResult: TDataSource
    Left = 536
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Page.LeftMargin = 0.500000000000000000
    Left = 304
    Top = 216
  end
end
