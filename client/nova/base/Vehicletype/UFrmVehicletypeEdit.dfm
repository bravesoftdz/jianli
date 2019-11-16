inherited FrmVehicletypeEdit: TFrmVehicletypeEdit
  Caption = #36710#22411#31649#29702#20449#24687
  ClientHeight = 209
  ClientWidth = 555
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  ExplicitWidth = 561
  ExplicitHeight = 237
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 555
    Height = 164
    ExplicitWidth = 555
    ExplicitHeight = 164
    inherited Bevel1: TBevel
      Top = 156
      Width = 521
      ExplicitTop = 233
      ExplicitWidth = 485
    end
    object lbl1: TLabel
      Left = 51
      Top = 34
      Width = 28
      Height = 14
      Caption = #31867#22411
    end
    object lbl2: TLabel
      Left = 313
      Top = 34
      Width = 28
      Height = 14
      Caption = #32423#21035
    end
    object lbl3: TLabel
      Left = 313
      Top = 73
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object lbl4: TLabel
      Left = 51
      Top = 73
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object Label1: TLabel
      Left = 231
      Top = 34
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label2: TLabel
      Left = 516
      Top = 34
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label3: TLabel
      Left = 516
      Top = 73
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label4: TLabel
      Left = 231
      Top = 73
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl5: TLabel
      Left = 271
      Top = 112
      Width = 70
      Height = 14
      Caption = #33258#23450#20041#21517#31216
    end
    object lbl6: TLabel
      Left = 37
      Top = 112
      Width = 42
      Height = 14
      Caption = #24231#20301#25968
    end
    object Label5: TLabel
      Left = 231
      Top = 112
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object cbbtype: TNovaComboBox
      Left = 85
      Top = 31
      Width = 140
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnSelect = cbbtypeSelect
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'vehicletype'
      HelpOptions.Columnname = 'type'
    end
    object cbbgrade: TNovaComboBox
      Left = 347
      Top = 31
      Width = 160
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
      OnSelect = cbbgradeSelect
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'vehicletype'
      HelpOptions.Columnname = 'grade'
    end
    object edtname: TNovaEdit
      Left = 85
      Top = 70
      Width = 140
      Height = 22
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 15
      ParentFont = False
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
    object edtcode: TNovaEdit
      Left = 347
      Top = 70
      Width = 160
      Height = 22
      MaxLength = 10
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
    object edtration: TNovaEdit
      Left = 85
      Top = 109
      Width = 140
      Height = 22
      MaxLength = 3
      TabOrder = 4
      ValueType = ssNumber
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
    object edtcustom: TNovaEdit
      Left = 347
      Top = 109
      Width = 160
      Height = 22
      MaxLength = 15
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
  end
  inherited pnlOperation: TPanel
    Top = 164
    Width = 555
    ExplicitTop = 164
    ExplicitWidth = 555
    inherited bbtnSave: TBitBtn
      Left = 123
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 123
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 275
      Top = 6
      ExplicitLeft = 275
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 240
    Top = 65528
  end
  object jsonCDSVehSave: TjsonClientDataSet
    DataSourceName = 'vehiclelist'
    QueryAddress = 'base/qryveh'
    SaveAddress = 'base/saveveh'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicletype.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.grade'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.rationseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.customname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicletype.islocaldelete'
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
    Left = 432
    Top = 152
  end
end
