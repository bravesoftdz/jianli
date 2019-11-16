inherited frmDriverEdit: TfrmDriverEdit
  Caption = #39550#39542#21592#26723#26696#20449#24687
  ClientHeight = 649
  ClientWidth = 784
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 790
  ExplicitHeight = 681
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 784
    Height = 611
    TabStop = True
    ExplicitWidth = 784
    ExplicitHeight = 611
    inherited Bevel1: TBevel
      Left = 0
      Top = 593
      Width = 784
      ExplicitLeft = 0
      ExplicitTop = 569
      ExplicitWidth = 726
    end
    object grp1: TGroupBox
      Left = 26
      Top = 16
      Width = 294
      Height = 561
      Caption = #22522#26412#20449#24687
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 0
      TabStop = True
      object lbl1: TLabel
        Left = 62
        Top = 25
        Width = 28
        Height = 14
        Caption = #22995#21517
      end
      object lbl2: TLabel
        Left = 61
        Top = 79
        Width = 28
        Height = 14
        Caption = #24037#21495
      end
      object lbl3: TLabel
        Left = 47
        Top = 112
        Width = 42
        Height = 14
        Caption = 'IC'#21345#21495
      end
      object lbl4: TLabel
        Left = 33
        Top = 278
        Width = 56
        Height = 14
        Caption = #20986#29983#26085#26399
      end
      object lbl5: TLabel
        Left = 33
        Top = 315
        Width = 56
        Height = 14
        Caption = #25919#27835#38754#35980
      end
      object lbl6: TLabel
        Left = 33
        Top = 351
        Width = 56
        Height = 14
        Caption = #25991#21270#31243#24230
      end
      object lbl7: TLabel
        Left = 56
        Top = 174
        Width = 28
        Height = 14
        Caption = #24615#21035
      end
      object lbl8: TLabel
        Left = 60
        Top = 389
        Width = 28
        Height = 14
        Caption = #31821#36143
      end
      object lbl9: TLabel
        Left = 33
        Top = 427
        Width = 56
        Height = 14
        Caption = #25307#32771#26085#26399
      end
      object lbl12: TLabel
        Left = 33
        Top = 499
        Width = 56
        Height = 14
        Caption = #32852#31995#30005#35805
      end
      object lbl13: TLabel
        Left = 34
        Top = 531
        Width = 56
        Height = 14
        Caption = #23478#24237#20303#22336
      end
      object lbl14: TLabel
        Left = 33
        Top = 241
        Width = 56
        Height = 14
        Caption = #36523#20221#35777#21495
      end
      object lbl10: TLabel
        Left = 32
        Top = 464
        Width = 56
        Height = 14
        Caption = #31227#21160#30005#35805
      end
      object lblSalary: TLabel
        Left = 62
        Top = 202
        Width = 28
        Height = 14
        Caption = #24037#36164
      end
      object lbl11: TLabel
        Left = 222
        Top = 27
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
        Left = 222
        Top = 77
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
        Left = 266
        Top = 240
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
      object lbl29: TLabel
        Left = 46
        Top = 147
        Width = 42
        Height = 14
        Caption = #26723#26696#21495
      end
      object Label1: TLabel
        Left = 60
        Top = 51
        Width = 28
        Height = 14
        Caption = #31616#25340
      end
      object nvedtName: TNovaEdit
        Left = 95
        Top = 21
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
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
      object nvedtCode: TNovaEdit
        Left = 95
        Top = 76
        Width = 121
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
      object nvedtCarNO: TNovaEdit
        Left = 95
        Top = 107
        Width = 164
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 18
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
        Left = 95
        Top = 237
        Width = 165
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 18
        TabOrder = 7
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
        Left = 95
        Top = 493
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 12
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
      object nvedtAdress: TNovaEdit
        Left = 95
        Top = 527
        Width = 191
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 25
        TabOrder = 15
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
        Left = 95
        Top = 348
        Width = 97
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
        HelpOptions.TableName = 'employee'
        HelpOptions.Columnname = 'education'
      end
      object dtpBirthdate: TDateTimePicker
        Left = 95
        Top = 273
        Width = 96
        Height = 23
        Date = 18264.000000000000000000
        Time = 18264.000000000000000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 8
      end
      object dtpRecruitmentdate: TDateTimePicker
        Left = 95
        Top = 422
        Width = 97
        Height = 23
        Date = 40555.000000000000000000
        Time = 40555.000000000000000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 12
      end
      object nvcbbPoliticsstatus: TNovaComboBox
        Left = 95
        Top = 311
        Width = 96
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
        HelpOptions.TableName = 'driver'
        HelpOptions.Columnname = 'politicsstatus'
      end
      object nvedtMovePhone: TNovaEdit
        Left = 95
        Top = 460
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 12
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
      object nvedtSalary: TNovaEdit
        Left = 95
        Top = 200
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 8
        TabOrder = 6
        Text = '0'
        ValueTrim = '0'
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
        Left = 95
        Top = 384
        Width = 182
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 18
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
      object rbMan: TRadioButton
        Left = 97
        Top = 173
        Width = 35
        Height = 18
        Caption = #30007
        TabOrder = 4
      end
      object rbGrile: TRadioButton
        Left = 159
        Top = 174
        Width = 33
        Height = 17
        Caption = #22899
        TabOrder = 5
      end
      object nvedtArchivenos: TNovaEdit
        Left = 95
        Top = 144
        Width = 165
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
      object nvedtJianpin: TNovaEdit
        Left = 96
        Top = 48
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
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
    end
    object grp2: TGroupBox
      Left = 331
      Top = 255
      Width = 422
      Height = 320
      Caption = #26377#25928#35777#20214#20449#24687
      TabOrder = 3
      object lbl15: TLabel
        Left = 55
        Top = 218
        Width = 56
        Height = 14
        Caption = #39550#39542#35777#21495
      end
      object lbl16: TLabel
        Left = 28
        Top = 252
        Width = 84
        Height = 14
        Caption = #26377#25928#36215#22987#26085#26399
      end
      object lbl17: TLabel
        Left = 242
        Top = 252
        Width = 56
        Height = 14
        Caption = #25130#27490#26085#26399
      end
      object lbl18: TLabel
        Left = 27
        Top = 150
        Width = 84
        Height = 14
        Caption = #20174#19994#36164#26684#35777#21495
      end
      object lblworkenddate: TLabel
        Left = 242
        Top = 117
        Width = 56
        Height = 14
        Caption = #25130#27490#26085#26399
      end
      object lbl20: TLabel
        Left = 13
        Top = 117
        Width = 98
        Height = 14
        Caption = #20934#39550#35777#21457#35777#26085#26399
      end
      object lblQualificationtype: TLabel
        Left = 55
        Top = 26
        Width = 56
        Height = 14
        Caption = #20934#39550#31867#22411
      end
      object lblWorkn: TLabel
        Left = 55
        Top = 82
        Width = 56
        Height = 14
        Caption = #20934#39550#35777#21495
      end
      object lbl23: TLabel
        Left = 55
        Top = 184
        Width = 56
        Height = 14
        Caption = #21457#35777#26085#26399
      end
      object lbl24: TLabel
        Left = 242
        Top = 185
        Width = 56
        Height = 14
        Caption = #25130#27490#26085#26399
      end
      object lbl25: TLabel
        Left = 16
        Top = 290
        Width = 126
        Height = 14
        Caption = #39550#39542#35777#21021#27425#39046#35777#26085#26399
      end
      object lbl30: TLabel
        Left = 242
        Top = 218
        Width = 56
        Height = 14
        Caption = #20934#39550#36710#22411
      end
      object Label10: TLabel
        Left = 53
        Top = 53
        Width = 56
        Height = 14
        Caption = #36816#33829#32447#36335
      end
      object dtpDriveingstart: TDateTimePicker
        Left = 118
        Top = 248
        Width = 108
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 8
      end
      object dtpDrivinglicensefirstdate: TDateTimePicker
        Left = 148
        Top = 285
        Width = 102
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 10
      end
      object dtpQualificationstartdate: TDateTimePicker
        Left = 118
        Top = 180
        Width = 108
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 5
      end
      object dtpDriveingend: TDateTimePicker
        Left = 304
        Top = 248
        Width = 102
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 9
      end
      object dtpWorkstartdate: TDateTimePicker
        Left = 118
        Top = 112
        Width = 108
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 2
      end
      object dtpQualificationenddate: TDateTimePicker
        Left = 304
        Top = 180
        Width = 102
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 6
      end
      object dtpWorkenddate: TDateTimePicker
        Left = 304
        Top = 112
        Width = 102
        Height = 22
        Date = 40392.483777488430000000
        Time = 40392.483777488430000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 3
      end
      object nvedtDrivinglicense: TNovaEdit
        Left = 118
        Top = 220
        Width = 108
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 30
        TabOrder = 7
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
      object nvedtQualification: TNovaEdit
        Left = 118
        Top = 146
        Width = 173
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
      object nvedtWorkNO: TNovaEdit
        Left = 118
        Top = 79
        Width = 172
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 30
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
      object nvcbbQualificationtype: TNovaComboBox
        Left = 118
        Top = 21
        Width = 139
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        HelpOptions.HDataSourceName = 'diclist'
        HelpOptions.HQueryAddress = 'system/querydictionary'
        HelpOptions.TableName = 'driver'
        HelpOptions.Columnname = 'qualificationtype'
      end
      object edtVehicletype: TNovaEdit
        Left = 304
        Top = 215
        Width = 102
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
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
      object NHelpRoute: TNovaHelp
        Left = 118
        Top = 51
        Width = 173
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
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
    end
    object grp3: TGroupBox
      Left = 331
      Top = 19
      Width = 231
      Height = 230
      Caption = #20854#20182#20449#24687
      TabOrder = 1
      object lblWorkstatus: TLabel
        Left = 4
        Top = 136
        Width = 70
        Height = 14
        Caption = #39550#39542#21592#29366#24577
      end
      object lbvehicleid: TLabel
        Left = 18
        Top = 100
        Width = 56
        Height = 14
        Caption = #24314#21046#36710#21495
      end
      object lblInitialkm: TLabel
        Left = 18
        Top = 173
        Width = 56
        Height = 14
        Caption = #21021#22987#37324#31243
      end
      object lblSubunit: TLabel
        Left = 18
        Top = 61
        Width = 56
        Height = 14
        Caption = #38582#23646#20998#38431
      end
      object lblUnit: TLabel
        Left = 18
        Top = 26
        Width = 56
        Height = 14
        Caption = #38582#23646#36710#38431
      end
      object lbl33: TLabel
        Left = 205
        Top = 27
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
      object lbl34: TLabel
        Left = 206
        Top = 137
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
      object nvcbbWorkstatus: TNovaComboBox
        Left = 80
        Top = 133
        Width = 121
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 2
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
        HelpOptions.TableName = 'driver'
        HelpOptions.Columnname = 'workstatus'
      end
      object nvedtInitialkm: TNovaEdit
        Left = 80
        Top = 169
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 15
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
      object nvedtSubunit: TNovaEdit
        Left = 80
        Top = 59
        Width = 121
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
      object chkResponsibility: TCheckBox
        Left = 116
        Top = 200
        Width = 94
        Height = 17
        Caption = #31614#23450#36131#20219#20070
        TabOrder = 4
      end
      object chkTemp: TCheckBox
        Left = 13
        Top = 202
        Width = 91
        Height = 17
        Caption = #26159#21542#20020#26102#24037
        TabOrder = 5
      end
      object nvhelpUnit: TNovaHelp
        Left = 78
        Top = 18
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
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
            Title.Caption = #21517#31216
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
        HelpOptions.HelpType = 'UnitHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlpVehicle: TNovaHelp
        Left = 80
        Top = 96
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 15
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #36710#29260#21495#30721
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'code'
            Title.Caption = 'IC'#21345#21495
            Width = 50
            Visible = True
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
        HelpOptions.HelpType = 'VehiclenoHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
    end
    object grpPicture: TGroupBox
      Left = 568
      Top = 19
      Width = 185
      Height = 230
      Caption = #30456#29255
      TabOrder = 2
      object btn2: TSpeedButton
        Left = 101
        Top = 196
        Width = 69
        Height = 26
        Caption = #28165#38500#22270#29255
        OnClick = btn2Click
      end
      object btn1: TSpeedButton
        Left = 8
        Top = 196
        Width = 69
        Height = 26
        Caption = #27983#35272
        OnClick = btn1Click
      end
      object pnl1: TPanel
        Left = 2
        Top = 16
        Width = 181
        Height = 174
        Align = alTop
        TabOrder = 0
        object imgImg_Picture1: TImage
          Left = 1
          Top = 1
          Width = 179
          Height = 172
          Hint = #20056#21153#21592#22836#20687
          Align = alClient
          ParentShowHint = False
          PopupMenu = pmpicture
          ShowHint = True
          OnDblClick = imgImg_Picture1DblClick
          ExplicitHeight = 168
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 611
    Width = 784
    Height = 38
    ExplicitTop = 611
    ExplicitWidth = 784
    ExplicitHeight = 38
    inherited bbtnSave: TBitBtn
      Left = 223
      Top = 3
      OnClick = bbtnSaveClick
      ExplicitLeft = 223
      ExplicitTop = 3
    end
    inherited bbtnClose: TBitBtn
      Left = 390
      Top = 3
      ExplicitLeft = 390
      ExplicitTop = 3
    end
  end
  inherited ImageList: TImageList
    Left = 24
    Top = 104
  end
  object jcdsSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/saveDriver'
    SaveAddress = 'archive/saveDriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'driver.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.archiveno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.birthday'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.drivinglicense'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.drivinglicenseenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.drivinglicensestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.drivinglicensefirstdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.education'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.familyaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.familyphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.idcard'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.initialkm'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.issignedresponsibility'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.istemporary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.mobilephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.nativeplace'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pictures'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.politicsstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.qualification'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.qualificationenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.qualificationstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.qualificationtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.recruitmentdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.salary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.sex'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.subunit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.workno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.workenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.workstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.workstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'driver.route.id'
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
        Name = 'driverid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'driver.qualifyvehicletype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver.jianpin'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 296
    Top = 512
  end
  object dlgOpenPicPictrue: TOpenPictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg'
    Left = 588
    Top = 48
  end
  object pmpicture: TPopupMenu
    Left = 648
    Top = 56
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
