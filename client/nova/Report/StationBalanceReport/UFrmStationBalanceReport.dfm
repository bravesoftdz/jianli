inherited FrmStationBalanceReport: TFrmStationBalanceReport
  Caption = #23458#36816#31449#32467#31639#27719#24635#34920
  ClientHeight = 563
  ClientWidth = 1232
  OnShow = FormShow
  ExplicitTop = -56
  ExplicitWidth = 1248
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1232
    Height = 116
    ExplicitWidth = 1232
    ExplicitHeight = 116
    object lbl1: TLabel
      Left = 14
      Top = 51
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
      Left = 462
      Top = 19
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 714
      Top = 17
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label2: TLabel
      Left = 239
      Top = 52
      Width = 56
      Height = 14
      Caption = #32467#31639#23545#35937
    end
    object Label3: TLabel
      Left = 690
      Top = 50
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label4: TLabel
      Left = 460
      Top = 49
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label5: TLabel
      Left = 679
      Top = 85
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label6: TLabel
      Left = 460
      Top = 83
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object Label7: TLabel
      Left = 239
      Top = 85
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object Label8: TLabel
      Left = 867
      Top = 14
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object Label10: TLabel
      Left = 239
      Top = 19
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 14
      Top = 84
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
    object Label9: TLabel
      Left = 28
      Top = 20
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object lblworkways: TLabel
      Left = 867
      Top = 49
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object Label12: TLabel
      Left = 1020
      Top = 14
      Width = 70
      Height = 14
      Caption = #32467#31639#21333#31867#22411
    end
    object lbl2: TLabel
      Left = 1020
      Top = 49
      Width = 70
      Height = 14
      Caption = #21171#21153#36153#21462#20540
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 76
      Top = 46
      Width = 147
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpstartdate: TDateTimePicker
      Left = 524
      Top = 12
      Width = 148
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 742
      Top = 11
      Width = 107
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object cbbBalanceObject: TComboBox
      Left = 303
      Top = 47
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
      Items.Strings = (
        #36710#23646#21333#20301
        #32467#31639#21333#20301
        #29677#27425
        #36710#36742
        #32447#36335)
    end
    object NHelpRoute: TNovaHelp
      Left = 524
      Top = 47
      Width = 148
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object NovaHelpSchedule: TNovaHelp
      Left = 742
      Top = 46
      Width = 103
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
    object NovaHelpVehiclenoHelp: TNovaHelp
      Left = 742
      Top = 80
      Width = 103
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object cbbOvertime: TComboBox
      Left = 928
      Top = 9
      Width = 79
      Height = 22
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
      Items.Strings = (
        ''
        #27491#29677
        #21152#29677)
    end
    object NovaChkPrintOrg: TNovaCheckedComboBox
      Left = 76
      Top = 80
      Width = 147
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NovachkPorg: TNovaCheckedComboBox
      Left = 76
      Top = 14
      Width = 147
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NovaChkSaleOrg: TNovaCheckedComboBox
      Left = 303
      Top = 14
      Width = 145
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object ChkIsShowZero: TCheckBox
      Left = 867
      Top = 83
      Width = 122
      Height = 17
      Caption = #26174#31034#20154#25968#20026'0'#30340
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object NovaHelpUnit: TNovaCheckedComboBox
      Left = 302
      Top = 80
      Width = 147
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.HelpType = 'UnitUsedHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NovachBalanceUnit: TNovaCheckedComboBox
      Left = 524
      Top = 80
      Width = 147
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.HelpType = 'BalanceUnitHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbbworkways: TNovaCheckedComboBox
      Left = 928
      Top = 46
      Width = 79
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
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
          Value = 'schedule'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'workways'
        end>
    end
    object cbbbalancetype: TComboBox
      Left = 1096
      Top = 9
      Width = 113
      Height = 22
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 15
      Items.Strings = (
        #20840#37096
        #24494#26426#21333
        #25163#24037#21333)
    end
    object cbbAgenttype: TComboBox
      Left = 1096
      Top = 45
      Width = 113
      Height = 22
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemIndex = 0
      TabOrder = 16
      Text = #21462#21407#21333#25454#37329#39069
      Items.Strings = (
        #21462#21407#21333#25454#37329#39069
        #25353'10%'#35745#31639
        #25353'8%'#35745#31639)
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1232
    ExplicitWidth = 1232
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
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 161
    Width = 1232
    Height = 402
    ExplicitTop = 161
    ExplicitWidth = 1232
    ExplicitHeight = 402
    inherited GroupBox1: TGroupBox
      Width = 1232
      Height = 402
      ExplicitWidth = 1232
      ExplicitHeight = 402
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1228
        Height = 384
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
            FieldName = 'endstation'
            Footer.Value = #21512#35745
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32467#31639#23545#35937
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #33829#36816#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'invoincenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#21333#25968
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'balancetype'
            Footers = <>
            Title.Caption = #32467#31639#21333#31867#22411
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'schnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29677#27425#25968
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'seats'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#20154#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#37329#39069
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'ticketsellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#20154#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'allprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'laowufee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21171#21153#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20215#24046
            Visible = False
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'invoinceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36816#37327#37329#39069'('#25187#20215#24046')'
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#37329#39069'('#25187#31449#21153#36153')'
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'canamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#32467#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'peopledistance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21608#36716#37327
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'allpeopledistance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#34892#31243#36733#23458#37327
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'rate'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #23454#36733#29575
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24494#26426#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31354#35843#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38468#21152#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37197#27700#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23567#35745
            Width = 60
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 200
    Top = 216
  end
  inherited ilToolBarDisable: TImageList
    Left = 544
    Top = 208
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryStationBalanceInvoinces'
    Params = <
      item
        DataType = ftString
        Name = 'rp.orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.saleorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.printorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.schtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.balanceunitids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.unitids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.balancetype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.isshowzerotickets'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.handflag'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.agentcaltype'
        ParamType = ptInput
      end>
    Left = 312
    Top = 216
  end
  inherited dsResult: TDataSource
    Left = 112
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 440
    Top = 224
  end
end
