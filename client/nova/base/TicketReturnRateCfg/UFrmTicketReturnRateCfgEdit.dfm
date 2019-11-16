inherited FrmTicketReturnRateCfgEdit: TFrmTicketReturnRateCfgEdit
  Caption = #34892#25919#21306#22495#20449#24687
  ClientHeight = 220
  ClientWidth = 341
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 347
  ExplicitHeight = 248
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 341
    Height = 175
    ExplicitWidth = 341
    ExplicitHeight = 175
    inherited Bevel1: TBevel
      Top = 167
      Width = 307
      ExplicitTop = 314
      ExplicitWidth = 317
    end
    object lblname: TLabel
      Left = 46
      Top = 117
      Width = 56
      Height = 14
      Caption = #20043#21069#36153#29575
    end
    object Label2: TLabel
      Left = 181
      Top = 117
      Width = 8
      Height = 14
      Caption = '%'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label3: TLabel
      Left = 195
      Top = 117
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
      Transparent = False
    end
    object Label6: TLabel
      Left = 233
      Top = 30
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
      Left = 46
      Top = 31
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lblcode: TLabel
      Left = 60
      Top = 74
      Width = 42
      Height = 14
      Caption = #26102#38388#28857
    end
    object lbl3: TLabel
      Left = 268
      Top = 74
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
      Transparent = False
    end
    object lbl4: TLabel
      Left = 234
      Top = 73
      Width = 30
      Height = 14
      Caption = #23567#26102
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object nvedtprerate: TNovaEdit
      Left = 109
      Top = 113
      Width = 69
      Height = 22
      MaxLength = 20
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
    object NovaCbbOrg: TNovaHComboBox
      Left = 109
      Top = 27
      Width = 121
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
          Value = 'OrgHelp'
        end
        item
          DataType = ftString
          Name = 'filter_INS_t!id'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_INS_t!type'
          ParamType = ptInput
        end>
    end
    object cbbtimepoint: TComboBox
      Left = 177
      Top = 70
      Width = 53
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = '0'
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12')
    end
    object cbbtimetag: TComboBox
      Left = 109
      Top = 70
      Width = 66
      Height = 22
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = #21457#36710#21069
      Items.Strings = (
        #21457#36710#21069
        #21457#36710#21518)
    end
  end
  inherited pnlOperation: TPanel
    Top = 175
    Width = 341
    ExplicitTop = 175
    ExplicitWidth = 341
    inherited bbtnSave: TBitBtn
      Left = 65
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 65
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 214
      Top = 6
      ExplicitLeft = 214
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 280
    Top = 8
  end
  object jcdsticketreturnrateSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveticketreturnrate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketreturnrate.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketreturnrate.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketreturnrate.timepoint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketreturnrate.prerate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketreturnrate.createby'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'ticketreturnrate.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'ticketreturnrate.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketreturnrate.updatetime'
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
        DataType = ftString
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 104
  end
end
