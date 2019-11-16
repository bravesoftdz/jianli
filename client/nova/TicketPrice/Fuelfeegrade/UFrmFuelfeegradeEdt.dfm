inherited FrmFuelfeegradeEdt: TFrmFuelfeegradeEdt
  Caption = 'FrmFuelfeegradeEdt'
  ClientHeight = 260
  ClientWidth = 372
  Position = poScreenCenter
  OnCreate = FormCreate
  ExplicitWidth = 378
  ExplicitHeight = 292
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 372
    Height = 215
    ExplicitWidth = 372
    ExplicitHeight = 215
    inherited Bevel1: TBevel
      Top = 207
      Width = 338
      ExplicitTop = 207
      ExplicitWidth = 338
    end
    object Label11: TLabel
      Left = 77
      Top = 37
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object Label1: TLabel
      Left = 77
      Top = 78
      Width = 28
      Height = 14
      Caption = #26723#27425
    end
    object Label2: TLabel
      Left = 63
      Top = 118
      Width = 42
      Height = 14
      Caption = #27833#20215#20174
    end
    object Label3: TLabel
      Left = 88
      Top = 158
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label4: TLabel
      Left = 201
      Top = 118
      Width = 70
      Height = 14
      Caption = '('#21333#20301#65306#20803')'
    end
    object NovaHCobOrg: TNovaHComboBox
      Left = 111
      Top = 30
      Width = 164
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
    object CobGrade: TComboBox
      Left = 111
      Top = 75
      Width = 83
      Height = 22
      TabOrder = 1
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10')
    end
    object NovaEdtFrom: TNovaEdit
      Left = 111
      Top = 115
      Width = 83
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
    object NovaEdtTo: TNovaEdit
      Left = 111
      Top = 153
      Width = 83
      Height = 22
      MaxLength = 50
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
  end
  inherited pnlOperation: TPanel
    Top = 215
    Width = 372
    ExplicitTop = 215
    ExplicitWidth = 372
    inherited bbtnSave: TBitBtn
      Left = 77
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 77
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 208
      Top = 6
      ExplicitLeft = 208
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 408
    Top = 296
  end
  object jscdsaveFuelfeegrade: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveFuelfeegrade'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fuelfeegrade.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.grade'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.fromprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.toprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fuelfeegrade.updateby'
        ParamType = ptInput
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
      end
      item
        DataType = ftBCD
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 136
  end
end
