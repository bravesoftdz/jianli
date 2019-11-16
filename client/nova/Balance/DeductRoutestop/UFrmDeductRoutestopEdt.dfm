inherited FrmDeductRoutestopEdt: TFrmDeductRoutestopEdt
  Caption = 'FrmDeductRoutestopEdt'
  ExplicitWidth = 443
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    ExplicitTop = 3
    object Label1: TLabel
      Left = 66
      Top = 37
      Width = 56
      Height = 14
      Caption = #25187#36153#39033#30446
    end
    object NovaHelp1: TNovaHelp
      Left = 128
      Top = 32
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 0
      Text = 'NovaHelp1'
      ValueTrim = 'NovaHelp1'
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
      HelpOptions.HelpHeight = 0
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelp2: TNovaHelp
      Left = 128
      Top = 80
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 1
      Text = 'NovaHelp2'
      ValueTrim = 'NovaHelp2'
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
      HelpOptions.HelpHeight = 0
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 432
    Top = 320
  end
  object jscdSaveDeducts: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/saveDeductitems'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'deductitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.printname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.orderno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.deducttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.ispriceitem'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.isexpress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.issum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.deductmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.description'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'deductitemid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 216
    Top = 176
  end
end
