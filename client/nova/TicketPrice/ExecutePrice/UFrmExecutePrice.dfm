inherited FrmExecutePrice: TFrmExecutePrice
  Caption = #33829#36816#35745#21010#31649#29702
  ClientHeight = 451
  ClientWidth = 1005
  OnShow = FormShow
  ExplicitWidth = 1021
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1005
    Height = 116
    ExplicitWidth = 1005
    ExplicitHeight = 116
    object Label1: TLabel
      Left = 14
      Top = 23
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label8: TLabel
      Left = 452
      Top = 21
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object Label4: TLabel
      Left = 233
      Top = 23
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#21035
    end
    object Label2: TLabel
      Left = 465
      Top = 54
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label6: TLabel
      Left = 14
      Top = 82
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object Label7: TLabel
      Left = 14
      Top = 54
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object Label9: TLabel
      Left = 235
      Top = 53
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object Label3: TLabel
      Left = 236
      Top = 88
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label5: TLabel
      Left = 457
      Top = 88
      Width = 56
      Height = 14
      Caption = #29677#27425#29366#24577
    end
    object Label24: TLabel
      Left = 668
      Top = 55
      Width = 42
      Height = 14
      Caption = #26816#31080#21475
    end
    object Label25: TLabel
      Left = 667
      Top = 90
      Width = 42
      Height = 14
      Caption = #19978#36710#21345
    end
    object lbl8: TLabel
      Left = 671
      Top = 19
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object Chkisoriginator: TCheckBox
      Left = 841
      Top = 40
      Width = 81
      Height = 17
      Caption = #36807#36335#29677#27425
      TabOrder = 0
    end
    object Chkislinework: TCheckBox
      Left = 841
      Top = 90
      Width = 81
      Height = 17
      Caption = #27969#27700#29677#27425
      TabOrder = 1
    end
    object Chkissellreturnticket: TCheckBox
      Left = 841
      Top = 65
      Width = 81
      Height = 17
      Caption = #21452#31243#29677#27425
      TabOrder = 2
    end
    object CobDISTRICTTYPE: TNovaComboBox
      Left = 302
      Top = 49
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      Left = 75
      Top = 78
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      Left = 520
      Top = 15
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object NEdtScheduleHelpCode: TNovaEdit
      Left = 520
      Top = 51
      Width = 140
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
    end
    object NCbbWorkType: TNovaComboBox
      Left = 302
      Top = 18
      Width = 124
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 8
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
      Left = 841
      Top = 16
      Width = 81
      Height = 17
      Caption = #26412#31449#19987#33829
      TabOrder = 9
    end
    object DpDepartDate: TDateTimePicker
      Left = 302
      Top = 82
      Width = 121
      Height = 22
      Date = 40656.693946030090000000
      Time = 40656.693946030090000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 10
    end
    object Chbisbegincheck: TCheckBox
      Left = 924
      Top = 39
      Width = 56
      Height = 17
      Caption = #24320#26816
      TabOrder = 11
    end
    object Chbisreported: TCheckBox
      Left = 924
      Top = 64
      Width = 56
      Height = 17
      Caption = #25253#21040
      TabOrder = 12
    end
    object Chbisdeparted: TCheckBox
      Left = 924
      Top = 89
      Width = 56
      Height = 17
      Caption = #21457#29677
      TabOrder = 13
    end
    object NovaCobbScheduleStatus: TNovaComboBox
      Left = 519
      Top = 85
      Width = 141
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
      HelpOptions.TableName = 'schedulestatus'
      HelpOptions.Columnname = 'schedulestatus'
      HelpOptions.DisAll = True
    end
    object NHccbTicketEntrance: TNovaHComboBox
      Left = 718
      Top = 50
      Width = 107
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 15
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
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketEntranceHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object NHccbVehiclepark: TNovaHComboBox
      Left = 718
      Top = 85
      Width = 107
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 16
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
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehicleparkHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object NovaHCbbOrg: TNovaHComboBox
      Left = 75
      Top = 21
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 17
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
      HelpOptions.HDataSourceName = 'list'
      HelpOptions.HQueryAddress = 'dispatch/qryCurOrg'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object nvhlpDeparts: TNovaHelp
      Left = 718
      Top = 15
      Width = 107
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
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
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1005
    ButtonWidth = 77
    ExplicitWidth = 1005
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 77
    end
    inherited tbtn1: TToolButton
      Left = 77
      ExplicitLeft = 77
    end
    inherited tbtnInsert: TToolButton
      Left = 85
      Caption = #21046#20316#35745#21010
      ImageIndex = 49
      OnClick = tbtnInsertClick
      ExplicitLeft = 85
      ExplicitWidth = 77
    end
    inherited tbtnEdit: TToolButton
      Left = 162
      Caption = #24231#20301#20449#24687
      ImageIndex = 39
      OnClick = tbtnEditClick
      ExplicitLeft = 162
      ExplicitWidth = 77
    end
    inherited tbtnDelete: TToolButton
      Left = 239
      AutoSize = True
      Caption = ''
      ImageIndex = -1
      Visible = False
      ExplicitLeft = 239
      ExplicitWidth = 18
    end
    inherited ToolButton50: TToolButton
      Left = 257
      ExplicitLeft = 257
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 275
      ExplicitLeft = 275
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 293
      ExplicitLeft = 293
    end
    inherited tbtnSave: TToolButton
      Left = 301
      Caption = #26597#30475#26085#24535
      ImageIndex = 6
      OnClick = tbtnSaveClick
      ExplicitLeft = 301
      ExplicitWidth = 77
    end
    inherited tbtnCancel: TToolButton
      Left = 378
      Caption = #37325#26597
      Visible = False
      OnClick = tbtnCancelClick
      ExplicitLeft = 378
      ExplicitWidth = 77
    end
    inherited ToolButton52: TToolButton
      Left = 455
      Caption = #21457#36710#26102#21051#34920
      ImageIndex = 23
      Visible = True
      OnClick = ToolButton52Click
      ExplicitLeft = 455
      ExplicitWidth = 81
    end
    inherited ToolButton53: TToolButton
      Left = 536
      ExplicitLeft = 536
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 554
      Visible = False
      ExplicitLeft = 554
    end
    inherited tbtnInfo: TToolButton
      Left = 562
      ExplicitLeft = 562
      ExplicitWidth = 77
    end
    inherited tbtn5: TToolButton
      Left = 639
      ExplicitLeft = 639
    end
    inherited tbtnExcel: TToolButton
      Left = 647
      ExplicitLeft = 647
      ExplicitWidth = 77
    end
    inherited tbtnPrinter: TToolButton
      Left = 724
      ExplicitLeft = 724
      ExplicitWidth = 77
    end
    inherited tbtn6: TToolButton
      Left = 801
      ExplicitLeft = 801
    end
    inherited tbtnClose: TToolButton
      Left = 809
      ExplicitLeft = 809
      ExplicitWidth = 77
    end
  end
  inherited Panel1: TPanel
    Top = 161
    Width = 1005
    Height = 290
    ExplicitTop = 161
    ExplicitWidth = 1005
    ExplicitHeight = 290
    object Splitter1: TSplitter [0]
      Left = 0
      Top = 139
      Width = 1005
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 243
    end
    inherited GroupBox1: TGroupBox
      Width = 1005
      Height = 139
      Caption = #29677#27425#33829#36816#20449#24687
      ExplicitWidth = 1005
      ExplicitHeight = 139
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1001
        Height = 121
        FooterRowCount = 1
        PopupMenu = pm1
        ReadOnly = False
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ischoose'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'schedulestatus'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
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
            FieldName = 'reachstation'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24635#24231#25968
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24050#21806
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'fixedreserveseatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#30041#20301#25968
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'autocancelreserveseatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33258#21160#21462#28040#30041#20301#25968
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'unautocancelreserveseatnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'issaleafterreport'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25253#21040#21518#21806#31080
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            ReadOnly = True
            Title.Caption = #27969#27700#29677#27425
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21152#29677#29677#27425
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #20056#36710#24211
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #35745#21010#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'isreported'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25253#21040
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isbegincheck'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24320#26816
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#29677
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'brandname'
            Footers = <>
            Title.Caption = #36710#36742#21378#29260
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #20844#37324#25968
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'driver1'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'1'
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'driver2'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'2'
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'driver3'
            Footers = <>
            Title.Caption = #35745#21010#39550#39542#21592'3'
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'steward1'
            Footers = <>
            Title.Caption = #35745#21010#20056#21153#21592
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'districttypename'
            Footers = <>
            Title.Caption = #36816#34892#21306#22495
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'scheduletypename'
            Footers = <>
            Title.Caption = #29677#27425#31867#22411
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Visible = False
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'workwaysname'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'highdistance'
            Footers = <>
            Title.Caption = #39640#36895#37324#31243
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'iscanmixcheck'
            Footers = <>
            ReadOnly = True
            Title.Caption = #28151#26816
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'isoriginator'
            Footers = <>
            Title.Caption = #36807#36335#29677#27425
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'isproprietary'
            Footers = <>
            Title.Caption = #26412#31449#19987#33829
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Footers = <>
            Title.Caption = #20801#35768#21806#31080
          end
          item
            EditButtons = <>
            FieldName = 'issellreturnticket'
            Footers = <>
            Title.Caption = #21452#31243#29677#27425
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            Title.Caption = #39318#29677#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'spacinginterval'
            Footers = <>
            Title.Caption = #21457#29677#38388#38548
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'endtime'
            Footers = <>
            Title.Caption = #26411#29677#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 150
          end>
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 142
      Width = 1005
      Height = 148
      Align = alBottom
      Caption = #25191#34892#31080#20215#20449#24687'('#28857#20987#20840#31080#31080#20215#21487#32534#36753#31080#20215#20998#39033')'
      TabOrder = 1
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 1001
        Height = 130
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsTicketprice
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnCellClick = NvDbgridEh1CellClick
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
        ParentName = 'FrmExecutePrice'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footers = <>
            Title.Caption = #19978#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Footers = <>
            Title.Caption = #20801#35768#21806#31080
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Title.TitleButton = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #24050#21806
            Width = 40
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 51
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#31080#20215
            Width = 50
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#31080#20215
          end
          item
            Color = clCream
            EditButtons = <>
            FieldName = 'moreprice'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 52
          end
          item
            Color = clInfoBk
            EditButtons = <>
            FieldName = 'toplimitprice'
            Footers = <>
            Title.Caption = #19978#38480#20215
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'lowerlimitprice'
            Footers = <>
            Title.Caption = #19979#38480#20215
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'autocancelreserveseatnum'
            Footers = <>
            Title.Caption = #33258#21160#21462#28040#30041#20301#25968
            Width = 114
          end
          item
            EditButtons = <>
            FieldName = 'fixedreserveseatnum'
            Footers = <>
            Title.Caption = #22266#23450#30041#20301#25968
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'unautocancelreserveseatnum'
            Footers = <>
            Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footers = <>
            Title.Caption = #31449#21153#36153
            Visible = False
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footers = <>
            Title.Caption = #29123#27833#36153
            Visible = False
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #20844#37324#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'balancedistance'
            Footers = <>
            Title.Caption = #32467#31639#37324#31243
            Width = 70
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 24
    Top = 368
  end
  inherited ilToolBarDisable: TImageList
    Left = 88
    Top = 376
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'scheduleplanlist'
    QueryAddress = 'ticketprice/qryScheduleplan'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_r!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sp!workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sp!districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sp!worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sp!scheduletype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!isoriginator'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!issellreturnticket'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!isproprietary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQD_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isbegincheck'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isdeparted'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isreported'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!buspark'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sp!orgid'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 480
    Top = 144
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
      Size = 10
    end
    object jcdsResultdistance: TIntegerField
      FieldName = 'distance'
    end
    object jcdsResultdistricttype: TWideStringField
      FieldName = 'districttype'
      Size = 10
    end
    object jcdsResultdistricttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'districttypename'
      LookupDataSet = jcdsDISTRICTTYPE
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'districttype'
      Lookup = True
    end
    object jcdsResultendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsResultendtime: TWideStringField
      FieldName = 'endtime'
      Size = 10
    end
    object jcdsResultfixedreserveseatnum: TIntegerField
      FieldName = 'fixedreserveseatnum'
    end
    object jcdsResulthighdistance: TIntegerField
      FieldName = 'highdistance'
    end
    object jcdsResultiscanmixcheck: TBooleanField
      FieldName = 'iscanmixcheck'
    end
    object jcdsResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsResultisoriginator: TBooleanField
      FieldName = 'isoriginator'
    end
    object jcdsResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsResultisproprietary: TBooleanField
      FieldName = 'isproprietary'
    end
    object jcdsResultissaleafterreport: TBooleanField
      FieldName = 'issaleafterreport'
    end
    object jcdsResultissellable: TBooleanField
      FieldName = 'issellable'
    end
    object jcdsResultissellreturnticket: TBooleanField
      FieldName = 'issellreturnticket'
    end
    object jcdsResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jcdsResultruntime: TFloatField
      FieldName = 'runtime'
    end
    object jcdsResultscheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsResultscheduletype: TWideStringField
      FieldName = 'scheduletype'
      Size = 10
    end
    object jcdsResultseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsResultsoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsResultspacinginterval: TIntegerField
      FieldName = 'spacinginterval'
    end
    object jcdsResultstartstationid: TLargeintField
      FieldName = 'startstationid'
    end
    object jcdsResultstarttime: TWideStringField
      FieldName = 'starttime'
      Size = 10
    end
    object jcdsResultunautocancelreserveseatnum: TIntegerField
      FieldName = 'unautocancelreserveseatnum'
    end
    object jcdsResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object jcdsResultworktypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'worktypename'
      LookupDataSet = jcsdWorkType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'worktype'
      Lookup = True
    end
    object jcdsResultworkways: TWideStringField
      FieldName = 'workways'
      Size = 10
    end
    object jcdsResultworkwaysname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'workwaysname'
      LookupDataSet = jcdsworkways
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'workways'
      Lookup = True
    end
    object jcdsResultreachstation: TWideStringField
      FieldName = 'reachstation'
    end
    object jcdsResultbuspark: TWideStringField
      FieldName = 'buspark'
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object jcdsResultisbegincheck: TBooleanField
      FieldName = 'isbegincheck'
    end
    object jcdsResultisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsResultisreported: TBooleanField
      FieldName = 'isreported'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
    end
    object jcdsResultautocancelreserveseatnum: TIntegerField
      FieldName = 'autocancelreserveseatnum'
    end
    object jcdsResultscheduletypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'scheduletypename'
      LookupDataSet = jcdstype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'scheduletype'
      Lookup = True
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 15
    end
    object jcdsResultbrandname: TWideStringField
      FieldName = 'brandname'
    end
    object jcdsResultbrandmodelid: TLargeintField
      FieldName = 'brandmodelid'
    end
    object jcdsResultdriver1: TWideStringField
      FieldName = 'driver1'
    end
    object jcdsResultdriver2: TWideStringField
      FieldName = 'driver2'
    end
    object jcdsResultdriver3: TWideStringField
      FieldName = 'driver3'
    end
    object jcdsResultsteward1: TWideStringField
      FieldName = 'steward1'
    end
    object jcdsResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 30
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
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object blnfldResultischoose: TBooleanField
      FieldName = 'ischoose'
    end
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 224
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
    Left = 288
    Top = 240
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
    Left = 368
    Top = 240
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
    Left = 448
    Top = 240
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
    Left = 528
    Top = 240
  end
  object jcdsQryTicketprice: TjsonClientDataSet
    DataSourceName = 'ticketpricelist'
    QueryAddress = 'ticketprice/qryTicketprice'
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
    Left = 280
    Top = 368
    object jcdsQryTicketpricedepartstation: TWideStringField
      FieldName = 'departstation'
    end
    object jcdsQryTicketpricereachstation: TWideStringField
      FieldName = 'reachstation'
    end
    object jcdsQryTicketpricefullprice: TFloatField
      FieldName = 'fullprice'
    end
    object jcdsQryTicketpricehalfprice: TFloatField
      FieldName = 'halfprice'
    end
    object jcdsQryTicketpriceissellable: TBooleanField
      FieldName = 'issellable'
    end
    object jcdsQryTicketpriceresidueseatnum: TIntegerField
      FieldName = 'residueseatnum'
    end
    object jcdsQryTicketpriceseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsQryTicketpriceseattype: TWideStringField
      FieldName = 'seattype'
      Size = 10
    end
    object jcdsQryTicketpricesoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsQryTicketpricestudentprice: TFloatField
      FieldName = 'studentprice'
    end
    object jcdsQryTicketpricetoplimitprice: TFloatField
      FieldName = 'toplimitprice'
    end
    object jcdsQryTicketpricelowerlimitprice: TFloatField
      FieldName = 'lowerlimitprice'
    end
    object jcdsQryTicketpriceseattypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'seattypename'
      LookupDataSet = jcdsQrySeatType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'seattype'
      Lookup = True
    end
    object jcdsQryTicketpriceruntime: TFloatField
      FieldName = 'runtime'
    end
    object jcdsQryTicketpriceid: TLargeintField
      FieldName = 'id'
    end
    object jcdsQryTicketpriceunautocancelreserveseatnum: TIntegerField
      FieldName = 'unautocancelreserveseatnum'
    end
    object jcdsQryTicketpricefixedreserveseatnum: TIntegerField
      FieldName = 'fixedreserveseatnum'
    end
    object jcdsQryTicketpriceautocancelreserveseatnum: TIntegerField
      FieldName = 'autocancelreserveseatnum'
    end
    object jcdsQryTicketpricestationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object jcdsQryTicketpricefueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object jcdsQryTicketpricedistance: TLargeintField
      FieldName = 'distance'
    end
    object jcdsQryTicketpricebalancedistance: TLargeintField
      FieldName = 'balancedistance'
    end
    object jcdsQryTicketpricemoreprice: TFloatField
      FieldName = 'moreprice'
    end
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
    Left = 568
    Top = 376
  end
  object dsTicketprice: TDataSource
    DataSet = jcdsQryTicketprice
    Left = 432
    Top = 368
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
    Top = 224
  end
  object pm1: TPopupMenu
    Left = 72
    Top = 184
    object N1: TMenuItem
      Caption = #20840#36873
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21453#36873
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #21462#28040
      OnClick = N3Click
    end
  end
end
