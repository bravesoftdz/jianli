inherited frmTicketSaleQry: TfrmTicketSaleQry
  Caption = #21806#31080#24773#20917#26597#35810
  ClientHeight = 478
  ClientWidth = 1189
  ExplicitWidth = 1205
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1189
    Height = 150
    ExplicitWidth = 1189
    ExplicitHeight = 150
    object lbl2: TLabel
      Left = 584
      Top = 22
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbl3: TLabel
      Left = 418
      Top = 22
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object lbl5: TLabel
      Left = 251
      Top = 57
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl6: TLabel
      Left = 418
      Top = 91
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl8: TLabel
      Left = 970
      Top = 89
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object lbl9: TLabel
      Left = 584
      Top = 55
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object lbl10: TLabel
      Left = 752
      Top = 21
      Width = 56
      Height = 14
      Caption = #21806#31080#36884#24452
    end
    object lbl11: TLabel
      Left = 18
      Top = 58
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl12: TLabel
      Left = 752
      Top = 55
      Width = 56
      Height = 14
      Caption = #25903#20184#26041#24335
    end
    object lbl13: TLabel
      Left = 237
      Top = 130
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object lbl1: TLabel
      Left = 212
      Top = 23
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object lbl16: TLabel
      Left = 576
      Top = 123
      Width = 56
      Height = 14
      Caption = #36710#31080#31867#22411
    end
    object lbl17: TLabel
      Left = 432
      Top = 126
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl4: TLabel
      Left = 584
      Top = 93
      Width = 42
      Height = 14
      Caption = #36864#31080#21592
    end
    object lbl7: TLabel
      Left = 18
      Top = 95
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl14: TLabel
      Left = 251
      Top = 93
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 18
      Top = 130
      Width = 56
      Height = 14
      Caption = #26412#31449#32447#36335
    end
    object Label2: TLabel
      Left = 32
      Top = 24
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object Label3: TLabel
      Left = 966
      Top = 21
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 273
      Top = 53
      Width = 112
      Height = 22
      Date = 40413.000000000000000000
      Time = 40413.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 6
    end
    object nvhelpendstation: TNovaHelp
      Left = 635
      Top = 53
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object nvhelpUserid: TNovaHelp
      Left = 468
      Top = 87
      Width = 103
      Height = 22
      CharCase = ecUpperCase
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
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbticketstatus: TNovaComboBox
      Left = 273
      Top = 122
      Width = 112
      Height = 22
      Style = csDropDownList
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'ticketstatus'
      HelpOptions.DisAll = True
    end
    object nvcbbSellway: TNovaComboBox
      Left = 814
      Top = 16
      Width = 77
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'sellway'
      HelpOptions.DisAll = True
    end
    object nvcbbPaymethod: TNovaComboBox
      Left = 814
      Top = 52
      Width = 78
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
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'paymethod'
      HelpOptions.DisAll = True
    end
    object nvhcbbTickettype: TNovaHComboBox
      Left = 638
      Top = 119
      Width = 89
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 13
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.DisAll = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketTypeHelp'
        end>
    end
    object nvhelpTicketoutlets: TNovaHelp
      Left = 469
      Top = 18
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object chkIsnotline: TCheckBox
      Left = 898
      Top = 56
      Width = 74
      Height = 17
      Caption = #38750#27969#27700#29677
      Checked = True
      State = cbChecked
      TabOrder = 22
    end
    object chkIsline: TCheckBox
      Left = 897
      Top = 19
      Width = 62
      Height = 17
      Caption = #27969#27700#29677
      Checked = True
      State = cbChecked
      TabOrder = 21
    end
    object chkIsnotcheck: TCheckBox
      Left = 817
      Top = 121
      Width = 47
      Height = 17
      Caption = #26410#26816
      Checked = True
      State = cbChecked
      TabOrder = 20
    end
    object chkIscheck: TCheckBox
      Left = 752
      Top = 121
      Width = 50
      Height = 17
      Caption = #24050#26816
      Checked = True
      State = cbChecked
      TabOrder = 19
    end
    object nvedtTicketno: TNovaEdit
      Left = 468
      Top = 120
      Width = 103
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 12
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
    object chkIsnotlocal: TCheckBox
      Left = 816
      Top = 90
      Width = 63
      Height = 17
      Caption = #24322#31449#31080
      Checked = True
      State = cbChecked
      TabOrder = 18
    end
    object chkIslocal: TCheckBox
      Left = 751
      Top = 90
      Width = 62
      Height = 17
      Caption = #26412#31449#31080
      Checked = True
      State = cbChecked
      TabOrder = 17
    end
    object chkIsovertime: TCheckBox
      Left = 896
      Top = 119
      Width = 45
      Height = 18
      Caption = #21152#29677
      Checked = True
      State = cbChecked
      TabOrder = 24
    end
    object chkIsnotovertime: TCheckBox
      Left = 896
      Top = 90
      Width = 48
      Height = 17
      Caption = #27491#29677
      Checked = True
      State = cbChecked
      TabOrder = 23
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 80
      Top = 53
      Width = 127
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 5
    end
    object dtpBselldate: TDateTimePicker
      Left = 81
      Top = 89
      Width = 126
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 273
      Top = 87
      Width = 112
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
      OnChange = dtpEselldateChange
    end
    object nvhelpRoute: TNovaHelp
      Left = 80
      Top = 122
      Width = 127
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 130
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
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpReturnby: TNovaHelp
      Left = 636
      Top = 86
      Width = 110
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
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpschedule: TNovaHelp
      Left = 635
      Top = 18
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #29677#27425
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 273
      Top = 18
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object nvhlpDeparts: TNovaHelp
      Left = 1026
      Top = 86
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object NovachkPorg: TNovaCheckedComboBox
      Left = 80
      Top = 18
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 25
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object Nvehicleno: TNovaHelp
      Left = 1026
      Top = 16
      Width = 119
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      MaxLength = 50
      TabOrder = 26
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
    object CheckBox1: TCheckBox
      Left = 416
      Top = 57
      Width = 153
      Height = 17
      Caption = #20351#29992#28151#26816#21069#21457#36710#26085#26399
      TabOrder = 27
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1189
    ButtonWidth = 105
    ExplicitWidth = 1189
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 105
    end
    inherited tbtn1: TToolButton
      Left = 105
      Visible = False
      ExplicitLeft = 105
    end
    inherited tbtnInsert: TToolButton
      Left = 113
      Caption = #20462#25913#20056#36710#20154#20449#24687
      ImageIndex = 19
      Visible = False
      OnClick = tbtnInsertClick
      ExplicitLeft = 113
      ExplicitWidth = 105
    end
    inherited tbtnEdit: TToolButton
      Left = 218
      Visible = False
      ExplicitLeft = 218
      ExplicitWidth = 105
    end
    inherited tbtnDelete: TToolButton
      Left = 323
      Visible = False
      ExplicitLeft = 323
      ExplicitWidth = 105
    end
    inherited ToolButton50: TToolButton
      Left = 428
      ExplicitLeft = 428
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 446
      ExplicitLeft = 446
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 464
      Visible = False
      ExplicitLeft = 464
    end
    inherited tbtnSave: TToolButton
      Left = 472
      Visible = False
      ExplicitLeft = 472
      ExplicitWidth = 105
    end
    inherited tbtnCancel: TToolButton
      Left = 577
      Visible = False
      ExplicitLeft = 577
      ExplicitWidth = 105
    end
    inherited ToolButton52: TToolButton
      Left = 682
      ExplicitLeft = 682
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 700
      ExplicitLeft = 700
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 718
      Visible = False
      ExplicitLeft = 718
    end
    inherited tbtnInfo: TToolButton
      Left = 726
      Visible = False
      ExplicitLeft = 726
      ExplicitWidth = 105
    end
    inherited tbtn5: TToolButton
      Left = 831
      Visible = False
      ExplicitLeft = 831
    end
    inherited tbtnExcel: TToolButton
      Left = 839
      ExplicitLeft = 839
      ExplicitWidth = 105
    end
    inherited tbtnPrinter: TToolButton
      Left = 944
      ExplicitLeft = 944
      ExplicitWidth = 105
    end
    inherited tbtn6: TToolButton
      Left = 1049
      ExplicitLeft = 1049
    end
    inherited tbtnClose: TToolButton
      Left = 1057
      ExplicitLeft = 1057
      ExplicitWidth = 105
    end
  end
  inherited Panel1: TPanel
    Top = 195
    Width = 1189
    Height = 283
    ExplicitTop = 195
    ExplicitWidth = 1189
    ExplicitHeight = 283
    inherited GroupBox1: TGroupBox
      Width = 1189
      Height = 283
      ExplicitWidth = 1189
      ExplicitHeight = 283
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1185
        Height = 265
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #31080#21495
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'dpartname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'reachname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#36141#31080#20215
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #36710#31080#31867#22411
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'sellwayname'
            Footers = <>
            Title.Caption = #21806#31080#36884#24452
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31449#21153#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#25187#36153'1'
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#31354#35843#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#29123#27833#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#37197#27700#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#38468#21152#36153
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20445#38505#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#20854#20182
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'||'#23567#35745
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #35746'/'#34917#31080#26381#21153#36153
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'serviceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36141#31080#26381#21153#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'sellip'
            Footers = <>
            Title.Caption = #21806#31080#30005#33041'IP'
            Width = 116
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'islocal'
            Footers = <>
            Title.Caption = #26159#21542#24322#31449#31080
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #26159#21542#27969#27700#29677
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677#29677#27425
            Width = 51
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
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #19978#36710#21345#20301
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'returnbyname'
            Footers = <>
            Title.Caption = #36864#31080#20154
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'returntime'
            Footers = <>
            Title.Caption = #36864#31080#26102#38388
          end
          item
            EditButtons = <>
            FieldName = 'returnwayname'
            Footers = <>
            Title.Caption = #36864#31080#36884#24452
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returnamount'
            Footers = <>
            Title.Caption = #36864#31080#37329#39069
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            Title.Caption = #26159#21542#24050#26816#31080
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'checkedname'
            Footers = <>
            Title.Caption = #26816#31080#21592
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'checkstationname'
            Footers = <>
            Title.Caption = #26816#31080#28857
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'checktime'
            Footers = <>
            Title.Caption = #26816#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'vehiclebrandmodelname'
            Footers = <>
            Title.Caption = #36710#36742#21697#29260#22411#21495
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            Title.Caption = #39038#23458#22995#21517
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #25903#20184#26041#24335
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'carrychildnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24102#20799#31461#25968
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'hticketoutlesname'
            Footers = <>
            Title.Caption = #20195#21806#28857#21517#31216
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'houtletsaddress'
            Footers = <>
            Title.Caption = #20195#21806#28857#22320#22336
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            Title.Caption = #26159#21542#24050#24320#36816#37327#21333
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footers = <>
            Title.Caption = #36816#37327#21333#21495
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesbyname'
            Footers = <>
            Title.Caption = #24320#20855#36816#37327#21333#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicestime'
            Footers = <>
            Title.Caption = #24320#36816#37327#21333#26102#38388
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'printorgname'
            Footers = <>
            Title.Caption = #21462#31080#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'printname'
            Footers = <>
            Title.Caption = #21462#31080#25171#21360#20154
            Width = 60
          end>
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
    DataSourceName = 'ticketSellQrymap'
    QueryAddress = 'query/findticketSellQry'
    SaveAddress = 'query/findticketSellQry'
    Params = <
      item
        DataType = ftString
        Name = 'qp.departSdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.departEdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellSdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellEdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.schcode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.returnby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ticketstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.sellway'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.paymethod'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.ischecked'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.islocalticket'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.saleorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qp.isolddate'
        ParamType = ptInput
      end>
    Left = 280
    Top = 328
    object wdstrngfldResultdpartname: TWideStringField
      FieldName = 'dpartname'
    end
    object wdstrngfldResultreachname: TWideStringField
      FieldName = 'reachname'
    end
    object wdstrngfldResultsellname: TWideStringField
      FieldName = 'sellname'
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object wdstrngfldResultschedulecode: TWideStringField
      FieldName = 'schedulecode'
      Size = 30
    end
    object blnfldResultischecked: TBooleanField
      FieldName = 'ischecked'
    end
    object blnfldResultisdepartinvoices: TBooleanField
      FieldName = 'isdepartinvoices'
    end
    object blnfldResultislocal: TBooleanField
      FieldName = 'islocal'
    end
    object wdstrngfldResultpaymethod: TWideStringField
      FieldName = 'paymethod'
      Size = 10
    end
    object wdstrngfldResultpaymethodname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodname'
      LookupDataSet = jcdsPaymethod
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'paymethod'
      Size = 40
      Lookup = True
    end
    object wdstrngfldResultticketstatus: TWideStringField
      FieldName = 'ticketstatus'
      Size = 10
    end
    object wdstrngfldResultticketstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ticketstatusname'
      LookupDataSet = jcdsTicketstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'ticketstatus'
      Lookup = True
    end
    object wdstrngfldResultsellway: TWideStringField
      FieldName = 'sellway'
      Size = 10
    end
    object wdstrngfldResultsellwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'sellwayname'
      LookupDataSet = jcdsSellway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'sellway'
      Lookup = True
    end
    object wdstrngfldResultticketno: TWideStringField
      FieldName = 'ticketno'
      Size = 30
    end
    object dtfldResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object intgrfldResultseatno: TIntegerField
      FieldName = 'seatno'
    end
    object blnfldResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object intgrfldResultcarrychildnum: TIntegerField
      FieldName = 'carrychildnum'
    end
    object lrgntfldResultdistance: TLargeintField
      FieldName = 'distance'
    end
    object fltfldResultfullprice: TFloatField
      FieldName = 'fullprice'
    end
    object fltfldResultfueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object fltfldResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object fltfldResultprice: TFloatField
      FieldName = 'price'
    end
    object wdstrngfldResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 60
    end
    object wdstrngfldResultbuspark: TWideStringField
      FieldName = 'buspark'
      Size = 60
    end
    object wdstrngfldResultticketoutletname: TWideStringField
      FieldName = 'ticketoutletname'
    end
    object wdstrngfldResultsellip: TWideStringField
      FieldName = 'sellip'
      Size = 40
    end
    object wdstrngfldResultcustomername: TWideStringField
      FieldName = 'customername'
      Size = 30
    end
    object wdstrngfldResulthticketoutlesname: TWideStringField
      FieldName = 'hticketoutlesname'
      Size = 30
    end
    object wdstrngfldResulthoutletsaddress: TWideStringField
      FieldName = 'houtletsaddress'
      Size = 60
    end
    object wdstrngfldResultcheckedname: TWideStringField
      FieldName = 'checkedname'
      Size = 40
    end
    object wdstrngfldResultcheckstationname: TWideStringField
      FieldName = 'checkstationname'
      Size = 30
    end
    object wdstrngfldResultdepartinvoicesbyname: TWideStringField
      FieldName = 'departinvoicesbyname'
      Size = 40
    end
    object wdstrngfldResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
      Size = 40
    end
    object fltfldResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsResultvehiclebrandmodelname: TWideStringField
      FieldName = 'vehiclebrandmodelname'
      Size = 30
    end
    object dtmfldResultchecktime: TDateTimeField
      FieldName = 'checktime'
    end
    object wdstrngfldResulttickettypename: TWideStringField
      FieldName = 'tickettypename'
    end
    object dtmfldResultdepartinvoicestime: TDateTimeField
      FieldName = 'departinvoicestime'
    end
    object jcdsResultcomputefee: TFloatField
      FieldName = 'computefee'
    end
    object jcdsResultcoolairfee: TFloatField
      FieldName = 'coolairfee'
    end
    object jcdsResultadditionfee: TFloatField
      FieldName = 'additionfee'
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 60
    end
    object blnfldResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object wdstrngfldResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 30
    end
    object fltfldResultticketprice: TFloatField
      FieldName = 'ticketprice'
    end
    object fltfldResultreturnamount: TFloatField
      FieldName = 'returnamount'
    end
    object wdstrngfldResultreturnbyname: TWideStringField
      FieldName = 'returnbyname'
    end
    object dtmfldResultreturntime: TDateTimeField
      FieldName = 'returntime'
    end
    object wdstrngfldResultreturnway: TWideStringField
      FieldName = 'returnway'
      Size = 10
    end
    object wdstrngfldResultreturnwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'returnwayname'
      LookupDataSet = jcdsReturnway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'returnway'
      Size = 10
      Lookup = True
    end
    object jcdsResultmoreprice: TFloatField
      FieldName = 'moreprice'
    end
    object jcdsResultselltime: TDateTimeField
      FieldName = 'selltime'
    end
    object fltfldResultservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object fltfldResultwaterfee: TFloatField
      FieldName = 'waterfee'
    end
    object fltfldResultinsurefee: TFloatField
      FieldName = 'insurefee'
    end
    object fltfldResultserviceprice: TFloatField
      FieldName = 'serviceprice'
    end
    object fltfldResultsubtotal: TFloatField
      FieldName = 'subtotal'
    end
    object jcdsResultprintorgname: TWideStringField
      FieldName = 'printorgname'
      Size = 50
    end
    object jcdsResultprintname: TWideStringField
      FieldName = 'printname'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
      Size = 100
    end
    object jcdsResultolddepartdate: TDateField
      FieldName = 'olddepartdate'
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 368
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 360
  end
  object jcdsPaymethod: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'paymethod'
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 360
  end
  object jcdsTicketstatus: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'ticketstatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 528
    Top = 352
  end
  object jcdsSellway: TjsonClientDataSet
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
        Value = 'ticketsell'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'sellway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 616
    Top = 360
  end
  object jcdsReturnway: TjsonClientDataSet
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
        Value = 'ticketreturn'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'returnway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 704
    Top = 360
  end
end
