inherited FrmVehicleDistanceActive: TFrmVehicleDistanceActive
  Caption = #36710#36742#37324#31243#38480#21046
  ClientHeight = 514
  ClientWidth = 1284
  OnCreate = nil
  OnShow = FormShow
  ExplicitWidth = 1300
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1284
    Height = 52
    ExplicitWidth = 1284
    ExplicitHeight = 52
    object lbldate: TLabel
      Left = 25
      Top = 22
      Width = 56
      Height = 14
      Caption = #28608#27963#26085#26399
    end
    object lbl1: TLabel
      Left = 201
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl2: TLabel
      Left = 508
      Top = 22
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object lblUserId: TLabel
      Left = 349
      Top = 22
      Width = 42
      Height = 14
      Caption = #28608#27963#20154
    end
    object dtpstartdate: TDateTimePicker
      Left = 87
      Top = 19
      Width = 98
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 228
      Top = 19
      Width = 98
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 1
    end
    object nvhlpUserid: TNovaHelp
      Left = 394
      Top = 19
      Width = 95
      Height = 22
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
    object nvhlpvehicleno: TNovaHelp
      Left = 555
      Top = 19
      Width = 94
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
    Width = 1284
    ExplicitWidth = 1284
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #28608#27963
      ImageIndex = 36
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Caption = #28608#27963#21382#21490
      ImageIndex = 49
      OnClick = tbtnEditClick
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
    Top = 97
    Width = 1284
    Height = 417
    ExplicitTop = 97
    ExplicitWidth = 1284
    ExplicitHeight = 417
    inherited GroupBox1: TGroupBox
      Width = 1284
      Height = 417
      ExplicitWidth = 1284
      ExplicitHeight = 417
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1280
        Height = 399
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'distancelimit'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #38480#21046#37324#31243
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'departdistance'
            Footers = <>
            Title.Caption = #24050#36816#34892#37324#31243
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'maintainvaliddate'
            Footers = <>
            Title.Caption = #20108#32500#26377#25928#26399
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #28608#27963#20154
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28608#27963#26102#38388
            Width = 147
          end
          item
            EditButtons = <>
            FieldName = 'lastactivetime'
            Footers = <>
            Title.Caption = #19978#27425#28608#27963#26102#38388
            Width = 156
          end
          item
            EditButtons = <>
            FieldName = 'vehicleid'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 104
    Top = 280
  end
  inherited ilToolBarDisable: TImageList
    Left = 48
    Top = 344
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'lastactivemap'
    QueryAddress = 'vehicledistance/queryLastvehicledistance'
    SaveAddress = 'vehicledistance/queryLastvehicledistance'
    Params = <
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
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'userid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 144
    Top = 336
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 256
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 24
    Top = 200
  end
  object jcdsSave: TjsonClientDataSet
    DataSourceName = 'map'
    QueryAddress = 'vehicledistance/savevehicleactive'
    SaveAddress = 'vehicledistance/savevehicleactive'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <
      item
        Visible = False
      end>
    Params = <
      item
        DataType = ftString
        Name = 'vehicledistance.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicledistance.lastactivetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicledistance.departdistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicledistance.limitdistance'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'vehicleid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 248
    Top = 344
  end
end
