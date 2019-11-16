inherited FrmPackacceptAdd: TFrmPackacceptAdd
  Caption = #34892#21253#21463#29702
  ClientHeight = 591
  ClientWidth = 844
  Font.Charset = ANSI_CHARSET
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 850
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 269
    Height = 472
    Align = alNone
    ExplicitWidth = 269
    ExplicitHeight = 472
    DesignSize = (
      269
      472)
    inherited Bevel1: TBevel
      Top = 466
      Width = 235
      ExplicitTop = 312
      ExplicitWidth = 488
    end
  end
  inherited pnlOperation: TPanel
    Top = 548
    Width = 844
    Height = 43
    BevelInner = bvRaised
    ExplicitTop = 548
    ExplicitWidth = 844
    ExplicitHeight = 43
    inherited bbtnSave: TBitBtn
      Left = 255
      Top = 5
      OnClick = bbtnSaveClick
      ExplicitLeft = 255
      ExplicitTop = 5
    end
    inherited bbtnClose: TBitBtn
      Left = 456
      Top = 6
      ExplicitLeft = 456
      ExplicitTop = 6
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 844
    Height = 548
    Align = alClient
    TabOrder = 2
    object GroupBox2: TGroupBox
      Left = 275
      Top = 8
      Width = 558
      Height = 169
      Caption = #23492#20214#20154#20449#24687
      TabOrder = 1
      object Label17: TLabel
        Left = 11
        Top = 65
        Width = 56
        Height = 14
        Caption = #25176' '#36816' '#20154
      end
      object Label18: TLabel
        Left = 345
        Top = 64
        Width = 56
        Height = 14
        Caption = #32852#31995#30005#35805
      end
      object Label19: TLabel
        Left = 10
        Top = 141
        Width = 56
        Height = 14
        Caption = #22320'    '#22336
      end
      object Label20: TLabel
        Left = 311
        Top = 64
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
      object Label21: TLabel
        Left = 534
        Top = 66
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
      object lblunitid: TLabel
        Left = 9
        Top = 26
        Width = 56
        Height = 14
        Caption = #23458#25143#32534#30721
      end
      object Label68: TLabel
        Left = 10
        Top = 104
        Width = 56
        Height = 14
        Caption = #23458#25143#31867#22411
      end
      object Label69: TLabel
        Left = 345
        Top = 104
        Width = 56
        Height = 14
        Caption = #21487#29992#31215#20998
      end
      object nvedtsender: TNovaEdit
        Left = 72
        Top = 61
        Width = 233
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      object nvedtsenderphone: TNovaEdit
        Left = 407
        Top = 61
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 11
        TabOrder = 2
        OnKeyUp = nvedtsenderphoneKeyUp
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
      object nvedtsenderaddress: TNovaEdit
        Left = 72
        Top = 138
        Width = 457
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 33
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
      object nvhelpclient: TNovaHelp
        Left = 72
        Top = 23
        Width = 234
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 0
        OnIdChange = nvhelpclientIdChange
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
            FieldName = 'code'
            Title.Caption = #23458#25143#32534#30721
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'contacter'
            Title.Caption = #32852#31995#20154
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'mobilephone'
            Title.Caption = #30005#35805#21495#30721
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'address'
            Title.Caption = #22320#22336
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'type'
            Title.Caption = #23458#25143#31867#22411
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'integrater'
            Title.Caption = #21487#29992#31215#20998
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 400
        HelpOptions.EdtField = 'code'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'schedulemap'
        HelpOptions.HelpType = 'StationHelp'
        HelpOptions.HQueryAddress = 'pack/queryclient'
        Params = <
          item
            DataType = ftString
            Name = 'filter_EQB_cnt!isactive'
            ParamType = ptInput
            Value = '1'
          end
          item
            DataType = ftString
            Name = 'filter_EQB_cnt!islocaldelete'
            ParamType = ptUnknown
            Value = '0'
          end>
        notFocusedShowHelp = False
      end
      object nvedtsendtype: TNovaComboBox
        Left = 72
        Top = 100
        Width = 233
        Height = 22
        Style = csDropDownList
        Enabled = False
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
        TabOrder = 4
        OnChange = nvedtsendtypeChange
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
        HelpOptions.TableName = 'client'
        HelpOptions.Columnname = 'type'
      end
      object nvedtsendintegrater: TNovaEdit
        Left = 407
        Top = 100
        Width = 121
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 5
        Text = '0'
        ValueTrim = '0'
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
    end
    object GroupBox3: TGroupBox
      Left = 275
      Top = 191
      Width = 558
      Height = 108
      Caption = #25910#20214#20154#20449#24687
      TabOrder = 2
      object Label22: TLabel
        Left = 11
        Top = 31
        Width = 56
        Height = 14
        Caption = #25910' '#36135' '#20154
      end
      object Label23: TLabel
        Left = 311
        Top = 30
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
      object Label24: TLabel
        Left = 345
        Top = 31
        Width = 56
        Height = 14
        Caption = #32852#31995#30005#35805
      end
      object Label25: TLabel
        Left = 534
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
      object Label26: TLabel
        Left = 11
        Top = 69
        Width = 56
        Height = 14
        Caption = #22320'    '#22336
      end
      object Label27: TLabel
        Left = 266
        Top = 118
        Width = 56
        Height = 14
        Caption = #35777' '#20214' '#21495
        Visible = False
      end
      object Label35: TLabel
        Left = 10
        Top = 115
        Width = 56
        Height = 14
        Caption = #35777#20214#31867#22411
        Visible = False
      end
      object nvedtconsignee: TNovaEdit
        Left = 72
        Top = 27
        Width = 233
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
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
      object nvedtconsigneephone: TNovaEdit
        Left = 407
        Top = 27
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 1
        OnKeyUp = nvedtconsigneephoneKeyUp
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
      object nvedtconsigneeaddress: TNovaEdit
        Left = 71
        Top = 65
        Width = 457
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 33
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
      object nvedtcertificateno: TNovaEdit
        Left = 328
        Top = 114
        Width = 201
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 18
        TabOrder = 4
        Visible = False
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
      object nvcbbcertificatetype: TNovaComboBox
        Left = 72
        Top = 114
        Width = 145
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
        TabOrder = 3
        Visible = False
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
        HelpOptions.TableName = 'customer'
        HelpOptions.Columnname = 'certificatetype'
      end
    end
    object feeinfo: TGroupBox
      Left = 277
      Top = 305
      Width = 558
      Height = 220
      Caption = #35745#36153#20449#24687
      TabOrder = 3
      object Label34: TLabel
        Left = 153
        Top = 26
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
      object Label37: TLabel
        Left = 198
        Top = 67
        Width = 56
        Height = 14
        Caption = #21253' '#35013' '#36153
      end
      object Label41: TLabel
        Left = 10
        Top = 67
        Width = 56
        Height = 14
        Caption = #35013' '#21368' '#36153
      end
      object Label44: TLabel
        Left = 198
        Top = 26
        Width = 56
        Height = 14
        Caption = #22768#26126#20215#20540
      end
      object Label45: TLabel
        Left = 341
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
      object Label48: TLabel
        Left = 8
        Top = 107
        Width = 56
        Height = 14
        Caption = #36865' '#36135' '#36153
      end
      object Label49: TLabel
        Left = 386
        Top = 107
        Width = 56
        Height = 14
        Caption = #20854#20182#36153#29992
      end
      object Label52: TLabel
        Left = 153
        Top = 144
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
      object Label53: TLabel
        Left = 531
        Top = 27
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
      object Label54: TLabel
        Left = 202
        Top = 144
        Width = 56
        Height = 14
        Caption = #20195#25910#36135#27454
      end
      object Label33: TLabel
        Left = 10
        Top = 26
        Width = 56
        Height = 14
        Caption = #25176' '#36816' '#36153
      end
      object Label43: TLabel
        Left = 386
        Top = 67
        Width = 56
        Height = 14
        Caption = #20013' '#36716' '#36153
      end
      object Label51: TLabel
        Left = 10
        Top = 144
        Width = 56
        Height = 14
        Caption = #24212#25910#37329#39069
      end
      object Label50: TLabel
        Left = 390
        Top = 27
        Width = 56
        Height = 14
        Caption = #20445' '#20215' '#36153
      end
      object Label55: TLabel
        Left = 529
        Top = 67
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
      object Label56: TLabel
        Left = 341
        Top = 67
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
      object Label57: TLabel
        Left = 151
        Top = 106
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
      object Label58: TLabel
        Left = 343
        Top = 144
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
      object Label59: TLabel
        Left = 153
        Top = 66
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
      object Label60: TLabel
        Left = 342
        Top = 108
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
      object Label64: TLabel
        Left = 200
        Top = 107
        Width = 56
        Height = 14
        Caption = #26381' '#21153' '#36153
      end
      object Label65: TLabel
        Left = 531
        Top = 105
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
      object Label67: TLabel
        Left = 311
        Top = 186
        Width = 56
        Height = 14
        Caption = #23454#25910#37329#39069
      end
      object Label66: TLabel
        Left = 9
        Top = 186
        Width = 91
        Height = 14
        Caption = #25269#25187#31215#20998'/'#37329#39069
      end
      object nvedtshipprice: TNovaEdit
        Left = 72
        Top = 22
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 0
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
      object nvedtpackfee: TNovaEdit
        Left = 260
        Top = 63
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 4
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
      object nvedthandfee: TNovaEdit
        Left = 72
        Top = 63
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 3
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
      object nvedttransitfee: TNovaEdit
        Left = 448
        Top = 63
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 5
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
      object nvedtinsuredamount: TNovaEdit
        Left = 260
        Top = 22
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 9
        TabOrder = 1
        Text = '0'
        OnChange = nvedtinsuredamountChange
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
      object nvedtdeliveryfee: TNovaEdit
        Left = 70
        Top = 104
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 6
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
      object nvedtotherfee: TNovaEdit
        Left = 450
        Top = 101
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 8
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
      object nvedttotalfee: TNovaEdit
        Left = 72
        Top = 141
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 9
        Text = '0'
        OnChange = nvedttotalfeeChange
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
      object nvedtinsurancefee: TNovaEdit
        Left = 450
        Top = 23
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 2
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
        Left = 262
        Top = 141
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 9
        TabOrder = 10
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
      object nvedtservicefee: TNovaEdit
        Left = 260
        Top = 103
        Width = 75
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 7
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
      object nvedtPayMoney: TNovaEdit
        Left = 371
        Top = 183
        Width = 75
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 11
        Text = '0'
        OnExit = nvedtPayMoneyExit
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
      object nvedtIntegrateMoney: TNovaEdit
        Left = 167
        Top = 183
        Width = 82
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 12
        Text = '0'
        OnChange = nvedttotalfeeChange
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
      object nvedtintegrate: TNovaEdit
        Left = 102
        Top = 183
        Width = 59
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 13
        Text = '0'
        OnChange = nvedtIntegrateChange
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
    end
    object packinfo: TGroupBox
      Left = 9
      Top = 8
      Width = 262
      Height = 520
      Caption = #34892#21253#20449#24687
      TabOrder = 0
      object Label1: TLabel
        Left = 35
        Top = 92
        Width = 42
        Height = 14
        Caption = #30446#30340#22320
      end
      object Label2: TLabel
        Left = 21
        Top = 148
        Width = 56
        Height = 14
        Caption = #36135#29289#21517#31216
      end
      object Label6: TLabel
        Left = 20
        Top = 31
        Width = 56
        Height = 14
        Caption = #21457#36135#26085#26399
      end
      object Label7: TLabel
        Left = 49
        Top = 181
        Width = 28
        Height = 14
        Caption = #21253#35013
      end
      object Label8: TLabel
        Left = 49
        Top = 236
        Width = 28
        Height = 14
        Caption = #20214#25968
      end
      object Label9: TLabel
        Left = 48
        Top = 269
        Width = 28
        Height = 14
        Caption = #37325#37327
      end
      object Label11: TLabel
        Left = 19
        Top = 476
        Width = 56
        Height = 14
        Caption = #36135#29289#25551#36848
      end
      object Label12: TLabel
        Left = 210
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
      object Label14: TLabel
        Left = 210
        Top = 149
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
      object Label15: TLabel
        Left = 209
        Top = 29
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
      object Label16: TLabel
        Left = 210
        Top = 187
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
      object Label36: TLabel
        Left = 21
        Top = 354
        Width = 56
        Height = 14
        Caption = #26159#21542#20445#20215
      end
      object Label38: TLabel
        Left = 210
        Top = 235
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
      object Label39: TLabel
        Left = 209
        Top = 269
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
      object Label61: TLabel
        Left = 35
        Top = 316
        Width = 42
        Height = 14
        Caption = #20844#37324#25968
      end
      object Label62: TLabel
        Left = 222
        Top = 269
        Width = 14
        Height = 14
        Caption = 'kg'
      end
      object Label29: TLabel
        Left = 20
        Top = 64
        Width = 56
        Height = 14
        Caption = #21463#29702#21333#21495
      end
      object Label42: TLabel
        Left = 210
        Top = 59
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
      object lbl1: TLabel
        Left = 20
        Top = 435
        Width = 56
        Height = 14
        Caption = #25552#36135#26041#24335
      end
      object lbl2: TLabel
        Left = 233
        Top = 440
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
        Left = 8
        Top = 395
        Width = 56
        Height = 14
        Caption = #20184#27454#26041#24335
      end
      object lbl4: TLabel
        Left = 232
        Top = 400
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
      object Label3: TLabel
        Left = 47
        Top = 118
        Width = 28
        Height = 14
        Caption = #29677#27425
        Visible = False
      end
      object nvcbbgoodname: TNovaComboBox
        Left = 83
        Top = 146
        Width = 121
        Height = 22
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
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
        HelpOptions.HDataSourceName = 'diclist'
        HelpOptions.HQueryAddress = 'system/querydictionary'
        HelpOptions.TableName = 'pack'
        HelpOptions.Columnname = 'name'
      end
      object dtpdepartdate: TDateTimePicker
        Left = 82
        Top = 27
        Width = 121
        Height = 22
        Date = 41492.639888414350000000
        Format = 'yyyy-MM-dd'
        Time = 41492.639888414350000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
        OnChange = dtpdepartdateChange
      end
      object nvedtpieces: TNovaEdit
        Left = 83
        Top = 233
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 3
        TabOrder = 6
        Text = '1'
        OnChange = nvedtweightChange
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
      object nvedtweight: TNovaEdit
        Left = 82
        Top = 268
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 7
        TabOrder = 7
        Text = '1'
        OnChange = nvedtweightChange
        OnExit = nvedtweightExit
        ValueTrim = '1'
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
      object memremarks: TMemo
        Left = 81
        Top = 472
        Width = 146
        Height = 23
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 13
      end
      object nvcbbpacked: TNovaComboBox
        Left = 83
        Top = 177
        Width = 121
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 10
        TabOrder = 5
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
      object rbvaluablesno: TRadioButton
        Left = 86
        Top = 354
        Width = 36
        Height = 17
        Caption = #21542
        Checked = True
        TabOrder = 9
        TabStop = True
      end
      object rbvaluablesyes: TRadioButton
        Left = 139
        Top = 354
        Width = 50
        Height = 17
        Caption = #26159
        TabOrder = 10
      end
      object nvedtdistance: TNovaEdit
        Left = 83
        Top = 313
        Width = 121
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 6
        TabOrder = 8
        Text = '1'
        ValueTrim = '1'
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
      object nvhelptostation: TNovaHelp
        Left = 83
        Top = 84
        Width = 121
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 2
        OnIdChange = nvhelptostationIdChange
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
        HelpOptions.HelpType = 'ScheduleRHelp'
        HelpOptions.HQueryAddress = 'pack/querytostation'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvedtpackno: TNovaEdit
        Left = 83
        Top = 57
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 1
        OnKeyPress = nvedtpacknoKeyPress
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
      object nvcbbshiptype: TNovaComboBox
        Left = 82
        Top = 432
        Width = 145
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 12
        TabOrder = 12
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
        Left = 81
        Top = 395
        Width = 145
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 12
        TabOrder = 11
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
      object nvedtpacked: TNovaEdit
        Left = 83
        Top = 205
        Width = 121
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
        TabOrder = 14
        OnChange = nvedtweightChange
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
      object NHelpSchedule: TNovaHComboBox
        Left = 2
        Top = 111
        Width = 17
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 15
        Visible = False
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
            Value = 'ScheduleRHelp'
          end
          item
            DataType = ftString
            Name = 'filter_INS_r!id'
            ParamType = ptInput
          end>
      end
      object nvhelpschedule: TNovaHelp
        Left = 83
        Top = 114
        Width = 122
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 3
        Visible = False
        OnChange = nvhelpscheduleChange
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
            Title.Caption = #29677#27425
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #21040#36798#31449
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'departtime'
            Title.Caption = #21457#36710#26102#38388
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 240
        HelpOptions.EdtField = 'code'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'schedulemap'
        HelpOptions.HelpType = 'ScheduleHelp'
        HelpOptions.HQueryAddress = 'pack/queryschedule'
        Params = <
          item
            DataType = ftString
            Name = 'filter_EQD_tp!departdate'
            ParamType = ptInput
          end
          item
            DataType = ftString
            Name = 'filter_EQL_tp!reachstationid'
            ParamType = ptInput
          end
          item
            DataType = ftString
            Name = 'filter_EQL_tp!departstationid'
            ParamType = ptInput
          end>
        notFocusedShowHelp = False
      end
    end
  end
  inherited ImageList: TImageList
    Left = 648
    Top = 584
  end
  object jcdspacksave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savePack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
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
        Name = 'pack.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.vehicleid'
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
        Name = 'pack.invoiceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.pieces'
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
        Name = 'pack.packed'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.handfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.deliveryfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.custodial'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.transitfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insuredamount'
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
        Name = 'pack.otherfee'
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
        Name = 'pack.signby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.signtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.onlycode'
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
        Name = 'pack.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.usertype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.clientid'
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
        Name = 'pack.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.integraterprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.servicefee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.clientid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.price'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.integrater'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.collectstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.recyclestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.collectby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.collectdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 556
    Top = 544
  end
  object jcdsquerypackfee: TjsonClientDataSet
    DataSourceName = 'packlist'
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
      end
      item
        DataType = ftFloat
        Name = 'handfee'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 72
    Top = 536
    object wdstrngfldResultshowvalue: TWideStringField
      FieldName = 'showvalue'
      Size = 100
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
    end
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
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'distance'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    object WideStringField3: TWideStringField
      FieldName = 'showvalue'
      Size = 100
    end
    object WideStringField4: TWideStringField
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
  object jcdsResult: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'pack/querystockschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_sd!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sd!routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vep!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!id'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 776
    Top = 528
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultischoose: TBooleanField
      FieldName = 'ischoose'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
      Size = 0
    end
    object jcdsResultname: TWideStringField
      FieldName = 'name'
      Size = 0
    end
    object jcdsResultstarttime: TDateTimeField
      FieldName = 'starttime'
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 0
    end
    object jcdsResultisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 0
    end
    object jcdsResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jcdsResultscheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 0
    end
    object jcdsResultdrivername: TWideStringField
      FieldName = 'drivername'
      Size = 0
    end
    object jcdsResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 0
    end
  end
  object jcdsIntegrateToMoney: TjsonClientDataSet
    DataSourceName = 'packIntegrateRuleList'
    QueryAddress = 'pack/integraterToMoney'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'integrater'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'clienttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qrytype'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 544
  end
  object jsdcQueryPercent: TjsonClientDataSet
    DataSourceName = 'packIntegrateRuleList'
    QueryAddress = 'pack/queryPercent'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'clienttype'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 688
    Top = 16
  end
  object jcdsParameters: TjsonClientDataSet
    DataSourceName = 'paramlistmap'
    QueryAddress = 'system/findParametersValue'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 184
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
    Left = 232
    Top = 216
  end
  object jcdsQueryRoutes: TjsonClientDataSet
    DataSourceName = 'dataset'
    SaveAddress = 'base/listRouteByStation'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ids'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 251
    Top = 64
  end
end
