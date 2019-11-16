inherited FrmBalanceInfo: TFrmBalanceInfo
  Caption = #32467#31639#20449#24687
  ClientHeight = 633
  ClientWidth = 798
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 804
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 798
    Height = 588
    ExplicitWidth = 798
    ExplicitHeight = 588
    inherited Bevel1: TBevel
      Top = 580
      Width = 764
      ExplicitTop = 476
      ExplicitWidth = 754
    end
    object GroupBox3: TGroupBox
      Left = 27
      Top = 53
      Width = 753
      Height = 224
      Caption = #32467#31639#21333#20449#24687
      TabOrder = 1
      object Label16: TLabel
        Left = 232
        Top = 124
        Width = 70
        Height = 14
        Caption = #24635#32467#31639#37329#39069
      end
      object Label17: TLabel
        Left = 18
        Top = 61
        Width = 70
        Height = 14
        Caption = #24635#31080#27454#37329#39069
      end
      object Label21: TLabel
        Left = 257
        Top = 61
        Width = 42
        Height = 14
        Caption = #24635#20154#25968
      end
      object Label1: TLabel
        Left = 18
        Top = 30
        Width = 70
        Height = 14
        Caption = #32467#31639#21333#24352#25968
      end
      object Label5: TLabel
        Left = 239
        Top = 189
        Width = 56
        Height = 14
        Caption = #24212#32467#37329#39069
      end
      object Label15: TLabel
        Left = 18
        Top = 157
        Width = 70
        Height = 14
        Caption = #23458#36816#20195#29702#36153
      end
      object lblStationFee: TLabel
        Left = 46
        Top = 93
        Width = 42
        Height = 14
        Caption = #31449#21153#36153
      end
      object Label3: TLabel
        Left = 46
        Top = 125
        Width = 42
        Height = 14
        Caption = #29123#27833#36153
      end
      object Label22: TLabel
        Left = 245
        Top = 92
        Width = 56
        Height = 14
        Caption = #20854#20182#25187#36153
      end
      object Label33: TLabel
        Left = 231
        Top = 157
        Width = 70
        Height = 14
        Caption = #23458#20195#36153#27604#20363
      end
      object Label7: TLabel
        Left = 231
        Top = 30
        Width = 70
        Height = 14
        Caption = #32467#31639#36710#36742#25968
      end
      object Label30: TLabel
        Left = 18
        Top = 189
        Width = 70
        Height = 14
        Caption = #31449#21153#38468#21152#36153
      end
      object NovaEdtCount: TNovaEdit
        Left = 94
        Top = 27
        Width = 120
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 0
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtTicketnum: TNovaEdit
        Left = 307
        Top = 58
        Width = 113
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 1
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdttotalamount: TNovaEdit
        Left = 94
        Top = 58
        Width = 120
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 2
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtBalanceMoney: TNovaEdit
        Left = 308
        Top = 185
        Width = 112
        Height = 22
        Hint = #24635#32467#31639#37329#39069'-'#32467#31639#25187#36153#37329#39069
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '0'
        OnChange = NovaEdtBalanceMoneyChange
        value = '0'
        ValueTrim = '0'
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
      object NovaEdtbalanceamount: TNovaEdit
        Left = 308
        Top = 121
        Width = 112
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 4
        Text = '0'
        ValueTrim = '0'
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
      object GroupBox2: TGroupBox
        Left = 441
        Top = 16
        Width = 310
        Height = 206
        Align = alRight
        Caption = #20854#20013#38656#35201#25163#24037#36755#20837#30340#32467#31639#25187#36153
        TabOrder = 5
        object NvDbgridEh1: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 306
          Height = 188
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = DataSource1
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FooterRowCount = 1
          ImeMode = imClose
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          RowDetailPanel.Color = clBtnFace
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -14
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          ExpOpenType = AutoOpen
          AutoSetMultiSelect = False
          AutoSetCtrlKey = False
          PrintInfo.TitleFont.Charset = GB2312_CHARSET
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
          ParentName = 'FrmBalanceInfo'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'name'
              Footer.ValueType = fvtCount
              Footers = <>
              ReadOnly = True
              Title.Caption = #25187#36153#39033#30446
              Width = 100
            end
            item
              DisplayFormat = '#0.00'
              EditButtons = <>
              FieldName = 'deductmoney'
              Footer.Value = '0'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #32467#31639#25187#36153
              Width = 95
            end
            item
              EditButtons = <>
              FieldName = 'divdedeductmoney'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #20998#25104#25187#36153
              Width = 89
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object NovaEdtstationservicefee: TNovaEdit
        Left = 94
        Top = 90
        Width = 120
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 6
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtfueladditionfee: TNovaEdit
        Left = 94
        Top = 121
        Width = 120
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 7
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtagentfee: TNovaEdit
        Left = 94
        Top = 153
        Width = 120
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 8
        Text = '0'
        OnChange = NovaEdtagentfeeChange
        ValueTrim = '0'
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
      object NovaEdtothterfee: TNovaEdit
        Left = 308
        Top = 89
        Width = 112
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 9
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtRate: TNovaEdit
        Left = 308
        Top = 150
        Width = 69
        Height = 27
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 4
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        Text = '0'
        TextHint = #36755#20837#27604#20363#21518#65292#23458#36816#20195#29702#36153#21017#20197#26032#35745#31639#30340#20540#20026#20934
        OnChange = NovaEdtRateChange
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
      object NovaEdtVehiclenum: TNovaEdit
        Left = 307
        Top = 27
        Width = 113
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ReadOnly = True
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
      object NovaEdtAddFee: TNovaEdit
        Left = 94
        Top = 181
        Width = 81
        Height = 27
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 6
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
        Text = '0'
        OnChange = NovaEdtAddFeeChange
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
      object BtnAddFeeAct: TBitBtn
        Left = 179
        Top = 181
        Width = 54
        Height = 28
        Caption = #35745#31639
        TabOrder = 13
        OnClick = BtnAddFeeActClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 21
      Top = 0
      Width = 753
      Height = 53
      Caption = #32467#31639#23545#35937'(*)'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label25: TLabel
        Left = 469
        Top = 26
        Width = 56
        Height = 14
        Caption = #32467#31639#36710#36742
      end
      object Label28: TLabel
        Left = 287
        Top = 26
        Width = 56
        Height = 14
        Caption = #20998#25104#23545#35937
      end
      object LabObject: TLabel
        Left = 16
        Top = 27
        Width = 56
        Height = 14
        Caption = #32467#31639#21333#20301
      end
      object NovaHUnit: TNovaHelp
        Left = 78
        Top = 23
        Width = 202
        Height = 24
        CharCase = ecUpperCase
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnIdChange = NovaHUnitIdChange
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
            Width = 80
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
      object EdtVehicleNo: TEdit
        Left = 530
        Top = 21
        Width = 211
        Height = 24
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object EdtDivideVehicle: TNovaEdit
        Left = 351
        Top = 22
        Width = 103
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ReadOnly = True
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
    end
    object GroupBox4: TGroupBox
      Left = 21
      Top = 280
      Width = 749
      Height = 141
      Caption = #32467#31639#21333#20301#20854#20182#32467#31639#20449#24687
      TabOrder = 2
      object Label6: TLabel
        Left = 539
        Top = 110
        Width = 84
        Height = 14
        Caption = #34917#24405#32467#31639#37329#39069
        Visible = False
      end
      object Label8: TLabel
        Left = 180
        Top = 54
        Width = 70
        Height = 14
        Caption = #19978#27425#28322#27424#27454
      end
      object Label9: TLabel
        Left = 28
        Top = 26
        Width = 56
        Height = 14
        Caption = #26202#28857#32602#37329
      end
      object Label10: TLabel
        Left = 194
        Top = 26
        Width = 56
        Height = 14
        Caption = #33073#29677#32602#37329
      end
      object Label12: TLabel
        Left = 376
        Top = 26
        Width = 56
        Height = 14
        Caption = #20943#20813#37329#39069
      end
      object Label11: TLabel
        Left = 14
        Top = 54
        Width = 70
        Height = 14
        Caption = #36710#36742#39044#32564#27454
      end
      object Label20: TLabel
        Left = 544
        Top = 101
        Width = 70
        Height = 14
        Caption = #34917#24405#24635#20154#25968
        Visible = False
      end
      object Label34: TLabel
        Left = 377
        Top = 54
        Width = 56
        Height = 14
        Caption = #36829#35268#32602#37329
      end
      object Label35: TLabel
        Left = 544
        Top = 54
        Width = 56
        Height = 14
        Caption = #36820#36824#37329#39069
      end
      object Label23: TLabel
        Left = 28
        Top = 82
        Width = 56
        Height = 14
        Caption = #34892#21253#37329#39069
      end
      object Label18: TLabel
        Left = 194
        Top = 82
        Width = 56
        Height = 14
        Caption = #21253#36710#33829#25910
      end
      object Label4: TLabel
        Left = 544
        Top = 26
        Width = 56
        Height = 14
        Caption = #25163#24037#25187#36153
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label19: TLabel
        Left = 376
        Top = 84
        Width = 56
        Height = 14
        Caption = #19978#26376#27424#20132
      end
      object Label26: TLabel
        Left = 544
        Top = 84
        Width = 56
        Height = 14
        Caption = #26412#26376#19978#20132
      end
      object Label29: TLabel
        Left = 14
        Top = 110
        Width = 70
        Height = 14
        Caption = #36135#36816#20195#29702#36153
      end
      object Label37: TLabel
        Left = 180
        Top = 110
        Width = 70
        Height = 14
        Caption = #36135#20195#36153#27604#20363
      end
      object Label38: TLabel
        Left = 376
        Top = 110
        Width = 56
        Height = 14
        Caption = #36135#31080#37329#39069
      end
      object NovaEdtReturnBalance: TNovaEdit
        Left = 632
        Top = 106
        Width = 97
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 0
        Text = '0'
        Visible = False
        ValueTrim = '0'
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
      object NovaEdtLastLost: TNovaEdit
        Left = 261
        Top = 48
        Width = 97
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 1
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtLateMoney: TNovaEdit
        Left = 91
        Top = 22
        Width = 84
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 2
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtLostMoney: TNovaEdit
        Left = 261
        Top = 22
        Width = 97
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 3
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtFree: TNovaEdit
        Left = 440
        Top = 22
        Width = 98
        Height = 24
        Font.Charset = GB2312_CHARSET
        Font.Color = clFuchsia
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        TabOrder = 4
        Text = '0'
        OnChange = NovaEdtFreeChange
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
      object NovaEdtReturnNum: TNovaEdit
        Left = 620
        Top = 97
        Width = 73
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 5
        Text = '0'
        Visible = False
        ValueTrim = '0'
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
      object NovaEdtPreUpmoney: TNovaEdit
        Left = 91
        Top = 50
        Width = 84
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 6
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtdebit: TNovaEdit
        Left = 440
        Top = 50
        Width = 98
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 7
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtbackMoney: TNovaEdit
        Left = 606
        Top = 48
        Width = 98
        Height = 24
        Enabled = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clFuchsia
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        Text = '0'
        OnChange = NovaEdtFreeChange
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
      object NovaEdtPackPrice: TNovaEdit
        Left = 91
        Top = 78
        Width = 84
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        Text = '0'
        OnChange = NovaEdtPackPriceChange
        value = '0'
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
      object NovaEdtRentPrice: TNovaEdit
        Left = 261
        Top = 77
        Width = 97
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        Text = '0'
        OnChange = NovaEdtRentPriceChange
        value = '0'
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
      object NovaEdtDeduct: TNovaEdit
        Left = 606
        Top = 22
        Width = 97
        Height = 22
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 11
        OnChange = NovaEdtDeductChange
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
      object NovaEditprevious: TNovaEdit
        Left = 440
        Top = 78
        Width = 98
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        Text = '0'
        OnChange = NovaEditnowChange
        value = '0'
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
      object NovaEditnow: TNovaEdit
        Left = 606
        Top = 78
        Width = 97
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        Text = '0'
        OnChange = NovaEditnowChange
        value = '0'
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
      object NovaEdtPackAgent: TNovaEdit
        Left = 91
        Top = 106
        Width = 84
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 14
        Text = '0'
        OnChange = NovaEditnowChange
        value = '0'
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
      object PackAgentRate: TNovaEdit
        Left = 261
        Top = 106
        Width = 97
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 15
        Text = '0'
        OnChange = PackAgentRateChange
        value = '0'
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
      object NovaEditPackFee: TNovaEdit
        Left = 440
        Top = 106
        Width = 98
        Height = 22
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 7
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 16
        Text = '0'
        OnChange = PackAgentRateChange
        value = '0'
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
    end
    object GroupBox6: TGroupBox
      Left = 21
      Top = 427
      Width = 529
      Height = 126
      Caption = #32467#31639#21333#20301#23454#38469#32467#36134'(*)'
      TabOrder = 3
      object Label13: TLabel
        Left = 34
        Top = 66
        Width = 56
        Height = 14
        Caption = #24212#32467#37329#39069
      end
      object Label14: TLabel
        Left = 6
        Top = 103
        Width = 84
        Height = 14
        Caption = #23454#38469#32467#24080#37329#39069
      end
      object Lbl_REdit_memo: TLabel
        Left = 329
        Top = 66
        Width = 28
        Height = 14
        Caption = #22791#27880
      end
      object Label2: TLabel
        Left = 254
        Top = 105
        Width = 42
        Height = 14
        Caption = #28322#27424#27454
      end
      object LabLost: TLabel
        Left = 307
        Top = 101
        Width = 44
        Height = 19
        Hint = #27491#25968#65306#23569#32467#65292#36127#25968#65306#22810#32467
        Caption = '0.00'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
      end
      object Label24: TLabel
        Left = 21
        Top = 33
        Width = 70
        Height = 14
        Caption = #25187#36153#21518#33829#25910
      end
      object Label31: TLabel
        Left = 253
        Top = 30
        Width = 42
        Height = 14
        Caption = #34892#21253#36153
      end
      object Label32: TLabel
        Left = 378
        Top = 30
        Width = 56
        Height = 14
        Caption = #21253#36710#24212#32467
      end
      object NovaEdtLeave: TNovaEdit
        Left = 96
        Top = 61
        Width = 154
        Height = 27
        Hint = #32467#31639#21333#24212#32467#37329#39069'-'#20854#20182#32467#31639
        Enabled = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtActBalance: TNovaEdit
        Left = 98
        Top = 94
        Width = 152
        Height = 27
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        TabOrder = 1
        Text = '0'
        OnChange = NovaEdtActBalanceChange
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
      object MeRemark: TMemo
        Left = 368
        Top = 61
        Width = 144
        Height = 63
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 100
        TabOrder = 2
      end
      object NovaEdtPack: TNovaEdit
        Left = 300
        Top = 24
        Width = 70
        Height = 27
        Hint = #32467#31639#21333#24212#32467#37329#39069'-'#20854#20182#32467#31639
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = '0'
        OnChange = NovaEdtPackChange
        value = '0'
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
      object NovaEdtIncome: TNovaEdit
        Left = 97
        Top = 28
        Width = 142
        Height = 22
        Hint = #32467#31639#21333#24212#32467#37329#39069'-'#20854#20182#32467#31639
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Text = '0'
        OnChange = NovaEdtIncomeChange
        ValueTrim = '0'
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
      object NovaEdtRentIncome: TNovaEdit
        Left = 439
        Top = 24
        Width = 73
        Height = 27
        Hint = #32467#31639#21333#24212#32467#37329#39069'-'#20854#20182#32467#31639
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Text = '0'
        OnChange = NovaEdtPackChange
        value = '0'
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
    end
    object GrpDivdeInfo: TGroupBox
      Left = 556
      Top = 427
      Width = 214
      Height = 124
      Caption = #20998#25104#21333#20301#23454#38469#32467#31639'(*)'
      TabOrder = 4
      object Label27: TLabel
        Left = 10
        Top = 64
        Width = 56
        Height = 14
        Caption = #24212#32467#37329#39069
      end
      object Label36: TLabel
        Left = 11
        Top = 30
        Width = 56
        Height = 14
        Caption = #25163#24037#25187#36153
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object NovaEdtDivdeBalance: TNovaEdit
        Left = 73
        Top = 60
        Width = 121
        Height = 22
        Hint = #32467#31639#21333#24212#32467#37329#39069'-'#20854#20182#32467#31639
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '0'
        ValueTrim = '0'
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
      object NovaEdtDivdeDeduct: TNovaEdit
        Left = 73
        Top = 25
        Width = 120
        Height = 22
        Enabled = False
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        MaxLength = 50
        TabOrder = 1
        OnChange = NovaEdtDivdeDeductChange
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
  inherited pnlOperation: TPanel
    Top = 588
    Width = 798
    ExplicitTop = 588
    ExplicitWidth = 798
    inherited bbtnSave: TBitBtn
      Left = 49
      Top = 6
      Caption = '&S '#32467#31639
      OnClick = bbtnSaveClick
      ExplicitLeft = 49
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 681
      Top = 6
      Width = 81
      Kind = bkCustom
      OnClick = bbtnCloseClick
      ExplicitLeft = 681
      ExplicitTop = 6
      ExplicitWidth = 81
    end
    object BtnPrint: TBitBtn
      Left = 145
      Top = 6
      Width = 115
      Height = 25
      Caption = '&P.'#25171#21360#32467#36134#21333
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = BtnPrintClick
    end
    object btn1: TBitBtn
      Left = 388
      Top = 6
      Width = 118
      Height = 25
      Caption = '&P.'#25353#31449#28857#25171#21360
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btn1Click
    end
    object btn2: TBitBtn
      Left = 514
      Top = 6
      Width = 155
      Height = 25
      Caption = '&P.'#25353#31449#28857#31080#20215#25171#21360
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btn2Click
    end
    object chk1: TCheckBox
      Left = 273
      Top = 10
      Width = 109
      Height = 17
      Caption = #25171#21360#32467#31639#21333#21495
      TabOrder = 5
    end
  end
  inherited ImageList: TImageList
    Left = 16
    Top = 128
  end
  object jcsdQryInvoicesdeductdetails: TjsonClientDataSet
    DataSourceName = 'balancedeductlist'
    UpdateDataSet = 'dds'
    QueryAddress = 'balance/qryBalanceDeductDetail'
    SaveAddress = 'balance/invoicesBalance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'invoicesids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'otherinvoicesids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancetype'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.balanceobject'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.routename'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.objectid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.agentrate'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.ditotalnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.invoicesnum'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.ditotalmoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.distationservicefee'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.fueladditionfee'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.diotherpredeductifee'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.diagentfee'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.dibalanceablemoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.dideductmoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.dibalancemoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.returnmoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.vipscoremoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.lastlost'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.lost'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.ticketincome'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.deratemoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.lateforfeit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.vehicleno'
        ParamType = ptInput
        Value = 'ck'
      end
      item
        DataType = ftString
        Name = 'balance.preupmoney'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.lostforfeit'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.balancemoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'balance.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.packmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.departstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.departenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.additionfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.balancedividevehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.divide'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.packprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.rentmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.rentprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.debit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.backmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'balanceid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'balanceno'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'balance.bysj'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.syqj'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balance.goodsagent'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 632
    Top = 144
    object jcsdQryInvoicesdeductdetailsid: TLargeintField
      FieldName = 'id'
    end
    object jcsdQryInvoicesdeductdetailsname: TWideStringField
      FieldName = 'name'
    end
    object jcsdQryInvoicesdeductdetailsdivdedeductmoney: TFloatField
      FieldName = 'divdedeductmoney'
      OnChange = jcsdQryInvoicesdeductdetailsdivdedeductmoneyChange
    end
    object jcsdQryInvoicesdeductdetailsdeductmoney: TFloatField
      FieldName = 'deductmoney'
      OnChange = jcsdQryInvoicesdeductdetailsdeductmoneyChange
    end
  end
  object DataSource1: TDataSource
    DataSet = jcsdQryInvoicesdeductdetails
    OnDataChange = DataSource1DataChange
    Left = 632
    Top = 208
  end
  object jcsdQryOtherbalace: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/qryOtherBalance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceobject'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'objectid'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'invoicesids'
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
        Name = 'obi.balancemoney'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.lateforfeit'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.lostforfeit'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.integralmoney'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.lastlost'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.lessmoney'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.lessnum'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.preupmoney'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.returnpeople'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.debit'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.backmoney'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'obi.packfee'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 200
  end
  object jcsdQryOtherDeduct: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/qryOtherDeduct'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'invoicesids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'additionfee'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'agentrate'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'agentfee'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 512
    Top = 192
  end
  object jcsdQryDeducts: TjsonClientDataSet
    DataSourceName = 'balancedeductlist'
    QueryAddress = 'balance/qryBalanceDeductPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'balanceid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 608
    Top = 512
  end
  object jsonQryDivideUnit: TjsonClientDataSet
    DataSourceName = 'datamap'
    QueryAddress = 'balance/qrybalancedivide'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!vehicleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 512
    Top = 248
  end
  object jsonAddFeeIsSame: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/additionFeeIsSame'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleids'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 388
    Top = 264
  end
  object jsoncalPackBalancePrice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/calPackBalancePrice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'packbalanceprice'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 32
    Top = 168
  end
  object jsonQryRoute: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/qryRoutename'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routename'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 600
    Top = 24
  end
  object jsoncalRentBalancePrice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/calRentBalancePrice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'rentprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'rentbalanceprice'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 728
    Top = 256
  end
  object jcdsroundBalance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/roundLeaveBalance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'leaveBalance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'leaveBalanceresult'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 584
    Top = 200
  end
  object AcRptEngineTotalDeatil: TAcRptEngine
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 704
    Top = 520
  end
  object jcdsQryBalanceStationDetail: TjsonClientDataSet
    DataSourceName = 'balanceStationdetailprintlist'
    QueryAddress = 'balance/qryBalanceStationdetailPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balanceid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isByprice'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 705
    Top = 305
  end
  object ds1: TDataSource
    DataSet = jcdsQryBalanceStationDetail
    Left = 752
    Top = 519
  end
  object jcdsbalanceACPrint: TjsonClientDataSet
    DataSourceName = 'balancedlist'
    QueryAddress = 'balance/qrybalanceACPrintinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'balanceid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 504
  end
  object DataSource2: TDataSource
    DataSet = jcdsbalanceACPrint
    Left = 88
    Top = 504
  end
end
