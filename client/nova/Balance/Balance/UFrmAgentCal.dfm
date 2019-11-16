inherited FrmAgentCal: TFrmAgentCal
  Caption = 'FrmAgentCal'
  ClientHeight = 249
  ClientWidth = 457
  ExplicitWidth = 463
  ExplicitHeight = 281
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 457
    Height = 204
    ExplicitWidth = 457
    ExplicitHeight = 204
    inherited Bevel1: TBevel
      Top = 196
      Width = 423
      ExplicitTop = 196
      ExplicitWidth = 423
    end
    object Label1: TLabel
      Left = 48
      Top = 57
      Width = 329
      Height = 14
      Caption = #23458#36816#20195#29702#36153'='#65288#31080#27454#37329#39069'-'#31080#20215#20998#39033#25187#36153'-'#31449#21153#38468#21152#36153#65289
    end
    object Label2: TLabel
      Left = 48
      Top = 140
      Width = 140
      Height = 14
      Caption = #35831#36755#20837#23458#36816#20195#29702#36153#27604#20363
    end
    object LabInfo: TLabel
      Left = 375
      Top = 53
      Width = 44
      Height = 19
      Caption = '*0.1'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 32
      Top = 20
      Width = 70
      Height = 14
      Caption = #25552#31034#20449#24687#65306
    end
    object Label5: TLabel
      Left = 281
      Top = 137
      Width = 11
      Height = 19
      Caption = '%'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 48
      Top = 97
      Width = 280
      Height = 14
      Caption = #31080#20215#20998#39033#25187#36153#22914#65306#31449#21153#36153#12289#24494#26426#36153#12289#31354#35843#36153#31561
    end
    object NovaEdtRate: TNovaEdit
      Left = 194
      Top = 136
      Width = 79
      Height = 22
      MaxLength = 4
      TabOrder = 0
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
  end
  inherited pnlOperation: TPanel
    Top = 204
    Width = 457
    ExplicitTop = 204
    ExplicitWidth = 457
    inherited bbtnSave: TBitBtn
      Caption = '&S '#35745#31639
    end
  end
  inherited ImageList: TImageList
    Left = 400
    Top = 304
  end
  object jsonqryAdditionFee: TjsonClientDataSet
    DataSourceName = 'balancedeductlist'
    SaveAddress = 'balance/calAgent'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'invoicesids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 128
    object jsonqryAdditionFeeid: TLargeintField
      FieldName = 'id'
    end
    object jsonqryAdditionFeename: TWideStringField
      FieldName = 'name'
      Size = 100
    end
    object jsonqryAdditionFeedeductmoney: TFloatField
      FieldName = 'deductmoney'
    end
    object jsonqryAdditionFeestationid: TLargeintField
      FieldName = 'stationid'
    end
    object jsonqryAdditionFeevehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jsonqryAdditionFeeorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jsonqryAdditionFeeticketnum: TLargeintField
      FieldName = 'ticketnum'
    end
    object jsonqryAdditionFeetotalfee: TLargeintField
      FieldName = 'totalfee'
    end
  end
end
