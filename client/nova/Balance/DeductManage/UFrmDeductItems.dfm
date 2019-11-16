inherited FrmDeductItems: TFrmDeductItems
  Caption = 'FrmDeductItems'
  ClientHeight = 406
  ClientWidth = 559
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 565
  ExplicitHeight = 438
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 559
    Height = 361
    ExplicitWidth = 559
    ExplicitHeight = 361
    inherited Bevel1: TBevel
      Top = 353
      Width = 525
      ExplicitTop = 314
      ExplicitWidth = 512
    end
    object Label2: TLabel
      Left = 45
      Top = 139
      Width = 56
      Height = 14
      Caption = #25187#36153#31867#22411
    end
    object Label6: TLabel
      Left = 45
      Top = 74
      Width = 56
      Height = 14
      Caption = #25187#36153#21517#31216
    end
    object LabRemark: TLabel
      Left = 73
      Top = 307
      Width = 28
      Height = 14
      Caption = #25551#36848
    end
    object LabDeduct: TLabel
      Left = 45
      Top = 271
      Width = 56
      Height = 14
      Caption = #25187#36153#37329#39069
    end
    object Label3: TLabel
      Left = 276
      Top = 73
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
      Left = 276
      Top = 107
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
    object Label5: TLabel
      Left = 73
      Top = 172
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object Label7: TLabel
      Left = 45
      Top = 106
      Width = 56
      Height = 14
      Caption = #25171#21360#21517#31216
    end
    object Label8: TLabel
      Left = 45
      Top = 204
      Width = 56
      Height = 14
      Caption = #26174#31034#24207#21495
    end
    object Label1: TLabel
      Left = 276
      Top = 141
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
    object Label10: TLabel
      Left = 276
      Top = 172
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
    object Label11: TLabel
      Left = 195
      Top = 206
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
    object Label16: TLabel
      Left = 45
      Top = 38
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label17: TLabel
      Left = 276
      Top = 36
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
    object NovaCobType: TNovaComboBox
      Left = 110
      Top = 137
      Width = 156
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
      HelpOptions.TableName = 'deductitem'
      HelpOptions.Columnname = 'deducttype'
    end
    object NovaEdtName: TNovaEdit
      Left = 110
      Top = 71
      Width = 156
      Height = 22
      MaxLength = 10
      TabOrder = 1
      OnExit = NovaEdtNameExit
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
    object MeRemark: TMemo
      Left = 110
      Top = 302
      Width = 411
      Height = 24
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 10
      OnChange = MeRemarkChange
    end
    object NovaEdtdeductmoney: TNovaEdit
      Left = 110
      Top = 269
      Width = 77
      Height = 22
      MaxLength = 5
      TabOrder = 8
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
    object ChbIsPriceItem: TCheckBox
      Left = 110
      Top = 238
      Width = 99
      Height = 17
      Caption = #31080#20215#20998#39033
      TabOrder = 6
      OnClick = ChbIsPriceItemClick
    end
    object NovaEdtCode: TNovaEdit
      Left = 110
      Top = 170
      Width = 155
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 4
      OnKeyPress = NovaEdtCodeKeyPress
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
    object NovaEdtPrintName: TNovaEdit
      Left = 109
      Top = 103
      Width = 156
      Height = 22
      MaxLength = 10
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
    object NovaEdtOrderno: TNovaEdit
      Left = 110
      Top = 203
      Width = 65
      Height = 22
      MaxLength = 20
      TabOrder = 5
      Text = '0'
      ValueTrim = '0'
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
    object UpDown1: TUpDown
      Left = 175
      Top = 203
      Width = 16
      Height = 22
      Associate = NovaEdtOrderno
      TabOrder = 11
    end
    object ChkIsExpress: TCheckBox
      Left = 211
      Top = 272
      Width = 73
      Height = 17
      Caption = #34920#36798#24335
      Enabled = False
      TabOrder = 9
      OnClick = ChkIsExpressClick
    end
    object ChkIsSum: TCheckBox
      Left = 211
      Top = 238
      Width = 78
      Height = 17
      Caption = #23567#35745#39033#30446
      TabOrder = 7
    end
    object GroupBox1: TGroupBox
      Left = 313
      Top = 33
      Width = 208
      Height = 239
      Caption = #35828#26126
      TabOrder = 12
      object Label9: TLabel
        Left = 39
        Top = 30
        Width = 182
        Height = 14
        Caption = #25187#36153#32534#30721#38500' A'#65288#31080#27454#37329#39069#65289#12289
      end
      object Label12: TLabel
        Left = 16
        Top = 59
        Width = 175
        Height = 14
        Caption = 'B'#65288#20154#25968#65289#38500#22806#30340#33521#25991#23383#27597#25110
      end
      object Label13: TLabel
        Left = 40
        Top = 120
        Width = 154
        Height = 14
        Caption = #26174#31034#24207#21495#20026#32479#35745#25253#34920#26102#26174
      end
      object Label14: TLabel
        Left = 16
        Top = 146
        Width = 56
        Height = 14
        Caption = #31034#30340#39034#24207
      end
      object Label15: TLabel
        Left = 16
        Top = 87
        Width = 98
        Height = 14
        Caption = #33521#25991#23383#27597#30340#32452#21512
      end
      object Label18: TLabel
        Left = 40
        Top = 178
        Width = 154
        Height = 14
        Caption = #25171#21360#39033#30446#30340#25187#36153#33258#21160#22686#21152
      end
      object Label19: TLabel
        Left = 18
        Top = 204
        Width = 140
        Height = 14
        Caption = #21040#25171#21360#27169#29256#30340#25171#21360#39033#20013
      end
    end
    object NovaHCobOrg: TNovaHComboBox
      Left = 110
      Top = 33
      Width = 156
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
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
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelpStation'
        end>
    end
    object ChkIsprintitem: TCheckBox
      Left = 211
      Top = 206
      Width = 97
      Height = 17
      Caption = #25171#21360#39033#30446
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
  end
  inherited pnlOperation: TPanel
    Top = 361
    Width = 559
    ExplicitTop = 361
    ExplicitWidth = 559
    inherited bbtnSave: TBitBtn
      Left = 153
      Top = 8
      OnClick = bbtnSaveClick
      ExplicitLeft = 153
      ExplicitTop = 8
    end
    inherited bbtnClose: TBitBtn
      Left = 290
      Top = 8
      ExplicitLeft = 290
      ExplicitTop = 8
    end
  end
  inherited ImageList: TImageList
    Left = 600
    Top = 400
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
        DataType = ftString
        Name = 'deductitem.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.isprintitem'
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
    Left = 392
    Top = 288
  end
end
