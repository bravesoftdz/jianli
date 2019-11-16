inherited FrmFunctionPermissionEdit: TFrmFunctionPermissionEdit
  Caption = 'FrmFunctionPermissionEdit'
  ClientHeight = 234
  ClientWidth = 422
  ExplicitWidth = 428
  ExplicitHeight = 266
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 422
    Height = 189
    ExplicitWidth = 422
    ExplicitHeight = 189
    inherited Bevel1: TBevel
      Top = 181
      Width = 388
      ExplicitTop = 181
      ExplicitWidth = 388
    end
    object lblname: TLabel
      Left = 31
      Top = 24
      Width = 56
      Height = 14
      Caption = #21151#33021#21517#31216
    end
    object lblkey: TLabel
      Left = 31
      Top = 59
      Width = 56
      Height = 14
      Caption = #21151#33021'GUID'
    end
    object lbldescribe: TLabel
      Left = 31
      Top = 94
      Width = 56
      Height = 14
      Caption = #21151#33021#25551#36848
    end
    object lbl1: TLabel
      Left = 392
      Top = 28
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 392
      Top = 63
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object mmodescribe: TMemo
      Left = 95
      Top = 94
      Width = 292
      Height = 63
      TabOrder = 0
    end
    object nvedtname: TNovaEdit
      Left = 95
      Top = 24
      Width = 292
      Height = 22
      MaxLength = 50
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
    object nvedtkey: TNovaEdit
      Left = 95
      Top = 59
      Width = 292
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
    end
  end
  inherited pnlOperation: TPanel
    Top = 189
    Width = 422
    ExplicitTop = 189
    ExplicitWidth = 422
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jcdsFunctionPermissionSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/saveFunctionpermissionreg'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'functionpermissionreg.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.functionregid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.permissionname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.permissionkey'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionpermissionreg.permissiondescribe'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftLargeint
        Name = 'functionpermissionregid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 200
    Top = 104
  end
end
