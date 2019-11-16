inherited FrmOrgEdit: TFrmOrgEdit
  Caption = #32452#32455#26426#26500#20449#24687
  ClientHeight = 451
  ClientWidth = 678
  OnCreate = FormCreate
  ExplicitWidth = 684
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 678
    Height = 406
    ExplicitWidth = 678
    ExplicitHeight = 406
    inherited Bevel1: TBevel
      Left = 10
      Top = 390
      Width = 644
      ExplicitLeft = 10
      ExplicitTop = 354
      ExplicitWidth = 615
    end
    object lbl9: TLabel
      Left = 36
      Top = 66
      Width = 56
      Height = 14
      Caption = #19978#32423#26426#26500
    end
    object lbl4: TLabel
      Left = 404
      Top = 69
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object Label4: TLabel
      Left = 603
      Top = 69
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl1: TLabel
      Left = 376
      Top = 30
      Width = 56
      Height = 14
      Caption = #26426#26500#21517#31216
    end
    object lbl10: TLabel
      Left = 35
      Top = 26
      Width = 56
      Height = 14
      Caption = #26426#26500#31867#22411
    end
    object lbl13: TLabel
      Left = 89
      Top = 278
      Width = 56
      Height = 14
      Caption = #26426#26500#22320#22336
    end
    object lbl14: TLabel
      Left = 36
      Top = 107
      Width = 56
      Height = 14
      BiDiMode = bdRightToLeft
      Caption = #23545#24212#31449#28857
      ParentBiDiMode = False
    end
    object Label9: TLabel
      Left = 261
      Top = 29
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 603
      Top = 29
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl2: TLabel
      Left = 390
      Top = 104
      Width = 42
      Height = 14
      Caption = #32852#31995#20154
    end
    object lbl3: TLabel
      Left = 376
      Top = 147
      Width = 56
      Height = 14
      Caption = #32852#31995#30005#35805
    end
    object lbl5: TLabel
      Left = 116
      Top = 319
      Width = 28
      Height = 14
      Caption = #25551#36848
    end
    object lbl6: TLabel
      Left = 46
      Top = 194
      Width = 98
      Height = 14
      Caption = #24212#29992#26381#21153#22120#22320#22336
    end
    object lbl7: TLabel
      Left = 36
      Top = 145
      Width = 56
      Height = 14
      Caption = #25152#23646#21306#22495
    end
    object lbl8: TLabel
      Left = 560
      Top = 194
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl11: TLabel
      Left = 32
      Top = 234
      Width = 112
      Height = 14
      Caption = #32852#32593#21806#31080#26381#21153#22320#22336
    end
    object lbl16: TLabel
      Left = 261
      Top = 106
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object cbbComboxParentOrg: TNovaHComboBox
      Left = 98
      Top = 66
      Width = 157
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
          Name = 'param'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Size = 1000
          Value = 'OrgManagerHelp'
        end
        item
          DataType = ftString
          Name = 'filter_INS_t!type'
          ParamType = ptInput
        end>
    end
    object edtCode: TNovaEdit
      Left = 440
      Top = 66
      Width = 157
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 5
      OnKeyDown = edtCodeKeyDown
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
    object edtname: TNovaEdit
      Left = 440
      Top = 26
      Width = 157
      Height = 22
      MaxLength = 30
      TabOrder = 4
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
    object edtaddress: TNovaEdit
      Left = 151
      Top = 275
      Width = 400
      Height = 22
      MaxLength = 20
      TabOrder = 10
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
    object cbbCobOrgType: TNovaComboBox
      Left = 97
      Top = 26
      Width = 157
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      MaxLength = 2
      TabOrder = 1
      OnChange = cbbCobOrgTypeChange
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
      HelpOptions.TableName = 'organization'
      HelpOptions.Columnname = 'type'
    end
    object NovaHelpObjectID: TNovaHelp
      Left = 97
      Top = 102
      Width = 157
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 2
      OnIdChange = NovaHelpObjectIDIdChange
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
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationDHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edtSaleAddress: TNovaEdit
      Left = 151
      Top = 231
      Width = 400
      Height = 22
      MaxLength = 32
      TabOrder = 9
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
    object edtContactPerson: TNovaEdit
      Left = 440
      Top = 102
      Width = 157
      Height = 22
      MaxLength = 10
      TabOrder = 6
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
    object edtPhone: TNovaEdit
      Left = 440
      Top = 143
      Width = 157
      Height = 22
      MaxLength = 15
      TabOrder = 7
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
    object edtServiceAddress: TNovaEdit
      Left = 151
      Top = 191
      Width = 400
      Height = 22
      MaxLength = 32
      TabOrder = 8
      OnKeyPress = edtServiceAddressKeyPress
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
    object edtdistrict: TNovaHelp
      Left = 97
      Top = 141
      Width = 157
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'DistrictHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object mmoDescribe: TMemo
      Left = 151
      Top = 319
      Width = 400
      Height = 54
      MaxLength = 100
      TabOrder = 11
    end
  end
  inherited pnlOperation: TPanel
    Top = 406
    Width = 678
    ExplicitTop = 406
    ExplicitWidth = 678
    inherited bbtnSave: TBitBtn
      Left = 201
      Top = 4
      OnClick = bbtnSaveClick
      ExplicitLeft = 201
      ExplicitTop = 4
    end
    inherited bbtnClose: TBitBtn
      Left = 380
      Top = 4
      ExplicitLeft = 380
      ExplicitTop = 4
    end
  end
  inherited ImageList: TImageList
    Left = 576
    Top = 288
  end
  object jsonCDSOrgSave: TjsonClientDataSet
    DataSourceName = 'orglist'
    QueryAddress = 'system/qryorg'
    SaveAddress = 'system/saveorg'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'organization.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.organ.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.station.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.unit.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.contactperson'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.contactphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.serversaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.ticketserversaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.address'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.district.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.describe'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.islocal'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'organization.synccode'
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
        Name = 'orgid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 64
    Top = 328
  end
end
