inherited FrmPackTransfer: TFrmPackTransfer
  Caption = #36716#33267#23427#31449
  ClientHeight = 329
  ClientWidth = 435
  ExplicitWidth = 441
  ExplicitHeight = 357
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 435
    Height = 284
    ExplicitWidth = 435
    ExplicitHeight = 284
    inherited Bevel1: TBevel
      Top = 276
      Width = 401
      ExplicitTop = 290
      ExplicitWidth = 418
    end
    object lbl1: TLabel
      Left = 88
      Top = 50
      Width = 56
      Height = 14
      Caption = #34892#21253#21333#21495
    end
    object Label1: TLabel
      Left = 74
      Top = 95
      Width = 70
      Height = 14
      Caption = #20195#29702#20154#22995#21517
    end
    object Label2: TLabel
      Left = 102
      Top = 136
      Width = 42
      Height = 14
      Caption = #36716#36816#33267
    end
    object Label3: TLabel
      Left = 102
      Top = 176
      Width = 42
      Height = 14
      Caption = #20013#36716#36153
    end
    object Label20: TLabel
      Left = 325
      Top = 96
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 325
      Top = 137
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object NovaEditPackno: TNovaEdit
      Left = 158
      Top = 47
      Width = 160
      Height = 22
      Enabled = False
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
    object NovaEditTakename: TNovaEdit
      Left = 158
      Top = 92
      Width = 160
      Height = 22
      MaxLength = 20
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
    object nvhelptostation: TNovaHelp
      Left = 158
      Top = 133
      Width = 160
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedttransitfee: TNovaEdit
      Left = 158
      Top = 173
      Width = 160
      Height = 22
      MaxLength = 9
      TabOrder = 3
      Text = '0'
      ValueTrim = '0'
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
  end
  inherited pnlOperation: TPanel
    Top = 284
    Width = 435
    ExplicitTop = 284
    ExplicitWidth = 435
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 392
    Top = 8
  end
  object jcdspacktransfersave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/transferPack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pack.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.zhuanyuntostationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.transitfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.updateby'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 372
    Top = 80
  end
end
