inherited FrmOutstationcheckEdt: TFrmOutstationcheckEdt
  Caption = 'FrmOutstationcheckEdt'
  ClientHeight = 580
  ClientWidth = 853
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 859
  ExplicitHeight = 608
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 853
    Height = 535
    ExplicitWidth = 853
    ExplicitHeight = 535
    inherited Bevel1: TBevel
      Top = 527
      Width = 819
      Height = 8
      ExplicitTop = 513
      ExplicitWidth = 780
      ExplicitHeight = 8
    end
    object GroupBox1: TGroupBox
      Left = 30
      Top = 23
      Width = 313
      Height = 452
      Caption = #33829#36816#29677#27425#20449#24687
      TabOrder = 0
      object Label1: TLabel
        Left = 19
        Top = 32
        Width = 56
        Height = 14
        Caption = #21457#36710#26085#26399
      end
      object Label2: TLabel
        Left = 19
        Top = 72
        Width = 56
        Height = 14
        Caption = #36710#29260#21495#30721
      end
      object Label3: TLabel
        Left = 19
        Top = 108
        Width = 56
        Height = 14
        Caption = #26680#23450#36733#23458
      end
      object Label4: TLabel
        Left = 19
        Top = 142
        Width = 56
        Height = 14
        Caption = #25152#23646#21333#20301
      end
      object Label5: TLabel
        Left = 19
        Top = 179
        Width = 56
        Height = 14
        Caption = #25253#21040#29677#27425
      end
      object Label6: TLabel
        Left = 19
        Top = 216
        Width = 56
        Height = 14
        Caption = #25253#21040#26102#38388
      end
      object Label7: TLabel
        Left = 19
        Top = 250
        Width = 56
        Height = 14
        Caption = #25171#21333#20154#25968
      end
      object Label8: TLabel
        Left = 19
        Top = 284
        Width = 56
        Height = 14
        Caption = #23454#38469#20154#25968
      end
      object Label9: TLabel
        Left = 173
        Top = 283
        Width = 56
        Height = 14
        Caption = #34917#24405#20154#25968
      end
      object Label10: TLabel
        Left = 159
        Top = 250
        Width = 70
        Height = 14
        Caption = #20854#20013#20813#31080#25968
      end
      object lbl1: TLabel
        Left = 33
        Top = 423
        Width = 42
        Height = 14
        Caption = #26816#26597#21592
      end
      object DpDepartdate: TDateTimePicker
        Left = 82
        Top = 28
        Width = 103
        Height = 22
        Date = 41816.584648067130000000
        Time = 41816.584648067130000000
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        TabOrder = 0
      end
      object DpOuttime: TDateTimePicker
        Left = 208
        Top = 28
        Width = 61
        Height = 22
        Date = 41816.585209409720000000
        Time = 41816.585209409720000000
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        Kind = dtkTime
        TabOrder = 1
      end
      object nvhelpvehicleno: TNovaHelp
        Left = 81
        Top = 67
        Width = 103
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 2
        OnIdChange = nvhelpvehiclenoIdChange
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
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'code'
            Title.Caption = #25253#21040#21345
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end>
        HelpOptions.HelpHeight = 260
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'VehiclenoHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object EdtSeats: TNovaEdit
        Left = 82
        Top = 103
        Width = 103
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
      object EdtUnitname: TNovaEdit
        Left = 81
        Top = 136
        Width = 215
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
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
      object EdtEndstationname: TNovaEdit
        Left = 81
        Top = 173
        Width = 215
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
      end
      object EdtReporttime: TNovaEdit
        Left = 81
        Top = 211
        Width = 215
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
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
      object EdtCARRYPEOPLE: TNovaEdit
        Left = 81
        Top = 245
        Width = 69
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
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
      object NovaEdtFACTPEOPLE: TNovaEdit
        Left = 81
        Top = 280
        Width = 69
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 8
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
      object NovaFILLPEOPLE: TNovaEdit
        Left = 234
        Top = 279
        Width = 62
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
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
      object Editchildnum: TNovaEdit
        Left = 234
        Top = 245
        Width = 62
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
      end
      object CheckBox1: TCheckBox
        Left = 81
        Top = 322
        Width = 58
        Height = 17
        Caption = #36229#21592
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 11
      end
      object CheckBox2: TCheckBox
        Left = 79
        Top = 391
        Width = 97
        Height = 17
        Caption = #35777#20214#40784#20840
        Checked = True
        State = cbChecked
        TabOrder = 12
      end
      object CheckBox3: TCheckBox
        Left = 79
        Top = 356
        Width = 121
        Height = 17
        Caption = #24050#31995#22909#23433#20840#24102
        Checked = True
        State = cbChecked
        TabOrder = 13
      end
      object EdtAddCardno: TEdit
        Left = 208
        Top = 67
        Width = 46
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        TabOrder = 14
        Visible = False
      end
      object edt1: TNovaEdit
        Left = 81
        Top = 418
        Width = 118
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
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
    end
    object GroupBox2: TGroupBox
      Left = 384
      Top = 19
      Width = 387
      Height = 127
      Caption = #33829#36816#36710#36742#26816#26597
      TabOrder = 1
      object Label11: TLabel
        Left = 21
        Top = 29
        Width = 42
        Height = 14
        Caption = #33829#36816#35777
      end
      object Label12: TLabel
        Left = 21
        Top = 63
        Width = 42
        Height = 14
        Caption = #34892#39542#35777
      end
      object Label14: TLabel
        Left = 173
        Top = 26
        Width = 42
        Height = 14
        Caption = #32447#36335#29260
      end
      object Label16: TLabel
        Left = 187
        Top = 62
        Width = 28
        Height = 14
        Caption = #20363#26816
      end
      object Label17: TLabel
        Left = 35
        Top = 97
        Width = 28
        Height = 14
        Caption = #20108#32500
      end
      object CobRUNNOCHK: TComboBox
        Left = 74
        Top = 24
        Width = 89
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 0
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobDRIVERLICENSECHK: TComboBox
        Left = 74
        Top = 59
        Width = 89
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 1
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobROADNOCHK: TComboBox
        Left = 224
        Top = 23
        Width = 89
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 2
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobMAINTAINCHK: TComboBox
        Left = 75
        Top = 93
        Width = 88
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 3
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobBUSCHECKCHK: TComboBox
        Left = 224
        Top = 55
        Width = 89
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 4
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
    end
    object GroupBox3: TGroupBox
      Left = 384
      Top = 160
      Width = 387
      Height = 369
      Caption = #39550#39542#21592#26816#26597
      TabOrder = 2
      object Label18: TLabel
        Left = 20
        Top = 27
        Width = 42
        Height = 14
        Caption = #27491#39550#39542
      end
      object Label19: TLabel
        Left = 27
        Top = 61
        Width = 42
        Height = 14
        Caption = #39550#39542#35777
      end
      object Label13: TLabel
        Left = 4
        Top = 93
        Width = 70
        Height = 14
        Caption = #20174#19994#36164#26684#35777
      end
      object Label15: TLabel
        Left = 32
        Top = 129
        Width = 42
        Height = 14
        Caption = #20934#39550#35777
      end
      object Label20: TLabel
        Left = 25
        Top = 172
        Width = 42
        Height = 14
        Caption = #21103#39550#39542
      end
      object Label21: TLabel
        Left = 32
        Top = 203
        Width = 42
        Height = 14
        Caption = #39550#39542#35777
      end
      object Label22: TLabel
        Left = 4
        Top = 236
        Width = 70
        Height = 14
        Caption = #20174#19994#36164#26684#35777
      end
      object Label23: TLabel
        Left = 27
        Top = 270
        Width = 42
        Height = 14
        Caption = #20934#39550#35777
      end
      object lbl2: TLabel
        Left = 27
        Top = 305
        Width = 42
        Height = 14
        Caption = #39550#39542#21592
      end
      object lbl3: TLabel
        Left = 28
        Top = 337
        Width = 42
        Height = 14
        Caption = #20056#21153#21592
      end
      object CobDRIVINGLICENSE1CHK: TComboBox
        Left = 76
        Top = 54
        Width = 95
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 0
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobQUALIFICATION1CHK: TComboBox
        Left = 77
        Top = 88
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 1
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobWORKNO1CHK: TComboBox
        Left = 77
        Top = 123
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 2
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobDRIVINGLICENSE2CHK: TComboBox
        Left = 77
        Top = 198
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 3
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobQUALIFICATION2CHK: TComboBox
        Left = 77
        Top = 232
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 4
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object CobWORKNO2CHK: TComboBox
        Left = 77
        Top = 266
        Width = 93
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ItemIndex = 0
        TabOrder = 5
        Text = #21512#26684
        Items.Strings = (
          #21512#26684
          #19981#21512#26684)
      end
      object GroupBox4: TGroupBox
        Left = 193
        Top = 10
        Width = 170
        Height = 139
        Caption = #29031#29255
        TabOrder = 6
        object imgImg_Picture1: TImage
          Left = 2
          Top = 16
          Width = 166
          Height = 121
          Align = alClient
          Stretch = True
          ExplicitLeft = 8
          ExplicitTop = 40
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
      end
      object GroupBox5: TGroupBox
        Left = 194
        Top = 152
        Width = 170
        Height = 138
        Caption = #29031#29255
        TabOrder = 7
        object imgImg_Picture2: TImage
          Left = 2
          Top = 16
          Width = 166
          Height = 120
          Align = alClient
          Stretch = True
          ExplicitLeft = 8
          ExplicitTop = 40
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
      end
      object EdtDriver1: TNovaHelp
        Left = 76
        Top = 22
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 8
        OnEnter = EdtDriver1Enter
        OnExit = EdtDriver1Exit
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
            Title.Caption = #24037#21495
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 150
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object EdtDriver2: TNovaHelp
        Left = 77
        Top = 165
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 9
        OnEnter = EdtDriver2Enter
        OnExit = EdtDriver2Exit
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
            Title.Caption = #24037#21495
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 150
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlp1: TNovaHelp
        Left = 75
        Top = 302
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 10
        OnEnter = nvhlp1Enter
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
            Title.Caption = #24037#21495
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 150
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlpSteward: TNovaHelp
        Left = 76
        Top = 330
        Width = 94
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 11
        OnEnter = nvhlpStewardEnter
        OnExit = nvhlpStewardExit
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
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'code'
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 150
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'StewardHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
    end
    object zkfpngx1: TZKFPEngX
      Left = 580
      Top = 463
      Width = 24
      Height = 24
      OnCapture = zkfpngx1Capture
      ControlData = {
        5450463008545A4B4650456E6700044C656674020003546F7002000557696474
        6802180648656967687402180B456E726F6C6C436F756E7402030B53656E736F
        72496E6465780200095468726573686F6C64020A114F6E65546F4F6E65546872
        6573686F6C64020A10466F7263655365636F6E644D61746368080C4175746F49
        64656E74696679080D4973496D6167654368616E6765080000}
    end
    object GroupBox6: TGroupBox
      Left = 32
      Top = 465
      Width = 313
      Height = 56
      Caption = #25552#31034#20449#24687
      TabOrder = 4
      object mmoReportInfo: TMemo
        Left = 2
        Top = 16
        Width = 309
        Height = 38
        Align = alClient
        Color = clInfoBk
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#29579#30721#20116#31508#22411'86'#29256
        ParentCtl3D = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 535
    Width = 853
    ExplicitTop = 535
    ExplicitWidth = 853
    inherited bbtnSave: TBitBtn
      Left = 303
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 303
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 440
      Top = 6
      ExplicitLeft = 440
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 672
    Top = 352
  end
  object jscdQryDepartinvoices: TjsonClientDataSet
    DataSourceName = 'listmap'
    QueryAddress = 'checkticket/queryDepartinvoices'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 296
    Top = 112
  end
  object jcdsFindPicture: TjsonClientDataSet
    DataSourceName = 'pictureResult'
    QueryAddress = 'archive/finddriverPicture'
    SaveAddress = 'archive/finddriverPicture'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_d!id'
        ParamType = ptInput
        Value = 'employee'
      end>
    RemoteServer = DMPublic.jcon
    Left = 648
    Top = 120
  end
  object jscdsaveOutstationcheck: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/saveOutstationcheck'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ots.scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.reporttime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.outtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.seatnums'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.carrypeople'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.factpeople'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.fillpeople'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.runnochk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.driverlicensechk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.buscheckchk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.maintainchk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.roadnochk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.driver1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.drivinglicense1chk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.qualification1chk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.workno1chk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.driver2'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.drivinglicense2chk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.qualification2chk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.workno2chk'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.checker'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.remark'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ots.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'id'
        ParamType = ptOutput
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
    Left = 280
    Top = 328
  end
  object jscdqryVehicledriverreport: TjsonClientDataSet
    DataSourceName = 'listmap'
    QueryAddress = 'checkticket/qryVehicledriverreport'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 208
  end
  object jsnclntdtstSpcQry: TjsonClientDataSet
    DataSourceName = 'pictureResult'
    QueryAddress = 'archive/queryDriverFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 456
  end
  object jsncArrivalStationCheck: TjsonClientDataSet
    DataSourceName = 'arriverStationCheckList'
    QueryAddress = 'checkticket/queryArriverStationCheck'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 120
  end
  object jsonSpcQry: TjsonClientDataSet
    DataSourceName = 'pictureResult'
    QueryAddress = 'archive/queryDriverAndStewardFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 256
  end
  object jsnclQrydriverByDriverid: TjsonClientDataSet
    DataSourceName = 'drivermap'
    QueryAddress = 'archive/findDriverName'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'driverid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 568
    Top = 112
  end
  object jsncQryStewardName: TjsonClientDataSet
    DataSourceName = 'stewardmap'
    QueryAddress = 'archive/findStewardName'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'stewardid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 760
    Top = 464
  end
  object jsncQryStwed: TjsonClientDataSet
    DataSourceName = 'stewardpicture'
    QueryAddress = 'archive/queryStewardFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 584
    Top = 496
  end
end
