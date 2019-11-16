inherited frmEmployeeEdt: TfrmEmployeeEdt
  Caption = #32534#36753#21592#24037#26723#26696
  ClientHeight = 489
  ClientWidth = 527
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 533
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 527
    Height = 444
    ExplicitWidth = 527
    ExplicitHeight = 444
    inherited Bevel1: TBevel
      Top = 436
      Width = 493
      ExplicitTop = 346
      ExplicitWidth = 464
    end
    object lbl1: TLabel
      Left = 78
      Top = 63
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object lbl2: TLabel
      Left = 77
      Top = 107
      Width = 28
      Height = 14
      Caption = #24037#21495
    end
    object lbl4: TLabel
      Left = 49
      Top = 237
      Width = 56
      Height = 14
      Caption = #20986#29983#26085#26399
    end
    object lbl6: TLabel
      Left = 77
      Top = 277
      Width = 28
      Height = 14
      Caption = #23398#21382
    end
    object lbl7: TLabel
      Left = 78
      Top = 177
      Width = 28
      Height = 14
      Caption = #24615#21035
    end
    object lbl8: TLabel
      Left = 78
      Top = 409
      Width = 28
      Height = 14
      Caption = #31821#36143
    end
    object lbl12: TLabel
      Left = 278
      Top = 320
      Width = 56
      Height = 14
      Caption = #23478#24237#30005#35805
    end
    object lbl13: TLabel
      Left = 51
      Top = 367
      Width = 56
      Height = 14
      Caption = #23478#24237#20303#22336
    end
    object lbl14: TLabel
      Left = 49
      Top = 145
      Width = 56
      Height = 14
      Caption = #36523#20221#35777#21495
    end
    object lbl10: TLabel
      Left = 278
      Top = 277
      Width = 56
      Height = 14
      Caption = #31227#21160#30005#35805
    end
    object lblSalary: TLabel
      Left = 306
      Top = 237
      Width = 28
      Height = 14
      Caption = #24037#36164
    end
    object lbl11: TLabel
      Left = 241
      Top = 30
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
    object lbl19: TLabel
      Left = 241
      Top = 108
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
    object lbl21: TLabel
      Left = 241
      Top = 146
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
    object lbl22: TLabel
      Left = 241
      Top = 277
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
    object lbl26: TLabel
      Left = 241
      Top = 318
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
    object lbl28: TLabel
      Left = 241
      Top = 69
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
    object lbl3: TLabel
      Left = 49
      Top = 320
      Width = 56
      Height = 14
      Caption = #32844#20301#31867#22411
    end
    object lbl9: TLabel
      Left = 50
      Top = 27
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object nvedtName: TNovaEdit
      Left = 111
      Top = 63
      Width = 126
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
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
    object nvedtCode: TNovaEdit
      Left = 111
      Top = 104
      Width = 126
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object nvedtIDcard: TNovaEdit
      Left = 109
      Top = 142
      Width = 126
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 18
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
    object nvedtFamilyPhone: TNovaEdit
      Left = 340
      Top = 274
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 12
      TabOrder = 11
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
    object nvedtAdress: TNovaEdit
      Left = 113
      Top = 364
      Width = 353
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 13
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
    object nvcbbEducation: TNovaComboBox
      Left = 111
      Top = 274
      Width = 126
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 8
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
      HelpOptions.TableName = 'employee'
      HelpOptions.Columnname = 'education'
    end
    object dtpBirthdate: TDateTimePicker
      Left = 111
      Top = 230
      Width = 126
      Height = 23
      Date = 18264.000000000000000000
      Time = 18264.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
    end
    object nvedtMovePhone: TNovaEdit
      Left = 340
      Top = 315
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 12
      TabOrder = 12
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
    object nvedtSalary: TNovaEdit
      Left = 340
      Top = 230
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 10
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
    object nvedtNativeplace: TNovaEdit
      Left = 112
      Top = 406
      Width = 353
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 14
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
    object rbMan: TRadioButton
      Left = 112
      Top = 179
      Width = 35
      Height = 18
      Caption = #30007
      Checked = True
      TabOrder = 4
      TabStop = True
    end
    object rbGrile: TRadioButton
      Left = 175
      Top = 178
      Width = 33
      Height = 17
      Caption = #22899
      TabOrder = 5
      TabStop = True
    end
    object grpPicture: TGroupBox
      Left = 269
      Top = 9
      Width = 192
      Height = 200
      Caption = #30456#29255
      TabOrder = 15
      object btn1: TSpeedButton
        Left = 16
        Top = 164
        Width = 69
        Height = 26
        Caption = #27983#35272
        OnClick = btn1Click
      end
      object btn2: TSpeedButton
        Left = 105
        Top = 164
        Width = 69
        Height = 26
        Caption = #28165#38500#22270#29255
        OnClick = btn2Click
      end
      object pnl1: TPanel
        Left = 2
        Top = 16
        Width = 188
        Height = 139
        Align = alTop
        TabOrder = 0
        object imgImg_Picture1: TImage
          Left = 1
          Top = 1
          Width = 186
          Height = 137
          Hint = #20056#21153#21592#22836#20687
          Align = alClient
          ParentShowHint = False
          PopupMenu = pmpicture
          ShowHint = True
          OnDblClick = imgImg_Picture1DblClick
          ExplicitHeight = 128
        end
      end
    end
    object nvcbbPosition: TNovaComboBox
      Left = 111
      Top = 315
      Width = 126
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 9
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
      HelpOptions.TableName = 'employee'
      HelpOptions.Columnname = 'position'
    end
    object chkTemp: TCheckBox
      Left = 111
      Top = 205
      Width = 91
      Height = 17
      Caption = #26159#21542#20020#26102#24037
      TabOrder = 6
    end
    object nvhelpOrg: TNovaHelp
      Left = 112
      Top = 24
      Width = 125
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 15
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 444
    Width = 527
    ExplicitTop = 444
    ExplicitWidth = 527
    inherited bbtnSave: TBitBtn
      Left = 162
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 162
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 306
      Top = 6
      ExplicitLeft = 306
      ExplicitTop = 6
    end
  end
  object jcdsSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/saveEmployeer'
    SaveAddress = 'archive/saveEmployeer'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'employeer.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.idcard'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'employeer.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.birthday'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.position'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.education'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.familyaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.familyphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.mobilephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.nativeplace'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.picture'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.salary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.sex'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.istemporary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pictures'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'employeer.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 1000
        Value = '0'
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
        Value = '0'
      end
      item
        DataType = ftBCD
        Name = 'employeeid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 72
  end
  object dlgOpenPicPictrue: TOpenPictureDialog
    Left = 316
    Top = 64
  end
  object pmpicture: TPopupMenu
    Left = 312
    Top = 120
    object N1: TMenuItem
      Caption = #36873#25321#22270#29255
      OnClick = imgImg_Picture1DblClick
    end
    object N2: TMenuItem
      Caption = #28165#31354#22270#29255
      OnClick = N2Click
    end
  end
end
