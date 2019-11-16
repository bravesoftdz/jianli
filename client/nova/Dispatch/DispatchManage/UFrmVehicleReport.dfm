inherited FrmVehicleReport: TFrmVehicleReport
  Caption = 'FrmVehicleReport'
  ClientHeight = 555
  ClientWidth = 874
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 880
  ExplicitHeight = 583
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 874
    Height = 516
    ExplicitWidth = 874
    ExplicitHeight = 516
    inherited Bevel1: TBevel
      Top = 504
      Width = 838
      ExplicitTop = 515
      ExplicitWidth = 723
    end
    object grp1: TGroupBox
      Left = 16
      Top = 10
      Width = 257
      Height = 488
      Caption = #25253#29677#20449#24687
      TabOrder = 0
      object lbl1: TLabel
        Left = 28
        Top = 33
        Width = 60
        Height = 18
        Caption = #21457#36710#26085#26399
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 28
        Top = 71
        Width = 60
        Height = 18
        Caption = #25253#21040#21345#21495
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 29
        Top = 167
        Width = 60
        Height = 18
        Caption = #25253#21040#36710#29260
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl4: TLabel
        Left = 29
        Top = 199
        Width = 60
        Height = 18
        Caption = #36710#23646#21333#20301
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 28
        Top = 106
        Width = 60
        Height = 18
        Caption = #25253#21040#29677#27425
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl12: TLabel
        Left = 25
        Top = 419
        Width = 60
        Height = 18
        Caption = #25253#21040#24773#20917
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 33
        Top = 271
        Width = 56
        Height = 14
        Caption = #36710#36742#31867#22411
      end
      object lbl21: TLabel
        Left = 28
        Top = 309
        Width = 60
        Height = 18
        Caption = #23433#26816#32467#26524
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 29
        Top = 235
        Width = 60
        Height = 18
        Caption = #32467#31639#21333#20301
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object nvedtbdcard: TNovaEdit
        Left = 94
        Top = 67
        Width = 150
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 1
        OnChange = nvedtbdcardChange
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
      object chktempvehicle: TCheckBox
        Left = 94
        Top = 137
        Width = 67
        Height = 18
        Caption = #39030#29677#21542
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = chktempvehicleClick
      end
      object DpDepartDate: TDateTimePicker
        Left = 94
        Top = 29
        Width = 150
        Height = 22
        Date = 40673.421245115740000000
        Time = 40673.421245115740000000
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
        OnChange = DpDepartDateChange
        OnExit = DpDepartDateExit
      end
      object NovaHReprotSchedule: TNovaHelp
        Left = 94
        Top = 102
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 2
        OnKeyPress = NovaHReprotScheduleKeyPress
        OnIdChange = NovaHReprotScheduleIdChange
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
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'starttime'
            Title.Caption = #21457#36710#26102#38388
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'ScheduleHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHelpVehicleno: TNovaHelp
        Left = 94
        Top = 165
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 4
        OnIdChange = NovaHelpVehiclenoIdChange
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
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'seatnum'
            Title.Caption = #24231#20301#25968
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'brandname'
            Title.Caption = #21378#29260
            Width = 60
            Visible = True
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
      object NovaHUnit: TNovaHelp
        Left = 95
        Top = 198
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 20
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
        HelpOptions.HelpHeight = 300
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
      object RgReprotResult: TRadioGroup
        Left = 91
        Top = 408
        Width = 154
        Height = 40
        Columns = 2
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          #27491#24120
          #26202#28857)
        ParentFont = False
        TabOrder = 7
      end
      object NovaHelpVehicletype: TNovaHelp
        Left = 94
        Top = 267
        Width = 150
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 6
        OnIdChange = NovaHelpVehicletypeIdChange
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
            Title.Caption = #36710#22411#21517#31216
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'code'
            Title.Caption = #32534#30721
            Width = 70
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'VehicletypeHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object cbbCheckResult: TComboBox
        Left = 94
        Top = 308
        Width = 151
        Height = 22
        Style = csDropDownList
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 8
        Items.Strings = (
          #26410#26816
          #21512#26684
          #19981#21512#26684)
      end
      object mmoCheckResult: TMemo
        Left = 94
        Top = 349
        Width = 151
        Height = 39
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 9
      end
      object NovaHelpBalanceUnit: TNovaHelp
        Left = 95
        Top = 234
        Width = 150
        Height = 22
        CharCase = ecUpperCase
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        HelpOptions.HelpHeight = 300
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
      object bbtnAddtempVehi: TBitBtn
        Left = 169
        Top = 133
        Width = 75
        Height = 25
        Caption = #20020#26102#36710
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = bbtnAddtempVehiClick
      end
    end
    object pgc1: TPageControl
      Left = 279
      Top = 18
      Width = 574
      Height = 172
      ActivePage = tsdistpbcbd
      Style = tsButtons
      TabOrder = 1
      OnChange = pgc1Change
      object tsdistpbcbd: TTabSheet
        Caption = #38750#27969#27700#29677#27425#25253#21040#20449#24687
        ImageIndex = 1
        object grp5: TGroupBox
          Left = 0
          Top = 0
          Width = 566
          Height = 139
          Align = alClient
          Caption = #29677#27425#20449#24687
          TabOrder = 0
          object lbl13: TLabel
            Left = 38
            Top = 33
            Width = 60
            Height = 18
            Caption = #36816#33829#32447#36335
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl14: TLabel
            Left = 50
            Top = 65
            Width = 45
            Height = 18
            Caption = #29677#27425#21495
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl15: TLabel
            Left = 310
            Top = 29
            Width = 60
            Height = 18
            Caption = #21806#31080#36710#22411
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl16: TLabel
            Left = 202
            Top = 65
            Width = 60
            Height = 18
            Caption = #21457#36710#26102#38388
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl17: TLabel
            Left = 363
            Top = 66
            Width = 64
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24231#20301#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl18: TLabel
            Left = 183
            Top = 101
            Width = 64
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = #39044#30041#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl19: TLabel
            Left = 26
            Top = 102
            Width = 64
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = #24050#21806#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lbl20: TLabel
            Left = 363
            Top = 102
            Width = 64
            Height = 17
            Alignment = taRightJustify
            AutoSize = False
            Caption = #20313#24231#25968
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NvEdtRoute: TNovaEdit
            Left = 109
            Top = 28
            Width = 126
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            MaxLength = 50
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
          object nvedtcode: TNovaEdit
            Left = 109
            Top = 61
            Width = 81
            Height = 22
            Enabled = False
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
          end
          object nvedttickettype: TNovaEdit
            Left = 394
            Top = 29
            Width = 130
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          object nvedDeparttime: TNovaEdit
            Left = 268
            Top = 64
            Width = 89
            Height = 22
            Enabled = False
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
          end
          object nvedtSeatnum: TNovaEdit
            Left = 435
            Top = 61
            Width = 81
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          object nvedtSoldeatnum: TNovaEdit
            Left = 109
            Top = 101
            Width = 84
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          object nvedtylNum: TNovaEdit
            Left = 268
            Top = 99
            Width = 90
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            MaxLength = 50
            TabOrder = 6
            OnExit = nvedtylNumExit
            OnKeyPress = nvedtylNumKeyPress
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
          object nvedtyzNum: TNovaEdit
            Left = 435
            Top = 99
            Width = 81
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          object nvedtSeatnumhid: TNovaEdit
            Left = 531
            Top = 61
            Width = 30
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            MaxLength = 50
            TabOrder = 8
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
          object Scheduleplanidhid: TNovaEdit
            Left = 251
            Top = 23
            Width = 46
            Height = 22
            Enabled = False
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            MaxLength = 50
            TabOrder = 9
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
        end
      end
      object tstpbcbd: TTabSheet
        Caption = #27969#27700#29677#27425#25253#21040#20449#24687
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grp3: TGroupBox
          Left = 0
          Top = 0
          Width = 566
          Height = 139
          Align = alClient
          Caption = #35745#21010#25253#21040#36710#36742#12289#20154#21592#20449#24687
          TabOrder = 0
          object nvdbgrdhregisterrecord: TNvDbgridEh
            Left = 2
            Top = 16
            Width = 562
            Height = 121
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = DsVehiclepeople
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            ImeMode = imClose
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            OnDblClick = nvdbgrdhregisterrecordDblClick
            ExpOpenType = AutoOpen
            AutoSetMultiSelect = False
            AutoSetCtrlKey = False
            PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
            PrintInfo.TitleFont.Color = clWindowText
            PrintInfo.TitleFont.Height = -19
            PrintInfo.TitleFont.Name = #23435#20307
            PrintInfo.TitleFont.Style = []
            PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
            PrintInfo.GridHeadFont.Color = clWindowText
            PrintInfo.GridHeadFont.Height = -11
            PrintInfo.GridHeadFont.Name = 'Tahoma'
            PrintInfo.GridHeadFont.Style = []
            PrintInfo.TitleNullLine = 0
            PrintInfo.PrintPageFooter = True
            PrintInfo.PrintPrintFooterTime = True
            PrintInfo.PageFooterRight = #21335#20940#31185#25216
            PrintInfo.PageSize.BottomMargin = 1.000000000000000000
            PrintInfo.PageSize.LeftMargin = 1.000000000000000000
            PrintInfo.PageSize.RightMargin = 1.000000000000000000
            PrintInfo.PageSize.TopMargin = 1.000000000000000000
            PrintOptions = [pghOptimalColWidths]
            PrintAutoNewLine = False
            ParentName = 'Frmvehicleregister'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'code'
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Alignment = taCenter
                Title.Caption = #29677#27425#21495
                Width = 46
              end
              item
                EditButtons = <>
                FieldName = 'endstation'
                Footers = <>
                Title.Alignment = taCenter
                Title.Caption = #32456#28857#31449
                Width = 108
              end
              item
                EditButtons = <>
                FieldName = 'vehicletypename'
                Footers = <>
                Title.Alignment = taCenter
                Title.Caption = #36710#22411
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'vehicleno'
                Footers = <>
                Title.Alignment = taCenter
                Title.Caption = #35745#21010#36710#36742
                Width = 86
              end
              item
                EditButtons = <>
                FieldName = 'vehicleseatnum'
                Footers = <>
                Title.Alignment = taCenter
                Title.Caption = #24231#20301#25968
                Width = 54
              end
              item
                EditButtons = <>
                FieldName = 'unitname'
                Footers = <>
                Title.Alignment = taCenter
                Title.Caption = #33829#36816#21333#20301
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'driver1'
                Footers = <>
                Title.Caption = #35745#21010#20027#39550
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'driver2'
                Footers = <>
                Title.Caption = #35745#21010#21103#39550'1'
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'driver3'
                Footers = <>
                Title.Caption = #35745#21010#21103#39550'2'
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'driver4'
                Footers = <>
                Title.Caption = #35745#21010#21103#39550'3'
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'stwname1'
                Footers = <>
                Title.Caption = #35745#21010#20056#21153#21592
                Width = 70
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
    object grp4: TGroupBox
      Left = 283
      Top = 289
      Width = 570
      Height = 205
      Caption = #39550#39542#21592#20449#24687
      TabOrder = 2
      object lbl6: TLabel
        Left = 44
        Top = 25
        Width = 45
        Height = 18
        Caption = #27491#39550#39542
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl7: TLabel
        Left = 26
        Top = 85
        Width = 62
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21103#39550#39542'1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl10: TLabel
        Left = 23
        Top = 171
        Width = 64
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20056#21153#21592
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LabInfo: TLabel
        Left = 95
        Top = 0
        Width = 144
        Height = 16
        Caption = #25351#32441#35774#22791#21021#22987#21270#25104#21151
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
        Visible = False
      end
      object Label9: TLabel
        Left = 273
        Top = 27
        Width = 112
        Height = 14
        Caption = #20174#19994#36164#26684#35777#26377#25928#26399
      end
      object Label12: TLabel
        Left = 45
        Top = 57
        Width = 42
        Height = 14
        Caption = #19978#23703#35777
      end
      object Label7: TLabel
        Left = 275
        Top = 57
        Width = 84
        Height = 14
        Caption = #39550#39542#35777#26377#25928#26399
      end
      object Label11: TLabel
        Left = 273
        Top = 87
        Width = 112
        Height = 14
        Caption = #20174#19994#36164#26684#35777#26377#25928#26399
      end
      object Label13: TLabel
        Left = 47
        Top = 116
        Width = 42
        Height = 14
        Caption = #19978#23703#35777
      end
      object Label10: TLabel
        Left = 277
        Top = 117
        Width = 84
        Height = 14
        Caption = #39550#39542#35777#26377#25928#26399
      end
      object lbl8: TLabel
        Left = 26
        Top = 143
        Width = 62
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21103#39550#39542'2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl9: TLabel
        Left = 290
        Top = 143
        Width = 62
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21103#39550#39542'3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object nvhlpdriver: TNovaHelp
        Left = 113
        Top = 22
        Width = 96
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 0
        OnIdChange = nvhlpdriverIdChange
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
      object NovaHelpcopilot1: TNovaHelp
        Left = 113
        Top = 84
        Width = 97
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 1
        OnIdChange = NovaHelpcopilot1IdChange
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
      object NovaHelpsteward: TNovaHelp
        Left = 112
        Top = 171
        Width = 97
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        HelpOptions.HelpType = 'StewardHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object Editqualificationenddate: TEdit
        Left = 403
        Top = 22
        Width = 102
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 3
      end
      object Edit1: TEdit
        Left = 113
        Top = 53
        Width = 96
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 4
      end
      object Edtdrivinglicenseenddate: TEdit
        Left = 404
        Top = 53
        Width = 102
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 5
      end
      object Editqualificationenddate1: TEdit
        Left = 403
        Top = 81
        Width = 102
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 6
      end
      object Edtworkenddate1: TEdit
        Left = 113
        Top = 114
        Width = 96
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 7
      end
      object Edtdrivinglicenseenddate1: TEdit
        Left = 403
        Top = 114
        Width = 102
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 8
      end
      object NovaHelpcopilot2: TNovaHelp
        Left = 112
        Top = 142
        Width = 97
        Height = 22
        BiDiMode = bdLeftToRight
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentBiDiMode = False
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
      object Chkdqualificationres: TCheckBox
        Left = 511
        Top = 24
        Width = 97
        Height = 17
        Caption = #21512#26684
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
      object Chkdworknores: TCheckBox
        Left = 216
        Top = 56
        Width = 53
        Height = 17
        Caption = #21512#26684
        Checked = True
        State = cbChecked
        TabOrder = 11
      end
      object Chkddrivinglicenseres: TCheckBox
        Left = 512
        Top = 54
        Width = 53
        Height = 17
        Caption = #21512#26684
        Checked = True
        State = cbChecked
        TabOrder = 12
      end
      object chkdqualificationres2: TCheckBox
        Left = 511
        Top = 84
        Width = 53
        Height = 17
        Caption = #21512#26684
        Checked = True
        State = cbChecked
        TabOrder = 13
      end
      object Chkdworknores2: TCheckBox
        Left = 216
        Top = 114
        Width = 53
        Height = 17
        Caption = #21512#26684
        Checked = True
        State = cbChecked
        TabOrder = 14
      end
      object Chkddrivinglicenseres2: TCheckBox
        Left = 511
        Top = 117
        Width = 53
        Height = 17
        Caption = #21512#26684
        Checked = True
        State = cbChecked
        TabOrder = 15
      end
      object NovaHelpcopilot3: TNovaHelp
        Left = 403
        Top = 142
        Width = 103
        Height = 22
        BiDiMode = bdLeftToRight
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentBiDiMode = False
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
    end
    object GroupBox1: TGroupBox
      Left = 283
      Top = 182
      Width = 570
      Height = 101
      Caption = #35777#20214#20449#24687
      TabOrder = 3
      object Label3: TLabel
        Left = 11
        Top = 21
        Width = 98
        Height = 14
        Caption = #25215#36816#20154#38505#26377#25928#26399
      end
      object Label4: TLabel
        Left = 298
        Top = 20
        Width = 84
        Height = 14
        Caption = #34892#39542#35777#26377#25928#26399
      end
      object Label5: TLabel
        Left = 25
        Top = 46
        Width = 84
        Height = 14
        Caption = #33829#36816#35777#26377#25928#26399
      end
      object Label6: TLabel
        Left = 301
        Top = 48
        Width = 70
        Height = 14
        Caption = #32447#36335#26631#24535#29260
      end
      object lbl11: TLabel
        Left = 25
        Top = 71
        Width = 84
        Height = 14
        Caption = #20132#24378#38505#26377#25928#26399
      end
      object Edtliabilityinsureenddate: TEdit
        Left = 115
        Top = 17
        Width = 126
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 0
      end
      object Edtlicenseenddate: TEdit
        Left = 403
        Top = 17
        Width = 126
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 1
      end
      object Edtworkenddate: TEdit
        Left = 115
        Top = 41
        Width = 126
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 2
      end
      object Edtworkno: TEdit
        Left = 403
        Top = 43
        Width = 126
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 3
      end
      object edtcompulsoryinsureenddate: TEdit
        Left = 116
        Top = 69
        Width = 126
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ReadOnly = True
        TabOrder = 4
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 516
    Width = 874
    Height = 39
    ExplicitTop = 516
    ExplicitWidth = 874
    ExplicitHeight = 39
    inherited bbtnSave: TBitBtn
      Left = 374
      Top = 6
      Caption = '&S '#25253#21040
      OnClick = bbtnSaveClick
      ExplicitLeft = 374
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 504
      Top = 6
      ExplicitLeft = 504
      ExplicitTop = 6
    end
    object BitBtn1: TBitBtn
      Left = 208
      Top = 6
      Width = 105
      Height = 25
      Caption = '&B '#25253#21040#32487#32493
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
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  inherited ImageList: TImageList
    Left = 59
    Top = 60
  end
  object jcdsQryDriver: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'dispatch/qryReprotDriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'driverid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cardno'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 184
  end
  object jcdsQryvehiclepeopleplans: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'dispatch/qryvehiclepeopleplans'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereport.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsQryvehiclepeopleplansAfterScroll
    Left = 648
  end
  object DsVehiclepeople: TDataSource
    DataSet = jcdsQryvehiclepeopleplans
    Left = 520
    Top = 96
  end
  object jscdIsLater: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/isVehicleLater'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.departdate'
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
    Left = 280
    Top = 320
  end
  object jcsdQryVehiclecheck: TjsonClientDataSet
    DataSourceName = 'dateset'
    SaveAddress = 'dispatch/qryVehiclecheckinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereport.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.departdate'
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
    Left = 248
    Top = 376
  end
  object jsonShowValidate: TjsonClientDataSet
    DataSourceName = 'checkValidatelist'
    QueryAddress = 'check/showValidate'
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
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'driverid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driverid1'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 32
    Top = 361
    object jsonShowValidatecardName: TWideStringField
      FieldName = 'cardName'
      Size = 100
    end
    object jsonShowValidatecardNo: TWideStringField
      FieldName = 'cardNo'
      Size = 100
    end
    object jsonShowValidateendate: TDateField
      FieldName = 'endate'
    end
    object jsonShowValidatedays: TLargeintField
      FieldName = 'days'
    end
  end
  object jcdsqryDriverbycardno: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'dispatch/qryDriverbycardno'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cardno'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 8
  end
  object jcsdQryTempVehi: TjsonClientDataSet
    DataSourceName = 'vehiclemap'
    QueryAddress = 'base/qryVehicleById'
    SaveAddress = 'base/savevehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'vehicleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 104
  end
  object jcdsVehicleDriver: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'dispatch/qryVehicleDriver'
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
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 647
    Top = 258
  end
  object jscdSpcQry: TjsonClientDataSet
    DataSourceName = 'pictureResult'
    QueryAddress = 'archive/queryDriverAndStewardFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 456
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
    Left = 800
    Top = 264
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
    Left = 744
    Top = 456
  end
  object jscdExamineCheck: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/examincheck'
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
        Name = 'driverid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'driver1id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
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
    Left = 576
    Top = 264
  end
end
