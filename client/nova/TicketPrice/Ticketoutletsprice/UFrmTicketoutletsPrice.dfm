inherited FrmTicketoutletsPrice: TFrmTicketoutletsPrice
  Caption = #31080#28857#31080#20215#24046#39069#31649#29702
  ClientHeight = 488
  ClientWidth = 1231
  OnShow = FormShow
  ExplicitWidth = 1247
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1231
    Height = 108
    ExplicitWidth = 1231
    ExplicitHeight = 108
    object Label1: TLabel
      Left = 14
      Top = 23
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label8: TLabel
      Left = 216
      Top = 54
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object Label4: TLabel
      Left = 216
      Top = 84
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#21035
    end
    object Label2: TLabel
      Left = 439
      Top = 54
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label6: TLabel
      Left = 425
      Top = 23
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object Label9: TLabel
      Left = 14
      Top = 84
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object Label7: TLabel
      Left = 14
      Top = 54
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object lbl3: TLabel
      Left = 230
      Top = 23
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object Chkisoriginator: TCheckBox
      Left = 526
      Top = 84
      Width = 81
      Height = 17
      Caption = #36807#36335#29677#27425
      TabOrder = 0
    end
    object Chkislinework: TCheckBox
      Left = 430
      Top = 84
      Width = 81
      Height = 17
      Caption = #27969#27700#29677#27425
      TabOrder = 1
    end
    object Chkissellreturnticket: TCheckBox
      Left = 612
      Top = 84
      Width = 81
      Height = 17
      Caption = #21452#31243#29677#27425
      TabOrder = 2
    end
    object CobDISTRICTTYPE: TNovaComboBox
      Left = 75
      Top = 80
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
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
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'districttype'
      HelpOptions.DisAll = True
    end
    object CobWORKWAYS: TNovaComboBox
      Left = 75
      Top = 50
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'workways'
      HelpOptions.DisAll = True
    end
    object NcbbScheduleType: TNovaComboBox
      Left = 486
      Top = 18
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 5
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'scheduletype'
      HelpOptions.DisAll = True
    end
    object NHelpRoute: TNovaHelp
      Left = 278
      Top = 50
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 6
      OnKeyPress = NHelpRouteKeyPress
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
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 75
      Top = 18
      Width = 120
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NEdtScheduleHelpCode: TNovaEdit
      Left = 486
      Top = 50
      Width = 120
      Height = 22
      CharCase = ecUpperCase
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
    object NCbbWorkType: TNovaComboBox
      Left = 278
      Top = 80
      Width = 121
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'worktype'
      HelpOptions.DisAll = True
    end
    object ChkISPROPRIETARY: TCheckBox
      Left = 612
      Top = 54
      Width = 81
      Height = 17
      Caption = #26412#31449#19987#33829
      TabOrder = 10
    end
    object nvhelpTicketoutlets: TNovaHelp
      Left = 278
      Top = 18
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 168
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1231
    ButtonWidth = 91
    ExplicitWidth = 1231
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
      Caption = #22686#21152
      OnClick = tbtnInsertClick
      ExplicitLeft = 99
      ExplicitWidth = 91
    end
    inherited tbtnEdit: TToolButton
      Left = 190
      OnClick = tbtnEditClick
      ExplicitLeft = 190
      ExplicitWidth = 91
    end
    inherited tbtnDelete: TToolButton
      Left = 281
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
      Caption = #22797#21046#31080#20215
      ImageIndex = 14
      Visible = False
      ExplicitLeft = 416
      ExplicitWidth = 91
    end
    inherited tbtnCancel: TToolButton
      Left = 507
      Caption = #22797#21046#22987#21457#31080#20215
      ImageIndex = 15
      Visible = False
      ExplicitLeft = 507
      ExplicitWidth = 91
    end
    inherited ToolButton52: TToolButton
      Left = 598
      AutoSize = False
      Caption = #31449#28857#31080#20215
      ImageIndex = 15
      ExplicitLeft = 598
      ExplicitWidth = 91
    end
    inherited ToolButton53: TToolButton
      Left = 689
      ExplicitLeft = 689
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 707
      ExplicitLeft = 707
    end
    inherited tbtnInfo: TToolButton
      Left = 715
      ExplicitLeft = 715
      ExplicitWidth = 91
    end
    inherited tbtn5: TToolButton
      Left = 806
      ExplicitLeft = 806
    end
    inherited tbtnExcel: TToolButton
      Left = 814
      ExplicitLeft = 814
      ExplicitWidth = 91
    end
    inherited tbtnPrinter: TToolButton
      Left = 905
      ExplicitLeft = 905
      ExplicitWidth = 91
    end
    inherited tbtn6: TToolButton
      Left = 996
      ExplicitLeft = 996
    end
    inherited tbtnClose: TToolButton
      Left = 1004
      ExplicitLeft = 1004
      ExplicitWidth = 91
    end
  end
  inherited Panel1: TPanel
    Top = 153
    Width = 1231
    Height = 335
    ExplicitTop = 153
    ExplicitWidth = 1231
    ExplicitHeight = 335
    object Splitter1: TSplitter [0]
      Left = 0
      Top = 109
      Width = 1231
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 193
      ExplicitWidth = 69
    end
    inherited GroupBox1: TGroupBox
      Width = 1231
      Height = 109
      ExplicitWidth = 1231
      ExplicitHeight = 109
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1227
        Height = 91
        FooterRowCount = 1
        SortLocal = True
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25152#23646#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'outletsname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #25152#23646#32447#36335
            Width = 119
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'STARTTIME'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'WORKTYPENAME'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'WORKWAYSNAME'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'DISTRICTTYPENAME'
            Footers = <>
            Title.Caption = #33829#36816#21306#22495
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'TYPENAME'
            Footers = <>
            Title.Caption = #29677#27425#31867#22411
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'RUNTIME'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
            Width = 66
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISPROPRIETARY'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#26412#31449#19987#33829
            Width = 100
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISOVERTIME'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#21152#29677#29677#27425
            Width = 100
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISSELLRETURNTICKET'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#21452#31243#29677#27425
            Width = 100
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISLINEWORK'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#27969#27700#29677#27425
            Width = 100
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISORIGINATOR'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#36807#36335#29677#27425
            Width = 100
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISSALEAFTERREPORT'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#25253#21040#21518#21806#31080
            Width = 114
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISCANMIXCHECK'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#20801#35768#28151#26816
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'PLANSEATNUM'
            Footers = <>
            Title.Caption = #35745#21010#24231#20301#25968
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'VIASTATION'
            Footers = <>
            Title.Caption = #36884#24452#31449#28857
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'PRINTINFO'
            Footers = <>
            Title.Caption = #29677#27425#25171#21360#20449#24687
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'REMARKS'
            Footers = <>
            Title.Caption = #22791#27880#20449#24687
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'CREATETIME'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'username'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'UPDATETIME'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 112
      Width = 1231
      Height = 223
      Align = alBottom
      Caption = #31080#20215#20449#24687
      TabOrder = 1
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 1227
        Height = 205
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DsHandPrice
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
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
        PrintOptions = [pghOptimalColWidths]
        PrintAutoNewLine = False
        ParentName = 'FrmHandPrice'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footers = <>
            Title.Caption = #19978#36710#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'vehicletype'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'rationseatnum'
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Title.TitleButton = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'difprice'
            Footers = <>
            Title.Caption = #21806#31080#28857#31080#20215#24046#39069
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'seats'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'brandname'
            Footers = <>
            Title.Caption = #21378#29260
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'modelcode'
            Footers = <>
            Title.Caption = #22411#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            Title.Caption = #24320#22987#26085#26399
          end
          item
            EditButtons = <>
            FieldName = 'endtime'
            Footers = <>
            Title.Caption = #32467#26463#26085#26399
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 136
    Top = 192
  end
  inherited ilToolBarDisable: TImageList
    Left = 200
    Top = 192
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'scheduleslist'
    QueryAddress = 'ticketprice/queryscheduleOutlets'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!type'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!islinework'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!isoriginator'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!issellreturnticket'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!isproprietary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_tp!id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 704
    Top = 192
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 50
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
      Size = 50
    end
    object jcdsResultWORKTYPE: TWideStringField
      FieldName = 'WORKTYPE'
      Size = 10
    end
    object jcdsResultWORKWAYS: TWideStringField
      FieldName = 'WORKWAYS'
      Size = 10
    end
    object jcdsResultDISTRICTTYPE: TWideStringField
      FieldName = 'DISTRICTTYPE'
      Size = 10
    end
    object jcdsResultTYPE: TWideStringField
      FieldName = 'TYPE'
      Size = 10
    end
    object jcdsResultSTARTTIME: TWideStringField
      FieldName = 'STARTTIME'
      Size = 10
    end
    object jcdsResultRUNTIME: TFloatField
      FieldName = 'RUNTIME'
    end
    object jcdsResultISPROPRIETARY: TBooleanField
      FieldName = 'ISPROPRIETARY'
    end
    object jcdsResultISOVERTIME: TBooleanField
      FieldName = 'ISOVERTIME'
    end
    object jcdsResultISSELLRETURNTICKET: TBooleanField
      FieldName = 'ISSELLRETURNTICKET'
    end
    object jcdsResultISLINEWORK: TBooleanField
      FieldName = 'ISLINEWORK'
    end
    object jcdsResultISORIGINATOR: TBooleanField
      FieldName = 'ISORIGINATOR'
    end
    object jcdsResultISSALEAFTERREPORT: TBooleanField
      FieldName = 'ISSALEAFTERREPORT'
    end
    object jcdsResultISCANMIXCHECK: TBooleanField
      FieldName = 'ISCANMIXCHECK'
    end
    object jcdsResultPLANSEATNUM: TIntegerField
      FieldName = 'PLANSEATNUM'
    end
    object jcdsResultVIASTATION: TWideStringField
      FieldName = 'VIASTATION'
      Size = 200
    end
    object jcdsResultPRINTINFO: TWideStringField
      FieldName = 'PRINTINFO'
      Size = 100
    end
    object jcdsResultREMARKS: TWideStringField
      FieldName = 'REMARKS'
      Size = 200
    end
    object jcdsResultISAUDITED: TBooleanField
      FieldName = 'ISAUDITED'
    end
    object jcdsResultISAUDITPASS: TBooleanField
      FieldName = 'ISAUDITPASS'
    end
    object jcdsResultISACTIVE: TBooleanField
      FieldName = 'ISACTIVE'
    end
    object jcdsResultusername: TWideStringField
      FieldName = 'username'
    end
    object jcdsResultWORKTYPENAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'WORKTYPENAME'
      LookupDataSet = jcsdWorkType
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'WORKTYPE'
      Size = 10
      Lookup = True
    end
    object jcdsResultWORKWAYSNAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'WORKWAYSNAME'
      LookupDataSet = jcdsworkways
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'WORKWAYS'
      Lookup = True
    end
    object jcdsResultDISTRICTTYPENAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'DISTRICTTYPENAME'
      LookupDataSet = jcdsDISTRICTTYPE
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'DISTRICTTYPE'
      Lookup = True
    end
    object jcdsResultTYPENAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'TYPENAME'
      LookupDataSet = jcdstype
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'TYPE'
      Lookup = True
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
    end
    object jcdsResultvehcilepark: TWideStringField
      FieldName = 'vehcilepark'
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultORGID: TLargeintField
      FieldName = 'ORGID'
    end
    object jcdsResultROUTEID: TLargeintField
      FieldName = 'ROUTEID'
    end
    object jcdsResultstartstationid: TLargeintField
      FieldName = 'startstationid'
    end
    object jcdsResultendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsResultCREATEBY: TLargeintField
      FieldName = 'CREATEBY'
    end
    object jcdsResultUPDATEBY: TLargeintField
      FieldName = 'UPDATEBY'
    end
    object jcdsResultCREATETIME: TDateTimeField
      FieldName = 'CREATETIME'
    end
    object jcdsResultUPDATETIME: TDateTimeField
      FieldName = 'UPDATETIME'
    end
    object jcdsResultoutletsname: TWideStringField
      FieldName = 'outletsname'
    end
    object jcdsResultticketoutletsid: TLargeintField
      FieldName = 'ticketoutletsid'
    end
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 192
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Top = 192
  end
  object jcsdWorkType: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'worktype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 192
  end
  object jcdsworkways: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'workways'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 472
    Top = 192
  end
  object jcdsDISTRICTTYPE: TjsonClientDataSet
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
        Value = 'route'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'districttype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 552
    Top = 192
  end
  object jcdstype: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'scheduletype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 624
    Top = 192
  end
  object jcsdQryHandPrice: TjsonClientDataSet
    DataSourceName = 'ticketoutletlist'
    QueryAddress = 'ticketprice/queticketoutletsprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 56
    Top = 320
    object jcsdQryHandPricescheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcsdQryHandPricedepartstation: TWideStringField
      FieldName = 'departstation'
    end
    object jcsdQryHandPricereachstation: TWideStringField
      FieldName = 'reachstation'
    end
    object jcsdQryHandPricevehicletype: TWideStringField
      FieldName = 'vehicletype'
    end
    object jcsdQryHandPriceseattype: TWideStringField
      FieldName = 'seattype'
      Size = 10
    end
    object jcsdQryHandPricefullprice: TFloatField
      FieldName = 'fullprice'
    end
    object jcsdQryHandPricehalfprice: TFloatField
      FieldName = 'halfprice'
    end
    object jcsdQryHandPricestudentprice: TFloatField
      FieldName = 'studentprice'
    end
    object jcsdQryHandPriceseattypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'seattypename'
      LookupDataSet = jcdsQrySeatType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'seattype'
      Lookup = True
    end
    object jcsdQryHandPricevehicletypeid: TLargeintField
      FieldName = 'vehicletypeid'
    end
    object wdstrngfldQryHandPriceseats: TWideStringField
      FieldName = 'seats'
      Size = 500
    end
    object wdstrngfldQryHandPricebrandname: TWideStringField
      FieldName = 'brandname'
      Size = 50
    end
    object wdstrngfldQryHandPricemodelcode: TWideStringField
      FieldName = 'modelcode'
      Size = 50
    end
    object jcsdQryHandPricerationseatnum: TIntegerField
      FieldName = 'rationseatnum'
    end
    object jcsdQryHandPriceid: TLargeintField
      FieldName = 'id'
    end
    object jcsdQryHandPricedepartstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcsdQryHandPricereachstationid: TLargeintField
      FieldName = 'reachstationid'
    end
    object jcsdQryHandPricedifprice: TFloatField
      FieldName = 'difprice'
    end
    object jcsdQryHandPriceticketoutletspriceid: TLargeintField
      FieldName = 'ticketoutletspriceid'
    end
    object jcsdQryHandPriceendtime: TDateField
      FieldName = 'endtime'
    end
    object jcsdQryHandPricestarttime: TDateField
      FieldName = 'starttime'
    end
  end
  object DsHandPrice: TDataSource
    DataSet = jcsdQryHandPrice
    Left = 264
    Top = 320
  end
  object jcdsQrySeatType: TjsonClientDataSet
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
        Value = 'handprice'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'seattype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 320
  end
  object jcdsDelhandprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delhandprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'handprice.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'handprice.vehicletypeid'
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
    Left = 360
    Top = 376
  end
  object jcsdQryCheckSchedule: TjsonClientDataSet
    DataSourceName = 'vehiclettypelist'
    QueryAddress = 'ticketprice/qryScheduleVehicletype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 464
    Top = 320
  end
  object jscdCopyStartprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/copyHandpricetoStatioin'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
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
    Left = 808
    Top = 192
  end
end
