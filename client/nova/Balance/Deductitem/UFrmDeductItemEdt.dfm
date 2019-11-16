inherited FrmDeductItemEdt: TFrmDeductItemEdt
  Caption = 'FrmDeductItemEdt'
  ClientHeight = 425
  ClientWidth = 504
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 510
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 504
    Height = 380
    ExplicitWidth = 504
    ExplicitHeight = 380
    inherited Bevel1: TBevel
      Top = 372
      Width = 470
      ExplicitTop = 355
      ExplicitWidth = 522
    end
    object Label1: TLabel
      Left = 39
      Top = 72
      Width = 84
      Height = 14
      Caption = #25152#23646#25187#36153#39033#30446
    end
    object Label2: TLabel
      Left = 67
      Top = 135
      Width = 56
      Height = 14
      Caption = #25187#36153#31867#22411
    end
    object Label6: TLabel
      Left = 67
      Top = 34
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object LabRemark: TLabel
      Left = 95
      Top = 326
      Width = 28
      Height = 14
      Caption = #25551#36848
    end
    object LabDeduct: TLabel
      Left = 67
      Top = 179
      Width = 56
      Height = 14
      Caption = #25187#36153#37329#39069
    end
    object Label3: TLabel
      Left = 299
      Top = 32
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
    object Label4: TLabel
      Left = 299
      Top = 136
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
    object Label9: TLabel
      Left = 299
      Top = 179
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
    object lbltemplatetype: TLabel
      Left = 68
      Top = 286
      Width = 56
      Height = 14
      Caption = #27169#26495#31867#22411
    end
    object NovaHCobParent: TNovaHComboBox
      Left = 130
      Top = 70
      Width = 160
      Height = 22
      ImeMode = imClose
      TabOrder = 1
      OnChange = NovaHCobParentChange
      OnSelect = NovaHCobParentSelect
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
          Value = 'BalancedeductitemHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object NovaCobType: TNovaComboBox
      Left = 130
      Top = 132
      Width = 160
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
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
      HelpOptions.TableName = 'balancedeductitem'
      HelpOptions.Columnname = 'deducttype'
    end
    object NovaEdtName: TNovaEdit
      Left = 130
      Top = 29
      Width = 160
      Height = 22
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
    object ChbIsPrintDeduct: TCheckBox
      Left = 130
      Top = 104
      Width = 124
      Height = 17
      Caption = #21457#29677#25171#21333#26102#25187#36153
      TabOrder = 2
      OnClick = ChbIsPrintDeductClick
    end
    object MeRemark: TMemo
      Left = 130
      Top = 323
      Width = 255
      Height = 24
      MaxLength = 50
      TabOrder = 5
    end
    object NovaEdtdeductmoney: TNovaEdit
      Left = 130
      Top = 174
      Width = 158
      Height = 22
      MaxLength = 6
      TabOrder = 4
      Text = '0'
      ValueTrim = '0'
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
    object Nvhcbbtemplatetype: TNovaHComboBox
      Left = 130
      Top = 282
      Width = 255
      Height = 22
      Enabled = False
      ImeMode = imClose
      TabOrder = 6
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
      HelpOptions.HDataSourceName = 'printtemplatetypelist'
      HelpOptions.HQueryAddress = 'system/queryPrinttemplatetype'
      HelpOptions.displayFieldname = 'name'
      Params = <>
    end
    object ChkAddPrint: TCheckBox
      Left = 130
      Top = 251
      Width = 177
      Height = 17
      Caption = #21152#20837#27169#26495#31867#22411#25171#21360#39033#30446
      TabOrder = 7
      OnClick = ChkAddPrintClick
    end
    object NovaEdtFormula: TNovaEdit
      Left = 130
      Top = 214
      Width = 255
      Height = 22
      Hint = #36755#20837#25187#36153#20844#24335
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 50
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
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
    object ChkForma: TCheckBox
      Left = 45
      Top = 217
      Width = 79
      Height = 17
      Caption = #20844#24335#25187#36153
      TabOrder = 9
      OnClick = ChkFormaClick
    end
  end
  inherited pnlOperation: TPanel
    Top = 380
    Width = 504
    ExplicitTop = 380
    ExplicitWidth = 504
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Top = 6
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 24
    Top = 104
  end
  object jcdsSavebalancedeductitem: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/saveDeductitem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balancedeductitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.deductmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.deducttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.description'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.isdeductbeforebalance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.parentid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.isaddprintitem'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.printtemplatetypeitemid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.isexpress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.formula'
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
        Name = 'balancedeductitemid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'balancedeductitem.isticketpriceitem'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 120
  end
end
