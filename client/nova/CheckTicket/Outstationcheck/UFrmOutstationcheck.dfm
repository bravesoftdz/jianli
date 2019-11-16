inherited FrmOutstationcheck: TFrmOutstationcheck
  Caption = #36710#36742#20986#31449#26816#26597#34920
  ClientHeight = 396
  ClientWidth = 812
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 828
  ExplicitHeight = 434
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 812
    Height = 120
    ExplicitWidth = 812
    ExplicitHeight = 120
    object Label1: TLabel
      Left = 265
      Top = 56
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label3: TLabel
      Left = 462
      Top = 23
      Width = 42
      Height = 14
      Caption = #26816#26597#21592
    end
    object Label4: TLabel
      Left = 28
      Top = 56
      Width = 56
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = #36710#23646#21333#20301
      ParentBiDiMode = False
    end
    object Label8: TLabel
      Left = 251
      Top = 23
      Width = 56
      Height = 14
      Cursor = crDrag
      Caption = #26816#26597#26085#26399
    end
    object Label10: TLabel
      Left = 30
      Top = 22
      Width = 56
      Height = 14
      Caption = #26816#26597#36710#31449
    end
    object lbltype: TLabel
      Left = 28
      Top = 87
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#22411
    end
    object nvhelpcheckname: TNovaHelp
      Left = 512
      Top = 19
      Width = 130
      Height = 22
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      MaxLength = 50
      TabOrder = 0
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
          Title.Caption = #22995#21517
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object startdate: TDateTimePicker
      Left = 315
      Top = 19
      Width = 130
      Height = 22
      Date = 40603.000000000000000000
      Time = 40603.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object nvhelpcardno: TNovaHelp
      Left = 315
      Top = 83
      Width = 130
      Height = 27
      CharCase = ecUpperCase
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      ParentFont = False
      TabOrder = 2
      OnChange = nvhelpcardnoChange
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
      HDBGColumns = <>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'cardno'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'CardissueHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQS_i!cardtype'
          ParamType = ptInput
          Value = '0'
        end>
      notFocusedShowHelp = False
    end
    object nvhelpunitname: TNovaHelp
      Left = 92
      Top = 52
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
          Title.Caption = #21517#31216
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object curnvhelpvehicleno: TNovaHelp
      Left = 315
      Top = 52
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
    object cbborg: TNovaCheckedComboBox
      Left = 92
      Top = 19
      Width = 130
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbbChecktype: TNovaCheckedComboBox
      Left = 92
      Top = 83
      Width = 130
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
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
    object chkIsCheck: TCheckBox
      Left = 235
      Top = 87
      Width = 76
      Height = 17
      Caption = #25253#29677#21345#21495
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 812
    ExplicitWidth = 812
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      OnClick = tbtnDeleteClick
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
    Top = 165
    Width = 812
    Height = 231
    ExplicitTop = 165
    ExplicitWidth = 812
    ExplicitHeight = 231
    inherited GroupBox1: TGroupBox
      Width = 812
      Height = 231
      ExplicitWidth = 812
      ExplicitHeight = 231
      inherited dbgrdhResult: TNvDbgridEh
        Width = 808
        Height = 213
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'outtime'
            Footers = <>
            Title.Caption = #26816#26597#26085#26399
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reporttime'
            Footers = <>
            Title.Caption = #25253#21040#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'outtime'
            Footers = <>
            Title.Caption = #20986#31449#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'driver1'
            Footers = <>
            Title.Caption = #39550#39542#21592#22995#21517
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'driverlicensechk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#39550#39542#35777
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicense1chk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#39550#39542#35777
            Visible = False
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'qualification1chk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#20174#19994#36164#26684#35777
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'driverlicensechk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#34892#39542#35777
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'runnochk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#33829#36816#35777
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'roadnochk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#32447#36335#26631#24535#29260
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'buscheckchk'
            Footers = <>
            Title.Caption = #22235#35777#19968#29260#19968#21333#26597#39564#24773#20917'|'#20363#26816#21512#26684#36890#30693#21333
            Width = 128
          end
          item
            EditButtons = <>
            FieldName = 'seatnums'
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#26680#36733#20154#25968
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'carrypeople'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#25171#21333#20154#25968
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'childnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#20813#31080#20799#31461#25968
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'factpeople'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#23454#36733#20154#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'fillpeople'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#36733#24773#20917'|'#34917#24405#20154#25968
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'maintainchk'
            Footers = <>
            Title.Caption = #20108#32500#32467#26524
            Visible = False
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'driver1'
            Footers = <>
            Title.Caption = #39550#39542#21592'1|'#22995#21517
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'workno1chk'
            Footers = <>
            Title.Caption = #39550#39542#21592'1|'#20934#39550#35777
            Visible = False
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'driver2'
            Footers = <>
            Title.Caption = #39550#39542#21592'2|'#22995#21517
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicense2chk'
            Footers = <>
            Title.Caption = #39550#39542#21592'2|'#39550#39542#35777
            Visible = False
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'qualification2chk'
            Footers = <>
            Title.Caption = #39550#39542#21592'2|'#20174#19994#36164#26684#35777
            Visible = False
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'workno2chk'
            Footers = <>
            Title.Caption = #39550#39542#21592'2|'#20934#39550#35777
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'isoverload'
            Footers = <>
            Title.Caption = #26159#21542#36229#21592
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'iscomplete'
            Footers = <>
            Title.Caption = #35777#20214#26159#21542#40784#20840
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'isseatbelts'
            Footers = <>
            Title.Caption = #26159#21542#31995#22909#23433#20840#24102
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'driver1'
            Footers = <>
            Title.Caption = #39550#39542#21592#31614#23383
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'checker'
            Footers = <>
            Title.Caption = #26816#26597#21592#31614#23383
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #31293#26597#26102#38388
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'steward1'
            Footers = <>
            Title.Caption = #20056#21153#21592#31614#23383
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 200
    Top = 296
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 288
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'listmap'
    QueryAddress = 'checkticket/queryOutstationcheck'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_uf!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_st!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_v!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_v!cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_st!outtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_st!outtime'
        ParamType = ptInput
      end>
    Left = 304
    Top = 280
  end
  inherited dsResult: TDataSource
    Top = 192
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 496
    Top = 288
  end
  object jscdDelOutstaion: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/delOutstationcheck'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 100
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 320
  end
  object jsonVehicleResult: TjsonClientDataSet
    DataSourceName = 'vehiclemap'
    QueryAddress = 'base/qryVehicles'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_v!cardno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 688
    Top = 144
    object jsonVehicleResultid: TLargeintField
      FieldName = 'id'
    end
    object jsonVehicleResultunitname: TWideStringField
      FieldName = 'unitname'
    end
    object jsonVehicleResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
    end
    object wdstrngfldVehicleResultcardno: TWideStringField
      FieldName = 'cardno'
    end
    object wdstrngfldVehicleResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
  end
end
