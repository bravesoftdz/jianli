inherited FrmChangeCustomerInfo: TFrmChangeCustomerInfo
  Caption = #20462#25913#20056#36710#20154#20449#24687
  ClientHeight = 278
  ClientWidth = 454
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 460
  ExplicitHeight = 306
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 454
    Height = 233
    ExplicitWidth = 454
    ExplicitHeight = 233
    inherited Bevel1: TBevel
      Top = 225
      Width = 420
      ExplicitTop = 225
      ExplicitWidth = 420
    end
    object lbl1: TLabel
      Left = 12
      Top = 29
      Width = 70
      Height = 14
      Caption = #20056#36710#20154#22995#21517
    end
    object lbl14: TLabel
      Left = 225
      Top = 30
      Width = 56
      Height = 14
      Caption = #36523#20221#35777#21495
    end
    object Label1: TLabel
      Left = 26
      Top = 77
      Width = 56
      Height = 14
      Caption = #20056#36710#26085#26399
    end
    object Label2: TLabel
      Left = 225
      Top = 78
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object Label3: TLabel
      Left = 40
      Top = 181
      Width = 42
      Height = 14
      Caption = #24231#20301#21495
    end
    object Label4: TLabel
      Left = 225
      Top = 182
      Width = 56
      Height = 14
      Caption = #21806#31080#26102#38388
    end
    object Label5: TLabel
      Left = 54
      Top = 129
      Width = 28
      Height = 14
      Caption = #21040#31449
    end
    object Label6: TLabel
      Left = 239
      Top = 129
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object nvedtName: TNovaEdit
      Left = 90
      Top = 26
      Width = 126
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
    object nvedtIDcard: TNovaEdit
      Left = 286
      Top = 26
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 18
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
    object NovaDepartdate: TNovaEdit
      Left = 90
      Top = 74
      Width = 126
      Height = 22
      Enabled = False
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
    end
    object NovaDeparttime: TNovaEdit
      Left = 286
      Top = 74
      Width = 121
      Height = 22
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 18
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
    end
    object NovaSeatno: TNovaEdit
      Left = 90
      Top = 178
      Width = 126
      Height = 22
      Enabled = False
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
    end
    object NovaSelltime: TNovaEdit
      Left = 286
      Top = 178
      Width = 121
      Height = 22
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 18
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
    end
    object NovaResearchStation: TNovaEdit
      Left = 90
      Top = 126
      Width = 126
      Height = 22
      Enabled = False
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
    end
    object NovaSchCode: TNovaEdit
      Left = 286
      Top = 126
      Width = 121
      Height = 22
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 18
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
    end
  end
  inherited pnlOperation: TPanel
    Top = 233
    Width = 454
    ExplicitTop = 233
    ExplicitWidth = 454
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 384
    Top = 216
  end
  object jcdsSaveCustomerinfo: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'query/saveCustomerinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'customerid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'birthday'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sex'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'customername'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 144
    Top = 144
  end
end
