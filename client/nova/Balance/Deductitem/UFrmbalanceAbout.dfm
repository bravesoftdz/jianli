inherited FrmbalanceAbout: TFrmbalanceAbout
  Caption = 'FrmbalanceAbout'
  ClientHeight = 359
  ClientWidth = 526
  ExplicitWidth = 532
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 526
    Height = 314
    ExplicitWidth = 526
    ExplicitHeight = 314
    inherited Bevel1: TBevel
      Top = 306
      Width = 492
      ExplicitTop = 306
      ExplicitWidth = 492
    end
    object Label6: TLabel
      Left = 102
      Top = 43
      Width = 56
      Height = 14
      Caption = #25187#36153#39033#30446
    end
    object LabFrom: TLabel
      Left = 102
      Top = 133
      Width = 56
      Height = 14
      Caption = #36215#22987#37324#31243
    end
    object LabEnd: TLabel
      Left = 102
      Top = 185
      Width = 56
      Height = 14
      Caption = #25130#27490#37324#31243
    end
    object Label8: TLabel
      Left = 102
      Top = 229
      Width = 56
      Height = 14
      Caption = #25187#36153#37329#39069
    end
    object NovaEdtName: TNovaEdit
      Left = 168
      Top = 38
      Width = 193
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 20
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
    object NovaEdtFrom: TNovaEdit
      Left = 168
      Top = 130
      Width = 140
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 5
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
    object NovaEdtEnd: TNovaEdit
      Left = 168
      Top = 178
      Width = 140
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 5
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
    object NovaEdtValue: TNovaEdit
      Left = 168
      Top = 222
      Width = 140
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 6
      TabOrder = 3
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
    object RbAboutDistance: TRadioButton
      Left = 168
      Top = 85
      Width = 113
      Height = 17
      Caption = #37324#31243#30456#20851
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = RbAboutDistanceClick
    end
    object RbAboutPrice: TRadioButton
      Left = 295
      Top = 85
      Width = 113
      Height = 17
      Caption = #31080#20215#30456#20851
      TabOrder = 5
      OnClick = RbAboutPriceClick
    end
  end
  inherited pnlOperation: TPanel
    Top = 314
    Width = 526
    ExplicitTop = 314
    ExplicitWidth = 526
    inherited bbtnSave: TBitBtn
      Left = 141
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 141
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 278
      Top = 6
      ExplicitLeft = 278
      ExplicitTop = 6
    end
  end
  object jcsdSaveAboutDistance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/saveDeductitemaboutdistance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.fromdistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.enddistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemdistance.balancedeductitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'curid'
        ParamType = ptOutput
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
    Left = 384
    Top = 176
  end
  object jcdsSaveAboutPrice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/saveDeductitemaboutprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balancedeductitemprice.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemprice.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemprice.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemprice.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemprice.fromprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemprice.endprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitemprice.balancedeductitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'curid'
        ParamType = ptOutput
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
    Left = 384
    Top = 240
  end
end
