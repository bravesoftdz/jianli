inherited FrmVehicleturnoverEdit: TFrmVehicleturnoverEdit
  Caption = #36710#36742#32564#27454#20449#24687
  ClientHeight = 196
  ClientWidth = 447
  ExplicitWidth = 453
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 447
    Height = 151
    ExplicitWidth = 447
    ExplicitHeight = 151
    inherited Bevel1: TBevel
      Top = 143
      Width = 413
      ExplicitTop = 222
      ExplicitWidth = 421
    end
    object lblvehicleno: TLabel
      Left = 42
      Top = 29
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object lblmoney: TLabel
      Left = 239
      Top = 29
      Width = 56
      Height = 14
      Caption = #32564#27454#37329#39069
    end
    object lblremarks: TLabel
      Left = 56
      Top = 66
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object lbl1: TLabel
      Left = 190
      Top = 29
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl2: TLabel
      Left = 380
      Top = 29
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object nvhlpvehicleno: TNovaHelp
      Left = 90
      Top = 26
      Width = 94
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
          Title.Caption = #36710#29260#21495
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edtmoney: TNovaEdit
      Left = 301
      Top = 26
      Width = 73
      Height = 22
      MaxLength = 8
      TabOrder = 1
      ValueType = ssDouble
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
    object mmoremarks: TMemo
      Left = 90
      Top = 63
      Width = 284
      Height = 60
      MaxLength = 50
      TabOrder = 2
    end
  end
  inherited pnlOperation: TPanel
    Top = 151
    Width = 447
    ExplicitTop = 151
    ExplicitWidth = 447
    inherited bbtnSave: TBitBtn
      Left = 134
      Top = 0
      OnClick = bbtnSaveClick
      ExplicitLeft = 134
      ExplicitTop = 0
    end
    inherited bbtnClose: TBitBtn
      Left = 272
      Top = 0
      ExplicitLeft = 272
      ExplicitTop = 0
    end
  end
  inherited ImageList: TImageList
    Left = 232
    Top = 72
  end
  object jsonCDSVehicleturnoverSave: TjsonClientDataSet
    DataSourceName = 'overlist'
    QueryAddress = 'balance/qryvehicleturnover'
    SaveAddress = 'balance/savevehicleturnover'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleturnover.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.money'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleturnover.receiptorgid'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 32
    Top = 152
  end
end
