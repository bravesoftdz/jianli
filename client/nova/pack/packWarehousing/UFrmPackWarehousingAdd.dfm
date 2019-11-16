inherited FrmPackWarehousingAdd: TFrmPackWarehousingAdd
  ActiveControl = nvhelpvehiclecode
  Caption = #21040#36135#20837#20179
  ClientHeight = 501
  ClientWidth = 663
  Font.Charset = ANSI_CHARSET
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 669
  ExplicitHeight = 529
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 0
    Height = 433
    ExplicitLeft = 305
    ExplicitHeight = 386
  end
  inherited pnlEditBox: TPanel
    Width = 233
    Height = 472
    Align = alNone
    ExplicitWidth = 233
    ExplicitHeight = 472
    DesignSize = (
      233
      472)
    inherited Bevel1: TBevel
      Top = 466
      Width = 199
      ExplicitTop = 312
      ExplicitWidth = 488
    end
  end
  inherited pnlOperation: TPanel
    Top = 433
    Width = 663
    Height = 68
    BevelOuter = bvSpace
    ExplicitTop = 433
    ExplicitWidth = 663
    ExplicitHeight = 68
    inherited bbtnSave: TBitBtn
      Left = 180
      Top = 19
      Height = 28
      OnClick = bbtnSaveClick
      ExplicitLeft = 180
      ExplicitTop = 19
      ExplicitHeight = 28
    end
    inherited bbtnClose: TBitBtn
      Left = 338
      Top = 19
      Height = 28
      ExplicitLeft = 338
      ExplicitTop = 19
      ExplicitHeight = 28
    end
  end
  object Panel1: TPanel [3]
    Left = 3
    Top = 0
    Width = 660
    Height = 433
    Align = alClient
    TabOrder = 2
    object Label11: TLabel
      Left = 58
      Top = 359
      Width = 56
      Height = 14
      Caption = #23384#25918#20301#32622
    end
    object Label34: TLabel
      Left = 267
      Top = 122
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
    object Label33: TLabel
      Left = 362
      Top = 162
      Width = 28
      Height = 14
      Caption = #36816#36153
    end
    object Label51: TLabel
      Left = 363
      Top = 322
      Width = 28
      Height = 14
      Caption = #36135#27454
    end
    object Label39: TLabel
      Left = 268
      Top = 196
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
    object Label8: TLabel
      Left = 85
      Top = 162
      Width = 28
      Height = 14
      Caption = #20214#25968
    end
    object Label7: TLabel
      Left = 85
      Top = 256
      Width = 28
      Height = 14
      Caption = #21253#35013
    end
    object Label5: TLabel
      Left = 73
      Top = 200
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label3: TLabel
      Left = 59
      Top = 58
      Width = 56
      Height = 14
      Caption = #25910#35755#21333#21495
    end
    object Label12: TLabel
      Left = 267
      Top = 162
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
    object Label1: TLabel
      Left = 73
      Top = 226
      Width = 42
      Height = 14
      Caption = #21457#36135#31449
    end
    object Label24: TLabel
      Left = 320
      Top = 58
      Width = 70
      Height = 14
      Caption = #25910#36135#20154#30005#35805
    end
    object Label22: TLabel
      Left = 322
      Top = 24
      Width = 70
      Height = 14
      Caption = #25910#36135#20154#22995#21517
    end
    object Label19: TLabel
      Left = 336
      Top = 288
      Width = 56
      Height = 14
      Caption = #21512#35745#37329#39069
    end
    object Label26: TLabel
      Left = 267
      Top = 256
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
    object Label49: TLabel
      Left = 336
      Top = 256
      Width = 56
      Height = 14
      Caption = #20854#20182#36153#29992
    end
    object lbl1: TLabel
      Left = 267
      Top = 56
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
    object lbl2: TLabel
      Left = 267
      Top = 227
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
    object lbl3: TLabel
      Left = 267
      Top = 24
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
    object lbltoendstation: TLabel
      Left = 73
      Top = 393
      Width = 42
      Height = 14
      Caption = #36716#36816#33267
    end
    object lblsellby: TLabel
      Left = 350
      Top = 359
      Width = 42
      Height = 14
      Caption = #20837#20179#21592
    end
    object lbldepartdate: TLabel
      Left = 57
      Top = 24
      Width = 56
      Height = 14
      Caption = #20837#20179#26085#26399
    end
    object Label2: TLabel
      Left = 268
      Top = 359
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
      Left = 57
      Top = 322
      Width = 56
      Height = 14
      Caption = #36135#29289#29366#24577
    end
    object Label14: TLabel
      Left = 349
      Top = 196
      Width = 42
      Height = 14
      Caption = #20013#36716#36153
    end
    object Label18: TLabel
      Left = 348
      Top = 226
      Width = 42
      Height = 14
      Caption = #26381#21153#36153
    end
    object Label20: TLabel
      Left = 57
      Top = 127
      Width = 56
      Height = 14
      Caption = #34892#21253#21517#31216
    end
    object Label21: TLabel
      Left = 268
      Top = 322
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
    object Label23: TLabel
      Left = 334
      Top = 93
      Width = 56
      Height = 14
      Caption = #25552#36135#26041#24335
    end
    object Label25: TLabel
      Left = 334
      Top = 127
      Width = 56
      Height = 14
      Caption = #20184#27454#26041#24335
    end
    object Label27: TLabel
      Left = 547
      Top = 122
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
    object Label28: TLabel
      Left = 547
      Top = 88
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
    object Label29: TLabel
      Left = 555
      Top = 359
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
    object Label30: TLabel
      Left = 555
      Top = 322
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
    object Label6: TLabel
      Left = 57
      Top = 89
      Width = 56
      Height = 14
      Caption = #21463#29702#21333#21495
    end
    object Label9: TLabel
      Left = 266
      Top = 88
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
    object nvedtshipprice: TNovaEdit
      Left = 396
      Top = 156
      Width = 150
      Height = 22
      MaxLength = 7
      TabOrder = 15
      Text = '0'
      OnChange = nvedtshippriceChange
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
    object nvedtpackprice: TNovaEdit
      Left = 399
      Top = 319
      Width = 150
      Height = 22
      MaxLength = 9
      TabOrder = 20
      Text = '0'
      OnChange = nvedtshippriceChange
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
    object nvedtpieces: TNovaEdit
      Left = 119
      Top = 160
      Width = 140
      Height = 22
      MaxLength = 3
      TabOrder = 3
      Text = '1'
      ValueTrim = '1'
      ValueType = ssTicket
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
    object nvcbbpacked: TNovaComboBox
      Left = 121
      Top = 253
      Width = 140
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 6
      OnChange = nvcbbpackedChange
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
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'packed'
    end
    object nvhelpvehiclecode: TNovaHelp
      Left = 121
      Top = 193
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #36710#29260#21495
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vehicletypename'
          Title.Caption = #36710#22411
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedtconsigneephone: TNovaEdit
      Left = 399
      Top = 50
      Width = 140
      Height = 22
      MaxLength = 11
      TabOrder = 12
      ValueType = ssTicket
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
    object nvedtconsignee: TNovaEdit
      Left = 399
      Top = 20
      Width = 140
      Height = 22
      MaxLength = 20
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
    object nvedtpackarriverno: TNovaEdit
      Left = 121
      Top = 53
      Width = 140
      Height = 22
      Enabled = False
      MaxLength = 20
      TabOrder = 22
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
    object nvedttotalfee: TNovaEdit
      Left = 398
      Top = 288
      Width = 150
      Height = 22
      MaxLength = 7
      TabOrder = 19
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
    object nvhelpsendstationid: TNovaHelp
      Left = 121
      Top = 223
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 5
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
    object nvedtotherfee: TNovaEdit
      Left = 398
      Top = 255
      Width = 150
      Height = 22
      MaxLength = 7
      TabOrder = 18
      Text = '0'
      OnChange = nvedtshippriceChange
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
    object dtpdepartdate: TDateTimePicker
      Left = 121
      Top = 20
      Width = 140
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      TabOrder = 0
    end
    object nvhelpzytostationid: TNovaHelp
      Left = 121
      Top = 390
      Width = 145
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
    object nvcbblocation: TNovaComboBox
      Left = 120
      Top = 356
      Width = 140
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'location'
    end
    object nvedtpacked: TNovaEdit
      Left = 120
      Top = 285
      Width = 138
      Height = 22
      MaxLength = 20
      TabOrder = 7
      OnExit = nvedtpackedExit
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
    object nvcbbentrypacker: TNovaCheckedComboBox
      Left = 398
      Top = 356
      Width = 150
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 21
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'usermap'
      HelpOptions.HQueryAddress = 'system/listEntrypacker'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'filter_INS_u!orgid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_INS_r!id'
          ParamType = ptInput
        end>
    end
    object nvcbbgoodsstatus: TNovaComboBox
      Left = 119
      Top = 319
      Width = 140
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'goodsstatus'
    end
    object nvedttransitfee: TNovaEdit
      Left = 397
      Top = 193
      Width = 150
      Height = 22
      MaxLength = 7
      TabOrder = 16
      Text = '0'
      OnChange = nvedtshippriceChange
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
    object nvedtservicefee: TNovaEdit
      Left = 396
      Top = 223
      Width = 150
      Height = 22
      MaxLength = 7
      TabOrder = 17
      Text = '0'
      OnChange = nvedtshippriceChange
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
    object nveditpackname: TNovaEdit
      Left = 119
      Top = 125
      Width = 140
      Height = 22
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
    object nvcbbshiptype: TNovaComboBox
      Left = 396
      Top = 85
      Width = 140
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      MaxLength = 12
      TabOrder = 13
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
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'shiptype'
    end
    object nvcbbpaymethod: TNovaComboBox
      Left = 396
      Top = 120
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      MaxLength = 12
      TabOrder = 14
      OnChange = nvcbbpaymethodChange
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
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'paymethod'
    end
    object nvedtpackno: TNovaEdit
      Left = 120
      Top = 85
      Width = 140
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
  end
  inherited ImageList: TImageList
    Left = 16
    Top = 8
  end
  object jcdspacksave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savePackWarehousing'
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
        Name = 'pack.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.pieces'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sendstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.tostationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packed'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.goodsstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.location'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consigneephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consigneeaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.shiptype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.paymethod'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.goodtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.invoiceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.entrypacker'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.weight'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.volume'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.shipprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.handfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insurancefee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insurance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.transitfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.deliveryfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.servicefee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.otherfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.custodial'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.unloadfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.totalfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insuredamount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sender'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.senderphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.senderaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.valuables'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.remak'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.signby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.zhuanyuntostationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.signtime'
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
      end
      item
        DataType = ftInteger
        Name = 'packid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packarriver.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.packarriverno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.arriverdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.sendstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.servicefee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.packfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.packprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.transitstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.receiver'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.consigneephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.pieces'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.packed'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.location'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.recyclestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.createtime'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 264
    Top = 392
  end
  object jcdsdistance: TjsonClientDataSet
    DataSourceName = 'parametermap'
    SaveAddress = 'pack/queryDistance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_r!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!stationid'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'distance'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 608
    Top = 56
    object WideStringField3: TWideStringField
      FieldName = 'showvalue'
      Size = 100
    end
    object WideStringField4: TWideStringField
      FieldName = 'code'
    end
  end
  object jcdsquerypackfee: TjsonClientDataSet
    DataSourceName = 'parametermap'
    QueryAddress = 'pack/queryPackfee'
    SaveAddress = 'pack/queryPackfee'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'distance'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'weight'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pieces'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'shipprice'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 608
    Top = 104
    object wdstrngfldResultshowvalue: TWideStringField
      FieldName = 'showvalue'
      Size = 100
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
    end
  end
  object jcdsupdateBillinuse: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/updateBillinuse'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'billinusestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinusenextno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billtypecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinusenextform'
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
    Left = 180
    Top = 552
  end
  object jcdspacktypesave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savenewpacktype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'newPackType'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 40
    Top = 256
  end
end
