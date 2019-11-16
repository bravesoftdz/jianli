inherited FrmParameterAdd: TFrmParameterAdd
  Caption = #31995#32479#21442#25968#35774#32622
  ClientHeight = 253
  ClientWidth = 528
  Font.Charset = ANSI_CHARSET
  OldCreateOrder = False
  OnShow = FormShow
  ExplicitWidth = 534
  ExplicitHeight = 281
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 528
    Height = 206
    TabOrder = 1
    ExplicitWidth = 528
    ExplicitHeight = 206
    inherited Bevel1: TBevel
      Left = 0
      Top = 198
      Width = 583
      ExplicitLeft = 0
      ExplicitTop = 194
      ExplicitWidth = 583
    end
    object lblcode: TLabel
      Left = 299
      Top = 43
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object lblCodeType: TLabel
      Left = 46
      Top = 86
      Width = 56
      Height = 14
      Caption = #21442#25968#31867#21035
    end
    object lblorgid: TLabel
      Left = 46
      Top = 43
      Width = 56
      Height = 14
      Caption = #25152#23646#21333#20301
    end
    object lblremark: TLabel
      Left = 74
      Top = 117
      Width = 28
      Height = 14
      Caption = #25551#36848
    end
    object lblparamvalue: TLabel
      Left = 285
      Top = 85
      Width = 42
      Height = 14
      Caption = #21442#25968#20540
    end
    object lbl1: TLabel
      Left = 261
      Top = 86
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl2: TLabel
      Left = 476
      Top = 86
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lbl4: TLabel
      Left = 476
      Top = 43
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl5: TLabel
      Left = 261
      Top = 43
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object mmoDeseription: TMemo
      Left = 108
      Top = 111
      Width = 375
      Height = 57
      Enabled = False
      MaxLength = 100
      TabOrder = 0
    end
    object nvcbbtype: TNovaComboBox
      Left = 108
      Top = 82
      Width = 147
      Height = 22
      Enabled = False
      ImeMode = imClose
      TabOrder = 1
      Text = #35831#36873#25321'...'
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
      HelpOptions.TableName = 'parameter'
      HelpOptions.Columnname = 'type'
      HelpOptions.DisAll = True
    end
    object nvedtCode: TNovaEdit
      Left = 333
      Top = 40
      Width = 137
      Height = 22
      Enabled = False
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
    object nvedtValue: TNovaEdit
      Left = 333
      Top = 82
      Width = 137
      Height = 22
      MaxLength = 9
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
    object nvhcbbOrg: TNovaHComboBox
      Left = 108
      Top = 40
      Width = 147
      Height = 22
      Enabled = False
      ImeMode = imClose
      TabOrder = 4
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
    Top = 206
    Width = 528
    Height = 47
    TabOrder = 0
    ExplicitTop = 206
    ExplicitWidth = 528
    ExplicitHeight = 47
    inherited bbtnSave: TBitBtn
      Left = 131
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 131
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 307
      Top = 6
      OnClick = bbtnCloseClick
      ExplicitLeft = 307
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 56
    Top = 32
  end
  object jcdsSaveparamd: TjsonClientDataSet
    DataSourceName = 'paramlistmap'
    QueryAddress = 'system/findParameter'
    SaveAddress = 'system/saveParameterDetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <
      item
        Visible = False
      end>
    Params = <
      item
        DataType = ftString
        Name = 'paramorgdetail.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'paramorgdetail.parameterid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'paramorgdetail.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'paramorgdetail.value'
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
        Name = 'detailid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 112
  end
end
