inherited FrmTicketPriceItem: TFrmTicketPriceItem
  Caption = 'FrmTicketPriceItem'
  ClientHeight = 315
  ClientWidth = 616
  OnShow = FormShow
  ExplicitWidth = 622
  ExplicitHeight = 343
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 616
    Height = 270
    ExplicitWidth = 616
    ExplicitHeight = 270
    inherited Bevel1: TBevel
      Top = 262
      Width = 582
      ExplicitTop = 307
      ExplicitWidth = 415
    end
    object Label1: TLabel
      Left = 49
      Top = 112
      Width = 56
      Height = 14
      Caption = #39033#30446#20195#30721
    end
    object Label2: TLabel
      Left = 49
      Top = 156
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object Label5: TLabel
      Left = 21
      Top = 68
      Width = 84
      Height = 14
      Caption = #36153#29992#30456#20851#31867#22411
    end
    object Label3: TLabel
      Left = 213
      Top = 112
      Width = 147
      Height = 14
      Caption = #38500'Q'#20197#22806#30340#33521#25991#23383#27597#34920#31034
    end
    object Label15: TLabel
      Left = 194
      Top = 112
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
      Left = 318
      Top = 154
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
    object Label6: TLabel
      Left = 318
      Top = 66
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
    object Label7: TLabel
      Left = 385
      Top = 68
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label8: TLabel
      Left = 35
      Top = 203
      Width = 70
      Height = 14
      Caption = #35745#31639#34920#36798#24335
    end
    object Label9: TLabel
      Left = 77
      Top = 34
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object Label10: TLabel
      Left = 294
      Top = 28
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
    object cbISTICKETPRICEITEM: TCheckBox
      Left = 442
      Top = 112
      Width = 89
      Height = 17
      Hint = #33509#20026#31080#20215#20998#39033#65292#22312#29983#25104#30340#31080#20215#32452#25104#39033#20013#21487#26597#35810#35813#20998#39033
      Caption = #31080#20215#20998#39033
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = cbISTICKETPRICEITEMClick
    end
    object NovaEdtName: TNovaEdit
      Left = 114
      Top = 153
      Width = 200
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
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
    object CbISAUTOADJUST: TCheckBox
      Left = 442
      Top = 156
      Width = 201
      Height = 17
      Caption = #35843#25972#31080#20215#26102#33258#21160#35843#25972
      Enabled = False
      TabOrder = 5
    end
    object NovaCbbItemAbout: TNovaComboBox
      Left = 114
      Top = 65
      Width = 200
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnChange = NovaCbbItemAboutChange
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
      HelpOptions.TableName = 'ticketpriceformulaitem'
      HelpOptions.Columnname = 'relatetype'
    end
    object NovaEdtValue: TNovaEdit
      Left = 442
      Top = 65
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 6
      TabOrder = 6
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
    object NovaEdtItemFormula: TNovaEdit
      Left = 114
      Top = 200
      Width = 200
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 100
      TabOrder = 3
      OnKeyPress = NovaEdtItemFormulaKeyPress
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
    object chkisfreight: TCheckBox
      Left = 442
      Top = 203
      Width = 89
      Height = 17
      Caption = #22522#30784#36816#20215
      Enabled = False
      TabOrder = 7
      OnClick = chkisfreightClick
    end
    object NovaEdtCode: TComboBox
      Left = 114
      Top = 108
      Width = 63
      Height = 24
      Style = csDropDownList
      CharCase = ecUpperCase
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 1
      ParentFont = False
      TabOrder = 8
      OnChange = NovaEdtCodeChange
      Items.Strings = (
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K')
    end
    object NovaHCbbOrg: TNovaHComboBox
      Left = 114
      Top = 27
      Width = 170
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 270
    Width = 616
    ExplicitTop = 270
    ExplicitWidth = 616
    inherited bbtnSave: TBitBtn
      Left = 216
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 216
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 398
      Top = 6
      ExplicitLeft = 398
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 368
    Top = 112
  end
  object jscdSaveTicketPriceItem: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveTicketpriceformulaitem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.relatetype'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ticketpriceformulaitem.isdefault'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ticketpriceformulaitem.isticketpriceitem'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ticketpriceformulaitem.isautoadjust'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ticketpriceformulaitem.isfreight'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.itemformula'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'ticketpriceformulaitem.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformulaitem.value'
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
        Name = 'formulaitemid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 200
  end
end
