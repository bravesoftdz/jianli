inherited frmQueryBalanced: TfrmQueryBalanced
  Caption = #24050#32467#31639#26597#35810
  ClientHeight = 558
  ClientWidth = 1176
  OnShow = FormShow
  ExplicitWidth = 1192
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1176
    Height = 103
    ExplicitWidth = 1176
    ExplicitHeight = 103
    object lbl1: TLabel
      Left = 17
      Top = 18
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl2: TLabel
      Left = 261
      Top = 18
      Width = 56
      Height = 14
      Caption = #32467#24080#26085#26399
    end
    object lbl3: TLabel
      Left = 519
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl5: TLabel
      Left = 17
      Top = 84
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object lbl7: TLabel
      Left = 16
      Top = 50
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object lbl9: TLabel
      Left = 235
      Top = 50
      Width = 84
      Height = 14
      Caption = #32467#36134#35745#31639#26426'IP'
    end
    object lbl8: TLabel
      Left = 496
      Top = 50
      Width = 42
      Height = 14
      Caption = #32467#36134#20154
    end
    object lbl4: TLabel
      Left = 680
      Top = 17
      Width = 42
      Height = 14
      Caption = #25215#21253#32773
      Visible = False
    end
    object Label1: TLabel
      Left = 505
      Top = 84
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object lbl6: TLabel
      Left = 263
      Top = 84
      Width = 56
      Height = 14
      Caption = #32467#31639#36710#36742
    end
    object nvcbbNovaCkbOrg: TNovaCheckedComboBox
      Left = 82
      Top = 14
      Width = 133
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpBalancedStart: TDateTimePicker
      Left = 326
      Top = 14
      Width = 115
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object dtpBalancedEnd: TDateTimePicker
      Left = 543
      Top = 14
      Width = 116
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object NovaHelpUnit: TNovaHelp
      Left = 82
      Top = 80
      Width = 133
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaEdtInvoicesno: TNovaEdit
      Left = 82
      Top = 46
      Width = 133
      Height = 22
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
    object nvhelpUserid: TNovaHelp
      Left = 544
      Top = 46
      Width = 116
      Height = 22
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
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaEditIP: TNovaEdit
      Left = 326
      Top = 46
      Width = 115
      Height = 22
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
    object cbbStatus: TComboBox
      Left = 543
      Top = 80
      Width = 116
      Height = 22
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 8
      Items.Strings = (
        ''
        #27491#24120
        #27880#38144)
    end
    object nvhlpvehicle: TNovaHelp
      Left = 325
      Top = 80
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #36710#29260
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!route!id'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object NovaHelpContractor: TNovaHelp
      Left = 728
      Top = 18
      Width = 83
      Height = 22
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
      HelpOptions.HelpType = 'ContractorHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1176
    ButtonWidth = 91
    ExplicitWidth = 1176
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 91
    end
    inherited tbtn1: TToolButton
      Left = 91
      ExplicitLeft = 91
    end
    inherited tbtnInsert: TToolButton
      Left = 99
      Caption = #34917#25171
      ImageIndex = 8
      OnClick = tbtnInsertClick
      ExplicitLeft = 99
      ExplicitWidth = 91
    end
    inherited tbtnEdit: TToolButton
      Left = 190
      Caption = #26597#30475#26126#32454
      ImageIndex = 6
      OnClick = tbtnEditClick
      ExplicitLeft = 190
      ExplicitWidth = 91
    end
    inherited tbtnDelete: TToolButton
      Left = 281
      Caption = #27880#38144
      OnClick = tbtnDeleteClick
      ExplicitLeft = 281
      ExplicitWidth = 91
    end
    inherited ToolButton50: TToolButton
      Left = 372
      ExplicitLeft = 372
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 390
      ExplicitLeft = 390
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 408
      Visible = False
      ExplicitLeft = 408
    end
    inherited tbtnSave: TToolButton
      Left = 416
      Caption = #36335#21333#26126#32454
      ImageIndex = 6
      Visible = False
      OnClick = tbtnSaveClick
      ExplicitLeft = 416
      ExplicitWidth = 91
    end
    inherited tbtnCancel: TToolButton
      Left = 507
      Caption = #34917#25171#36335#21333#26126#32454
      ImageIndex = 8
      Visible = False
      OnClick = tbtnCancelClick
      ExplicitLeft = 507
      ExplicitWidth = 91
    end
    inherited ToolButton52: TToolButton
      Left = 598
      ExplicitLeft = 598
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 616
      ExplicitLeft = 616
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 634
      Visible = False
      ExplicitLeft = 634
    end
    inherited tbtnInfo: TToolButton
      Left = 642
      ExplicitLeft = 642
      ExplicitWidth = 91
    end
    inherited tbtn5: TToolButton
      Left = 733
      Visible = False
      ExplicitLeft = 733
    end
    inherited tbtnExcel: TToolButton
      Left = 741
      ExplicitLeft = 741
      ExplicitWidth = 91
    end
    inherited tbtnPrinter: TToolButton
      Left = 832
      ExplicitLeft = 832
      ExplicitWidth = 91
    end
    inherited tbtn6: TToolButton
      Left = 923
      ExplicitLeft = 923
    end
    inherited tbtnClose: TToolButton
      Left = 931
      ExplicitLeft = 931
      ExplicitWidth = 91
    end
    object btn1: TToolButton
      Left = 1022
      Top = 0
      Caption = #27719#24635#26126#32454
      ImageIndex = 6
      OnClick = btn1Click
    end
  end
  inherited Panel1: TPanel
    Top = 148
    Width = 1176
    Height = 410
    ExplicitTop = 148
    ExplicitWidth = 1176
    ExplicitHeight = 410
    object Splitter1: TSplitter [0]
      Left = 893
      Top = 0
      Height = 410
      Align = alRight
      ExplicitLeft = 1088
      ExplicitTop = 64
      ExplicitHeight = 100
    end
    inherited GroupBox1: TGroupBox
      Width = 893
      Height = 410
      ExplicitWidth = 893
      ExplicitHeight = 410
      inherited dbgrdhResult: TNvDbgridEh
        Width = 889
        Height = 392
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'balancemonth'
            Footers = <>
            Title.Caption = #32467#31639#26085#26399
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32467#24080#36710#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'objectname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32467#31639#23545#35937
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'objectname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #32467#31639#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balanceno'
            Footers = <>
            Title.Caption = #32467#24080#21333#21495
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'ditotalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#20154#25968
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'invoicesnum'
            Footers = <>
            Title.Caption = #32467#31639#21333#24352#25968
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'ditotalmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ticketincome'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33829#25910
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34892#21253#33829#25910
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'packmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34892#21253#24212#32467
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'rentmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21253#36710#33829#25910
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'rentprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21253#36710#24212#32467
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'debit'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36829#35268#32602#27454
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'backmoney'
            Footers = <>
            Title.Caption = #36820#36824#37329#39069
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'balancemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#32467#24080#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'distationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'diotherpredeductifee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#23427#25187#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#38468#21152#36153
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'divide'
            Footers = <>
            Title.Caption = #20998#23618#27604#20363
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'dividename'
            Footers = <>
            Title.Caption = #20998#23618#23545#35937
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'diagentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'dibalanceablemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#32467#31639#37329#39069
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'dipersonkilometre'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#20844#37324#25968
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'dideductmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#25187#27454#37329#39069
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'returnmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34917#24405#36816#37327#21333#24212#32467#37329#39069
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'vipscoremoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25187#38500#31215#20998#22522#37329
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'lastlost'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19978#27425#32467#24080#28322#27424#27454
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'lost'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26412#27425#32467#24080#28322#27424#27454
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'deratemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20943#20813#37329#39069
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'lateforfeit'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26202#28857#32602#37329
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'lostforfeit'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33073#29677#32602#37329
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'balancetime'
            Footers = <>
            Title.Caption = #32467#24080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'balancebyname'
            Footers = <>
            Title.Caption = #32467#24080#20154
            Width = 117
          end
          item
            EditButtons = <>
            FieldName = 'balanceip'
            Footers = <>
            Title.Caption = #32467#24080#35745#31639#26426'ip'
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'cancelip'
            Footers = <>
            Title.Caption = #27880#38144#35745#31639#26426#21517#31216
            Width = 116
          end
          item
            EditButtons = <>
            FieldName = 'cancelbyname'
            Footers = <>
            Title.Caption = #27880#38144#20154
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'cleartime'
            Footers = <>
            Title.Caption = #27880#38144#26102#38388
            Width = 140
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object pnl1: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object grp1: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 0
              Align = alClient
              Caption = #26597#35810#32467#26524
              TabOrder = 0
              object nvdbgrdh1: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 1295
                Height = 229
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsResult
                Flat = False
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -14
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                ImeMode = imDisable
                ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -14
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
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
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'orgname'
                    Footers = <>
                    Title.Caption = #26426#26500
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'routename'
                    Footers = <>
                    Title.Caption = #33829#36816#32447#36335
                    Width = 95
                  end
                  item
                    EditButtons = <>
                    FieldName = 'status'
                    Footers = <>
                    Visible = False
                    Width = 76
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unitname'
                    Footers = <>
                    Title.Caption = #33829#36816#21333#20301
                    Width = 97
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicletypename'
                    Footers = <>
                    Title.Caption = #36710#22411
                    Width = 112
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seatnum'
                    Footers = <>
                    Title.Caption = #24231#20301#25968
                    Width = 53
                  end
                  item
                    EditButtons = <>
                    FieldName = 'soldeatnum'
                    Footers = <>
                    Title.Caption = #24050#21806
                    Width = 42
                  end
                  item
                    EditButtons = <>
                    FieldName = 'distance'
                    Footers = <>
                    Title.Caption = #20844#37324#25968
                    Width = 98
                  end
                  item
                    EditButtons = <>
                    FieldName = 'autocancelreserveseatnum'
                    Footers = <>
                    Title.Caption = #33258#21160#21462#28040#30041#20301#25968
                    Width = 110
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unautocancelreserveseatnum'
                    Footers = <>
                    Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
                    Width = 124
                  end
                  item
                    EditButtons = <>
                    FieldName = 'runtime'
                    Footers = <>
                    Title.Caption = #36816#34892#26102#38388
                    Width = 61
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departdate'
                    Footers = <>
                    Title.Caption = #21457#36710#26085#26399
                    Width = 83
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departtime'
                    Footers = <>
                    Title.Caption = #21457#36710#26102#38388
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'highdistance'
                    Footers = <>
                    Title.Caption = #39640#36895#37324#31243
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isovertime'
                    Footers = <>
                    Title.Caption = #26159#21542#21152#29677
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'islinework'
                    Footers = <>
                    Title.Caption = #26159#21542#27969#27700#29677
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'worktype'
                    Footers = <>
                    Title.Caption = #33829#36816#31867#21035
                    Width = 65
                  end
                  item
                    EditButtons = <>
                    FieldName = 'workways'
                    Footers = <>
                    Width = 81
                  end
                  item
                    EditButtons = <>
                    FieldName = 'districttype'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isproprietary'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issellreturnticket'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'endtime'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isoriginator'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issaleafterrepor'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'iscanmixcheck'
                    Footers = <>
                  end
                  item
                    EditButtons = <>
                    FieldName = 'statusname'
                    Footers = <>
                    Title.Caption = #29677#27425#29366#24577
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
          end
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 896
      Top = 0
      Width = 280
      Height = 410
      Align = alRight
      Caption = #25187#36153#26126#32454
      TabOrder = 1
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 276
        Height = 392
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
        PrintOptions = [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]
        PrintAutoNewLine = False
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25187#36153#21517#31216
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'deductmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#25187#36153
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'divdedeductmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20998#25104#25187#36153
            Width = 65
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 96
    Top = 360
  end
  inherited ilToolBarDisable: TImageList
    Left = 184
    Top = 360
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'balancedlist'
    QueryAddress = 'balance/queryBalanced'
    SaveAddress = 'balance/queryBalanced'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_b!balancetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_b!balancetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_b!balanceip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_b!balanceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_b!objectid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_co!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_b!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_b!vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_b!unitid'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 232
    Top = 280
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 368
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 360
  end
  object jcdsSchedulestatus: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'schedulestatus'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'schedulestatus'
      end>
    Left = 632
    Top = 336
  end
  object jscdcancelBalance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/cancelBalance'
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
        Name = 'ip'
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
    Left = 384
    Top = 208
  end
  object jscdQryDeducts: TjsonClientDataSet
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
    Left = 808
    Top = 224
  end
  object DataSource1: TDataSource
    DataSet = jscdQryDeducts
    Left = 752
    Top = 232
  end
  object jcdsisHaveDepartinvoice: TjsonClientDataSet
    DataSourceName = 'haveDepartinvoicelist'
    QueryAddress = 'balance/isHaveDepartinvoice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 472
    Top = 304
  end
  object jcdsQryTotalDetail: TjsonClientDataSet
    DataSourceName = 'balancedetailprintlist'
    QueryAddress = 'balance/qryBalancedetailPrint'
    SaveAddress = 'balance/qryBalancedetailPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balanceid'
        ParamType = ptInput
      end>
    Left = 561
    Top = 233
  end
  object DataSource2: TDataSource
    DataSet = jcdsQryTotalDetail
    Left = 640
    Top = 231
  end
  object AcRptEngineTotalDeatil: TAcRptEngine
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 456
    Top = 248
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
    Left = 144
    Top = 256
  end
  object DataSource3: TDataSource
    DataSet = jcdsbalanceACPrint
    Left = 56
    Top = 256
  end
end
