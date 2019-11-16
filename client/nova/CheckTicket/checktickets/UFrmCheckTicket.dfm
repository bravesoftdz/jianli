inherited FrmCheckTicket: TFrmCheckTicket
  Caption = #32508#21512#26816#31080
  ClientHeight = 563
  ClientWidth = 1360
  Font.Charset = GB2312_CHARSET
  Font.Height = -16
  KeyPreview = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitLeft = -105
  ExplicitWidth = 1376
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnlQuery: TPanel
    Top = 49
    Width = 1360
    Height = 91
    ExplicitTop = 49
    ExplicitWidth = 1360
    ExplicitHeight = 91
    object Label1: TLabel
      Left = 500
      Top = 19
      Width = 72
      Height = 16
      Caption = #21040#31449'(F12)'
    end
    object Label3: TLabel
      Left = 284
      Top = 49
      Width = 64
      Height = 16
      Caption = #31080#21495'(F1)'
    end
    object Label7: TLabel
      Left = 708
      Top = 19
      Width = 64
      Height = 16
      Caption = #21457#36710#26102#38388
    end
    object Label9: TLabel
      Left = 724
      Top = 49
      Width = 48
      Height = 16
      Caption = #27969#27700#21495
      Visible = False
    end
    object Label13: TLabel
      Left = 524
      Top = 49
      Width = 48
      Height = 16
      Caption = #29677#27425#21495
    end
    object Label14: TLabel
      Left = 299
      Top = 19
      Width = 48
      Height = 16
      Caption = #21457#36710#31449
    end
    object lbl4: TLabel
      Left = 724
      Top = 49
      Width = 48
      Height = 16
      Caption = #36710#29260#21495
    end
    object Label15: TLabel
      Left = 891
      Top = 49
      Width = 48
      Height = 16
      Caption = #35777#20214#21495
      Visible = False
    end
    object GroupBox6: TGroupBox
      Left = 13
      Top = 13
      Width = 188
      Height = 62
      Align = alCustom
      TabOrder = 0
      object Label2: TLabel
        Left = 7
        Top = 29
        Width = 64
        Height = 16
        Caption = #21457#36710#26085#26399
      end
      object ChkAddCheck: TCheckBox
        Left = 2
        Top = -1
        Width = 90
        Height = 20
        Caption = '&F4.'#34917#26816
        TabOrder = 0
        OnClick = ChkAddCheckClick
      end
      object DpDepartDate: TDateTimePicker
        Left = 76
        Top = 25
        Width = 104
        Height = 22
        Date = 40333.738843125000000000
        Time = 40333.738843125000000000
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        TabOrder = 1
        OnChange = DpDepartDateChange
      end
    end
    object GroupBox5: TGroupBox
      Left = 204
      Top = 15
      Width = 75
      Height = 60
      Align = alCustom
      Caption = #26816#31080#21475
      TabOrder = 1
      object NovaHCobEntrance: TNovaCheckedComboBox
        Left = 6
        Top = 24
        Width = 59
        Height = 22
        ColorNotFocus = clWhite
        ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Version = '1.2'
        OnExit = NovaHCobEntranceExit
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'entrancelist'
        HelpOptions.HQueryAddress = 'checkticket/qryTicketentrance'
        HelpOptions.SelectAll = True
        Params = <
          item
            DataType = ftString
            Name = 'ip'
            ParamType = ptInput
          end
          item
            DataType = ftString
            Name = 'orgid'
            ParamType = ptInput
          end>
      end
    end
    object NovaEdtTicketNo: TNovaEdit
      Left = 351
      Top = 46
      Width = 138
      Height = 27
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 20
      ParentFont = False
      TabOrder = 2
      OnEnter = NovaEdtTicketNoEnter
      OnKeyPress = NovaEdtTicketNoKeyPress
      OnKeyUp = NovaEdtTicketNoKeyUp
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
    object NovaHelpEndStation: TNovaHelp
      Left = 578
      Top = 16
      Width = 118
      Height = 24
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 3
      OnKeyPress = NovaHelpEndStationKeyPress
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
          Title.Caption = #31449#28857#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 60
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
    object dtpfromdatetime: TDateTimePicker
      Left = 778
      Top = 16
      Width = 105
      Height = 24
      Date = 37571.000162037000000000
      Format = 'HH:mm'
      Time = 37571.000162037000000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      Kind = dtkTime
      TabOrder = 4
    end
    object NovaEdtSeatNo: TNovaEdit
      Left = 778
      Top = 46
      Width = 105
      Height = 24
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 4
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TextHint = #36755#20837#27969#27700#21495#21518#35831#22238#36710
      Visible = False
      OnKeyPress = NovaEdtSeatNoKeyPress
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
    object NovaEdtCardNo: TNovaEdit
      Left = 965
      Top = 6
      Width = 170
      Height = 24
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 6
      Visible = False
      OnChange = NovaEdtCardNoChange
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
    object NovaHelpSchedule: TNovaHelp
      Left = 578
      Top = 46
      Width = 118
      Height = 24
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 7
      OnKeyPress = NovaHelpScheduleKeyPress
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
    object nvcbbstation: TNovaCheckedComboBox
      Left = 353
      Top = 16
      Width = 136
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qrystation'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = False
      Params = <>
    end
    object cbbNvehicleno: TNovaHelp
      Left = 778
      Top = 46
      Width = 103
      Height = 24
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaEditcertificateNo: TNovaEdit
      Left = 939
      Top = 46
      Width = 181
      Height = 27
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 20
      ParentFont = False
      TabOrder = 10
      Visible = False
      OnEnter = NovaEditcertificateNoEnter
      OnKeyPress = NovaEdtTicketNoKeyPress
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
  inherited tlbShortCut: TToolBar
    Width = 1360
    Height = 49
    AutoSize = False
    ButtonHeight = 47
    ButtonWidth = 87
    ExplicitWidth = 1360
    ExplicitHeight = 49
    inherited tbtnFilter: TToolButton
      AutoSize = True
      Caption = '&F5.'#26597#35810
      OnClick = tbtnFilterClick
      ExplicitWidth = 67
      ExplicitHeight = 47
    end
    inherited tbtn1: TToolButton
      Left = 67
      ExplicitLeft = 67
      ExplicitHeight = 47
    end
    inherited tbtnInsert: TToolButton
      Left = 75
      AutoSize = True
      Caption = '&F3.'#36864#26816
      ImageIndex = 54
      OnClick = tbtnInsertClick
      ExplicitLeft = 75
      ExplicitWidth = 67
      ExplicitHeight = 47
    end
    inherited tbtnEdit: TToolButton
      Left = 142
      AutoSize = True
      Caption = ' '#36830#26816' '
      ImageIndex = 53
      OnClick = tbtnEditClick
      ExplicitLeft = 142
      ExplicitWidth = 59
      ExplicitHeight = 47
    end
    inherited tbtnDelete: TToolButton
      Left = 201
      AutoSize = True
      Caption = '&F6.'#20840#26816
      ImageIndex = 56
      OnClick = tbtnDeleteClick
      ExplicitLeft = 201
      ExplicitWidth = 67
      ExplicitHeight = 47
    end
    inherited ToolButton50: TToolButton
      Left = 268
      Caption = '&F7.'#28151#26816
      ImageIndex = 55
      Visible = True
      OnClick = ToolButton50Click
      ExplicitLeft = 268
      ExplicitWidth = 67
      ExplicitHeight = 47
    end
    inherited ToolButton51: TToolButton
      Left = 335
      Caption = #25972#36710#36864#26816
      ImageIndex = 39
      Visible = True
      OnClick = ToolButton51Click
      ExplicitLeft = 335
      ExplicitWidth = 75
      ExplicitHeight = 47
    end
    inherited tbtn3: TToolButton
      Left = 410
      Width = 7
      Caption = ''
      ImageIndex = 8
      ExplicitLeft = 410
      ExplicitWidth = 7
      ExplicitHeight = 47
    end
    inherited tbtnSave: TToolButton
      Left = 417
      AutoSize = True
      Caption = #25163#24037#21333
      ImageIndex = 2
      OnClick = tbtnSaveClick
      ExplicitLeft = 417
      ExplicitWidth = 59
      ExplicitHeight = 47
    end
    inherited tbtnCancel: TToolButton
      Left = 476
      Hint = #34917#24320#36816#37327#21333
      AutoSize = True
      Caption = 'F10.'#34917#24320
      ImageIndex = 45
      OnClick = tbtnCancelClick
      ExplicitLeft = 476
      ExplicitWidth = 75
      ExplicitHeight = 47
    end
    inherited ToolButton52: TToolButton
      Left = 551
      Width = 8
      AutoSize = False
      Style = tbsSeparator
      Visible = True
      ExplicitLeft = 551
      ExplicitWidth = 8
      ExplicitHeight = 47
    end
    inherited ToolButton53: TToolButton
      Left = 559
      Caption = '&F2.'#21457#29677
      ImageIndex = 17
      Visible = True
      OnClick = ToolButton53Click
      ExplicitLeft = 559
      ExplicitWidth = 67
      ExplicitHeight = 47
    end
    inherited tbtn4: TToolButton
      Left = 626
      Caption = '&F8.'#21462#28040
      ImageIndex = 18
      Style = tbsButton
      OnClick = tbtn4Click
      ExplicitLeft = 626
      ExplicitWidth = 87
      ExplicitHeight = 47
    end
    inherited tbtnInfo: TToolButton
      Left = 713
      AutoSize = True
      Caption = #24320#21551#26816#31080
      ImageIndex = 19
      ExplicitLeft = 713
      ExplicitWidth = 75
      ExplicitHeight = 47
    end
    inherited tbtn5: TToolButton
      Left = 788
      AutoSize = True
      Caption = '&P.'#37325#25171
      ImageIndex = 8
      Style = tbsButton
      OnClick = tbtn5Click
      ExplicitLeft = 788
      ExplicitWidth = 59
      ExplicitHeight = 47
    end
    inherited tbtnExcel: TToolButton
      Left = 847
      AutoSize = True
      Caption = '&F9.'#26126#32454
      ImageIndex = 53
      ExplicitLeft = 847
      ExplicitWidth = 67
      ExplicitHeight = 47
    end
    inherited tbtnPrinter: TToolButton
      Left = 914
      AutoSize = True
      Caption = ' '#24191#25773' '
      ImageIndex = 48
      ExplicitLeft = 914
      ExplicitWidth = 59
      ExplicitHeight = 47
    end
    inherited tbtn6: TToolButton
      Left = 973
      ExplicitLeft = 973
      ExplicitHeight = 47
    end
    inherited tbtnClose: TToolButton
      Left = 981
      AutoSize = True
      Caption = ' '#20851#38381
      ExplicitLeft = 981
      ExplicitWidth = 51
      ExplicitHeight = 47
    end
    object btnonecard: TToolButton
      Left = 1032
      Top = 0
      AutoSize = True
      Caption = #21047#21345#19978#36710
      ImageIndex = 12
      OnClick = btnonecardClick
    end
    object btnreturnonecard: TToolButton
      Left = 1107
      Top = 0
      AutoSize = True
      Caption = #21047#21345#36864#31080
      ImageIndex = 13
      OnClick = btnreturnonecardClick
    end
    object TtnTotalCheck: TToolButton
      Left = 1182
      Top = 0
      AutoSize = True
      Caption = ' '#36890#26816' '
      ImageIndex = 55
      OnClick = TtnTotalCheckClick
    end
    object ToolButton1: TToolButton
      Left = 1241
      Top = 0
      AutoSize = True
      Caption = ' '#36828#26816' '
      ImageIndex = 56
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 1300
      Top = 0
      Caption = #25171#21360#21021#26816#21333
      ImageIndex = 8
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 1387
      Top = 0
      Caption = #37325#25171#21021#26816#21333
      ImageIndex = 8
      OnClick = ToolButton3Click
    end
  end
  inherited Panel1: TPanel
    Top = 140
    Width = 1360
    Height = 423
    ExplicitTop = 140
    ExplicitWidth = 1360
    ExplicitHeight = 423
    object Splitter1: TSplitter [0]
      Left = 352
      Top = 0
      Height = 423
      ExplicitLeft = 272
      ExplicitTop = 112
      ExplicitHeight = 100
    end
    inherited GroupBox1: TGroupBox
      Width = 352
      Height = 423
      Align = alLeft
      Caption = ''
      ExplicitWidth = 352
      ExplicitHeight = 423
      inherited dbgrdhResult: TNvDbgridEh
        Top = 18
        Width = 348
        Height = 403
        Color = clWhite
        Font.Height = -16
        Font.Style = [fsBold]
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Height = -16
        FooterRowCount = 1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        PopupMenu = pm2
        ReadOnly = False
        SumList.Active = True
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Height = -16
        OnCellClick = dbgrdhResultCellClick
        OnDblClick = dbgrdhResultDblClick
        OnGetCellParams = dbgrdhResultGetCellParams
        Columns = <
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #26102#38388
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #25253#21040#36710#36742
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #21806
            Width = 25
          end
          item
            EditButtons = <>
            FieldName = 'checkeds'
            Footers = <>
            Title.Caption = #26816
            Width = 25
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#29677
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'schtype'
            Footers = <>
            Title.Caption = #29677#27425#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end>
      end
      object ChkIsReproted: TCheckBox
        Left = 36
        Top = -1
        Width = 66
        Height = 19
        Caption = #24050#25253#21040
        TabOrder = 1
        OnClick = ChkIsReprotedClick
      end
      object ChkIsdepart: TCheckBox
        Left = 108
        Top = 0
        Width = 66
        Height = 17
        Caption = #26410#21457#29677
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = ChkNotReprotedClick
      end
    end
    object Panel2: TPanel
      Left = 355
      Top = 0
      Width = 1005
      Height = 423
      Align = alClient
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'Panel2'
      TabOrder = 1
      object PcScheduleInfo: TPageControl
        Left = 0
        Top = 42
        Width = 1001
        Height = 377
        ActivePage = TabSheet2
        Align = alClient
        Images = ilToolBar
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = #38750#27969#27700#29677#27425#20449#24687
          object PaneNotOnline: TPanel
            Left = 0
            Top = 0
            Width = 993
            Height = 340
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object pnlseatplan: TPanel
              Left = 0
              Top = 105
              Width = 993
              Height = 235
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlue
              Font.Height = -16
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object GroupBox3: TGroupBox
              Tag = 99
              Left = 0
              Top = 0
              Width = 993
              Height = 105
              Align = alTop
              Caption = #29677#27425#20449#24687
              Color = clBtnHighlight
              ParentColor = False
              TabOrder = 1
              object Shape1: TShape
                Left = 26
                Top = 16
                Width = 660
                Height = 96
              end
              object Label8: TLabel
                Left = 535
                Top = 31
                Width = 32
                Height = 16
                Caption = #26410#26816
                Transparent = True
              end
              object LabUnCheckeds: TLabel
                Left = 532
                Top = 63
                Width = 37
                Height = 24
                Alignment = taCenter
                AutoSize = False
                Caption = '18'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Label5: TLabel
                Left = 46
                Top = 32
                Width = 64
                Height = 16
                Caption = #21457#36710#26085#26399
              end
              object LabDepartDate: TLabel
                Left = 26
                Top = 66
                Width = 111
                Height = 19
                Alignment = taCenter
                AutoSize = False
                Caption = '2010-12-12'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -19
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Bevel7: TBevel
                Left = 22
                Top = 51
                Width = 660
                Height = 4
                Shape = bsBottomLine
              end
              object Bevel8: TBevel
                Left = 140
                Top = 24
                Width = 2
                Height = 70
              end
              object Label12: TLabel
                Left = 143
                Top = 32
                Width = 64
                Height = 16
                Caption = #21457#36710#26102#38388
              end
              object LabDepartTime: TLabel
                Left = 143
                Top = 65
                Width = 65
                Height = 21
                Alignment = taCenter
                AutoSize = False
                Caption = '12:12'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -21
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Bevel9: TBevel
                Left = 210
                Top = 24
                Width = 2
                Height = 70
              end
              object Bevel10: TBevel
                Left = 320
                Top = 25
                Width = 2
                Height = 70
              end
              object Label23: TLabel
                Left = 440
                Top = 33
                Width = 48
                Height = 16
                Caption = #20056#36710#24211
              end
              object LabBusPark: TLabel
                Left = 440
                Top = 64
                Width = 49
                Height = 19
                Alignment = taCenter
                AutoSize = False
                Caption = '12'#21495
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -19
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Bevel12: TBevel
                Left = 430
                Top = 24
                Width = 2
                Height = 70
              end
              object Label25: TLabel
                Left = 350
                Top = 31
                Width = 48
                Height = 16
                Caption = #32456#28857#31449
              end
              object LabEndStation: TLabel
                Left = 320
                Top = 63
                Width = 112
                Height = 20
                Alignment = taCenter
                AutoSize = False
                Caption = #24191#24030#30465#31449
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -20
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label27: TLabel
                Left = 252
                Top = 32
                Width = 32
                Height = 16
                Caption = #29677#27425
              end
              object LabCode: TLabel
                Left = 220
                Top = 65
                Width = 95
                Height = 21
                Alignment = taCenter
                AutoSize = False
                Caption = '89877'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -21
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object bvl1: TBevel
                Left = 490
                Top = 23
                Width = 2
                Height = 72
              end
              object bvl2: TBevel
                Left = 530
                Top = 23
                Width = 2
                Height = 72
              end
              object Label6: TLabel
                Left = 495
                Top = 32
                Width = 32
                Height = 16
                Caption = #24050#26816
                Transparent = True
              end
              object LabCheckeds: TLabel
                Left = 493
                Top = 63
                Width = 36
                Height = 24
                Alignment = taCenter
                AutoSize = False
                Caption = '2'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Bevel1: TBevel
                Left = 568
                Top = 23
                Width = 2
                Height = 72
              end
              object Label11: TLabel
                Left = 575
                Top = 32
                Width = 32
                Height = 16
                Caption = #20813#31080
              end
              object LabChildnum: TLabel
                Left = 575
                Top = 63
                Width = 36
                Height = 24
                Alignment = taCenter
                AutoSize = False
                Caption = '0'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object lblOneCardChecketdnum: TLabel
                Left = 615
                Top = 65
                Width = 51
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
                Transparent = True
              end
              object bvl3: TBevel
                Left = 610
                Top = 24
                Width = 2
                Height = 72
              end
              object lbl1: TLabel
                Left = 615
                Top = 32
                Width = 48
                Height = 16
                Caption = #19968#21345#36890
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #27969#27700#29677#29677#27425#20449#24687
          ImageIndex = 1
          object PlanOnlineSchedule: TPanel
            Left = 0
            Top = 0
            Width = 993
            Height = 340
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object grp2: TGroupBox
              Left = 0
              Top = 121
              Width = 993
              Height = 219
              Align = alClient
              Caption = #27969#27700#29677#24403#21069#25253#21040#36710#36742
              TabOrder = 0
              object nvdbgrdhcodelist: TNvDbgridEh
                Left = 2
                Top = 18
                Width = 989
                Height = 199
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsVehicleReport
                Flat = False
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -16
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                ImeMode = imClose
                ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ParentFont = False
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = GB2312_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -16
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                OnCellClick = nvdbgrdhcodelistCellClick
                OnDblClick = nvdbgrdhcodelistDblClick
                OnDrawColumnCell = nvdbgrdhcodelistDrawColumnCell
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
                    FieldName = 'vehicleno'
                    Footer.Value = #21512#35745
                    Footer.ValueType = fvtStaticText
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #36710#29260#21495#30721
                    Width = 98
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seatnum'
                    Footer.ValueType = fvtCount
                    Footers = <>
                    Title.Caption = #24231#20301#25968
                    Width = 59
                  end
                  item
                    EditButtons = <>
                    FieldName = 'reporttime'
                    Footers = <>
                    Title.Alignment = taCenter
                    Title.Caption = #25253#21040#26102#38388
                    Width = 184
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicletype'
                    Footers = <>
                    Title.Caption = #25253#21040#36710#22411
                    Width = 147
                  end
                  item
                    EditButtons = <>
                    FieldName = 'brandname'
                    Footers = <>
                    Title.Caption = #36710#36742#21378#29260
                    Width = 123
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
              object chkReportIsDepart: TCheckBox
                Left = 170
                Top = 0
                Width = 119
                Height = 17
                Caption = #24050#21457#29677#36710#36742
                TabOrder = 1
                OnClick = chkReportIsDepartClick
              end
            end
            object GroupBox7: TGroupBox
              Tag = 99
              Left = 0
              Top = 0
              Width = 993
              Height = 121
              Align = alTop
              Caption = #29677#27425#20449#24687
              Color = clBtnHighlight
              ParentColor = False
              TabOrder = 1
              object Shape2: TShape
                Left = 19
                Top = 27
                Width = 643
                Height = 77
              end
              object Label26: TLabel
                Left = 42
                Top = 36
                Width = 64
                Height = 16
                Caption = #21457#36710#26085#26399
              end
              object LabOnDepartdate: TLabel
                Left = 19
                Top = 72
                Width = 123
                Height = 16
                Alignment = taCenter
                AutoSize = False
                Caption = '2010'#24180'12'#26376'12'#26085
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -19
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Bevel19: TBevel
                Left = 19
                Top = 58
                Width = 643
                Height = 3
                Shape = bsBottomLine
              end
              object Bevel20: TBevel
                Left = 142
                Top = 28
                Width = 2
                Height = 76
              end
              object Bevel22: TBevel
                Left = 218
                Top = 28
                Width = 2
                Height = 76
              end
              object Label32: TLabel
                Left = 349
                Top = 34
                Width = 48
                Height = 16
                Caption = #39564#31080#21475
              end
              object LabOnEntrance: TLabel
                Left = 338
                Top = 71
                Width = 82
                Height = 19
                Alignment = taCenter
                AutoSize = False
                Caption = '12'#21495#21345#20301
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -19
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label34: TLabel
                Left = 444
                Top = 36
                Width = 48
                Height = 16
                Caption = #20056#36710#24211
              end
              object LabOnBusPark: TLabel
                Left = 426
                Top = 71
                Width = 82
                Height = 19
                Alignment = taCenter
                AutoSize = False
                Caption = '12'#21495#21345#20301
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -19
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Bevel23: TBevel
                Left = 423
                Top = 27
                Width = 2
                Height = 77
              end
              object Bevel24: TBevel
                Left = 336
                Top = 28
                Width = 2
                Height = 76
              end
              object Label36: TLabel
                Left = 257
                Top = 36
                Width = 32
                Height = 16
                Caption = #21040#31449
              end
              object LabOnReachStation: TLabel
                Left = 222
                Top = 70
                Width = 112
                Height = 20
                Alignment = taCenter
                AutoSize = False
                Caption = #24191#24030#30465#31449
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -20
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label38: TLabel
                Left = 165
                Top = 36
                Width = 32
                Height = 16
                Caption = #36710#27425
              end
              object LabOnCode: TLabel
                Left = 144
                Top = 71
                Width = 73
                Height = 19
                Alignment = taCenter
                AutoSize = False
                Caption = '89877'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -19
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
              end
              object bvl4: TBevel
                Left = 511
                Top = 28
                Width = 2
                Height = 77
              end
              object Label18: TLabel
                Left = 518
                Top = 34
                Width = 32
                Height = 16
                Caption = #24050#26816
                Transparent = True
              end
              object LabOnlineCheckeds: TLabel
                Left = 515
                Top = 69
                Width = 43
                Height = 22
                Alignment = taCenter
                AutoSize = False
                Caption = '2'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object lbllineOneCardChecketdnum: TLabel
                Left = 610
                Top = 70
                Width = 45
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
                Transparent = True
              end
              object lbl3: TLabel
                Left = 608
                Top = 32
                Width = 48
                Height = 16
                Caption = #19968#21345#36890
              end
              object bvl5: TBevel
                Left = 559
                Top = 27
                Width = 2
                Height = 77
              end
              object Bevel2: TBevel
                Left = 604
                Top = 27
                Width = 2
                Height = 77
              end
              object Label10: TLabel
                Left = 566
                Top = 34
                Width = 32
                Height = 16
                Caption = #26410#26816
                Transparent = True
              end
              object LabLineUnCheck: TLabel
                Left = 564
                Top = 68
                Width = 37
                Height = 27
                Alignment = taCenter
                AutoSize = False
                Caption = '18'
                Font.Charset = GB2312_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = #23435#20307
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
            end
          end
        end
      end
      object pnl1: TPanel
        Left = 0
        Top = 0
        Width = 1001
        Height = 42
        Align = alTop
        Color = clInfoBk
        ParentBackground = False
        TabOrder = 1
        object lbl2: TLabel
          Left = 4
          Top = 4
          Width = 11
          Height = 20
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -20
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object grp1: TGroupBox
          Left = 706
          Top = 1
          Width = 294
          Height = 40
          Align = alRight
          Caption = #24403#21069#32467#31639#21333#21495
          TabOrder = 0
          object lblBillnum: TLabel
            Left = 190
            Top = 18
            Width = 102
            Height = 20
            Align = alClient
            Caption = '100'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 33
            ExplicitHeight = 19
          end
          object lblBillno: TLabel
            Left = 2
            Top = 18
            Width = 88
            Height = 20
            Align = alLeft
            Caption = '88888888'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
          object Label4: TLabel
            Left = 90
            Top = 18
            Width = 100
            Height = 20
            Align = alLeft
            Caption = #21097#20313#24352#25968#65306
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
        end
        object grp3: TGroupBox
          Left = 412
          Top = 1
          Width = 294
          Height = 40
          Align = alRight
          Caption = #24403#21069#21021#26816#21333#21495
          TabOrder = 1
          object lbllBillnum1: TLabel
            Left = 190
            Top = 18
            Width = 102
            Height = 20
            Align = alClient
            Caption = '100'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 33
            ExplicitHeight = 19
          end
          object lblBillno1: TLabel
            Left = 2
            Top = 18
            Width = 88
            Height = 20
            Align = alLeft
            Caption = '88888888'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
          object lblabel15: TLabel
            Left = 90
            Top = 18
            Width = 100
            Height = 20
            Align = alLeft
            Caption = #21097#20313#24352#25968#65306
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -19
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitHeight = 19
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 40
    Top = 280
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'planlist'
    QueryAddress = 'checkticket/qryScheduleplan'
    Params = <
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reportorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ta!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sp!endstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isreported'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isdeparted'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GES_ss!departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sp!scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_vr!vehicleid'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 176
    Top = 256
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultdepartstation: TWideStringField
      FieldName = 'departstation'
      Size = 40
    end
    object jcdsResultendstation: TWideStringField
      FieldName = 'endstation'
      Size = 40
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsResultseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsResultsoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 50
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 50
    end
    object jcdsResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 50
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsResultschedulestatus: TWideStringField
      FieldKind = fkLookup
      FieldName = 'schedulestatus'
      LookupDataSet = jcdsScheduleStatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object jcdsResultplanvehiclebrandmodelid: TLargeintField
      FieldName = 'planvehiclebrandmodelid'
    end
    object jcdsResultbrandname: TWideStringField
      FieldName = 'brandname'
      Size = 50
    end
    object jcdsResultmodelcode: TWideStringField
      FieldName = 'modelcode'
    end
    object jcdsResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsResultisreported: TBooleanField
      FieldName = 'isreported'
    end
    object jcdsResultisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsResultvehiclereportid: TLargeintField
      FieldName = 'vehiclereportid'
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultdistance: TIntegerField
      FieldName = 'distance'
    end
    object jcdsResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jcdsResultjianpin: TWideStringField
      FieldName = 'jianpin'
      Size = 10
    end
    object jcdsResultcarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object jcdsResultcanonecard: TBooleanField
      FieldName = 'canonecard'
    end
    object jcdsResultcheckeds: TIntegerField
      FieldName = 'checkeds'
    end
    object jcdsResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object jcdsResultschtype: TWideStringField
      FieldName = 'schtype'
    end
    object jcdsResultscheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsResultdepartstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcdsResultendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultischecked: TBooleanField
      FieldName = 'ischecked'
      OnChange = jcdsResultischeckedChange
    end
    object jcdsResultisbegincheck: TBooleanField
      FieldName = 'isbegincheck'
    end
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 176
    Top = 336
  end
  object jcdsScheduleStatus: TjsonClientDataSet
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
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 128
    Top = 208
  end
  object jcdsQrySeatstatus: TjsonClientDataSet
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
    Left = 248
    Top = 288
  end
  object jscdCheckByTicketno: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/checkbyTicketno'
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
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleplanid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'islazycheck'
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
        DataType = ftString
        Name = 'reportid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ticketsellid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate1'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 152
  end
  object jscdcancelCheckticket: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/cancelCheckticket'
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
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleplanid'
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
    Left = 88
    Top = 144
  end
  object jscdQryVehicleReport: TjsonClientDataSet
    DataSourceName = 'reportvehiclelist'
    QueryAddress = 'checkticket/qryReportvehicle'
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
        Name = 'isdeparted'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jscdQryVehicleReportAfterScroll
    Left = 792
    Top = 384
  end
  object dsVehicleReport: TDataSource
    DataSet = jscdQryVehicleReport
    Left = 552
    Top = 408
  end
  object jcdsQryCheckticketeds: TjsonClientDataSet
    DataSourceName = 'checkticketedlist'
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
      end
      item
        DataType = ftInteger
        Name = 'oneCardChecktickets'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'unchecktickets'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 720
    Top = 408
  end
  object jcsdCheckallTickets: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/checkAlltickets'
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
      end
      item
        DataType = ftBCD
        Name = 'checktickets'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'filter_INS_t!departstationid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 200
  end
  object jcdsDepartinvoice: TjsonClientDataSet
    DataSourceName = 'invoiceslist'
    QueryAddress = 'checkticket/vehicleDepartinvoice'
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
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'iscomputeno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isreprint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isprintbynewticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
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
        DataType = ftString
        Name = 'msg1'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 152
  end
  object jcdsQryDetail: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryInvoicesDetailPrintInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 344
  end
  object tmrFlash: TTimer
    Enabled = False
    Interval = 50000
    OnTimer = tmrFlashTimer
    Left = 72
    Top = 328
  end
  object tmGetCurInvoinNo: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmGetCurInvoinNoTimer
    Left = 552
    Top = 344
  end
  object jscdcancelDepartinvoices: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/cancelDepartinvoices'
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
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 832
    Top = 336
  end
  object jcsdQryprintitem: TjsonClientDataSet
    DataSourceName = 'printlist'
    QueryAddress = 'system/qryprintitem'
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
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'templatename'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 520
    Top = 136
  end
  object jscdcheckBySeatno: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/checkBySeatno'
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
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'islazycheck'
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
    Left = 496
    Top = 392
  end
  object jscdcancelAllCheckticket: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/cancelAllCheckticket'
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
        DataType = ftString
        Name = 'filter_INS_t!departstationid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 824
    Top = 176
  end
  object pm1: TPopupMenu
    Left = 392
    Top = 352
    object N1: TMenuItem
      Caption = #29305#26816
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #36864#26816
      OnClick = N2Click
    end
  end
  object jscdAuthCheck: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/checkAuthBySeatno'
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
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'islazycheck'
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
    Left = 456
    Top = 344
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
    Top = 208
  end
  object jcdsOthersells: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'checkticket/qryOthersellmessage'
    SaveAddress = 'checkticket/qryOthersellmessage'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'othersells'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 400
  end
  object jscdSchDepartinvoice: TjsonClientDataSet
    DataSourceName = 'dateset'
    SaveAddress = 'checkticket/schDepartinvoice'
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
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 656
    Top = 128
  end
  object jscdQryDeductfees: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryDeductfees'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 616
    Top = 424
  end
  object jcdsSetScheduleStatus: TjsonClientDataSet
    DataSourceName = 'dataset'
    SaveAddress = 'checkticket/setScheduleStatus'
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
        Name = 'cardno'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 80
    Top = 416
  end
  object jcdsAdjustPack: TjsonClientDataSet
    DataSourceName = 'adjustresultlist'
    QueryAddress = 'pack/adjustPackinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 280
    Top = 344
  end
  object jcdsQryPackItems: TjsonClientDataSet
    DataSourceName = 'packlist'
    QueryAddress = 'pack/listTotalPack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sd!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isbukai'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isreprint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packStockVo.code'
        ParamType = ptOutput
      end
      item
        DataType = ftDate
        Name = 'packStockVo.departdate'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.departtime'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.vehicleno'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.drivername'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.unitname'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 296
    Top = 256
  end
  object jcdsUpdatepack: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/updatPackBy'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_p!scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'singbillno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 360
  end
  object jcdsisnolyticket: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/isnolyticketsell'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketnoisonlyticket'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdateisnolyticket'
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
        DataType = ftString
        Name = 'certificateno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 24
    Top = 184
  end
  object jcdscheckticketbyId: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/checkbyTicketId'
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
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleplanid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'islazycheck'
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
        DataType = ftString
        Name = 'reportid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ticketsellid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate1'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 160
  end
  object jcdscheckticketno: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/checkticketno'
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
        Name = 'id'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'certificateno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 496
    Top = 272
  end
  object jsonQryVehSeateType: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryDeductfees'
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
    Left = 824
    Top = 440
  end
  object jcdsCheckPrintPermission: TjsonClientDataSet
    DataSourceName = 'invoiceslist'
    QueryAddress = 'checkticket/reprintPermission'
    SaveAddress = 'checkticket/reprintPermission'
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
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printpermission'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 624
    Top = 216
  end
  object jcdsFirstCheck: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/queryFirstCheck'
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
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 1144
    Top = 208
  end
  object jscdverifystation: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/verifystation'
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
        DataType = ftBCD
        Name = 'verifystation'
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
      end
      item
        DataType = ftString
        Name = 'filter_INS_t!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 448
  end
  object jcsdQryticketinfobyidcard: TjsonClientDataSet
    DataSourceName = 'ticketlist'
    QueryAddress = 'check/qryticketinfobyIDcard'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQS_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQD_ts!departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 408
    Top = 144
  end
  object jcdssecurityisture: TjsonClientDataSet
    DataSourceName = 'invoiceslist'
    QueryAddress = 'checkticket/vehiclejcdssecurityisture'
    SaveAddress = 'checkticket/vehiclejcdssecurityisture'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg1'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 600
    Top = 288
  end
  object jcdsFirstCheckSave: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    SaveAddress = 'checkticket/saveFirstCheck'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'firstcheck.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.checkinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.ticketnum'
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
        Name = 'firstcheck.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketnums'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reachstationids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'firstcheck.printway'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
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
        Name = 'firstcheck.vehiclereportid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 1232
    Top = 232
  end
  object pm2: TPopupMenu
    Left = 104
    Top = 280
    object N4: TMenuItem
      Caption = #20840#36873
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #21453#36873
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #21462#28040
      OnClick = N6Click
    end
  end
  object jcdsQryFirstCheck: TjsonClientDataSet
    DataSourceName = 'resultlist'
    QueryAddress = 'QueryFirstCheck/QueryFirstCheck'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQD_f!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_f!departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_f!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_f!orgid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 1104
    Top = 40
  end
  object jsonchangeticketstatus: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/changeticketstatus'
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
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'isbegincheck'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 1224
    Top = 48
  end
end
