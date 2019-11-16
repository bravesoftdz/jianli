inherited FrmBilldestoryEdt: TFrmBilldestoryEdt
  Caption = 'FrmBilldestoryEdt'
  OnCreate = FormCreate
  ExplicitWidth = 443
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    object lbllbcode: TLabel
      Left = 64
      Top = 73
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object Label1: TLabel
      Left = 74
      Top = 120
      Width = 42
      Height = 14
      Caption = #24223#31080#20154
    end
    object lbl6: TLabel
      Left = 66
      Top = 30
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label2: TLabel
      Left = 74
      Top = 164
      Width = 28
      Height = 14
      Caption = #37329#39069
    end
    object Label3: TLabel
      Left = 74
      Top = 209
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object cbbbilltype: TNovaHComboBox
      Left = 128
      Top = 70
      Width = 145
      Height = 22
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
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BilltypeHelp'
        end>
    end
    object NovaHBilldestoryer: TNovaHelp
      Left = 128
      Top = 117
      Width = 147
      Height = 22
      MaxLength = 50
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object neprice: TNovaEdit
      Left = 130
      Top = 161
      Width = 143
      Height = 22
      MaxLength = 50
      NumbersOnly = True
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
    object DpDESTROYDATE: TDateTimePicker
      Left = 130
      Top = 209
      Width = 145
      Height = 22
      Date = 41872.857086759260000000
      Time = 41872.857086759260000000
      TabOrder = 3
    end
    object NovaCbbOrg: TNovaHComboBox
      Left = 128
      Top = 27
      Width = 145
      Height = 22
      Style = csDropDownList
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
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 400
    Top = 272
  end
  object jscd: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'bill/savebilldestroy'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'billdestroy.orgid'
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
        Name = 'billdestroy.billtypeid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'billdestroy.billdestroyer'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'billdestroy.destroyprice'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'billdestroy.destroydate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'billdestroy.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'id'
        ParamType = ptOutput
      end
      item
        DataType = ftDate
        Name = 'billdestroy.createtime'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 184
  end
end
