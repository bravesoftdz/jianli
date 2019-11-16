inherited FrmAboutVehcile: TFrmAboutVehcile
  Caption = 'FrmAboutVehcile'
  ClientHeight = 253
  ClientWidth = 402
  OnShow = FormShow
  ExplicitWidth = 408
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 402
    Height = 208
    ExplicitWidth = 402
    ExplicitHeight = 208
    inherited Bevel1: TBevel
      Top = 200
      Width = 368
      ExplicitTop = 250
      ExplicitWidth = 368
    end
    object Label1: TLabel
      Left = 94
      Top = 89
      Width = 28
      Height = 14
      Caption = #36710#22411
    end
    object Label2: TLabel
      Left = 80
      Top = 135
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label3: TLabel
      Left = 66
      Top = 43
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object lbl1: TLabel
      Left = 303
      Top = 41
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
    object lbl2: TLabel
      Left = 303
      Top = 87
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
    object lbl3: TLabel
      Left = 262
      Top = 133
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
    object NovaHcbbVehcile: TNovaHComboBox
      Left = 135
      Top = 86
      Width = 162
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehicletypeHelp'
        end>
    end
    object NovaEdtValue: TNovaEdit
      Left = 135
      Top = 132
      Width = 121
      Height = 22
      MaxLength = 6
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
    object NovaEdtName: TNovaEdit
      Left = 135
      Top = 40
      Width = 162
      Height = 22
      MaxLength = 50
      ReadOnly = True
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
  end
  inherited pnlOperation: TPanel
    Top = 208
    Width = 402
    ExplicitTop = 208
    ExplicitWidth = 402
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 48
    Top = 40
  end
  object jcdsSaveItemAboutVchile: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveformulaitemvehcile'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemvehcile.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcile.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemvehcile.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcile.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcile.value'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemvehcile.vehciletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftUnknown
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 88
    Top = 200
  end
end
