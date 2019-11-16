inherited FrmVehicleEdit: TFrmVehicleEdit
  Left = 256
  Top = 199
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #36710#36742#20449#24687#35774#32622
  ClientHeight = 669
  ClientWidth = 931
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitTop = -75
  ExplicitWidth = 937
  ExplicitHeight = 697
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 931
    Height = 623
    ExplicitWidth = 931
    ExplicitHeight = 623
    inherited Bevel1: TBevel
      Left = 37
      Top = 633
      Width = 506
      ExplicitLeft = 37
      ExplicitTop = 670
      ExplicitWidth = 425
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 931
      Height = 623
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 64
        Top = 473
        Width = 28
        Height = 14
        Caption = #22791#27880
      end
      object btn1: TSpeedButton
        Left = 798
        Top = 377
        Width = 45
        Height = 22
        Caption = '...'
        OnClick = btn1Click
      end
      object btn2: TSpeedButton
        Left = 798
        Top = 405
        Width = 45
        Height = 22
        Caption = #28165#38500
        OnClick = btn2Click
      end
      object Label3: TLabel
        Left = 612
        Top = 345
        Width = 28
        Height = 14
        Caption = #22791#27880
      end
      object Label14: TLabel
        Left = 370
        Top = 345
        Width = 56
        Height = 14
        Caption = #26680#20934#32447#36335
      end
      object GroupBox1: TGroupBox
        Left = 364
        Top = 368
        Width = 424
        Height = 245
        Caption = #36710#36742#22270#29255
        TabOrder = 0
        object img_Picture: TImage
          Left = 2
          Top = 16
          Width = 420
          Height = 227
          Hint = #22312#24231#20301#22270#20013#26174#31034
          Align = alClient
          ParentShowHint = False
          ShowHint = True
          Stretch = True
          ExplicitTop = 17
        end
      end
      object GroupBox3: TGroupBox
        Left = 362
        Top = 21
        Width = 546
        Height = 313
        Caption = #20854#20182#20449#24687
        TabOrder = 1
        object lblcontractno: TLabel
          Left = 13
          Top = 23
          Width = 112
          Height = 14
          Caption = #31532#19977#32773#36131#20219#38505#32534#21495
        end
        object Label18: TLabel
          Left = 250
          Top = 23
          Width = 42
          Height = 14
          Caption = #26377#25928#26399
        end
        object Label19: TLabel
          Left = 407
          Top = 24
          Width = 14
          Height = 14
          Caption = #33267
        end
        object lblliabilityinsureno: TLabel
          Left = 14
          Top = 59
          Width = 70
          Height = 14
          Caption = #25215#36816#38505#32534#21495
        end
        object Label21: TLabel
          Left = 250
          Top = 54
          Width = 42
          Height = 14
          Caption = #26377#25928#26399
        end
        object Label23: TLabel
          Left = 14
          Top = 91
          Width = 70
          Height = 14
          Caption = #20132#24378#38505#32534#21495
        end
        object Label24: TLabel
          Left = 250
          Top = 90
          Width = 42
          Height = 14
          Caption = #26377#25928#26399
        end
        object Label27: TLabel
          Left = 250
          Top = 150
          Width = 42
          Height = 14
          Caption = #26377#25928#26399
        end
        object lblworkno: TLabel
          Left = 13
          Top = 148
          Width = 70
          Height = 14
          Caption = #33829#36816#35777#32534#21495
        end
        object Label22: TLabel
          Left = 407
          Top = 54
          Width = 14
          Height = 14
          Caption = #33267
        end
        object Label25: TLabel
          Left = 407
          Top = 88
          Width = 14
          Height = 14
          Caption = #33267
        end
        object lbl1: TLabel
          Left = 407
          Top = 119
          Width = 14
          Height = 14
          Caption = #33267
        end
        object lbl2: TLabel
          Left = 407
          Top = 151
          Width = 14
          Height = 14
          Caption = #33267
        end
        object Label6: TLabel
          Left = 39
          Top = 255
          Width = 42
          Height = 14
          Caption = #20445#35777#37329
        end
        object Label7: TLabel
          Left = 193
          Top = 255
          Width = 42
          Height = 14
          Caption = #20572#36710#36153
        end
        object Label8: TLabel
          Left = 39
          Top = 287
          Width = 42
          Height = 14
          Caption = #20363#26816#36153
        end
        object Label9: TLabel
          Left = 179
          Top = 287
          Width = 56
          Height = 14
          Caption = #20854#20182#36153#29992
        end
        object Label12: TLabel
          Left = 344
          Top = 255
          Width = 56
          Height = 14
          Caption = #36827#31449#21345#21495
        end
        object Label13: TLabel
          Left = 344
          Top = 285
          Width = 56
          Height = 14
          Caption = #20986#21378#26085#26399
        end
        object Label16: TLabel
          Left = 25
          Top = 119
          Width = 56
          Height = 14
          Caption = #34892#39542#35777#21495
        end
        object Label17: TLabel
          Left = 250
          Top = 119
          Width = 42
          Height = 14
          Caption = #26377#25928#26399
        end
        object Label20: TLabel
          Left = 13
          Top = 227
          Width = 70
          Height = 14
          Caption = #32447#36335#26631#24535#29260
        end
        object Label26: TLabel
          Left = 13
          Top = 198
          Width = 70
          Height = 14
          Caption = #20108#32500#26377#25928#26399
        end
        object Label28: TLabel
          Left = 288
          Top = 216
          Width = 112
          Height = 14
          Caption = #19979#27425#20108#32423#32500#25252#37324#31243
        end
        object Label29: TLabel
          Left = 501
          Top = 216
          Width = 28
          Height = 14
          Caption = #20844#37324
        end
        object Label31: TLabel
          Left = 13
          Top = 174
          Width = 70
          Height = 14
          Caption = #20108#32500#35777#20214#21495
        end
        object edtcontractno: TNovaEdit
          Left = 128
          Top = 21
          Width = 112
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 0
          OnChange = edtcontractnoChange
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
        object dtpcontractstartdate: TDateTimePicker
          Left = 298
          Top = 18
          Width = 100
          Height = 21
          Date = 40586.000000000000000000
          Time = 40586.000000000000000000
          Checked = False
          DoubleBuffered = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          ParentDoubleBuffered = False
          TabOrder = 1
        end
        object dtpcontractenddate: TDateTimePicker
          Left = 429
          Top = 19
          Width = 100
          Height = 21
          Date = 40586.999988425930000000
          Time = 40586.999988425930000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 2
        end
        object dtpliabilityinsurestartdate: TDateTimePicker
          Left = 298
          Top = 53
          Width = 100
          Height = 21
          Date = 40570.000000000000000000
          Time = 40570.000000000000000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 4
        end
        object dtpcompulsoryinsureenddate: TDateTimePicker
          Left = 429
          Top = 85
          Width = 100
          Height = 21
          Date = 40570.999988425930000000
          Time = 40570.999988425930000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 8
        end
        object edtliabilityinsureno: TNovaEdit
          Left = 89
          Top = 53
          Width = 151
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 3
          OnChange = edtliabilityinsurenoChange
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
        object dtpcompulsoryinsurestartdate: TDateTimePicker
          Left = 298
          Top = 86
          Width = 100
          Height = 21
          Date = 40570.000000000000000000
          Time = 40570.000000000000000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 7
        end
        object dtpliabilityinsureenddate: TDateTimePicker
          Left = 429
          Top = 51
          Width = 100
          Height = 21
          Date = 40570.999988425930000000
          Time = 40570.999988425930000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 5
        end
        object edtcompulsoryinsureno: TNovaEdit
          Left = 89
          Top = 86
          Width = 151
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 6
          OnChange = edtcompulsoryinsurenoChange
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
        object NovaEdtroadno: TNovaEdit
          Left = 89
          Top = 222
          Width = 150
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 11
          OnChange = NovaEdtroadnoChange
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
        object dtpworkstartdate: TDateTimePicker
          Left = 298
          Top = 146
          Width = 100
          Height = 21
          Date = 40570.000000000000000000
          Time = 40570.000000000000000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 12
        end
        object dtplicenseenddate: TDateTimePicker
          Left = 429
          Top = 115
          Width = 100
          Height = 21
          Date = 40570.999988425930000000
          Time = 40570.999988425930000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 10
        end
        object dtplicensestartdate: TDateTimePicker
          Left = 298
          Top = 114
          Width = 100
          Height = 21
          Date = 40570.000000000000000000
          Time = 40570.000000000000000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 9
        end
        object dtpworkenddate: TDateTimePicker
          Left = 429
          Top = 147
          Width = 100
          Height = 21
          Date = 40586.999988425930000000
          Time = 40586.999988425930000000
          Checked = False
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 13
        end
        object NovaEdtmargin: TNovaEdit
          Left = 90
          Top = 250
          Width = 75
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 8
          TabOrder = 14
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
        object NovaEdtstopfee: TNovaEdit
          Left = 239
          Top = 250
          Width = 83
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 8
          TabOrder = 15
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
        object NovaEdtcheckfee: TNovaEdit
          Left = 89
          Top = 282
          Width = 76
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 8
          TabOrder = 16
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
        object NovaEdtotherfee: TNovaEdit
          Left = 239
          Top = 282
          Width = 83
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 8
          TabOrder = 17
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
        object NovaEdtEnterNo: TNovaEdit
          Left = 405
          Top = 250
          Width = 124
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 10
          TabOrder = 18
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
        object dtpMakeDate: TDateTimePicker
          Left = 405
          Top = 283
          Width = 122
          Height = 21
          Date = 40570.000000000000000000
          Time = 40570.000000000000000000
          ShowCheckbox = True
          Checked = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 19
        end
        object NovaEdtdriverlicense: TNovaEdit
          Left = 89
          Top = 114
          Width = 151
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 20
          OnChange = NovaEdtdriverlicenseChange
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
        object edtworkno: TNovaEdit
          Left = 90
          Top = 141
          Width = 151
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 21
          OnChange = edtworknoChange
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
        object Dpmaintainvaliddate: TDateTimePicker
          Left = 89
          Top = 195
          Width = 151
          Height = 21
          Date = 40570.000000000000000000
          Time = 40570.000000000000000000
          ShowCheckbox = True
          Checked = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 22
        end
        object NEdtNextmaintaindistance: TNovaEdit
          Left = 405
          Top = 213
          Width = 90
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 8
          TabOrder = 23
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
        object Cbxisneed: TCheckBox
          Left = 298
          Top = 186
          Width = 149
          Height = 17
          Caption = #38656#35201#39550#39542#21592#25165#33021#25253#29677
          TabOrder = 24
        end
        object edttwono: TNovaEdit
          Left = 89
          Top = 168
          Width = 151
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 30
          TabOrder = 25
          OnChange = edtworknoChange
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
      object grpremarks: TGroupBox
        Left = 125
        Top = 463
        Width = 125
        Height = 41
        Caption = #22791#27880
        TabOrder = 2
      end
      object mmoremarks: TMemo
        Left = 648
        Top = 340
        Width = 260
        Height = 24
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 3
      end
      object NovaEdtAuditroute: TNovaEdit
        Left = 433
        Top = 341
        Width = 169
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    end
    object GroupBox4: TGroupBox
      Left = 22
      Top = 25
      Width = 316
      Height = 592
      Caption = #36710#36742#20449#24687
      TabOrder = 0
      object lblvehicleno: TLabel
        Left = 37
        Top = 33
        Width = 56
        Height = 14
        Caption = #36710#29260#21495#30721
      end
      object lbl3: TLabel
        Left = 257
        Top = 167
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 38
        Top = 64
        Width = 56
        Height = 14
        Caption = #19978#29260#26102#38388
      end
      object lblunitid: TLabel
        Left = 37
        Top = 96
        Width = 56
        Height = 14
        Caption = #25152#23646#21333#20301
      end
      object lblcardno: TLabel
        Left = 51
        Top = 235
        Width = 42
        Height = 14
        Caption = 'IC'#21345#21495
      end
      object lblrationseatnum: TLabel
        Left = 23
        Top = 358
        Width = 70
        Height = 14
        Caption = #26680#23450#24231#20301#25968
      end
      object lblseatnum: TLabel
        Left = 23
        Top = 389
        Width = 70
        Height = 14
        Caption = #20056#23458#24231#20301#25968
      end
      object lblloadamout: TLabel
        Left = 192
        Top = 418
        Width = 28
        Height = 14
        Caption = #36733#37325
      end
      object lbltype: TLabel
        Left = 37
        Top = 298
        Width = 56
        Height = 14
        Caption = #33829#36816#31867#22411
      end
      object lbl5: TLabel
        Left = 256
        Top = 98
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbl9: TLabel
        Left = 216
        Top = 359
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbl10: TLabel
        Left = 215
        Top = 391
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbl13: TLabel
        Left = 292
        Top = 417
        Width = 14
        Height = 14
        Caption = 'KG'
      end
      object lbl6: TLabel
        Left = 50
        Top = 266
        Width = 42
        Height = 14
        Caption = #26377#25928#26399
      end
      object Label4: TLabel
        Left = 38
        Top = 127
        Width = 56
        Height = 14
        Caption = #32467#31639#21333#20301
      end
      object Label5: TLabel
        Left = 257
        Top = 128
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 36
        Top = 329
        Width = 56
        Height = 14
        Caption = #36816#33829#32447#36335
      end
      object lbl8: TLabel
        Left = 37
        Top = 204
        Width = 56
        Height = 14
        Caption = #36710#36742#29366#24577
      end
      object lbl11: TLabel
        Left = 256
        Top = 205
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label15: TLabel
        Left = 256
        Top = 300
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lblcolor: TLabel
        Left = 38
        Top = 418
        Width = 56
        Height = 14
        Caption = #36710#29260#39068#33394
      end
      object lblcontactperson: TLabel
        Left = 50
        Top = 450
        Width = 42
        Height = 14
        Caption = #32852#31995#20154
      end
      object lblcontactphone: TLabel
        Left = 36
        Top = 479
        Width = 56
        Height = 14
        Caption = #32852#31995#30005#35805
      end
      object lbl4: TLabel
        Left = 173
        Top = 419
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lblgprs: TLabel
        Left = 51
        Top = 511
        Width = 42
        Height = 14
        Caption = 'gprs'#30721
      end
      object Label11: TLabel
        Left = 38
        Top = 165
        Width = 56
        Height = 14
        Caption = #21378#29260#22411#21495
      end
      object Label30: TLabel
        Left = 220
        Top = 35
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lbl7: TLabel
        Left = 38
        Top = 539
        Width = 56
        Height = 14
        Caption = #24231#20301#31867#22411
      end
      object lbl14: TLabel
        Left = 256
        Top = 541
        Width = 6
        Height = 12
        Caption = '*'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object dtpvehiclenotime: TDateTimePicker
        Left = 100
        Top = 61
        Width = 115
        Height = 22
        Date = 40783.636841724540000000
        Time = 40783.636841724540000000
        ShowCheckbox = True
        Checked = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 1
      end
      object chkTempVehicle: TCheckBox
        Left = 228
        Top = 63
        Width = 78
        Height = 17
        Caption = #20020#26102#36710
        TabOrder = 2
      end
      object edtcardno: TNovaEdit
        Left = 100
        Top = 231
        Width = 110
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 7
        OnChange = edtcardnoChange
        OnEnter = edtcardnoEnter
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
      object edtrationseatnum: TNovaEdit
        Left = 100
        Top = 354
        Width = 110
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 3
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
      object edtseatnum: TNovaEdit
        Left = 100
        Top = 386
        Width = 110
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 3
        ReadOnly = True
        TabOrder = 13
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
      object edtloadamout: TNovaEdit
        Left = 223
        Top = 414
        Width = 65
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
        TabOrder = 15
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
      object cbbType: TNovaComboBox
        Left = 100
        Top = 294
        Width = 150
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 10
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
        HelpOptions.TableName = 'vehicle'
        HelpOptions.Columnname = 'type'
      end
      object NovaHelpUnit: TNovaHelp
        Left = 100
        Top = 92
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #21333#20301#21517#31216
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'UnitHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object dtpCardValidate: TDateTimePicker
        Left = 100
        Top = 262
        Width = 125
        Height = 23
        Date = 40764.576852569430000000
        Time = 40764.576852569430000000
        ShowCheckbox = True
        Checked = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 9
      end
      object NovaHelpBalanceUnit: TNovaHelp
        Left = 100
        Top = 123
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
            Title.Caption = #21333#20301#21517#31216
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'UnitHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NHelpRoute: TNovaHelp
        Left = 100
        Top = 324
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Caption = #32447#36335#21517#31216
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'RouteHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object btnReadCard: TButton
        Left = 216
        Top = 231
        Width = 41
        Height = 21
        Caption = #28165#38500
        TabOrder = 8
        OnClick = btnReadCardClick
      end
      object cbbstatus: TNovaComboBox
        Left = 100
        Top = 201
        Width = 150
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 6
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
        HelpOptions.TableName = 'vehicle'
        HelpOptions.Columnname = 'status'
      end
      object edtcontactperson: TNovaEdit
        Left = 100
        Top = 445
        Width = 150
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 16
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
      object edtcontactphone: TNovaEdit
        Left = 100
        Top = 476
        Width = 150
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 17
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
      object edtgprs: TNovaEdit
        Left = 100
        Top = 507
        Width = 150
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 18
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
      object cbbcolor: TNovaComboBox
        Left = 100
        Top = 414
        Width = 67
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 14
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
        HelpOptions.TableName = 'vehicle'
        HelpOptions.Columnname = 'color'
      end
      object edtvehicleno: TNovaHelp
        Left = 99
        Top = 33
        Width = 115
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 0
        OnChange = edtvehiclenoChange
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
            Title.Caption = #31616#31216
            Width = 20
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #21517#31216
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'fullname'
            Title.Caption = #25152#23646#22320
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlpVehiclebrandmodel: TNovaHelp
        Left = 99
        Top = 162
        Width = 151
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        TabOrder = 5
        OnIdChange = nvhlpVehiclebrandmodelIdChange
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
            FieldName = 'NAME'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Caption = #21378#29260#22411#21495
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'rationseatnum'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            Title.Caption = #24231#20301#25968
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'code'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end>
        HelpOptions.HelpHeight = 150
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'VehiclebrandmodelHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object vehicleseattype: TNovaComboBox
        Left = 100
        Top = 535
        Width = 150
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 19
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
        HelpOptions.TableName = 'vehicle'
        HelpOptions.Columnname = 'seattype'
      end
      object chkisneedcheck: TCheckBox
        Left = 99
        Top = 564
        Width = 156
        Height = 17
        Caption = #38656#35777#20214#23457#26680#25165#33021#25253#29677
        Checked = True
        State = cbChecked
        TabOrder = 20
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 623
    Width = 931
    Height = 46
    ExplicitTop = 623
    ExplicitWidth = 931
    ExplicitHeight = 46
    inherited bbtnSave: TBitBtn
      Left = 311
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 311
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 520
      Top = 6
      ExplicitLeft = 520
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 368
    Top = 80
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 572
    Top = 304
  end
  object jsonCDSVehicleSave: TjsonClientDataSet
    DataSourceName = 'dataset'
    QueryAddress = 'base/savevehicle'
    SaveAddress = 'base/savevehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.createby'
        ParamType = ptInput
      end
      item
        DataType = ftOraTimeStamp
        Name = 'vehicle.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.color'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.grantdate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.rationseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.seatnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.loadamout'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.type'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contactperson'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contactphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.gprs'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contractno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.contractstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.contractenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.liabilityinsureno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.liabilityinsurestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.liabilityinsureenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.compulsoryinsureno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.compulsoryinsurestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.compulsoryinsureenddate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.licensestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.licenseenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.workno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.workstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.workenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'picture'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.islocaldelete'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'validdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.margin'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.stopfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.istempvehicle'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.makedate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.cardnoprintdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.checkfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.entercardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.auditroute'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.otherfee'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isneedfinger'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.vehiclenodate'
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
        Name = 'vehicleid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'vehicle.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.driverlicense'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.roadno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.maintainvaliddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.nextmaintaindistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.seattype'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isneedcheck'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.twodimensionno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 406
    Top = 360
  end
  object jcdsQryPic: TjsonClientDataSet
    DataSourceName = 'vehiclepic'
    QueryAddress = 'base/qryVehiclePic'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 320
  end
  object ilToolBar: TImageList
    Left = 512
    Top = 16
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A57B6B00A57B6B0000000000000000000000
      000000000000A57B6B00A57B6B0000000000000000008C8C9400CEADB5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00A57B6B00A57B6B00A57B
      6B00A57B6B00FFFFFF00FFFFFF000000000084A5B5004284DE006373AD00C6A5
      AD00CECECE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A57B6B00FFFFFF00FFCE9C00A57B6B00A57B
      6B00FFCE9C00FFFFFF00A57B6B000000000084BDE7004AADFF003984DE009484
      A500C6A5AD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFCEB500FFCEAD00FFCE
      AD00F7CEA500FFCEA500F7C6A500F7C69C00A57B6B00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A57B6B000000000000000000000000007BBDEF005ABDFF00427B
      DE006373AD00C6A5AD00CECECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFD6B500FFD6B500FFCE
      AD00FFCEAD00FFCEA500FFCEA500FFC6A500A57B6B00FFCE9C00FFCE9C00FFCE
      9C00A57B6B0000000000000000000000000000000000BDCED60084BDEF004AAD
      FF003984D60094849C00C6ADB500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C840094DEFF0094DEFF0094DE
      FF0094DEFF0094DEFF0094DEFF00A57B6B00FFCE9C00FFFFFF00A57B6B00FFFF
      FF00FFFFFF00A57B6B00A57B6B000000000000000000000000000000000084BD
      EF0052BDFF005A8CC6008C8C9400C6B5B500BD9C9400BDA59400CEAD9C00CEAD
      A500C6ADAD00CECED60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFDEC600FFDEBD00FFD6
      BD00FFD6B500FFCEB500A57B6B00FFCE9C00FFFFFF00A57B6B00A57B6B00A57B
      6B00FFFFFF00FFCE9C00A57B6B0000000000000000000000000000000000C6CE
      DE0084BDEF00ADBDCE009C949400CEA59400DEBDA500F7EFC600F7F7CE00EFE7
      C600DEC6B500BDADAD00CED6D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFDECE00FFDEC600FFDE
      C600FFDEBD00FFD6B500A57B6B00FFFFFF00A57B6B00F7CEAD0094524A000000
      0000A57B6B00FFFFFF00A57B6B00000000000000000000000000000000000000
      000000000000C6BDBD00CE9C8C00FFF7C600FFF7C600FFFFDE00FFFFE700FFFF
      F700FFFFFF00E7DED600B59C9400CED6DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C840094DEFF0094DEFF0094DE
      FF0094DEFF0094DEFF0094DEFF00A57B6B00A57B6B00F7CEAD0094524A000000
      000000000000A57B6B00A57B6B00000000000000000000000000000000000000
      000000000000CEADAD00DEBDA500FFEFB500FFEFBD00FFFFDE00FFFFE700FFFF
      FF00FFFFFF00FFFFDE00DEC6AD00D6D6DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFE7D60094DEFF0094DE
      FF0094DEFF0094DEFF0094DEFF0094DEFF00FFD6B500FFD6B50094524A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEA59C00FFF7C600FFDEAD00FFEFB500FFFFD600FFFFDE00FFFF
      EF00FFFFEF00FFFFD600F7EFC600D6CECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFEFD600FFE7D600FFE7
      CE00FFE7CE00FFDEC600FFDEC600FFDEBD00FFD6BD00FFD6B50094524A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEA59C00FFFFC600FFDEA500FFEFB500FFFFCE00FFFFD600FFFF
      E700FFFFDE00FFFFD600F7EFC600CECECE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFEFDE00FFEFDE00FFEF
      D600FFE7D600FFE7CE00FFE7CE00CE845200DE631000C64A08007B2900000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CEA59C00EFDEBD00FFEFCE00FFDEB500FFEFBD00FFF7BD00FFFF
      C600FFFFC600FFFFC600EFCEA500D6CED6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFEFE70094DEFF0094DE
      FF0094DEFF0094DEFF00FFE7CE00DE946300FF8C2100FFFFFF00B54A00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6ADAD00DEBDAD00FFFFFF00FFFFEF00FFE7B500FFE7B500FFEF
      B500FFE7B500FFEFBD00CEA58C00D6D6DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400FFF7EF00FFF7EF00FFEF
      E700FFEFDE00FFEFD600FFEFD600DEAD7B00FFB55A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6B5BD00EFE7DE00FFFFFF00FFF7C600FFF7BD00FFFF
      CE00FFE7BD00B58C8400C6BDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C69C8400E7E7E700E7E7E700DEDE
      DE00D6DED600CED6D600CECECE00DEAD7B00C6947B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B58C8C00CEAD9400FFEFC600FFEFC600EFCE
      A500CEA59400C6BDC600C6D6D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FE799FFF00000000FE0107FF00000000
      FE0107FF00000000000381FF00000000000781FF000000000001E00300000000
      0001E001000000000011F800000000000019F80000000000001FF80000000000
      001FF80000000000001FF80000000000001FF80000000000007FFC0100000000
      007FFE0100000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
