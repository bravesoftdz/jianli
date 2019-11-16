inherited FrmQueryVehicleLicense: TFrmQueryVehicleLicense
  Caption = #36710#36742#24212#29677#30331#35760#34920
  ClientHeight = 461
  ClientWidth = 832
  OnShow = FormShow
  ExplicitWidth = 848
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 832
    Height = 92
    ExplicitWidth = 832
    ExplicitHeight = 92
    object lbl1: TLabel
      Left = 14
      Top = 29
      Width = 56
      Height = 14
      Caption = #25253#21040#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 219
      Top = 26
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 442
      Top = 26
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label4: TLabel
      Left = 14
      Top = 64
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label5: TLabel
      Left = 400
      Top = 65
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label7: TLabel
      Left = 220
      Top = 64
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object Label8: TLabel
      Left = 583
      Top = 25
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object dtpstartdate: TDateTimePicker
      Left = 282
      Top = 21
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 461
      Top = 21
      Width = 102
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 1
    end
    object NHelpRoute: TNovaHelp
      Left = 78
      Top = 59
      Width = 128
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
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
      Left = 461
      Top = 61
      Width = 103
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
    object NovaHelpUnit: TNovaHelp
      Left = 282
      Top = 61
      Width = 110
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
    object cbbOvertime: TComboBox
      Left = 645
      Top = 22
      Width = 62
      Height = 22
      Style = csDropDownList
      TabOrder = 5
      Items.Strings = (
        #20840#37096
        #27491#29677
        #21152#29677)
    end
    object NovaChkReportOrg: TNovaCheckedComboBox
      Left = 77
      Top = 22
      Width = 129
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 832
    ExplicitWidth = 832
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
    Top = 137
    Width = 832
    Height = 324
    ExplicitTop = 137
    ExplicitWidth = 832
    ExplicitHeight = 324
    inherited GroupBox1: TGroupBox
      Width = 832
      Height = 324
      ExplicitWidth = 832
      ExplicitHeight = 324
      inherited dbgrdhResult: TNvDbgridEh
        Width = 828
        Height = 306
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            Title.Caption = #32534#21495
            Visible = False
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'departtime1'
            Footers = <>
            Title.Caption = #21457#65288#24212#65289#29677#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #39550#39542#21592
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicense'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#39550#39542#35777
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'qualification'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#20174#19994#36164#26684#35777
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'driverlicense'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#34892#39542#35777
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'workno'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#36947#36335#36816#36755#35777
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'rodeno'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#32447#36335#26631#24535#29260
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'workno1'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#19978#23703#35777
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'notenum'
            Footers = <>
            Title.Caption = #33829#36816#25163#32493#40784#20840#26377#25928#24773#20917'|'#20363#26816#21512#26684#36890#30693#21333
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#26680#36733#20154#25968
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'actpersons'
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#23454#36733#20154#25968
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'driversign'
            Footers = <>
            Title.Caption = #39550#39542#21592#31614#23383
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'classmember'
            Footers = <>
            Title.Caption = #24102#29677#21592#31614#23383
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'dispatcher'
            Footers = <>
            Title.Caption = #36710#36742#35843#24230#21592#31614#23383
            Width = 73
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/queryVehicleLicense'
    Params = <
      item
        DataType = ftString
        Name = 'rp.orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.schtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'rp.routeid'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 296
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 144
    Top = 288
  end
end
