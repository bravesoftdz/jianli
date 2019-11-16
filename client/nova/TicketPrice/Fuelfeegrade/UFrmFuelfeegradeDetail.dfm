inherited FrmFuelfeegradeDetail: TFrmFuelfeegradeDetail
  Caption = 'FrmFuelfeegradeDetail'
  ClientHeight = 245
  ClientWidth = 405
  Position = poScreenCenter
  ExplicitWidth = 411
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 405
    Height = 200
    ExplicitWidth = 405
    ExplicitHeight = 200
    inherited Bevel1: TBevel
      Top = 192
      Width = 371
      ExplicitTop = 192
      ExplicitWidth = 371
    end
    object Label1: TLabel
      Left = 55
      Top = 46
      Width = 70
      Height = 14
      Caption = #33829#36816#37324#31243#20174
    end
    object Label2: TLabel
      Left = 257
      Top = 47
      Width = 98
      Height = 14
      Caption = #65288#21333#20301#65306#20844#37324#65289
    end
    object Label3: TLabel
      Left = 55
      Top = 135
      Width = 70
      Height = 14
      Caption = #29123#27833#38468#21152#36153
    end
    object Label4: TLabel
      Left = 111
      Top = 91
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label5: TLabel
      Left = 257
      Top = 132
      Width = 84
      Height = 14
      Caption = #65288#21333#20301#65306#20803#65289
    end
    object NovaEdtFromdistance: TNovaEdit
      Left = 131
      Top = 42
      Width = 109
      Height = 22
      MaxLength = 5
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
    object NovaEdttodistance: TNovaEdit
      Left = 131
      Top = 86
      Width = 109
      Height = 22
      MaxLength = 5
      TabOrder = 1
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
    object NovaEdtFee: TNovaEdit
      Left = 131
      Top = 129
      Width = 109
      Height = 22
      MaxLength = 50
      TabOrder = 2
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
    Top = 200
    Width = 405
    ExplicitTop = 200
    ExplicitWidth = 405
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 424
    Top = 288
  end
  object jscdsaveFuelfeegradedetail: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveFuelfeegradedetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.fuelfeegradeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.fromdistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.todistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.fee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegradedetail.createtime'
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
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 80
  end
end
