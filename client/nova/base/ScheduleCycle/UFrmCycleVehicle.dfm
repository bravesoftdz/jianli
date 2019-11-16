inherited FrmCycleVehicle: TFrmCycleVehicle
  Caption = 'FrmCycleVehicle'
  ClientHeight = 304
  ClientWidth = 696
  ExplicitWidth = 702
  ExplicitHeight = 333
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 696
    Height = 259
    ExplicitWidth = 696
    ExplicitHeight = 259
    inherited Bevel1: TBevel
      Top = 251
      Width = 662
      ExplicitTop = 283
      ExplicitWidth = 573
    end
    object Label1: TLabel
      Left = 49
      Top = 45
      Width = 70
      Height = 14
      Caption = #24490#29615#32452#21517#31216
    end
    object Label3: TLabel
      Left = 36
      Top = 99
      Width = 84
      Height = 14
      Caption = #24490#29615#24320#22987#26085#26399
    end
    object Label4: TLabel
      Left = 65
      Top = 148
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object Label5: TLabel
      Left = 352
      Top = 99
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object Label6: TLabel
      Left = 352
      Top = 45
      Width = 56
      Height = 14
      Caption = #21378#29260#22411#21495
    end
    object Label7: TLabel
      Left = 352
      Top = 151
      Width = 56
      Height = 14
      Caption = #35745#21010#36710#36742
    end
    object Label2: TLabel
      Left = 568
      Top = 44
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object NovaEdtName: TNovaEdit
      Left = 126
      Top = 42
      Width = 187
      Height = 22
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
    end
    object DateTpFromDate: TDateTimePicker
      Left = 127
      Top = 96
      Width = 120
      Height = 22
      Date = 40621.664476805560000000
      Time = 40621.664476805560000000
      TabOrder = 1
    end
    object DateTpEndDate: TDateTimePicker
      Left = 127
      Top = 145
      Width = 120
      Height = 22
      Date = 40621.664558368060000000
      Time = 40621.664558368060000000
      TabOrder = 2
    end
    object NovaHelpUnit: TNovaHelp
      Left = 414
      Top = 96
      Width = 147
      Height = 22
      CharCase = ecUpperCase
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
          Title.Caption = #21333#20301#21517#31216
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
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
      Left = 414
      Top = 148
      Width = 148
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 5
      OnIdChange = NovaHelpVehiclenoHelpIdChange
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
    object nvhlpVehiclebrandmodel: TNovaHelp
      Left = 414
      Top = 42
      Width = 147
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 50
      ParentFont = False
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
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Caption = #21378#29260#22411#21495
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rationseatnum'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Caption = #24231#20301#25968
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'code'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclebrandmodelHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 259
    Width = 696
    ExplicitTop = 259
    ExplicitWidth = 696
    inherited bbtnSave: TBitBtn
      Left = 175
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 175
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 344
      Top = 6
      ExplicitLeft = 344
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 288
    Top = 288
  end
  object jcdsSaveVehicle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveCycleschemesvehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.unit.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.orderno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'cycleschemesvehicle.vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'cycleschemesvehicle.cyclescheme.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.createtime'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 312
    Top = 65528
  end
end
