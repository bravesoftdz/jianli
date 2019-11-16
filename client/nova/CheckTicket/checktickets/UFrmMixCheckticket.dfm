inherited FrmMixCheckticket: TFrmMixCheckticket
  ActiveControl = NovaEdtTicketNo
  Caption = #28151#26816#25805#20316
  ClientHeight = 594
  ClientWidth = 952
  KeyPreview = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 958
  ExplicitHeight = 622
  PixelsPerInch = 96
  TextHeight = 14
  object Label22: TLabel [0]
    Left = 33
    Top = 362
    Width = 42
    Height = 14
    Caption = #20056#36710#24211
  end
  object Label23: TLabel [1]
    Left = 95
    Top = 356
    Width = 127
    Height = 21
    Alignment = taCenter
    AutoSize = False
    Caption = '1'
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -21
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlEditBox: TPanel
    Width = 952
    Height = 589
    ExplicitWidth = 952
    ExplicitHeight = 589
    inherited Bevel1: TBevel
      Top = 596
      Width = 918
      Visible = False
      ExplicitTop = 450
      ExplicitWidth = 675
    end
    object Label3: TLabel
      Left = 210
      Top = 22
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object Label4: TLabel
      Left = 369
      Top = 22
      Width = 42
      Height = 14
      Caption = #24231#20301#21495
    end
    object Label5: TLabel
      Left = 498
      Top = 22
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object Label10: TLabel
      Left = 28
      Top = 22
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object LabInfo: TLabel
      Left = 173
      Top = 74
      Width = 9
      Height = 16
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label29: TLabel
      Left = 31
      Top = 74
      Width = 136
      Height = 16
      Caption = #24050#28151#26816#20449#24687#25552#31034#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label28: TLabel
      Left = 484
      Top = 54
      Width = 42
      Height = 14
      Caption = #35777#20214#21495
      Visible = False
    end
    object GroupBox2: TGroupBox
      Tag = 99
      Left = 25
      Top = 110
      Width = 249
      Height = 472
      Caption = #21407#22987#36710#31080#20449#24687
      Color = clBtnHighlight
      ParentBackground = False
      ParentColor = False
      TabOrder = 7
      object Shape1: TShape
        Left = 11
        Top = 32
        Width = 220
        Height = 410
      end
      object Label2: TLabel
        Left = 40
        Top = 93
        Width = 28
        Height = 14
        Caption = #21040#31449
        Transparent = True
      end
      object LabcurTostation: TLabel
        Left = 95
        Top = 91
        Width = 123
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = #24191#24030#30465#31449
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object LabcurSeatnum: TLabel
        Left = 95
        Top = 232
        Width = 127
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = '45'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 40
        Top = 266
        Width = 28
        Height = 14
        Caption = #31080#20215
        Transparent = True
      end
      object LabcurPrice: TLabel
        Left = 95
        Top = 264
        Width = 130
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = '120.00'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 26
        Top = 129
        Width = 56
        Height = 14
        Caption = #20056#36710#26085#26399
      end
      object LabcurDepartdate: TLabel
        Left = 99
        Top = 129
        Width = 123
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = '2010'#24180'12'#26376'12'#26085
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel7: TBevel
        Left = 11
        Top = 285
        Width = 220
        Height = 5
        Shape = bsBottomLine
      end
      object Bevel10: TBevel
        Left = 91
        Top = 33
        Width = 3
        Height = 409
      end
      object Label21: TLabel
        Left = 40
        Top = 167
        Width = 28
        Height = 14
        Caption = #29677#27425
      end
      object LabcurCode: TLabel
        Left = 95
        Top = 165
        Width = 123
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = '89877'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label27: TLabel
        Left = 24
        Top = 200
        Width = 56
        Height = 14
        Caption = #21457#36710#26102#38388
      end
      object LabcurDeparttime: TLabel
        Left = 95
        Top = 198
        Width = 123
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = '12:45'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 40
        Top = 233
        Width = 28
        Height = 14
        Caption = #24231#21495
      end
      object bvl3: TBevel
        Left = 11
        Top = 149
        Width = 220
        Height = 7
        Shape = bsBottomLine
      end
      object bvl4: TBevel
        Left = 11
        Top = 181
        Width = 220
        Height = 9
        Shape = bsBottomLine
      end
      object bvl11: TBevel
        Left = 11
        Top = 222
        Width = 220
        Height = 3
        Shape = bsBottomLine
      end
      object bvl12: TBevel
        Left = 12
        Top = 253
        Width = 220
        Height = 3
        Shape = bsBottomLine
      end
      object Label12: TLabel
        Left = 33
        Top = 331
        Width = 42
        Height = 14
        Caption = #26816#31080#21475
      end
      object Label13: TLabel
        Left = 35
        Top = 362
        Width = 42
        Height = 14
        Caption = #20056#36710#24211
      end
      object LabcurEntrance: TLabel
        Left = 95
        Top = 326
        Width = 127
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Caption = '2'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -20
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl14: TBevel
        Left = 11
        Top = 318
        Width = 220
        Height = 3
        Shape = bsBottomLine
      end
      object bvl15: TBevel
        Left = 12
        Top = 348
        Width = 219
        Height = 3
        Shape = bsBottomLine
      end
      object LabcurBuspark: TLabel
        Left = 95
        Top = 356
        Width = 127
        Height = 21
        Alignment = taCenter
        AutoSize = False
        Caption = '1'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -21
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LabcurTicketStatus: TLabel
        Left = 95
        Top = 297
        Width = 127
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = #27491#24120
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 40
        Top = 299
        Width = 28
        Height = 14
        Caption = #29366#24577
      end
      object LabcurFromStation: TLabel
        Left = 95
        Top = 48
        Width = 130
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = #24464#22346#23458#36816#31449
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label19: TLabel
        Left = 35
        Top = 56
        Width = 42
        Height = 14
        Caption = #20056#36710#31449
        Transparent = True
      end
      object bvl16: TBevel
        Left = 13
        Top = 76
        Width = 218
        Height = 5
        Shape = bsBottomLine
      end
      object bvl17: TBevel
        Left = 11
        Top = 112
        Width = 220
        Height = 5
        Shape = bsBottomLine
      end
      object Label24: TLabel
        Left = 33
        Top = 392
        Width = 42
        Height = 14
        Caption = #21806#31080#21592
      end
      object LabSaler: TLabel
        Left = 97
        Top = 388
        Width = 127
        Height = 21
        Alignment = taCenter
        AutoSize = False
        Caption = #24352#19977
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl19: TBevel
        Left = 12
        Top = 380
        Width = 219
        Height = 3
        Shape = bsBottomLine
      end
      object bvl20: TBevel
        Left = 12
        Top = 411
        Width = 219
        Height = 3
        Shape = bsBottomLine
      end
      object Label25: TLabel
        Left = 24
        Top = 421
        Width = 56
        Height = 14
        Caption = #21806#31080#26102#38388
      end
      object LabSalertime: TLabel
        Left = 97
        Top = 420
        Width = 127
        Height = 17
        AutoSize = False
        Caption = #24352#19977
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox7: TGroupBox
      Tag = 99
      Left = 292
      Top = 110
      Width = 636
      Height = 474
      Caption = #26816#20837#29677#27425#20449#24687
      Color = clBtnHighlight
      ParentColor = False
      TabOrder = 8
      object pnl1: TPanel
        Left = 2
        Top = 16
        Width = 632
        Height = 122
        Align = alTop
        TabOrder = 0
        object shp1: TShape
          Left = 25
          Top = 47
          Width = 576
          Height = 62
        end
        object LabmFromStation: TLabel
          Left = 46
          Top = 18
          Width = 70
          Height = 14
          Caption = #31119#30000#23458#36816#31449
          Transparent = True
        end
        object Label9: TLabel
          Left = 153
          Top = 20
          Width = 14
          Height = 14
          Caption = #33267
          Transparent = True
        end
        object LabmEndStation: TLabel
          Left = 184
          Top = 17
          Width = 68
          Height = 16
          Caption = #24191#24030#30465#31449
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object bvl1: TBevel
          Left = 36
          Top = 33
          Width = 104
          Height = 5
          Shape = bsBottomLine
        end
        object bvl2: TBevel
          Left = 178
          Top = 32
          Width = 114
          Height = 5
          Shape = bsBottomLine
        end
        object LabSeatnum: TLabel
          Left = 428
          Top = 84
          Width = 24
          Height = 21
          Caption = '45'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -21
          Font.Name = #26032#23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label18: TLabel
          Left = 487
          Top = 56
          Width = 28
          Height = 14
          Caption = #24050#21806
          Transparent = True
        end
        object LabSolds: TLabel
          Left = 496
          Top = 80
          Width = 13
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -24
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label26: TLabel
          Left = 56
          Top = 56
          Width = 56
          Height = 14
          Caption = #21457#36710#26085#26399
        end
        object LabOnDepartdate: TLabel
          Left = 42
          Top = 86
          Width = 98
          Height = 14
          Caption = '2010'#24180'12'#26376'12'#26085
        end
        object bvl5: TBevel
          Left = 25
          Top = 76
          Width = 576
          Height = 4
          Shape = bsBottomLine
        end
        object bvl6: TBevel
          Left = 151
          Top = 48
          Width = 2
          Height = 60
        end
        object bvl7: TBevel
          Left = 239
          Top = 48
          Width = 2
          Height = 60
        end
        object bvl8: TBevel
          Left = 471
          Top = 48
          Width = 2
          Height = 60
        end
        object bvl9: TBevel
          Left = 399
          Top = 47
          Width = 2
          Height = 60
        end
        object Label38: TLabel
          Left = 182
          Top = 56
          Width = 28
          Height = 14
          Caption = #29677#27425
        end
        object LabCode: TLabel
          Left = 178
          Top = 85
          Width = 35
          Height = 14
          Caption = '89877'
        end
        object Label15: TLabel
          Left = 416
          Top = 56
          Width = 42
          Height = 14
          Caption = #24231#20301#25968
        end
        object Label7: TLabel
          Left = 337
          Top = 56
          Width = 56
          Height = 14
          Caption = #25253#21040#36710#36742
        end
        object LabVehicleNo: TLabel
          Left = 327
          Top = 85
          Width = 77
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Caption = #31908'B55555'
        end
        object Label8: TLabel
          Left = 247
          Top = 56
          Width = 56
          Height = 14
          Caption = #21457#36710#26102#38388
        end
        object LabDepartTime: TLabel
          Left = 259
          Top = 85
          Width = 35
          Height = 14
          Caption = '12:45'
        end
        object bvl10: TBevel
          Left = 319
          Top = 49
          Width = 2
          Height = 60
        end
        object bvl13: TBevel
          Left = 534
          Top = 48
          Width = 2
          Height = 60
        end
        object Label14: TLabel
          Left = 554
          Top = 56
          Width = 28
          Height = 14
          Caption = #24050#26816
          Transparent = True
        end
        object LabCheckeds: TLabel
          Left = 542
          Top = 80
          Width = 13
          Height = 24
          Alignment = taCenter
          Caption = '2'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -24
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label17: TLabel
          Left = 416
          Top = 18
          Width = 28
          Height = 14
          Caption = #26816#21040
        end
        object LabNewSeatno: TLabel
          Left = 456
          Top = 12
          Width = 13
          Height = 24
          Alignment = taCenter
          Caption = '2'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -24
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label20: TLabel
          Left = 503
          Top = 18
          Width = 42
          Height = 14
          Caption = #21495#24231#20301
        end
        object bvl18: TBevel
          Left = 450
          Top = 36
          Width = 47
          Height = 5
          Shape = bsBottomLine
        end
      end
      object pnlseatplan: TPanel
        Left = 2
        Top = 138
        Width = 632
        Height = 334
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitHeight = 362
      end
    end
    object NovaEdtTicketNo: TNovaEdit
      Left = 534
      Top = 18
      Width = 146
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 3
      OnChange = NovaEdtTicketNoChange
      OnKeyPress = NovaEdtTicketNoKeyPress
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
    object btnMixCheck: TBitBtn
      Left = 699
      Top = 15
      Width = 83
      Height = 28
      Caption = '&S '#26816#31080
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 5
      OnClick = btnMixCheckClick
    end
    object BitBtn2: TBitBtn
      Left = 812
      Top = 15
      Width = 83
      Height = 28
      Caption = '&Q '#20851#38381
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = BitBtn2Click
    end
    object dtpDepartdate: TDateTimePicker
      Left = 91
      Top = 18
      Width = 110
      Height = 22
      Date = 40829.815839120370000000
      Time = 40829.815839120370000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
      OnChange = dtpDepartdateChange
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 245
      Top = 18
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          Title.Caption = #29677#27425#21495
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'departtime'
          Title.Caption = #21457#36710#26102#38388
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleplanHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQD_t!departdate'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object NovaEdtSeatno: TNovaEdit
      Left = 417
      Top = 18
      Width = 75
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 3
      TabOrder = 2
      OnExit = NovaEdtSeatnoExit
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
    object edtcertificateno: TNovaEdit
      Left = 534
      Top = 50
      Width = 146
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 4
      Visible = False
      OnKeyPress = NovaEdtTicketNoKeyPress
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
    Top = 589
    Width = 952
    Height = 5
    Visible = False
    ExplicitTop = 589
    ExplicitWidth = 952
    ExplicitHeight = 5
    inherited bbtnSave: TBitBtn
      Left = 182
      Top = 6
      ExplicitLeft = 182
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 399
      Top = 6
      ExplicitLeft = 399
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 368
    Top = 304
  end
  object jcsdQryTicket: TjsonClientDataSet
    DataSourceName = 'ticketlist'
    QueryAddress = 'checkticket/qryTicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'certificateno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 456
    Top = 296
  end
  object jcsdMixCheckticket: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/mixCheckticket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'newseatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketentrance'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 552
    Top = 297
  end
  object jscdQrySeatstatus: TjsonClientDataSet
    DataSourceName = 'seatstatuslist'
    QueryAddress = 'checkticket/qrySeatstatus'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 536
    Top = 216
  end
  object jscdQryMixInfo: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/queryMixInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 384
    Top = 232
  end
  object jsCdqrycheckticketeds: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/qrycheckticketeds'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'checktickets'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 728
    Top = 248
  end
  object jcdsQryScheduleSeatstatus: TjsonClientDataSet
    DataSourceName = 'scheduleseatlist'
    QueryAddress = 'ticketprice/qryScheduleseatinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplan.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 376
    Top = 48
  end
end
