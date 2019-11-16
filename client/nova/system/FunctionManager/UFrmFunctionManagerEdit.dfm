inherited FrmFunctionManagerEdit: TFrmFunctionManagerEdit
  Caption = 'FrmFunctionManagerEdit'
  ClientHeight = 343
  ClientWidth = 442
  OnShow = FormShow
  ExplicitWidth = 448
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 442
    Height = 298
    ExplicitWidth = 442
    ExplicitHeight = 298
    DesignSize = (
      442
      298)
    inherited Bevel1: TBevel
      Top = 290
      Width = 408
      ExplicitTop = 186
      ExplicitWidth = 382
    end
    object lblname: TLabel
      Left = 31
      Top = 28
      Width = 56
      Height = 14
      Caption = #21151#33021#21517#31216
    end
    object lblkey: TLabel
      Left = 31
      Top = 102
      Width = 56
      Height = 14
      Caption = #21151#33021'GUID'
    end
    object lbldescribe: TLabel
      Left = 31
      Top = 133
      Width = 56
      Height = 14
      Caption = #21151#33021#25551#36848
    end
    object lblparamdescribe: TLabel
      Left = 31
      Top = 210
      Width = 56
      Height = 14
      Caption = #21442#25968#25551#36848
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
      Top = 102
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
    object lbl9: TLabel
      Left = 59
      Top = 65
      Width = 28
      Height = 14
      Caption = #21253#21517
    end
    object lblpackagename: TLabel
      Left = 119
      Top = 65
      Width = 7
      Height = 14
    end
    object lbl3: TLabel
      Left = 392
      Top = 65
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
      Left = 94
      Top = 133
      Width = 292
      Height = 63
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object mmoParamdescribe: TMemo
      Left = 93
      Top = 210
      Width = 292
      Height = 63
      ScrollBars = ssVertical
      TabOrder = 4
    end
    object nvedtname: TNovaEdit
      Left = 94
      Top = 24
      Width = 292
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
    object nvedtkey: TNovaEdit
      Left = 94
      Top = 98
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
    object btnpackagename: TButton
      Left = 92
      Top = 59
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnpackagenameClick
    end
  end
  inherited pnlOperation: TPanel
    Top = 298
    Width = 442
    ExplicitTop = 298
    ExplicitWidth = 442
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 128
  end
  object jcdsFunctionSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/saveFunctionreg'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'functionreg.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.packagename'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.functionkey'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.functiondescribe'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'functionreg.parameterdescribe'
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
        Name = 'functionregid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 40
    Top = 112
  end
  object fopdlgpackage: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = #21160#24577#24211
        FileMask = '*.bpl'
      end>
    Options = []
    Left = 240
    Top = 48
  end
  object dlgOpenPackage: TOpenDialog
    Filter = #21335#20940#21160#24577#24211'|*.bpl'
    Left = 328
    Top = 48
  end
end
