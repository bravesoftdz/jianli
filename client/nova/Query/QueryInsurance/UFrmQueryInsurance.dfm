inherited FrmQueryInsurance: TFrmQueryInsurance
  Caption = #20445#38505#38144#21806#26126#32454#34920
  ClientHeight = 447
  ClientWidth = 993
  OnShow = FormShow
  ExplicitWidth = 1009
  ExplicitHeight = 485
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 993
    Height = 172
    ExplicitWidth = 993
    ExplicitHeight = 172
    object lbl1: TLabel
      Left = 199
      Top = 15
      Width = 56
      Height = 14
      Caption = #21806#20445#26426#26500
    end
    object Label1: TLabel
      Left = 572
      Top = 51
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label2: TLabel
      Left = 384
      Top = 51
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl9: TLabel
      Left = 765
      Top = 51
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object lbl2: TLabel
      Left = 21
      Top = 51
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl3: TLabel
      Left = 227
      Top = 51
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl7: TLabel
      Left = 21
      Top = 88
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl14: TLabel
      Left = 227
      Top = 88
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl17: TLabel
      Left = 35
      Top = 119
      Width = 42
      Height = 14
      Caption = #20445#21333#21495
    end
    object Label3: TLabel
      Left = 199
      Top = 119
      Width = 56
      Height = 14
      Caption = #20445#38505#21333#21495
    end
    object lbl13: TLabel
      Left = 958
      Top = 15
      Width = 70
      Height = 14
      Caption = #20445#38505#31080#29366#24577
    end
    object Label4: TLabel
      Left = 384
      Top = 87
      Width = 56
      Height = 14
      Caption = #20056#23458#22995#21517
    end
    object lbl5: TLabel
      Left = 558
      Top = 87
      Width = 56
      Height = 14
      Caption = #20056#23458#30005#35805
    end
    object Label5: TLabel
      Left = 737
      Top = 88
      Width = 70
      Height = 14
      Caption = #20056#23458#35777#20214#21495
    end
    object Label6: TLabel
      Left = 555
      Top = 15
      Width = 56
      Height = 14
      Caption = #34987#21806#26426#26500
    end
    object Label7: TLabel
      Left = 21
      Top = 15
      Width = 56
      Height = 14
      Caption = #19978#32423#26426#26500
    end
    object Label8: TLabel
      Left = 384
      Top = 15
      Width = 56
      Height = 14
      Caption = #19978#32423#26426#26500
    end
    object Label9: TLabel
      Left = 751
      Top = 15
      Width = 56
      Height = 14
      Caption = #20445#38505#20844#21496
    end
    object Label10: TLabel
      Left = 398
      Top = 119
      Width = 42
      Height = 14
      Caption = #35746#21333#21495
    end
    object lbl10: TLabel
      Left = 557
      Top = 117
      Width = 56
      Height = 14
      Caption = #21806#20445#36884#24452
    end
    object lbl12: TLabel
      Left = 751
      Top = 119
      Width = 56
      Height = 14
      Caption = #25903#20184#26041#24335
    end
    object sellOrgid: TNovaCheckedComboBox
      Left = 258
      Top = 12
      Width = 116
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
    object nvhlpschedule: TNovaHelp
      Left = 619
      Top = 48
      Width = 111
      Height = 22
      CharCase = ecUpperCase
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
    object nvhelpRoute: TNovaHelp
      Left = 442
      Top = 48
      Width = 109
      Height = 22
      CharCase = ecUpperCase
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
    object nvhelpendstation: TNovaHelp
      Left = 813
      Top = 48
      Width = 128
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
    object dtpstartdate: TDateTimePicker
      Left = 83
      Top = 48
      Width = 108
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      ShowCheckbox = True
      Checked = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 4
      OnChange = dtpstartdateChange
    end
    object dtpenddate: TDateTimePicker
      Left = 258
      Top = 48
      Width = 116
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      ShowCheckbox = True
      Checked = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 5
      OnChange = dtpenddateChange
    end
    object dtpBselldate: TDateTimePicker
      Left = 83
      Top = 84
      Width = 110
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 6
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 258
      Top = 84
      Width = 116
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
      OnChange = dtpEselldateChange
    end
    object edtpolnumber: TNovaEdit
      Left = 83
      Top = 116
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 25
      TabOrder = 8
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
    object edtinsuranceno: TNovaEdit
      Left = 258
      Top = 116
      Width = 116
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 25
      TabOrder = 9
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
    object nvcbbstatus: TNovaComboBox
      Left = 1034
      Top = 12
      Width = 128
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
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'ticketstatus'
      HelpOptions.DisAll = True
    end
    object nvedtPhone: TNovaEdit
      Left = 619
      Top = 84
      Width = 111
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    end
    object edtcertificateno: TNovaEdit
      Left = 813
      Top = 84
      Width = 128
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
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
    end
    object nvhlpname: TNovaHelp
      Left = 442
      Top = 84
      Width = 109
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #39038#23458#22995#21517
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #35777#20214#21495#30721
          Width = 120
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'CustomerHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbb1: TNovaCheckedComboBox
      Left = 619
      Top = 12
      Width = 111
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'notnetOrg'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbbNovachkPorg: TNovaCheckedComboBox
      Left = 85
      Top = 12
      Width = 108
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbb2: TNovaCheckedComboBox
      Left = 442
      Top = 11
      Width = 109
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbb3: TNovaCheckedComboBox
      Left = 813
      Top = 12
      Width = 128
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'InsurerHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object edt1: TNovaEdit
      Left = 442
      Top = 116
      Width = 109
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 25
      TabOrder = 18
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
    object cbbSellway: TNovaComboBox
      Left = 619
      Top = 116
      Width = 111
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 19
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
    object cbbPaymethod: TNovaComboBox
      Left = 813
      Top = 116
      Width = 128
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 20
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
  end
  inherited tlbShortCut: TToolBar
    Width = 993
    ExplicitWidth = 993
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
    end
    inherited tbtnInsert: TToolButton
      Visible = False
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Visible = False
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn5: TToolButton
      Hint = #25152#26377#21806#31080#21592#21806#38505#30340#25991#26412#26684#24335#35760#24405
      Caption = #23548#20986'TXT'
      ImageIndex = 58
      Style = tbsButton
      OnClick = tbtn5Click
      ExplicitWidth = 70
    end
    inherited tbtnExcel: TToolButton
      Left = 656
      ExplicitLeft = 656
    end
    inherited tbtnPrinter: TToolButton
      Left = 726
      ExplicitLeft = 726
    end
    inherited tbtn6: TToolButton
      Left = 796
      ExplicitLeft = 796
    end
    inherited tbtnClose: TToolButton
      Left = 804
      ExplicitLeft = 804
    end
  end
  inherited Panel1: TPanel
    Top = 217
    Width = 993
    Height = 230
    ExplicitTop = 217
    ExplicitWidth = 993
    ExplicitHeight = 230
    inherited GroupBox1: TGroupBox
      Width = 993
      Height = 230
      ExplicitWidth = 993
      ExplicitHeight = 230
      inherited dbgrdhResult: TNvDbgridEh
        Width = 989
        Height = 212
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
            FieldName = 'sellorg'
            Footers = <>
            Title.Caption = #21806#20445#26426#26500
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'htsellorg'
            Footers = <>
            Title.Caption = #34987#21806#26426#26500
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'ticketname'
            Footer.Value = #21512#35745':'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'outletsaddress'
            Footers = <>
            Title.Caption = #21806#31080#28857#22320#22336
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #31080#21495
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'insuranceno'
            Footers = <>
            Title.Caption = #20445#38505#21333#21495
            Width = 102
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
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #26159#21542#27969#27700#29677#27425
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'startname'
            Footers = <>
            Title.Caption = #20986#21457#31449
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'endname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            Title.Caption = #39038#23458#22995#21517
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #39038#23458#30005#35805
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypename'
            Footers = <>
            Title.Caption = #39038#23458#35777#20214#31867#22411
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #39038#23458#35777#20214#21495
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #38505#31181
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'premium'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153#29992
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ywmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24847#22806#21307#30103#36153
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'shmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24847#22806#20260#23475#36153
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'emoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24847#22806#20260#23475#20445#38505#37329#39069
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'emmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24847#22806#20260#23475#21307#30103#20445#38505#37329#39069
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'insureamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'insurancestatusname'
            Footers = <>
            Title.Caption = #20445#38505#31080#29366#24577
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'returnorcancelby'
            Footers = <>
            Title.Caption = #20316#24223#25110#36864#31080#24037#21495
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'returnorcanceltime'
            Footers = <>
            Title.Caption = #20316#24223#25110#36864#31080#26102#38388
            Width = 155
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #20445#38505#21806#20986#20154
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#20986#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'sellip'
            Footers = <>
            Title.Caption = #21806#31080#30005#33041
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            Title.Caption = #20184#27454#26041#24335
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sellwayname'
            Footers = <>
            Title.Caption = #21806#31080#36884#24452
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'insuranceprintdatetime'
            Footers = <>
            Title.Caption = #20445#38505#31080#25171#21360#26102#38388
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'reprintnum'
            Footers = <>
            Title.Caption = #37325#25171#27425#25968
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'insurername'
            Footers = <>
            Title.Caption = #20445#38505#20844#21496
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'insurersbankcode'
            Footers = <>
            Title.Caption = #20445#38505#20844#21496#20195#30721
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'polnumber'
            Footers = <>
            Title.Caption = #20445#21333#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'insuretypecode'
            Footers = <>
            Title.Caption = #20445#38505#20135#21697#20195#30721
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            Title.Caption = #35746#21333#21495
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 96
    Top = 272
    Bitmap = {
      494C01013B003D00040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000680100000100200000000000001C
      0200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B6AA94004E2F0000664106007F5D1A009D7B40009F804900765A
      27007A5606000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000959595008B8B8B008E8E
      8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008F8F8F00D3D3
      D3009A9A9A008C8C8C008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E008C8C8C009090900000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A695
      78008F6B2A008C601E007F580C0082510C0081540E007C5410009A753700C6A9
      7C00CDB28800CBAF8400CCB18700CFB68F00D2BA9500D5BD9900DAC3A300DECA
      AB007C5609000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000899168008E966F008E95
      73008D9471008F9674008D946F008E957300909776008E95720088906500B7B9
      A90089916B008C956D008F9573008D9571008F9573008D946F008D9571009097
      7500909874008890670000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E3E0DE00F0EF
      EE0000000000000000000000000000000000000000000000000000000000774D
      0300C8AA7E00C8AA7E00CBAF8500CDB28900CDB28900CEB38C00D0B79100D1B8
      9300D0B69000CEB48D00D0B69100D2BB9700D3BA9600D3BA9600D7BF9C00DBC6
      A700784700000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8D1A600D6DFB500D9E1
      B900D5DDB500B8BDB700C5CDB500DAE3BB00D8DFBA00D8E1B900D2DAAE00C1C5
      B300C3CCA300D5DDB400D9E2B900D6DEB500B0B5B700C9D1B500DAE2B900D8E0
      BB00D9E1B900CFD8AE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEDEB00E1DBD400F4EFEA00D6D0
      C80000000000000000000000000000000000000000000000000000000000794F
      0400C7A97C00C9AB8000CFB48C009B896F00D0B69100D1B893009D8C7300C0AC
      8F00D0B99600CFB69100D3BB9700423A3100D2B99500D0B79100D4BB9600D9C3
      A0007E4E05000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEE0D000E2E6D500E7EB
      D800D5D7DD00362EBB007D7AC500E2E6D400ECEFDD00EBEFDC00E6EADA00C9CB
      C300D8DCCA00E4E7D700E5E8D500C7C7D9002B23B9009796CA00E1E4D200EBEE
      DD00EBEFDC00E6E9D90000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBDBDB00D2D2D200D3D3D300C7C7
      C700D9D9D900D9D9D900E8E8E80000000000EFEAE400EFEBE600F2EEE900E7E2
      DD0000000000000000000000000000000000000000000000000000000000764C
      0400C6A87B00C9AD8000D0B69100A8957C00D1B89300D1B99400B8A589009082
      6D00D4BC9900D0B79100D3BC9A0047403400D4BC9900D0B68F00D2B99300D8C0
      9F00794802000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEEEEE00ECEBEF00C1BF
      EA004038C4002E25BD003028BD00C1BDE700FFFFFF00FAF9F900F8F8F800D1D1
      D100E8E8E800EFEFF300D1CEEC00342CC0003A32C200362EBF00D6D4EC00FFFF
      FF00FAF9F900F6F6F70000000000000000000000000000000000000000000000
      0000000000000000000000000000D7D7D700E6E6E600ECECEC00F0F0F000F5F5
      F500F2F2F200ECECEC00E0E0E000DCDCDC00FAF9F700F0EDE700E9E4DD00F8F6
      F40000000000000000000000000000000000000000000000000000000000784E
      0400C7A87C00CAAD8200D1B89500B4A18400D2B99500D2B99400000000004E4D
      4B00D4BD9900D2B99500D5BE9D004D463A00D5BE9C00D0B79100D2B99300D6BE
      9B00D1CAB4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DDE1D300E3E6D800D8D9
      DD009C9BD100B6B6CD006560C3002921BC00CECEEE00F7F9F800EBEEE000C8C9
      C300D9DCCE00E4E7DA00DFE1DC009A97D200C0C1CF004B45BE003C35C000BCBB
      E900F8F9FA00EBEEE20000000000000000000000000000000000000000000000
      0000000000000000000000000000E3E3E300EDEDED00F3F3F300F3F2F100E5E0
      DC00F5F4F300F6F6F600EDEDED00E7E7E7000000000000000000EAE8E600EAE8
      E600000000000000000000000000000000000000000000000000000000007C4E
      0400C7A87A00CAAD8200BEA78100BDA78400D0B68F00CEB38C00CFB48D00D0B6
      8F00D3BA9300D1B89400C5AF8D00C5B09000C7B08F00D0B69100D1B89200D5BD
      9A00CDBDAC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDCC8700CDD9A000D4DE
      AE00CDD8A400BECB8900A3AE8B00160DB400514DBD00D8E1C600C3D18C00D1D7
      B900BECA8700CCD79C00D3DDAD00D0DBA900C1CE8F008D978A002E24C5002E27
      B800DBE3CD00C7D4970000000000000000000000000000000000000000000000
      0000000000000000000000000000ECECEC00E6E6E600ECECEC00DAD5CF00BAAF
      A200DFDAD500EDEDED00E3E3E300F5F5F5000000000000000000E3E1DE00F0EF
      EE00000000000000000000000000000000000000000000000000000000007C4E
      0300C6A67800C7A97A00C9AB7F00C8AA7D00C7A97A00C6A67800C6A77A00C7A9
      7A00C9AB8000CAAD8200CCB08800CDB48C00CEB38C00CCB28900D1B68F00D5BD
      9A00C5A57E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6CCAF00C3CAAB00C7CC
      B200C5CBAE00C5CBAB00C6CCAF008181AE005450B000C2C8AB00C4CAAB00E2E4
      D800C8CEB300C3CAAA00C7CCB100C6CCB000C5CBAB00C5CBAD006A68B0004642
      B000C4CAAB00C3C9AB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F9F900F0F0F000D4CEC700AEA2
      9200D8D3CE00DAD7D300E1DFDB00E3E1DE00E3E1DE00E3E1DE00000000000000
      000000000000000000000000000000000000000000000000000000000000794D
      0400C6A67800C4A57500C4A37300C2A17000C2A06F00C19F6E00C1A06E00C2A1
      7000C4A37300C5A57800C7A87B00C8AA7D00C9AC8000C9AE8200D0B58F00D6BE
      9B00A88451000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B6E5B00646855006467
      5600636755006367550063675500646656005A5C60006266560062665200B5B7
      B0006E7260006467550064675600636755006367550063675500626656005A5D
      5D00646A56006569540000000000000000000000000000000000F1F0EE00DCDB
      D600DAD8D300DAD8D400DEDDD800E7E6E300E6E5E200E8E7E400D9D5CF00C7C1
      B600D7D3CD00EAE9E600E9E8E500E9E8E600E9E9E600E9E8E500E9E8E500E6E5
      E100F7F7F6000000000000000000000000000000000000000000000000007C50
      0400C6A87900C5A57600C3A37300C3A27100C1A16D00C1A16D00C2A06F00BF9E
      6D00BD9D6D00C1A27300BFA07300C6A77B00C8AB7F00CBAE8300D1B79000D7BF
      9C00997331000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CAD2AF00D9E0BD00D9E1
      BD00D6DEBC007F7FB800AAADBA00DBE2C000D9E0BF00DDE4C100D2DAB500C3C6
      B800C7CEAB00D7DFBB00D9E1BD00D5DBBC007170B900B6BBBB00DBE2BF00D9E0
      BF00DDE4C200D3DAB60000000000000000000000000000000000D1CFC900DBAD
      8000E19E5E00E19F5F00E2A16100E2A16100E3A26200E4A36300E5A36400E5A4
      6400E6A56500E6A46500E6A46500E7A56600E5A36300E5A36300E3A06000DEBB
      9900DBDAD5000000000000000000000000000000000000000000000000007B4F
      0600C6A77A00C6A67800C4A47500C3A37300BB946200F9EEDF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6B05700CBAE8500D2B99300D8C0
      9F00845804000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1E4D600E4E6DA00CFD0
      D8008480D0000D03B4004640BD00DEE0D700F0F3E500EDF0E100EAEDE000CBCC
      C600DBDFD100E7E9DC00D7DAD7006E69CA004F46D3005C57C100E0E2D500EFF3
      E500EDF0E100EAECE00000000000000000000000000000000000D1CFC900E691
      3E00E8994700E99D4D00EA9E4E00EA9E4F00EA9E4E00EA9D4D00E99C4C00E99B
      4A00E99A4900E8984700E8974500E7944200E6924000E6903D00E58D3A00E5A2
      6200E1DFDB000000000000000000000000000000000000000000000000007A4A
      0700C7A97C00BB772A00ECA04000BA782D00FFA32F00FFA33100FFA83A00FFAD
      4500FFB04F00FFE2C000FFF7ED00FFFFFF00FFBB6600DE7E1200CAB18C00DFCC
      AF007D4D05000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEEEEE00EBEAEF00C4C1
      EC004E47C800817CD6003F37C200736ED300FBFBFE00FBFBFC00F8F8F800D1D1
      D100E8E8E800EFEDF400D7D5EF00443CC500938FDC003027BE008D88DA00F8F8
      FD00FCFCFD00F7F7F70000000000000000000000000000000000D2D0CA00E796
      4500EBA55700EEAE6100EEAF6300EFAF6300EEAF6200EEAC5F00EDAA5D00EDA8
      5A00ECA55700EBA25300EA9E4E00E99B4A00E8984600E7944200E6903D00E4A2
      6200DFDEDA000000000000000000000000000000000000000000000000007D4F
      0500C8AA7E00CD975000B8762B00BE7A2A00CC832C00FFA83B00FFA73A00FFA8
      3900FFB65A00FFD09600FFFFFF00FFFFFF00FFB45800D46F0000D5C1A400E0CE
      B3007E4904000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D7DCC500E0E4CF00E8EC
      D800E0E3D500D3D6C2009899C4004138CB008682D800F4F6F400E4E8D300C5C7
      BE00D2D7C100E1E5CF00E6EAD500DEE2D800D5DAC4007876BD00554CD4006863
      CF00F4F7F700E6EAD80000000000000000000000000000000000D3D1CB00E89A
      4A00EEAF6200F1BB7100F2BC7300F2BC7300F2BC7300F1B96F00F1B76C00F0B4
      6900EEAF6200EEAB5E00ECA75900EBA25300E99D4D00E8994700E6934000E4A2
      6200DEDED9000000000000000000000000000000000000000000000000007C50
      0900C9AC8000C8AB7F00BC7A2C00C27C2B00CB822F00FFAA4000FFA93C00FFAD
      4600FFBB6700FFC37900FFFFFF00FFFFFF00FFB55900C5792600DFCCAF00E2D1
      B7007E4902000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BCCA8700C8D49800CED9
      A700C8D49D00BBC98400B5C280004945B2004440B500D0DAB700BECB8200D7DD
      BF00BDC98700C6D39400CDD9A600CBD6A200BECB8800AEBC7D00312BB2002922
      B500D4DCBE00C1CF8D0000000000000000000000000000000000D4D3CC00EA9F
      4F00F0B76D00F4C67E00F9DFB500F9DFB600F9DEB500F8DDB300F8DAB100F8D9
      AF00F7D6AB00F7D4A900F4CA9800ECA95B00EBA35400E99D4C00E7954300E3A2
      6200DDDCD7000000000000000000000000000000000000000000000000007958
      1000CDB18700CAAC8100BC7C3400C9812C00D3872C00FFA83C00FFB65A00FFBC
      6700FFBE6F00FFC47B00FFFFFF00FFFFFF00FFC27500D4822700E2D0B600E6D6
      BE00745002000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B2B6A400ADB19E00AFB2
      A100AFB2A000AFB29F00AFB3A1009D9FA0007575A400AAAD9E00B0B3A000DADB
      D400B6BAA800ADB19F00AFB2A100AFB2A000AEB29F00AFB3A1009395A2007575
      A400ADB19D00B0B3A00000000000000000000000000000000000D8D7D100EBA1
      5200F3BF7600F7CF8A00F8D9A800F8D8A800F8D8A700F7D6A500F7D4A200F6D2
      A000F6CF9D00F5CD9900F3C38C00EEAF6300ECA95B00EAA15200E8994800E3A1
      6200DCDBD6000000000000000000000000000000000000000000000000007E54
      1600D2B89200D0B58E00D59A5300D0852F00DA8B2F00FFB05000FFB85F00FFBD
      6A00FFC47B00FFD09700FFF1DF00FFFFFF00FFC17300DBBB9300E5D4BC00E8D9
      C300745505000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000797F610079806200797F
      6300787E6300797F6400787E6300797F63007A806400797F6300747B5D00B5B7
      AB007B816500787E6100797F6400787E6300797F6300787E6300797F6300797F
      64007A806500757C5E0000000000000000000000000000000000DAD9D300EAA1
      5100F4C27B00F9D79300F6CD8A00F7CE8B00F7CD8A00F6CA8700F5C88300F4C6
      8000F3C17B00F2BC7500F0B76F00F0B66B00EEAD6100EBA55600E99B4B00E2A1
      6200DBD9D5000000000000000000000000000000000000000000000000007B5B
      1D00D7BF9C00D4BC9700D2B89200D98B3300E4923400FFB45700FFC47A00FFCE
      9200FFD09500FFD49E00FFE1BB00FFFFFF00FFC78000E5D5BD00E8D9C300EBDD
      C900725A02000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D2D8BB00DCE3C500E0E6
      C600DFE4C7009EA0C200BEC2C400E1E7C900DFE5C900E1E8CA00DCE2C300C5C8
      BB00CFD6B700DCE1C400DFE6C600DFE4C7009495C100C9CDC500E1E7C900DFE5
      C900E1E8C900DEE5C60000000000000000000000000000000000DCDAD600EBA3
      5400F4C57E00FADA9700FCEBC600FCEAC500FCE9C500FCE8C400FBE6C100FBE5
      BF00FAE2BC00F9DFB800F7D5A900F1BA7000EFB06400ECA75A00EA9D4E00E2A2
      6200DBD9D4000000000000000000000000000000000000000000000000009375
      4000DECBAD00DECAAD00DECAAD00E3A25800EFAC5D00FFD29A00FFC78100FFCD
      9100FFD5A000FFD5A100FFD7A800FFFFFF00FFC07100E8DAC400EBDDCA00EEE1
      CF00724D03000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E5E6DD00E6E8DF00E1E3
      E200A8A6DA000F06B400544EC000E5E7DD00F4F6EB00EFF2E700EEF0E500CCCE
      C800DFE1D600E9EBE200E4E5E000918FD4004A42CE00706BC600E1E4DA00F4F6
      EB00EFF2E600ECEEE40000000000000000000000000000000000DFDDD900EBA4
      5500F5C88100FBDC9900FCE2A000FCE19F00FBE09E00FBDE9C00FADA9700F8D5
      9200F7D18C00F5CA8400F4C37B00F2BB7200EFB26700EDA85B00EA9F4F00E1A2
      6300DAD8D300000000000000000000000000000000000000000000000000957B
      4700E5D4BB00E3D2BA00E2D0B600E1BD8F00F6CF9C00FFC47C00FFD5A100FFD5
      A200FFD5A300FFD6A500FFD7A600FFF9F2009A652B00ECDECB00EEE2D000F1E6
      D500794D05000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEEEEE00EBEAEF00BFBC
      EA003D35C300645DCC00372FC000918CDD00FFFFFF00FDFCFE00F8F8F800D0D0
      D000E8E8E800EEEDF300D0CEED00362EC100756FD2002C23BD00ACA8E500FFFF
      FF00FDFCFE00F7F7F70000000000000000000000000000000000E0DFDB00EA9F
      5000F5C78000FADA9800FBE09F00FBDF9D00FBDC9A00FADA9800F9D69200F7D0
      8B00F6CC8600F4C57D00F2BD7300F0B66B00EEAE6100EBA55600E99B4B00E1A0
      6000DAD8D300000000000000000000000000000000000000000000000000927B
      4800E9DAC400E7D8C200E6D6BF00E6D5BD00F7CD9A00FFDAAC00FFDAAB00FFD9
      A800FFD9AA00FFD9A900FFD9AA00FFCD9000C57D2F00EFE3D100F1E6D600F3E9
      DB007C4F0C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1DAB700DCE3C500E0E6
      CB00C7CBC600C2C8B4007E7EB5000B01B3009B99DB00EDF1EC00DEE5C400C8CA
      BC00CCD5B200DCE3C300E1E6C900C7CAC800CBD1B700615FB200130AB500817E
      D400EFF3F000DFE5C80000000000000000000000000000000000E0DFDA00E99A
      4900F1BB7100F7CE8800F8D59100F8D28E00F6CC8700F6CA8400F4C67F00F2BE
      7500F1B86E00EFB26700EEAD6000EBA45500EA9F4F00E8994800E6934100E09E
      5E00D9D8D300000000000000000000000000000000000000000000000000927A
      4A00ECDFCC00EBDECA00EADCC800E9DBC600F9DCB9004D3D2D00513A2300583E
      230079502500936028004E3A2500704B2400F2DBBC00F2E7D800F4EBDC00F6ED
      E100A9875B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C7D39500C9D69C00D4DD
      B100CED8A500C3D09000BCC791003630B200413DB400D1DCB600C3D19000E6EC
      D200C8D59800C9D59A00D1DCAE00D0DAAA00C6D19400B1BC8F001C14B100211A
      B200D5DDBB00C7D4970000000000000000000000000000000000D9D8D300E6C0
      9900EBC59C00ECCBA300EDCEA700EBCCA400E8C39A00E7C09700E5BF9600E3BC
      9200E2B98E00E0B68A00DFB58900DDB38700DCB18500DBAF8300DBAE8100D4C1
      AC00DCDBD6000000000000000000000000000000000000000000000000009474
      4B00F0E5D400EFE3D200EEE2D000EEE2D000EDE1CF00F3DAB800EACDA800FBD5
      A600E1B48000CDB19000F09A3700E49F5100F4EADC00F5ECDF00F7EFE300F8F1
      E600C7B794000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BBB8E800817CD60000000000000000000000
      00000000000000000000000000000000000000000000000000009E9BDF00746E
      D200000000000000000000000000000000000000000000000000EFEFEC00E7E6
      E300E7E6E300E9E8E500E9E8E600E6E6E200E7E6E300E8E7E400E6E5E200E5E4
      E100E5E4E100E5E4E000E5E4E000E5E4E000E5E4E000E5E4E000E5E4E000E8E7
      E400000000000000000000000000000000000000000000000000000000007960
      3200F3EADC00F3E9DA00F2E7D700F1E6D600F1E6D600F0E5D600F1E6D600F2E7
      D700F1E7D800F3E9DB00F4EADC00F5ECDF00F6EEE200F7F0E500F9F2E800FAF4
      EB00E5E8D5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AC9D
      84005B3F140056380100957E5700E2D6C500FDF7EE00FDF8EF00FCF6ED00A290
      7100DECBAC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C1BC
      AA00857D79006A625F00736B69007E767200887F7C008E858200928986009389
      820093887C0090867A008C827600867C70007D746800766D61006F655A00796F
      6400AAA08C00F0ECDC00000000000000000000000000959595008B8B8B008E8E
      8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008F8F8F00D3D3
      D3009A9A9A008C8C8C008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E008C8C8C0090909000000000000000000000000000909090008C8C8C008E8E
      8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008C8C8C009A9A9A00D3D3
      D3008F8F8F008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E008B8B8B0095959500000000000000000000000000909090008C8C8C008E8E
      8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008C8C8C009A9A9A00D3D3
      D3008F8F8F008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E008B8B8B009595950000000000000000000000000000000000ADA89C008678
      75008877730073635D0073635C0077665F00796762007B6963007C6963007B69
      65007B6866007A696500796764007665630073625F0071615D006E5E5B007D6C
      6900887A7D009A8E7500EEE9D7000000000000000000899168008E966F008E95
      73008D9471008F9674008D946F008E957300909776008E95720088906500B7B9
      A90089916B008C956D008F9573008D9571008F9573008D946F008D9571009097
      75009098740088906700000000000000000000000000889066008E9670008D95
      73008D9471008F9674008C946E008F957300919776008E96700089906B00B6B9
      A900889065008B946E008D9573008D9571008F9674008D946F008E9573009197
      7600909874008991680000000000000000000000000090666A00967074009573
      74009471730096747700946E730095737600977679009670730092677000B7B5
      A900879365008B946E008D9573008D9571008F9674008D946F008E9573009197
      7600909874008991680000000000000000000000000000000000988C8A008A75
      6E008B746C00A08A8300A4908900A5939000AB9A9800B7A4A100C0ADAB00C6B4
      AE00CAB5AB00C6B0A700C4ADA400BBA79E00B5A09900AF9A9000AE9A88009983
      750087716D0084746800D2CAAF000000000000000000C8D1A600D6DFB500D9E1
      B900D5DDB500D7DFB800D7E0B500DAE3BB00D8DFBA00D8E1B900D2DAAE00C1C5
      B300C3CCA300D5DDB400D9E2B900D6DEB500D6DFB800D6DFB500DAE2B900D8E0
      BB00D9E1B900CFD8AE00000000000000000000000000CED7AB00D7DFB700D7E1
      B800D5DDB500D7DFB800D7DFB500DAE2BB00D8E0BA00D7E1B800C2CBA200C1C5
      B200D2DCAE00D5DEB500D8E1B800D5DEB600D7DFB700D7DFB600DAE2BA00D7E0
      BA00D9E1B900C8D1A600000000000000000000000000D7ABAF00DFB7BB00E1B8
      BB00DC9EA400DE9EA400DFB5B900E2BBBF00E0BABE00E1B8BC00CB9FA600C2BF
      B300D2DEAD00D5DEB500D8E1B800D5DEB600D7DFB700D7DFB600DAE2BA00D7E0
      BA00D9E1B900C8D1A60000000000000000000000000000000000AEA09A008C76
      6D00BBA49B00DBC1B700D8C2BB00D7AB8100E3A65F00EBB67900F1BD8500E5C8
      B000C5D1E100E9EDF500CDD2DA00E8CFC600D3BCAD0094847A0077669900B39D
      AB009780760096827400DCD4B9000000000000000000DEE0D000E2E6D500E7EB
      D800EEF1E200EDF0DE00E4E7D500E2E6D400ECEFDD00EBEFDC00E6EADA00C9CB
      C300D8DCCA00E4E7D700E5E8D500EEF1E100EDF1DF00E6EAD700E1E4D200EBEE
      DD00EBEFDC00E6E9D900000000000000000000000000E5E8D700E1E4D400E9ED
      DA00EFF2E200EBEFDD00E1E6D300E4E8D600EBEFDD00ECEFDD00D7DACB00C8CA
      C200E6EAD800E2E6D500E7EBD800EEF1E100EDF1DF00E4E8D500E1E6D400EBEF
      DD00EBEFDC00DEE0D200000000000000000000000000E8D7D900E4D4D500ECCB
      CF00DF384700E2586500E6D3D500E8D6D800EFDDDF00EFDEDF00DAC9CD00C9C8
      C200E7EBD800E2E6D500E7EBD800EEF1E100EDF1DF00E4E8D500E1E6D400EBEF
      DD00EBEFDC00DEE0D20000000000000000000000000000000000AFA09B00917B
      7300BEA59A00D3B7AC00C9B0A700D49E5200D6A46700CDA98600DA9E4800C398
      640077A2CD00C8E6FD0095AEC80089766800584B41001C109A004D45E6005E51
      C100937B78009B887700DDD4BD000000000000000000EEEEEE00ECEBEF00F8F8
      FB00FFFFFF00F5F4F700EDECF000F6F4F600FFFFFF00FAF9F900F8F8F800D1D1
      D100E8E8E800EFEFF300F4F2F600FFFFFF00F8F8FC00ECEBEF00F3F2F400FFFF
      FF00FAF9F900F6F6F700000000000000000000000000F6F6F700EAE9EE00FCFC
      FE00FFFFFF00F2F1F500EEEDF100F7F6F800FFFFFF00F9F9FA00E8E8E800D1D1
      D100F9F9F900ECEBEF00F8F7FA00FFFFFF00F6F5F900EDEBEF00F5F4F600FFFF
      FF00F9F8F900EEEEEE00000000000000000000000000F6F7F700E9EEED00E453
      6000DD1C2E00DD2B3C00E7A4AA00F6F8F800FFFFFF00F9FAFA00E8E8E800D1D1
      D100F9F9F900ECEBEF00F8F7FA00FFFFFF00F6F5F900EDEBEF00F5F4F600FFFF
      FF00F9F8F900EEEEEE0000000000000000000000000000000000B2A39E00917B
      7300B1978E00CAAFA600B19A8E00D2AC5E00C0B6B100C0AE9A00E6BA6000C0A7
      87007CA2C900CDEAFF00849FAF003C322A001B0E9D005044FE00BAAFFF008A75
      CB008A716F00A28E7E00DED6BF000000000000000000DDE1D300E3E6D800ECEF
      E100EBEEE100DBDDD200E6E8DA00F5F7F500F8FAFB00F7F9F800EBEEE000C8C9
      C300D9DCCE00E4E7DA00E9ECDE00EFF1E400DCDFD300E1E5D700F2F4F000F8FA
      FB00F8F9FA00EBEEE200000000000000000000000000E4E6D800E3E6DA00EDF1
      E200E7EADE00DCDED200E8EBDE00F7F8F800F8FAFA00F6F8F600D9DDCF00C7C8
      C200E6E9DA00E4E6DA00EBEEDF00EBEEE200DBDED200E4E7DA00F5F6F400F8FA
      FA00F8F9F800E1E4D700000000000000000000000000E6D8D900E6DADA00EA9D
      A400E6AEB300DC737C00DA0F2200F0BEC200F8FAF800F8F6F500DDCED000C7C6
      C200E6EBDA00E4E6DA00EBEEDF00EBEEE200DBDED200E4E7DA00F5F6F400F8FA
      FA00F8F9F800E1E4D70000000000000000000000000000000000B6A6A1009781
      7900AC938800B59D96008C7C6F00DDC47000E3D18C00E7CF8000E9DEC000AEA0
      9E006F95BA008FB2C8005B788F001B0DA0005246FB009F93FF009C82E500B095
      980099817500A5918300DFD7C0000000000000000000BDCC8700CDD9A000D4DE
      AE00CDD8A400BECB8900B8C68500D5DEC300DCE4D100D8E1C600C3D18C00D1D7
      B900BECA8700CCD79C00D3DDAD00D0DBA900C1CE8F00B5C47E00CFD9B800DCE4
      D100DBE3CD00C7D49700000000000000000000000000C3D08A00CFDAA400D4DE
      AE00CBD69F00BAC98400BCC88D00D9E1C900DCE4D200D6DFBF00BECC8800D0D6
      BA00C0CF8800CDD99F00D4DEAE00CED9A500BDCB8A00B8C58400D5DCC100DCE4
      D100D9E1C800C0CD8C00000000000000000000000000D08A9200DAA4A900DEAE
      B300D69FA500CA7B8200D7122400DA2A3900E1CECA00DDC0BF00CC839000D3CE
      BA00BFD38700CDD89F00D4DEAE00CED9A500BDCB8A00B8C58400D5DCC100DCE4
      D100D9E1C800C0CD8C0000000000000000000000000000000000BAAAA4009C86
      7E00A68D86008D797000857C7800E6E4D600DFD6B400DDDBCC00C8C4C6006558
      5400466C8A00517592002126C3005042F9009F93FF009A82E400AA919500AB93
      820099807B00AB988A00E0D8C1000000000000000000C6CCAF00C3CAAB00C7CC
      B200C5CBAE00C5CBAB00C6CCAF00C6CCAD00C5CBAC00C4CAAC00C4CAAB00E2E4
      D800C8CEB300C3CAAA00C7CCB100C6CCB000C5CBAB00C5CBAD00C6CCAF00C5CB
      AC00C4CAAB00C3C9AB00000000000000000000000000C4CAAC00C4CAAC00C7CC
      B200C5CBAD00C4CBAB00C7CCAF00C6CBAD00C5CBAD00C3CAAA00C8CDB200E2E4
      D800C4CBAD00C3CAAC00C7CCB200C5CBAE00C5CBAB00C6CCAF00C6CCAD00C5CB
      AC00C4CAAB00C5CCAE00000000000000000000000000CAACAF00CAACAE00CCB2
      B400CBADB000CBABAE00CF7F8700D2384700CBA8AA00CAAAAD00CEB0B500E2E1
      D900C4CCAC00C3C9AC00C7CCB200C5CBAE00C5CBAB00C6CCAF00C6CCAD00C5CB
      AC00C4CAAB00C5CCAE0000000000000000000000000000000000BFAEA700A58D
      8600947E76005E504A00A5A19F00F6F9FD00D6D8DE00D9DBDF00857C7600362F
      2D00456D77003345AF00564AF700A598FF00967FE1009D858800A18D7B009C86
      7F009B837D00B39F9000E2DAC40000000000000000006B6E5B00646855006467
      560063675500636755006367550064675500646756006468550062665200B5B7
      B0006E7260006467550064675600636755006367550063675500636755006467
      5500646A56006569540000000000000000000000000065695400646855006467
      55006366550063675500636755006467550064675600646855006E705F00B5B7
      B000626652006467540064675600636755006367550063675500636755006467
      550064685600696E5A0000000000000000000000000069545500685557006755
      5700665556006755570067555600734C50006B54560068555600715F6200B6B5
      B000626852006467540064675600636755006367550063675500636755006467
      550064685600696E5A0000000000000000000000000000000000C5B5AC00AC94
      8C00715F58004E433E00CBC9C800F7F8F700DFDFDF00C1BFBD007E6D66007E6F
      6200425A9F003A38E400A48EFF00A58CD7008E79800093806F00927E7700907B
      74009E868100B9A59700E3DBC6000000000000000000CAD2AF00D9E0BD00D9E1
      BD00D0D8BC009798B900D1D7BD00DBE2C000D9E0BF00DDE4C100D2DAB500C3C6
      B800C7CEAB00D7DFBB00D9E1BD00D7DEBC00B3B8BB00ABAFBA00DBE2BF00D9E0
      BF00DDE4C200D3DAB600000000000000000000000000D2DAB400DAE1BE00D9E1
      BC00D1D7B900CCD2B800D8E0BC00DBE2C000D9DFBF00DCE4C000C6CDAB00C2C6
      B700D3DBB600D9E0BD00D9E1BD00D7DEBC00C8CEB600D5DBBB00DBE2C000D8DF
      BF00DDE5C100CAD2B000000000000000000000000000DAB4B700E1BEC200E1BC
      C000DD9EA400DFA1A500E0BCC000E2C0C300DFBFC200E4C0C400CEA8AE00C3C2
      B700D3DFB600D9E0BD00D9E1BD00ADB0BA00C4CCBC00D9E0BC00DBE2C000D8DF
      BF00DDE5C100CAD2B00000000000000000000000000000000000CCBBB200A993
      8C004F423D00584E4B00EDECEB00F9F9F900E0E2E2009A928F00816D65008372
      64006A6EB300927FFF00897AB500826D64008573660085726B0085726B00836F
      6800A28A8400C0AB9E00E3DCC6000000000000000000E1E4D600E4E6DA00DADC
      DA008D8AD200160CB500A8A8CD00E4E6D800F0F3E500EDF0E100EAEDE000CBCC
      C600DBDFD100E7E9DC00E6EADA00D8D9E3003730BD00423BBD00DEDFD400EFF3
      E500EDF0E100EAECE000000000000000000000000000EAEDE000E3E5D800E7E9
      DC009A9A97008E8E8B00DFE2D300E6E9DB00F0F3E500EDF0E300DBDED100CACC
      C500ECEFE100E4E6DA00EAEDDE00DADCD3006E6E6D00BDBFB700E2E6D700F0F3
      E500EDF0E100E1E4D800000000000000000000000000EDE0E000E5D8DA00EDC0
      C400DD1F3100E0455300E4D3D400E8DBDC00F3E5E600F0E3E400DFD1D200CACA
      C500ECF1E100E4E6DA00B9B9D5002017B8006E6AC900E2E6D700E2E6D700F0F3
      E500EDF0E100E1E4D80000000000000000000000000000000000D2C1B900AA94
      8D003E312C00736C6B00FFFFFF00E3E4E4009F9F9F006D605B006F5B5500998B
      8500AABBC600C1D7FC00858D9500725E5200786560007865600077655F007663
      5D00A48D8600C7B2A600E6DFCA000000000000000000EEEEEE00EBEAEF007A74
      D6002920BD005851CA003B33C100E5E4F600FFFFFF00FBFBFC00F8F8F800D1D1
      D100E8E8E800EFEDF400EEECF6005C55CC00332ABF003F37C200827CD700FFFF
      FF00FCFCFD00F7F7F700000000000000000000000000F7F6F700E9E8EF00BFBF
      C0008F8F8F00A6A6A800BDBCBF00FBFAFC00FFFFFF00FCFAFD00E8E8E800D1D1
      D100F9F9F900EBEBF000EEEDF1008B8B8B00B2B1B30092919300EDECEE00FFFF
      FF00FBFAFC00EEEEEE00000000000000000000000000F6F7F700E8EEED00E44F
      5D00E1394900DE344400E7899200FBFCFC00FFFFFF00FAFDFE00E8E8E800D1D1
      D100F9F9F900D7D6EA002F27BE00554ECA002E25BE00AAA6E200FAF9FB00FFFF
      FF00FBFAFC00EEEEEE0000000000000000000000000000000000D7C6BC00B19A
      9400372C2800928E8D00D1D1D200B3B5B500999593005C4B4500978D89009E93
      8E00697F9700CDEEFF0082868D00635149006A5A54006A5A5400695953006859
      5200A7908900CDB9AC00E8E1CD000000000000000000D7DCC500E0E4CF00CBCD
      D300AEAECD00C6C8C100332CB800443DC200D9DAF000F4F6F400E4E8D300C5C7
      BE00D2D7C100E1E5CF00E6EAD500C3C5D400B4B6C1009999C0003B31CB009592
      DC00F4F7F700E6EAD800000000000000000000000000DEE2CB00E1E5D000E1E5
      D300D6D8CA00CACEBD0062636200BFC1C000F1F3F500F3F6F100D4D7C300C6C8
      BE00E0E6CC00E1E5D000E7EBD700D3D6C800D3D7C300A5A79F0080808000CFD0
      D100F4F6F500DBDFCB00000000000000000000000000E2CBCD00E5D0D200E9B0
      B500E3B7BA00D8798100D9021500EB9FA500F5F7F300F5F1EF00D7C1C500C7C5
      BE00DFE7CD00E0E4D000B5B6CF00D0D1D3006E6BBB001A12B500B7B7E000EFF1
      F700F4F6F500DBDFCB0000000000000000000000000000000000DDCCC300B49F
      9800382D2A008F8F8E00D5D5D600F4F4F500827875008A7F7B00A59D9C00503F
      380060738700CEEDFF00767C830055453E005C4F49005B4E49005A4E48005C4D
      4800AB938D00D4C0B400E8E2CF000000000000000000BCCA8700C8D49800CED9
      A700C8D49D00BBC9840083898E003930C900898BBA00D1DBB700BECB8200D7DD
      BF00BDC98700C6D39400CDD9A600CBD6A200BECB8800B1C07C00413DAF00261F
      B500D4DCBE00C1CF8D00000000000000000000000000BFCC8500CAD69C00CFD9
      A800C6D29800B8C67E008B90790073737100CBD2B900CED9AF00BDC98600D8DE
      C000BBCA8000C7D49800CFD9A700C9D49D00BAC98300ADB880006B6C6B007B7D
      7900D2DBB900BFCC8900000000000000000000000000CC848B00D69CA100D9A7
      AB00D2989E00C77A8100D51F2F00D9223200DBBCBC00D8B0B100CB828E00DAD5
      C100BACF8000C7D49800CFD9A700C9D49D00AAB78700221BAC00423DB100C3CA
      BF00D2DBB900BFCC890000000000000000000000000000000000E3D1C900B39E
      970048403D00DCDDDD00FFFFFF00D6D4D300766E6A0096908E00463A3700392C
      26005C718600CFEEFF006F767D00433530004E423F004F433F004E423F004F42
      3E00AC958F00DAC6BA00EAE3D0000000000000000000B2B6A400ADB19E00AFB2
      A100AFB2A000AFB29F00AFB3A1005E5BA7007877A400AFB39F00B0B3A000DADB
      D400B6BAA800ADB19F00AFB2A100AFB2A000AEB29F00AFB3A1009899A1004E4A
      A900ADB19D00B0B3A000000000000000000000000000B0B3A100ADB19F00AFB3
      A100AFB2A000AFB2A000ADB1A0009EA19800A9AD9C00ACB19E00B6BAA800DBDB
      D500B0B3A100AFB3A000AFB3A100AFB2A000AEB29F00AFB3A100A1A398009C9D
      9500ACB19D00B3B6A400000000000000000000000000B49DA300B19BA000B39E
      A300B39DA100B39DA100B9808600C7434F00B3959A00B19AA000BAA3AB00DBDB
      D600AFB8A000AFB5A000AFB5A100AEB5A000AEB59F008183A4005553A8009DA0
      9F00ACB39D00B2B9A40000000000000000000000000000000000E8D6CC00B29C
      9400766F6D00FBFBFB00FFFFFF0096918F00413733002C2623001B1614001B14
      110056708800D7F5FF00636F7A00231915003C322E00483E3A0040373400483B
      3700B39B9500DFCBBF00EBE5D2000000000000000000797F610079806200797F
      6300787E6300797F6400787E6300787E640074796800797F6300747B5D00B5B7
      AB007B816500787E6100797F6400787E6300797F6300787E6300797F63007379
      66007A806500757C5E00000000000000000000000000757C5E00797F6400797F
      6300787E6300797F6400787E63007B8166007A806600787F62007B816500B3B6
      AA00747B5D00787E6100797F6400787E6300797F6300787E6300797F63007A80
      67007A806400797F610000000000000000000000000078745E007B7764007A75
      64007A7463007B7564007A7463007A6A64007B7164007B7564007D796600B5AF
      AC0079675E007C6C63007D6E64007C6C63007D6E64007C6C63007C6263007D68
      64007D6F65007C6C630000000000000000000000000000000000EAD7CE00B6A0
      9700A6A19E00FFFFFF00F1F1F1005D545100362A2700332B28002C2521002921
      1E00607A9500B9D6E70067727D003729230041393600565455004C413D006C56
      4F00B9A09900E3CFC100EBE5D2000000000000000000D2D8BB00DCE3C500E0E6
      C600D6DAC6009091C100D7DDC600E1E7C900DFE5C900E1E8CA00DCE2C300C5C8
      BB00CFD6B700DCE1C400DFE6C600DFE4C700B0B3C400AAACC200E1E7C900DFE5
      C900E1E8C900DEE5C600000000000000000000000000DBE2C300DDE4C600DFE6
      C600D6DAC300CFD3BF00DFE6C600E1E7CA00DFE5C800E1E8C900CDD3B700C5C8
      BA00DCE3C200DCE2C600DFE6C700DFE5C700C8CDBA00DBE0C400E1E7C900DFE5
      C900E1E8CA00D2D9BB00000000000000000000000000DAE7C200DCE8C600DFEB
      C600D4DFC6009094C000D7E3C500E0EDC900DEEAC800E1EDC900CBDBB600C7BE
      BA00E5B9C400E4C0C700E7C2C900E6BDC500E17A8600E7BBC300E8C3CB00E6C3
      CA00EAC5CC00DAB6BE0000000000000000000000000000000000E9D7CE00CBB5
      AF00D6D2D100FFFFFF00CBC4C200775E5800816760008B706900896F6700886F
      670095949700B0B6BB009B93920060514D00595B5C007E706C0083686100896E
      6700C8AFAA00E5D3C500EBE5D1000000000000000000E5E6DD00E6E8DF00C8C8
      DC00706BCC004840CE009795CC00E5E7DD00F4F6EB00EFF2E700EEF0E500CCCE
      C800DFE1D600E9EBE200E9EBE100C2C3E000241BB900322ABA00D4D7D800F4F6
      EB00EFF2E600ECEEE400000000000000000000000000ECEFE400E4E6DD00E5E6
      DD009C9C9A0095959400DFE1D700E8EAE000F4F6EB00F0F1E700DFE1D700CCCD
      C800EEF0E500E6E8DF00ECEEE400D7D8D1007C7C7C00B9BBB500E4E6DC00F4F6
      EB00EFF1E700E5E6DD00000000000000000000000000ECEEE400E4E6DD00E2E3
      E400706BCC004840CE009694CB00E8EAE000F4F6EB00F0F1E700DFE2D700CDC9
      C800F0E4E500E8DFDF00EED8D900E7687400D9001400E0878F00E6DCDC00F6EB
      EC00F1E7E800E6DDDD0000000000000000000000000000000000E6DDCC00E6D2
      CC00FAF8F900FFFFFF00BFAFAB00A88C8500A7938D0070635F00685B57006D64
      610092919000D7D5D500BCBBBD0083868B00A9A09F00AE938C00A98F8A00C3AA
      A300ECD5D300E7DBC700F6F4E9000000000000000000EEEEEE00EBEAEF007B76
      D600322AC000746ED1002C23BD00D1CFF100FFFFFF00FDFCFE00F8F8F800D0D0
      D000E8E8E800EEEDF300EFEEF700615BCE004A42C6004F47C700655ECF00FEFE
      FF00FDFCFE00F7F7F700000000000000000000000000F4F4F700EAE8EE00C8C8
      C900AEAEAE00BEBDC000B5B5B600FDFCFD00FFFFFF00FDFCFE00E8E8E800CFCF
      CF00F9F9F900EBEAEF00EEEDF000A1A1A100C6C6C8009D9D9D00E5E5E700FFFF
      FF00FDFCFE00EEEEEE00000000000000000000000000F4F4F700EAE8EE00B8B4
      E900332BC000746ED1002C24BD00D2CFF000FFFFFF00FDFCFE00E8E8E800CFCF
      CF00F9F9F900EAEFEF00EFBABF00DD1E3000E4727D00DC1F3100F5CDD100FFFF
      FF00FCFEFE00EEEEEE0000000000000000000000000000000000F2F3E800E2E0
      CD00FDFDFD00EEECE700E2D3C600EEDCCD00D0CAC700A9ADB2009B9DA200B8BB
      BF00CBCCCE00D6D5D700D5D6D500DFDAD100EAD8CB00EEDBCE00EDDCCF00F0DF
      D600EEE4D60000000000000000000000000000000000D1DAB700DCE3C500D8DD
      CA00C3C6C500C7CEB4003C37B4002B23BB00CCCEE800EDF1EC00DEE5C400C8CA
      BC00CCD5B200DCE3C300E1E6C900D1D5C900BFC3B7009FA3B100352DC5007874
      D200EFF3F000DFE5C800000000000000000000000000D6DEBB00DDE4C600E0E5
      CB00D5DBC100C2C8AC0080807F00B7B9B700EAEDEC00ECF1E700CED5B400C8CB
      BD00DBE3BD00DCE3C500E1E8CA00D9DEC600CCD3B400AEB1A20088898800C5C7
      C600EEF2ED00D5DCBE00000000000000000000000000D6DEBB00DDE4C600E3E8
      CC00BFC3C100C6CDB1003D38B5002C24BC00CCCDE800ECF0E700CDD7B400CBC2
      BE00E3BBC000E3C5C600E8C9CB00E3AFB200D3AEAF00D8354400DC1F3000E89F
      A400F0EEEB00DCBEBE000000000000000000000000000000000000000000ECED
      E200E7E9D700EEEEE500F5F5ED00F4F5EA00DBDCC800C0C0B400CFCFBE00D8D8
      CE00EEEEE800F1F2EB00F3F3EA00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C7D39500C9D69C00D4DD
      B100CED8A500C3D090009DA597002F26C2008586B800D1DDB600C3D19000E6EC
      D200C8D59800C9D59A00D1DCAE00D0DAAA00C6D19400C0CC8D005854B000241C
      B200D5DDBB00C7D49700000000000000000000000000C5D29200CDD7A100D4DD
      B100CCD8A200C1CF8D00A5AB8E00898A8700CCD4B800CFDAAF00C8D59900E6EC
      D200C3D18E00C9D69D00D3DEB000CFDAA600C3D09000BEC992008B8C88008D8E
      8A00D2DBB500C7D39600000000000000000000000000C5D29200CDD7A100D4DD
      B100CCD8A200C1CF8D009EA69D002F26C2008586B900D0D9AF00C8D99800EADB
      D400D1899200D69EA100DEB0B300DAA6A900D0909300D0747B00D7051800D933
      4100DBB5B600D396990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000837ED700B3B0E60000000000000000000000
      0000000000000000000000000000000000000000000000000000D9D8F200736D
      D200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D3D3D300BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000837ED700B3B0E60000000000000000000000
      0000000000000000000000000000000000000000000000000000EB858D00E97A
      8300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DADADA00CECE
      CE00D1D1D1000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AFAFAF00ADADAD00AFAF
      AF00AFAFAF00ADADAD009B9B9B00A2A2A200AFAFAF00ADADAD00ABABAB00A3A3
      A3009C9C9C0097979700979797009C9C9C00A1A1A100B9B9B900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0BF00A2A2A2009C9F9F009B9E
      A0009C9EA0009E9FA000A7A7A700D2D2D2000000000000000000000000000000
      00000000000000000000000000000000000000000000E0E0E000FAFAFA00F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F1F1F100E5E5E500DAD2A900E8DE
      8C00F6EC6C00F5EE5700F4E84C00F4DB4900E6CD6500B1A27F00DCDCDC000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEE0E000DEDFE00000000000D5D6D900C0C7CA00B3BB
      C200B4BCC300C2C8CC00D6D8D80000000000DCDDDD00DCDDDF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CBCBCB00B1B1B100A7A7
      A700A7A7A700B1B1B100CBCBCB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BCBCBC00A3A3A300C7BBB000D1B29A00CBA07E00C99E
      7B00CBA17F00CDA78800CBA68800BBA696009F9C9900D8D8D800000000000000
      00000000000000000000000000000000000000000000E1E1E100F4F4F400EFEF
      EF00EFEFEF00EFEFEF00EFEFEF00EBEBEB00DBD9D000E6DC8200F9F69300F1EE
      9700E9E5A300F1EAA500EDE39700E4D67B00EBD25100F3D14700E0BC6000E5E0
      DA00000000000000000000000000000000000000000000000000000000000000
      0000D7D8DA00CFD1D300D7D8D800BEC3C7007C9DB6005499CB00419DE500379C
      F300369AF1004097E1005491C900829CB500C2C8CA00D6D8D800CCCFD200D3D6
      D700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AAA9A900A3A4A500C2C7CB00D6DCDF00DADF
      E100DADFE100D6DCDF00C2C7CB00A3A4A500AAA9A90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A4A4A400C9BFB500C28A5E00BB774000BB774000BB774000BB77
      4000BB774000BB774000BB774000BB774000BB774000B6998300BCBCBC000000
      00000000000000000000000000000000000000000000E1E1E100F5F5F500EFEF
      EF00EFEFEF00EFEFEF00EEEEEE00DDDAD200EADD6000F7F16F00E9E6AE00E9E7
      E500F7F5F500D6D4D400C2C1C100F7F5F500D9D7D600E1D09C00F3C64B00E6B5
      5100000000000000000000000000000000000000000000000000000000000000
      0000DDDEDE00000000008DA8B7003A9DE2002CACFF0027A6FF00229FFF001E9A
      FF001D9AFF001F99FF00229AFF002397FF003A8DD8009BABBB0000000000D7D8
      DA00000000000000000000000000000000000000000000000000000000000000
      000000000000D1D1D100A4A5A500D7D9D900B9917000AA6F3E00B06E3A00AE6C
      3800AD6C3700AD6D3900B3744100C1AB9B00CACFD800AEB8C100D1D1D1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A4A4A400E8EEF100B87D4D00BB774000BB774000BB774000BB774000BB77
      4000BB774000BB774000BB774000BB774000BB774000BB774000C5B5A700BBBB
      BB000000000000000000000000000000000000000000E1E1E100F8F8F800F2F2
      F200F2F2F200F2F2F200E9E9E900DFD47A00F4ED4D00D8D59A00F7F5F500C2C1
      C100F7F5F500F0EEEE00EAE8E800F7F5F500A0A0A000F7F5F500E1D0AF00F3BA
      4900D8B177000000000000000000000000000000000000000000000000000000
      0000000000007CA3BC0027B0FF0026ABFF0021A3FF001FA0FF001D9FFF001D9E
      FF001B9CFF001795FF001993FF001A91FF001B95FF001D8FF8008EA6BB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C8C8C800B9BBBC00D9C8B900B6754100BB774000BB774000BB774000BB77
      4000BB774000BB774000C2BCBC00C5E1FF00C5E1FF00C5E1FF00C1D3E700C9C9
      C90000000000000000000000000000000000000000000000000000000000AFAF
      AF00E3EBEF00A3806500BB774000BB774000BB784200C48C5F00CA997100CC9C
      7500CB9B7400CA997000C8956B00BF825000BB774000BB774000C0845400C1C4
      C700D6D6D60000000000000000000000000000000000E3E3E300FAFAF900F4F4
      F300F4F4F300F4F4F300DED7C700F4E94C00E4DC7C00C2C1C100F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F0EEEE00DCDBDB00E1BA
      7700ECAC4100D6CCC00000000000000000000000000000000000000000000000
      000098B2C10027B7FF0025AEFF0024A9FF0024AAFF0026ACFF0037ABFC0046AC
      F7004CADF70040AAFC0027A0FF001B96FF001A91FF001992FF001C8FF800AFBE
      CA0000000000000000000000000000000000000000000000000000000000DDDD
      DD00B9BBBD00DBD7D200B2703B00BB774000BB774000BB774000BB774000BB77
      4000BB774000C1BAB900C5E1FF00B9D3FD005561F0009DB3F900C5E1FF00BED0
      E300DBDBDB000000000000000000000000000000000000000000DDDDDD00C8CC
      CD00BAA59600854A1B00BB774000BB774000C1865500D7B59900DFC4AE00E4CD
      BA00E4CEBC00E2C9B500DCBFA700CEA27E00BD7B4600BB774000BB774000E8DD
      D400AAAAAA0000000000000000000000000000000000E3E3E300FDFBFA00F8F5
      F400F8F8F800F8F8F800E0D59500F4E44E00DED9C200CFCECE00F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500D6D4D400DFD5
      C600F0AD3E00D7B079000000000000000000000000000000000000000000D3E0
      E80035B3EF0029B8FF0028B1FF0028B2FF0027ADFB002C9CEA002B8BD800247F
      CD00257FCD00318BD700399BEB00279FFC001C97FF001B91FF001B94FF00348D
      E50000000000000000000000000000000000000000000000000000000000A8A8
      A800EAECEE00814B2100BB774000BB774000BD7B4600CA9A7300D2AB8B00D6B0
      9200CBD0D900C5E1FF00BDD7FE00424CEC000000E2002024E700C5E1FF00CADF
      F700A8A8A8000000000000000000000000000000000000000000AFAFB000F5FA
      FD007F471B00AE6C3700BB774000BB774000CD9F7A00E2C9B500E9D7C800EEE0
      D400EFE2D700ECDBCE00E5CFBD00DBBEA500C48D6000BB774000BB774000B988
      6100DBE2E700CFCFCF00000000000000000000000000E5E5E50096D3D30091D3
      D6009DBFAB00A7C39D00CABF5D00F4DF5900EFEDEC00F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500D9D7
      D600F0B14D00E0AE650000000000000000000000000000000000000000007BB5
      D1002BC3FF002AB8FF002AB9FF002AB6FD002696E200438CC6008AB0CE00B3CC
      DD00B0CADF0081AACE003580BF002490E500209CFD001D97FF001B93FF001A94
      FF008FAECC000000000000000000000000000000000000000000C9C9C900DFE5
      E900956E4F00864B1B00BB774000BB774000C48D5F00DBBDA400E2CAB600D1DC
      E900C5E1FF00BAD5FD004049E9000000DF000000DF00515DEC00C5E1FF00C0BD
      BF00DFE5E900C9C9C90000000000000000000000000000000000BEC3C700E7D5
      C800A7673300BB774000BB774000BD7C4700DAB99D00E9D7C800F1E5DB00F5EE
      E700F6EFE900F3E9E000EBDBCD00E1C8B300C7936800BB774000BB7740009E5E
      2C00F6F8F800B1B2B200000000000000000000000000E5E5E5000FDEE10007EA
      EE0029AB680046BD3700C1B73E00D2BB5000ADADAD00DCDBDB00F7F5F500F7F5
      F500F7F5F500BFBEBE00C5C4C300E8E6E500F7F5F500F7F5F500E3E1E100ADAD
      AD00EDA94100E1AE6300DEDEDE00000000000000000000000000CDD9DF004AB7
      E50033C6FF002ABEFF002CC1FF002AA3EA007FA7C50000000000000000000000
      00000000000000000000000000006697BE002294EC001F9EFF001A95FF001997
      FF004B93D5000000000000000000000000000000000000000000AFB1B100F5F5
      F400844A1C00B6733C00BB774000BB774000CEA17D00E3CCB900D3DFED00C5E1
      FF00BBD6FD00454FE8000000DC000000DC00535EEB00C0DCFE00C5E1FF00AE8E
      7800F4F5F400AFB1B10000000000000000000000000000000000D8DCE100D09C
      7400BB774000BB774000BB774100C8956B00E3CCB900EEE0D400F5EDE600FAF6
      F200FAF6F300F6EFE900EFE1D600E4CEBC00C9966C00BB774000BB7740009556
      2400EEDFD100BABDBF00D9D9D9000000000000000000E5E5E50039D0D40034DC
      E2003EA7770048B25400ABAD4400F5D25D00E1E0DF00F7F5F500F7F5F500F7F5
      F500D9D7D600D9D7D600E3E1E000C4C4C100BEBEBA00EFEDED00F7F5F500E6E4
      E300EAA13600DDAA640000000000000000000000000000000000A5D5E8004DCA
      F8004DCEFF0041CCFF0034C6FF0071A0BE000000000000000000000000000000
      0000000000000000000000000000000000005790BB0022A4FF00239DFF002DA1
      FF003F99E900D8E2ED0000000000000000000000000000000000C1C5C800E1C5
      AF00B7743D00BB774000BB774000BF814E00DDC0A800D2DEEC00C5E1FF00BCD6
      FD00424BE6000000D9000000D9005561E900C3DFFF00C5E1FF00C1B8B5009A5B
      2800E7D1C000C1C5C800C8C8C800000000000000000000000000E1E2E300C380
      4B00BB774000BB774000C38B5E00D8B79C00E5D0BE00EFE2D700F6EEE800FAF6
      F200FAF6F200F6EEE800EEE1D500E4CEBC00C9966D00BB774000BB7740009457
      2600E9C9B200C6CACE00C7C7C7000000000000000000E5E5E50056E7E90055F2
      F6004BBE910049C86F008CA75000F3C64A00DFDAD100CFCECE00DCDBDB00DADA
      D800D9D8D600F7F5F500F7F5F500F7F5F500EFEDEC00E6E4E400C2C1C100DBCC
      B600E79C3200D5AB7400000000000000000000000000000000008DC8DB0054D5
      FA0056D5FF0059DDFF004DB9E200DBE2E7000000000000000000000000000000
      000000000000000000000000000000000000C2CCD30036A3F10046B1FF0046AC
      FF0042A5FC00C5D9EB0000000000000000000000000000000000D2D9DE00CB93
      6500BB774000BB774000BD7D4900CFA37F00D0D9E500C5E1FF00BAD5FD00424C
      E4000000D6000505D8005964E900C1DDFE00C5E1FF00C1B6B200BB7740009A5C
      2B00DDB29100D2D8DD00BDBDBD00000000000000000000000000E1E1E000BE79
      4200BB774000BB774000CB9F7B00D8B89C00E0C6B000EDDED100F1E5DA00F6EE
      E700F3EAE100F2E5DC00E8D6C600E1C9B400C8956C00BB774000BB774000975B
      2B00EAC4A700C9CED200C4C5C5000000000000000000E5E5E5006ADADC006BE3
      E70053B7950046BF7B00579D6500F1B94100E9C88900ADADAD00C1C1C000DDDC
      DA00F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500EAE8E800D6D4D400DCAB
      6800E4962E00D4C4B000000000000000000000000000000000008ACBDD005BDB
      FA005CDCFF005FE4FF0074BFD700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000058A6D70050BCFF004AB0
      FF0047AEFF00B3C3CF0000000000000000000000000000000000D8DEE200C282
      4E00BB774000BB774000C8987100CBD2DB00C5E1FF00BDD8FD00424CE2000000
      D3000707D6005B67E900C3DFFF00C5E1FF00C8C6C900BB774000BB7740009C5F
      2E00DCA77E00D8DEE200BBBCBD00000000000000000000000000E2E3E400C683
      4C00BB774000BB774000C0855400C2865600D2A88500E8D6C600E5CDB900EEE0
      D500E6D0BD00E8D6C600DDBFA600DCBFA700C7936900BB774000BB7740009C5F
      2F00F1D1B600CACED400CDCDCD000000000000000000E5E5E5007EEDEE0081F7
      F90059C7A70041D28E0044B68400B7A85100F2B34500E6D4BA00F3F2F100C2C1
      C100E3E1E100EAE8E800E3E1E100F7F5F500DCDBDB00F7F5F500E2CBAA00E498
      3200D4A36400000000000000000000000000000000000000000088C7D80060E1
      FA0062E1FF0066E9FF0076C8DA00000000000000000000000000000000000000
      000000000000000000000000000000000000000000005BB0E30055BDFF0050B4
      FF0050B3FE00B7C5D10000000000000000000000000000000000DAE1E300CB8E
      5C00BB774000BB774000C5C3C500C5E1FF00BAD5FC00414ADF000000CF000808
      D2005C68E600C2DEFE00C5E1FF00CFD5DE00CA997200BB774000BB7740009F62
      3100E3B08600DAE1E300BDBFBF00000000000000000000000000E0E3E700DEA9
      7E00BB774000BB774000BB774000BB774000CEA27D00E1C9B400DEC1A900E6D1
      C000DEC0A700E1C8B300D5B19300D5B19400C48E6200BB774000BB774000A264
      3200FAE5D500BFC1C400E1E1E1000000000000000000E5E5E5008BE1E3008EE9
      ED005CC2AA003ECB9A0046BA940047AF8500DAAB4B00EAAA4200E5C89B00D4D2
      D200F0EEEE00C8C7C700A7A6A600F7F5F500DBD9D800E4D2B600EBB36200DC9D
      4B00E1DDD600000000000000000000000000000000000000000090C6D90062E3
      F9006AE7FF006BEBFF0066DDED00CBDCE0000000000000000000000000000000
      00000000000090C2D70099B6C10000000000AFC7D40057C3FC0058BEFF0058BB
      FF0051AEF200C9DAE70000000000000000000000000000000000D5DDE100DCAB
      8300BB774000C1BBBB00C5E1FF00BDD7FD00434DDD000202CD000B0BD1005A66
      E500C1DDFE00C5E1FF00CDD1D900D8B79C00C8956D00BB774000BB774000A467
      3500EFC9A900D5DDE100C5C5C500000000000000000000000000C9CDD000FBE4
      D2009E663800BB774000BB774000BB774000CA997100D9B99E00CC9B7300CB9A
      7200C38A5B00C7936800C1865500C48D6100BD7C4800BB774000BB774000A76A
      3800FFFEFB00BDBFBF00000000000000000000000000E5E5E5009BE8E900A1EE
      F0005FCDB70036D9AB0044C8A40040CEA70043BC9200D5A34600EDA73A00DDA5
      4F00E0BF8D00D1BEA100DAC7AA00E3CDAA00EACA9200EFC57E00DDAA6500DED9
      D300000000000000000000000000000000000000000000000000ABD1E20059D8
      F50073EFFF006EEAFF0072F3FF0077C8D3000000000000000000000000000000
      00000000000090C6DA0068D6F7009EBCC8006CB6D90063CDFF005DC0FF0060C2
      FF0054A7E100DDE6EC0000000000000000000000000000000000C0C3C500FCE9
      DA00B8A19100C5E1FF00BBD5FC004750DD001212D1001717D300626EE600C3DF
      FE00C5E1FF00CACBD000C8956A00CB9C7600C0855500BB774000BB7740009E62
      3100FCE8DA00C0C3C500DFDFDF00000000000000000000000000BCBEBE00FFFF
      FF0093633D00A96D3D00BB774000BB774000C6916600D0A98800C1845300BB77
      4000BB774000BB774000BB774000BB774000BB774000BB774000B8753F00D2AC
      8C00EAEEF100E1E1E100000000000000000000000000E5E5E500E5EBEB00E2EA
      ED00CABA8900D6B55500C6AC6200CFB26000CFB15E00B69D5800C69A4600DE9D
      3E00E79C3200E6993000E7A24200E9AE5900E3B36D00B69A7300000000000000
      0000000000000000000000000000000000000000000000000000D8DDE1005CBF
      D90076FAFF0073F0FF0082F4FF0073E6FF00D6E9F00000000000000000000000
      00000000000094C6D70070DFFF006BD9FF0068D0FF0065C8FF0064C5FF0063C7
      FF00669FC6000000000000000000000000000000000000000000C2C2C200FFFF
      FF00B9C3D100C5E1FF005760E4002727D9002828D9006671E800C1DCFE00C5E1
      FF00C1B7B300BC794300BB774000BC794200BB774000BB774000BB774000AC72
      4300FFFFFF00C2C2C2000000000000000000000000000000000000000000D4D7
      DA00D5BEAB00AA6E3E00BB774000BB774000C18A5C00C7997300BF814F00BB77
      4000BB774000BB774000BB774000BB774000BB774000B8754000B2774700FFFF
      FF00BBBCBC0000000000000000000000000000000000E5E5E500FFFFFF00FFFE
      FF00E5C8A500F5BD7C00E3B78300ECBC8300F0BE8300E0B58200E7B87C00C39E
      7100BB936200B8884E00AD947600B9B4AD00C3C3C300C7C7C700000000000000
      00000000000000000000000000000000000000000000000000000000000093BF
      CD0064F5FF0087FCFF008BF4FF0062C1E2000000000000000000000000000000
      00000000000095C7D80075DFFF006ED5FF006BD0FF006ACBFF006DCAFF004FBC
      FB00A4BBC800000000000000000000000000000000000000000000000000D5D7
      D800C5E1FF00C5E1FF003737DF003A3AE100727EEC00C4E0FF00C5E1FF00C1B8
      B500BB774000BB774000BB774000BB774000BB774000BB774000A96C3A00EBD4
      C200D5D8D800000000000000000000000000000000000000000000000000D3D2
      D300EFF4F800C1916B00BB774000BB774000BB774000BB774000BB774000BB77
      4000BB774000B0754600A9714600AA7041009C693F00A7724700F9F1EA00D2D3
      D4000000000000000000000000000000000000000000E5E5E500FFFFFF00FFFF
      FF00F4F4F200F1EEEE00F1EFEE00F1EFED00F1F0EE00F0F0EE00EBEAE900DDDD
      DC00D5D4D300EBEAE900F3F3F300EBEBEB00CECECE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005FC4DE006BF6FF0060BBD800D5E0E5000000000000000000000000000000
      00000000000097C8D8007AE1FF0073D7FF0071D2FF0071CFFF005DC8FF005EA3
      CA0000000000000000000000000000000000000000000000000000000000CCCC
      CC00CFE5FD00C5E1FF008C9CF3007985EF00C2DDFE00C5E1FF00C2B9B700BB77
      4000BB774000BB774000B7764200BB774000B47440009A653B00D2AB8C00F6FB
      FD00CCCCCC000000000000000000000000000000000000000000000000000000
      0000C3C3C300F5F7F900BF825100BB774000BB774000BB774000BB774000BB77
      4000AB724400996B46009568430095674100B6865F00FBF7EF00DBDEE000DDDD
      DD000000000000000000000000000000000000000000E5E5E500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F6F600ECECEC00DBDB
      DB00D3D3D300FFFFFF00F2F2F200CDCDCD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0D0D40070C5E000DCE5E900000000000000000000000000000000000000
      0000000000009AC9D8007FE4FF0078D8FF0073D3FF0073CFFF0068CEFF008CB4
      C900000000000000000000000000000000000000000000000000000000000000
      0000C1C7CE00C5E1FF00C5E1FF00C5E1FF00C5E1FF00C1B8B500BB774000BB77
      4000BB774000A0704700996B45009567420098684000D2AD9100FFFFFF00C1C2
      C200000000000000000000000000000000000000000000000000000000000000
      000000000000CBCBCB00E7E9EB00D9B89D00BD815000BB774000B3744200A570
      45009A6C4700A0714C00B68A6500E0C8B300FFFFFF00D3D3D400E3E3E3000000
      00000000000000000000000000000000000000000000E5E5E500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00F3F3F300E8E8E800D6D6
      D600D8D8D800EEEEEE00CBCBCB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000097C8D60088E7FF008AE0FF0096E0FF009CDFFF0097DCFF007DCC
      F500A3C4D7000000000000000000000000000000000000000000000000000000
      000000000000CBD0D600CDC7C700C1B4AD00BE9A8000BB774000BB774000BB77
      4000A66F4200916542009B6C4700B6896500ECDACB00EFF1F400CCCDCD000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EDEDED00D0D1D100E4E7EB00ECEBEA00F4EFEB00F6EF
      E800F6EFE900F3EFEB00EBECEC00D9DDE000D0D0D00000000000000000000000
      00000000000000000000000000000000000000000000ECECEC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F6F600E9E9
      E900DDDDDD00CCCCCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009CC4D30057D2F6005ACDF6005DCCF4005CC7F20057BFEF004DBE
      F50071B0D2000000000000000000000000000000000000000000000000000000
      00000000000000000000DFDFDF00CBBFB500D0A88600C58A5A00D5A27A00F1CD
      B000FFE2CC00FDE8D600FBF1E900F5F6F800D0D2D400DFDFDF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C2C2C200CCCCCC00CBCB
      CB00C8C8C800CACACA00C9C9C900CACACA00CCCCCC00CBCBCB00CACACA00C1C1
      C100D8D8D8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1E1E100CDCFD000D9DBDD00C9CB
      CD00C9CBCD00D9DBDD00CDCFD000E1E1E1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E3E3E300EAEAEA0000000000000000000000
      00000000000000000000000000000000000000000000D5D5D500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECEDF00BCBCD800A8A8D0009797BB009595A400878790008E8C
      8A00CACACA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D7D7D7000000000000000000000000000000
      000000000000000000000000000000000000EFEFEF00D7D7D700000000000000
      000000000000000000000000000000000000000000000000000000000000EEEE
      EE00FDFDFD00FDFDFD00ABAAAB005E5F610055565900C3C3C300CFCFCF00CFCF
      CF00D4D4D400E0E0E000E0E0E000D4D4D4007C7C7D00595A5D007A7B7C00CDCD
      CD00CDCDCD00DBDBDB000000000000000000000000000000000000000000E4E4
      EF00CFCFCE00CACAC900C9C9C900CACACA00CACACA00CACACA00C7C7C900BDBD
      C600A9A9BD009E9EB7009595B100999AAD00A4A4A600AFAFAF0085848400777E
      8100B9BCBE00D3D2D2000000000000000000000000000000000000000000F0F0
      ED00EDEDE700F0F1EB00F2F2EE00F2F2EF00F5F5F300F7F7F600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EAEA
      EA00EAEAEA00E2E2E2008A8A8A00595A5C006E707100BEBEBE00BEBEBE00BEBE
      BE00C5C5C500CBCBCB00CBCBCB00C0C0C1007A7A7C005252550092929400CBCB
      CB00CBCBCB00DFDFDF0000000000000000000000000000000000ECEBEB00EBE8
      E800EFECEC00F1EEEE0081808200A8A8A9009B9A9B00A4A2A400F1EEEE00F1EE
      EE00F1EEEE00F1EEEE00F1EEEE00CBC9CA007C7C7E00B1B1B2006F6F7100F1EE
      EE00F1EEEE00F1EEEE00F5F4F4000000000000000000000000009292D1005150
      B200DCDCE500F4F4EF00E9E9E900E9E9E900E9E9E900E9E9E900EAEAEA00ECEC
      E900EFEFE900F0F0EB00F0F0E900C5C6C300B5B5B400A9AAAC00ADB1B500A5BE
      CC00D3DADC00B7B6B500CACACA00000000000000000000000000F9F9F800F5F5
      F100F7F6F700F8F8F600FFFFF700FFFFF700FDFDF500FDFDF400F9F9F000F6F6
      ED00F3F3EC00F3F2EC00F1F1EB00EFEFE900EFEFEA00F0F0EC00F3F3F000F5F5
      F300F6F6F400F7F7F50000000000000000000000000000000000E4E1E100EBE7
      E700F1EEEE00D8D6D60061626500A1A1A2007E7F8100CCCACB00F1EEEE00F1EE
      EE00F1EEEE00F1EEEE00F1EEEE00A4A3A5008B8C8D008F8F90006A6A6D00F1EE
      EE00F1EEEE00F1EEEE00F1F0F000000000000000000000000000EAE9E9009ABA
      D400CBCCD100DCD5D500D0C9C9008885880094909400DCD5D500DCD5D500DCD5
      D500DCD5D500DCD5D500DCD5D500DCD5D500A39EA100928E9100B7B2B300DCD5
      D500DCD5D500DCD5D500F4F2F2000000000000000000000000007474CC00A3A2
      D100ECECE800E6E6E600E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E0E0E000DFDFE000E0E0E000BCBCBC00B1B3BA00CFD3DC00D8C1A900B36E
      3C00C2B4AB00B4B7BA00D1D1D100000000000000000000000000F7F7F500FEFE
      F6008086D100363DB5004E5CC000626DC500767DCC00868CD20099A0D900AEB2
      E000BFC1E700D0D2EC00E0E2F100EFEFF400FBFBFB00FFFFFF00F7F8F400F7F7
      F300F8F8F200F4F3EF00EBEBE700000000000000000000000000E6E1E100609F
      CD00DCD5D500DCD5D500A7A3A6008F8C8F00A39FA200DCD5D500DCD5D500DCD5
      D500DCD5D500DCD5D500DCD5D500DCD5D5008F8C8F0093909300B7B2B400DCD5
      D500DCD5D500DCD5D500F4F2F200000000000000000000000000AEAEB0008A8A
      8C005A5B60009D9B9D00DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9
      D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9
      D900DFD9D900DFD9D900F5F3F3000000000000000000000000009C9AD500B5B4
      D000EEEFE600E3E3E400E4E4E400E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E600D6D7E000D5D3BE00E8C75500ED941100BC57
      0500C1B6AE00CFD2D50000000000000000000000000000000000F7F7F400FEFE
      F5003D4DC9000113B1000114B1000111B0000112B0003442C1003441BF002232
      BB000215AF000419AF000A20B1004756C300ECEDF900FFFFFF00434EBD005660
      C2006C70C800D7D9EF00F5F5EC000000000000000000000000007D7D80008F8F
      910065676A00CDC8C800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8
      D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8D800DFD8
      D800DFD8D800DFD8D800F5F3F300000000000000000000000000ACADAF00B2B1
      B20020232C00282B330097959800B2AFB200B2AFB200B2AFB200D6D3D300D6D3
      D300D6D3D300D6D3D300D6D3D300D6D3D300C4C1C200CCC8CA00B2AFB200B2AF
      B200B2AFB200C4C1C200F7F5F500000000000000000000000000AFAFD7008A8A
      BC00E9E9E000E2E2E300E2E2E100E2E2E200E2E2E200E2E2E200E2E2E200E2E2
      E200E2E2E200E2E2E200D4D4CE00DBD49300F4E96E00FFD40900FDA81300C76D
      1800C3BAB400D3D5D70000000000000000000000000000000000F8F8F400F5F6
      F4003042C8000118B0000119B0000118B0000119B000EEF0FA00EEF0FA00EEF0
      FA00EEF0FA00DDE0F400AEB5E600E7E9F700FFFFFF00BBC1EA000116B1000115
      B0000111B100B5BBE800F7F6E900000000000000000000000000828185008787
      8A0022242E003D3F4700C0BDBE00D6D2D200D6D2D200D6D2D200D6D2D200D6D2
      D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2
      D200D6D2D200DAD6D600F7F5F500000000000000000000000000BABBBD00999A
      9C00191C2600191C2600191C2600191C2600191C2600191C26004C4D5400191C
      2600191C26004C4D5400191C2600191C2600191C26007F7E8300191C2600191C
      2600191C26003D404700F8F7F700000000000000000000000000C1BFE3007372
      B500E8E8DF00E3E3E300E4E4E400E5E5E500E4E4E400E4E4E400E4E4E400E4E4
      E400E4E4E400E4E4E400CCC5B100EAC81C00FFE52A00FFC80F00F7A12200CD86
      4400C7C0BB00CED0D20000000000000000000000000000000000F9F8F400EBEE
      F3001F2EC7000119B600011AB600011AB6001228BC00EEF0FA0099A3E2003447
      C5005666CE007885D800C6CCEF00FFFFFF00FDFEFF00E2E5F7000119B6000119
      B700021ABA00CBD0F000F5F4EA00000000000000000000000000919296008687
      8A00191C2600191C2600191C2600191C2600191C26004D4E5500191C2600191C
      2600191C2600807F8400191C2600191C2600191C26004D4E5500191C2600191C
      2600191C26003D404700F8F7F700000000000000000000000000CECFD0006263
      680022252E00191C2600191C2600191C2600191C2600191C26004E505800191C
      2600191C26004E505800191C2600191C2600191C260084848900191C2600191C
      2600191C26003D404700FAF9F900000000000000000000000000D3D1EC006866
      B500E6E6DD00E5E5E500E4E4E500E4E4E400E2E2E200E2E2E200E2E2E200E2E2
      E200E2E2E200E2E2E200CCC3B700EBAA1C00FFBB0C00FDAA2300E5953F00BD81
      5000CEC9C500C7C8CA0000000000000000000000000000000000F6F5F000E3E6
      F4001424CA00011BC000011BC000011ABF003448CD00FFFFFF00CCD1F20099A3
      E6007885DD008591E100F8F9FD00FBFBFE00F4F5FC00AAB3EA00011AC000011B
      C000061DC300D5D9F200F4F4EB0000000000000000000000000077787E006263
      6800191C2600191C2600191C2600191C2600191C26005BA8C1002ABEF1002ABC
      EE002ABDEF0030C3F60030BEEE00416D7A00191C26004E4F5600191C2600191C
      2600191C26003D404700FAF9F90000000000000000000000000000000000DCDC
      DE00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500F7F7F700000000000000000000000000000000006B69
      B900DCDCDB00E8E8E600E5E5E500E4E4E300E2E2E200E2E2E200E2E2E200E2E2
      E200E2E2E200E3E3E300C8BFB600CC741700E7861C00D38C4700BF997900D4CE
      C900EAECEC00E6E6E50000000000000000000000000000000000F6F5EE00DBE0
      F4000B20CF00011DCB00011CCA00011DCA005668DC00EEF0FB00CCD2F500BBC3
      F100D1D6F500FCFCFE00FFFFFF00F8F9FE00EEF0FB00AAB4EE00011DCA00011D
      CA000B23CC00DFE2F500F0F0E800000000000000000000000000CBCCCD00E9E9
      E900ADAEB000ADAEB000ADAEB000ADAEB000ADAEB0005AD6F4002D9BAA003C56
      5800395E61003A5C600025C0D9008DD1DB00ADAEB000BBBCBD00ADAEB000ADAE
      B000ADAEB000C9C9CA00F7F6F60000000000000000000000000000000000DCDE
      ED001B18AC00B6B6D700CECEE300D7D8E3008585D1004A46C600D7D9E7006261
      D4005352D400DADCE600D4D4E800CFD0E6006369E000D3D6E9006168E0003C44
      DE00474BE000898CDD0000000000000000000000000000000000000000007575
      C500D2D2D900EBEAE700E5E5E500E5E5E500E4E4E400E4E4E400E4E4E400E4E4
      E400E4E4E400E4E4E400C6BAB000A7510D00B9835700C6BBB400DFE4E900D8DA
      E400F7F7F7000000000000000000000000000000000000000000F6F5EA00D2D8
      F400031CD700011ED600011ED600011ED6008896EC00FFFFFF00FFFFFF00EEF0
      FC00F8F9FE00FFFFFF00F4F5FD00C1C8F500BBC3F4005669E400011ED600011E
      D6001629D600E8EAF600F2F1EB0000000000000000000000000000000000F3F3
      F300F3F3F300FBFBFB00FBFBFB00FBFBFB00FBFBFB006CE3FC00337E86004A12
      0600471D1300471E140028B2CA00B7F4FC00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00F7F7F7000000000000000000000000000000000000000000DCDD
      EC002723B7007C7AD6004140C900BBBCE900ACADEA00231FD300DADBF8003F3D
      E4007D7EEC00C7CBF8002125ED00D0D1F7008C92F500D0D4FB008388F4003F46
      EF001F23EE007C7FEC0000000000000000000000000000000000000000008B8A
      D000D0D0DA00E9EAE400E1E1E100E2E2E200E1E1E100E1E1E100E1E1E100E1E1
      E100E1E1E100E1E1E100CBC4C000B4A19300D7DADD00D6D9DD00EEEDE700B4B4
      DC00000000000000000000000000000000000000000000000000F9F7EC00C4C9
      F300021FE0000120E1000120E1000120E100AAB5F500FFFFFF00EEF0FD00E9EC
      FC00FFFFFF00FFFFFF00E6E9FC00EEF0FD00EEF0FD0099A6F3000121E1000121
      E1001F31DE00EFF2F600F3F3EE00000000000000000000000000000000000000
      00000000000000000000EEFAFD00000000000000000071E7FB00308A9500471E
      140044282100442A230025BAD600BCF7FC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEDF
      EC001E1BB900413FC700CFCFF100F0F0FB005A56DC002826D800DBDCF8003E3E
      E9009798F300ACAFF700040BED00B1B5F700A3A8F600D4D7F900F1F2FB00E2E2
      F8003E42EF007679EC000000000000000000000000000000000000000000A8A7
      D900D2D2DD00EAEAE500E3E3E300E4E4E400E5E5E500E3E3E300E2E2E200E2E2
      E200E2E2E200E2E2E200E0E0E100DDE0E300E1E1E200C1C1C100F5F6EB00A9A9
      D700000000000000000000000000000000000000000000000000FAF9EB00B4BB
      F300011FE9000122EB000122EB000122EB00CCD3FB00FFFFFF00F1F3FE00FDFD
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EEF0FE00677AF3000122EB000122
      EB002F46E600F6F8F300F4F4F000000000000000000000000000000000000000
      0000000000000000000028D3FC0028BFEA002AC6EE0020D6EF00366D72004621
      17004429220045261E0029A6B80026D6F50030C6EF002BC1F00048D5FB000000
      000000000000000000000000000000000000000000000000000000000000DDDE
      EC001F1BBE00CACAEF00B9BAEF005859DA002926D9002422DF00D7DAFA003434
      EE008486F300BBBDF8000914EC00C3C6F7009CA1F500CBCFF9005459EF00D0D2
      F8007779F4007173EA000000000000000000000000000000000000000000BDBC
      E200D8D7E100F0F0EB00E0E0E100D7D7D700D2D2D200DCDCDC00F5F5F500FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00F1F1F100F7F6EB00A7A7
      D600CDCDF0000000000000000000000000000000000000000000FBF9EB00A4AD
      F400011FF0000123F2000123F200677BF700EEF0FE00FFFFFF00FFFFFF00FFFF
      FF00FBFBFF00FFFFFF00DDE2FD00DDE2FD00DDE2FD00344FF5000123F2000123
      F2004056EC00FDFCF200F4F4F100000000000000000000000000000000000000
      0000000000000000000020E2FC002E919D00403C39003F423F00432B2400442A
      2300442C250045282100413734003D4E4B003C4E4C0028B0C3002CE0FB000000
      000000000000000000000000000000000000000000000000000000000000DEDF
      EE00211BC400BFBFED00ADAFEC00C6C6EF00898CEB008E90EE00F7F8FA00ABAB
      F6007478F200E3E4F900A6ABF600E6E6F8006167F200E1E2FA00A6A9F400E8E9
      F8006164F2007477EB000000000000000000000000000000000000000000CDCD
      E900DEDDE300FAFBF500EBEBEB00E1E1E200DADADA00DEDEDE00F0F0F000F3F3
      F200F2F2F200F2F2F200F2F2F200F2F2F200F3F3F200EBEBEC00F7F8EC00A1A0
      D300B8B6EB000000000000000000000000000000000000000000FAFAEC00909C
      F5000120F2000123F3000123F300566CF700EEF0FE00F6F7FF00FFFFFF00FEFE
      FF00F1F3FE00EEF0FE00DDE2FD00EEF0FE00EEF0FE002340F5000123F3000122
      F2005265EF00FDFDF000F6F6F400000000000000000000000000D8E6F400CFE2
      F100D6E7F500CBDBEC0058ABD2002CDDF10032818600471C130046221A00442C
      2500442B2400442C2500481B1100452620002C9CA7003BDFF400579ACA00A2BD
      DE00A7C1E100C4D9EE00E5EFF70000000000000000000000000000000000DBDD
      ED001A14CA004644D600C4C4F300A4A5F0004A4BE700B1B2F600B4B5F800BDC0
      F8004D56EF00767DF300CDD0F800797CF2002F33EE00A8ABF600C4C6F8009598
      F4002629EE007777EE000000000000000000000000000000000000000000EEEE
      F500E2E2E700FAFAF700EFEFEF00ECECEC00F1F1F100F4F4F400F1F1F100F1F1
      F000F1F1F000F1F1F000F1F1F000F1F1F000F1F1F000ECECED00FAFAF0009B9A
      CD00A4A1E6000000000000000000000000000000000000000000FAF9ED007580
      F7000117F3000121F3000121F3000122F300B5BFFB00FEFEFF00FFFFFF00F5F6
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EEF0FE001232F4000123F3000122
      F3006779F300FDFDED00F7F8F600000000000000000000000000C9DFF300B6D7
      F500E0EBF800D1E1F3005D81BF004F93C60034E8FA002BA5B300442D27004622
      1900442D2600471E15003F42400024C1D00049E1F300457DBB007695CA00E0ED
      FA00DEEBF800CFE0F300C8DDF00000000000000000000000000000000000EDEF
      F1004E4BD7000D08D4001E1BDB001C1BE3001C1EEB001A1EED00191EEE001A23
      ED00212CED001F27ED00262CEE00262BEE003133EE002B2DEE002D30EE002628
      EE003434F200B7B7E80000000000000000000000000000000000000000000000
      0000E7E7E700F6F6F600D5D5D500DDDEDE00F7F7F700FDFCFD00FCFCFC00FCFC
      FD00FCFCFD00FCFCFD00FCFCFD00FDFDFD00FDFDFD00F4F4F500FBFCF1008686
      B9008D8BE0000000000000000000000000000000000000000000F8F7F000CACD
      FB008B93F8007281F7005D70F7004B5FF600B8C0FC00EAECFE00B1BBFB00102E
      F4006B7DF800586CF700455BF6007888F8006778F700011FF3000121F300011D
      F3007D8EF600FDFDED000000000000000000000000000000000093B9E20083B3
      E30090B8E200BDD6F100BBD2EE00A1B9DF00A9D6EE004FEBF90026B7C600413A
      350048140A003B56550021D0E20069E8F500AACCEA00A3BCE100BBD4EF00B5CD
      EC00B5CDEB00AFCAEA00C4D9EE0000000000000000000000000000000000FCFC
      FB00E6E7EF004947E0001511E3002324EB002326EE002226EE00212BED002430
      EC002731EE002C32EF002F33EE003235EE003436F0003537EF003132EE003333
      F200B0AFE900F6F6F1000000000000000000000000000000000000000000F7F7
      F700E8E8E800F9F9F900F0F0F000F3F3F300F5F5F500F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F500F0F0E3005351
      A9007B78E6000000000000000000000000000000000000000000EFEEEA00F5F4
      E900F8F8EB00F9F9EB00FCFCEE00FFFFF400FFFFFC00FFFFFB00F3F4FA00E6E8
      FB00D7DBFC00C7CDFB00B6C0FD00A3AEFB0094A0F8008390F8006D7EF6005566
      F600BEC4F900F8F7EB0000000000000000000000000000000000517CBD005582
      C2000E34930087A8D600D5EDFD00D4EBFC00D0E7F900C6E3F60068EEF90024C1
      D3003280890023D8F10086ECF600CDE4F800D2E9FA00D4E9FB00CFE5F900CEE4
      F800CFE6F900C4DDF300C7DCEF00000000000000000000000000000000000000
      000000000000E7E8EE00494BEC001317ED002328ED00232BEE002530EE002832
      EE002C32EE003135EE003235EE003336EF003638EF003335EF003031F200A9A8
      E900F8F7F100000000000000000000000000000000000000000000000000F6F6
      F600EBEBEB00FDFDFD00FAFAFA00FAFAFA00F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F9F9F900ECECEC00E1E1E200F5F5EB00BFBFCC002C2A
      C2005E5BEB000000000000000000000000000000000000000000000000000000
      0000F8F8F700F8F8F600F5F5F300F3F3F000D1D1CC00EEEFEA00F6F6F100F9F9
      F300F4F4EC00FCFCF200F2F2E600F6F4E700FDFDEF00FDFDEE00FDFDEF00FDFD
      F100FCFBF700EDEFEB00000000000000000000000000000000008BADD900698F
      C60000096E00102681005472B3005B7BB8005A77B6006686C000698AC10062D0
      E9003FE5F8006EC1E1006685BE006381BB006380BB006D8BC2006684BD006482
      BB005C77B5007F9DCD00C7DDF100000000000000000000000000000000000000
      00000000000000000000E7E8EE00494FEF00131DEE002531EE002932EE002C32
      EF003035EF003335EF003335EF003537F0003335EE003030F100A6A5E900F9F8
      F30000000000000000000000000000000000000000000000000000000000F6F6
      F600ECECEB00FFFFFF00FFFFFD00FFFFFD00FFFFFC00FFFFFD00FFFFFE00FEFE
      FE00FDFDFD00FDFDFD00FCFCFC00EDEDEE00F2F3EF00CCCBD7005754CA002E2B
      E1006261EB000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFDFDE0000000000F4F4
      F30000000000F0F0EF00DBDAD8000000000000000000F7F7F500F5F5F300F4F4
      F100F1F2EE00F9F9F800000000000000000000000000000000005E7BB8004C72
      B40000066B0000006500000062000000630000006000000F770000056D000000
      6100000062000012780000026B00000062000000620000147600000068000000
      620000005A00344C9800C4DCF000000000000000000000000000000000000000
      0000000000000000000000000000E9E9EF004F58ED001F29EF002B30EF002C2E
      F0004044E500393CEB002F32EF003335EF003333F000A1A0EA00F9F9F1000000
      000000000000000000000000000000000000000000000000000000000000F6F6
      F600E3E3E700F2F2FC00F4F4FB00F6F6FD00F6F5FC00F4F3FB00F3F2F800F6F6
      F700F7F7F700FBFBFB00F0F0F000E2E2E100D7D8D900B8B8E200C8C7F300D8D8
      F500E3E3F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B0AFAA006866
      5800BFBEBB000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009AB4D9009AB3
      D8005A6FAE005168A9005269AA005168AA005267A8005975B400556FAF005167
      A9005168A9005775B500536DAE005167A9005167A9005D77B400546BAC005167
      A9004F60A5007D96C600CBE1F200000000000000000000000000000000000000
      000000000000000000000000000000000000D4D5EF005F66EE005D61F0006264
      F0006668ED006668ED006667EE005F61EE008787EE00F3F2EF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFDE008280E8009996EA00B3B1EF00B7B5EC00C0BFE700C9C8E100E3E4
      E600ECECEC00F5F5F500F2F2F200F3F3F2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E4E4E2009596
      8900E3E3E2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EAF2F900D7E7
      F500DCEEF900E0F0FA00E3F2FA00E8F5FC00E3F3FB00E1F0F900E1F1FA00E1F0
      FA00E3F2FB00E8F5FC00E7F5FC00E8F6FC00E8F6FC00E8F5FC00E7F4FC00E6F4
      FC00E7F6FC00DBECF700DEEBF600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5E4E40087878900C5C5C600E3E3
      E300DCDCDC00EFEFEE000000000000000000B0B1B10094949500EBEBEB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DADADA0078787A0081818200D9D9D900D8D8D800D4D4D400DADA
      DA00D6D6D600D6D6D600D6D6D6009C9C9C0073747600B6B6B600D6D6D600D6D6
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E3E4E300898785000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E0DEDE00E0DEDE00E2E0E0008A8A8C00A6A6A6006B6B6E00E2E0
      E000E2E0E000E2E0E000E2E0E000C2C0C0007A797B00A3A2A3008E8E8F00E2E0
      E000E4E2E200EFEFEF00000000000000000000000000F2F1F100E2E0E000E3E1
      E100E5E4E4006161630099999B008484850098979900E5E4E400E5E4E400E5E4
      E400E5E4E400E5E4E400A5A4A50077777800929294006A6A6C00E5E4E400E5E4
      E400EDECEC00F7F7F70000000000000000000000000000000000000000000000
      000000000000FCFBFB00EAE7DE00ECE8E100F8F7F400F7F6F300F6F5F200F5F4
      F000F4F3EF00F3F1ED00F2F0EC00F1EFEA00F0EEE800EFECE700EEEBE500F9F8
      F700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D5D2D10050504C00E5E3
      E300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DDDADA009FB7CC00D7D0D000C0BABB008F8C8E00B0AAAC00DDD5
      D500DDD5D500DDD5D500DDD5D500DDD5D5009B97990093909300D0C9CA00DDD5
      D500DDD5D500EAEAEA00000000000000000000000000F3F0F000A0C3DD00D4D5
      DA00E1DADA0087898B0062808400506B6F0047555C00B8B6B800E1DADA00E1DA
      DA00E1DADA00E1DADA00D4CECF006F6E72005E5F640097949700E1DADA00E1DA
      DA00E1DADA00F5F4F40000000000000000000000000000000000000000000000
      0000FDFDFD00F8F7F400CCC1AC00D2C8B500E7E2D800F4F2ED00F3F0EB00D2DF
      E40077BDDF005DBCE30053BCE50056BFE50060B0CF0098B9C5008AB7C6005CBA
      DD0077CCF0000000000000000000000000000000000000000000000000000000
      0000F4F4F40094949200DFDCD8000000000000000000D3CAC600574438000000
      0000000000000000000000000000000000000000000000000000C6C6C500BEBE
      BC00000000000000000000000000000000000000000000000000000000000000
      000000000000707275006162660063646900DDD8D800E1DBDB00E1DBDB00E1DB
      DB00E1DBDB00E1DBDB00E1DBDB00E1DBDB00E1DBDB00E1DBDB00E1DBDB00E1DB
      DB00E1DBDB00EAEAEA00000000000000000000000000C6C5C600AFACAD009190
      9200C7C2C200A9CBD2004BCBDC0043BFD000098CA800A7B3BA00DDD5D500DDD5
      D500DDD5D500DDD5D500DDD5D500DDD5D500DDD5D500DDD5D500DDD5D500DDD5
      D500DDD5D500F4F2F20000000000000000000000000000000000000000000000
      0000FDFCFC00E7E1D700CBBFA900EBE6DE00E8E3DA00F0EDE700F4F2EE00BBDD
      EA0023ABE5001CA2DE0023A8E1002BB1E5002FABD9002597C7004CBEE8003EBC
      EE001EA8E500ADDFF60000000000000000000000000000000000000000000000
      0000EBEAE90066574F00C5C8C800000000000000000095BCCC003F656F009DD1
      E200BCEFFD00D7F3FC00000000000000000000000000000000009F897F007972
      6D00000000000000000000000000000000000000000000000000000000000000
      000000000000AEADB000737378001B1D2700393B43004D4E55004C5B54006E8E
      72005D826200607F64007F8C82007171760071717600A5A3A600717176007171
      760087868A00EAEAEA0000000000000000000000000098999D00868689002B2E
      360044464D009FC4CC0051B1BE0048A3B0000A849F00ABC0C900E4DEDE00E4DE
      DE00E4DEDE00E4DEDE00E4DEDE00E4DEDE00E4DEDE00E4DEDE00E4DEDE00E4DE
      DE00E4DEDE00F6F5F50000000000000000000000000000000000000000000000
      0000F9F9F700CFC5B100DCD5C600F8F7F300F9F8F600E4DFD400F5F2EE00CFE3
      EC001189CA001292D0001BA2D9001BA5D800148CBF003CB6E50049BBEB001484
      C3000D91D40092D6F40000000000000000000000000000000000000000000000
      0000E7E7E700585E5F006ABAD50056D4FD001CBBF60001B2F70000B6FA0000B9
      FF0001B5F5000ABBF7002BC4F80052CFF90086DDFC00B6E9FB0078858700867E
      7900000000000000000000000000000000000000000000000000000000000000
      0000000000007C7D82003D404700191C26001E2D41001629A4000810CA000A13
      C7001425BA000B15C500080FCB001325AD001D2A490081808500191C2600191C
      26003D404700EAEAEA00000000000000000000000000C2C2C400C8C7C7001A1D
      27001A1D27002938430058979F004D889000154956004C545B003E4047003E40
      470064656B003E4047003E4047003E4047008B8B8F003E4047003E4047003E40
      470066676C00F8F7F7000000000000000000000000000000000000000000FDFD
      FD00EBE7DE00CEC3AE00EEEAE300FDFCFB00EDE9E200C8C0B100C9C9C60094BA
      CE0027A7E3002DADE5002FAFE4002FB2E400229ED3004FC5F1002697CF00086B
      AE000987CB00CDEDFA0000000000000000000000000000000000000000000000
      00008FDBF00016BAE90004C6FF0007C2FC0007C2FB0006C3FC0006BFFA0005B6
      F50003B2F30001B2F50000B5F60000B7F80000B9F90000B9FB000AB0E8002FB1
      DA0087DDF9000000000000000000000000000000000000000000000000000000
      000000000000DADADB00D8D8D800909CB5000B14C800101FBD004B768D00D6DF
      DC009EC3A0004B93520039707200172CB0000A13C8007F92AF00ADAEB100ADAE
      B100C5C5C700EFEFEF00000000000000000000000000BFBFC20062636800191C
      2600191C2600143E4D0041E3F9003CC8DB0001414D0039474E00191C2600191C
      26004C4D5400191C2600191C2600191C26007F7D8300191C2600191C2600191C
      26003D404700F9F9F9000000000000000000000000000000000000000000FCFB
      FB00D2C8B500E0D9CC00FAF9F600F7F6F300D0CDC600C0BEBC00BCBDBB0090B6
      CA00119EDF000E98D40025A7DB002EA8D7002DA3D80045BEF0001E9ED9000280
      C7006AC2EC00000000000000000000000000000000000000000000000000D1F5
      FD001BD6FD000DD8FF001A7FBE001857A600156CB1001586C1001599CF0015AE
      DE0017BFEC0017C5F20014CBF90011CDFB000FCBFC000BC7FB0005C7FF0000C5
      FF0000BCFB0079D9F90000000000000000000000000000000000000000000000
      00000000000000000000E2E6F0001A25C500152AB40066A17500E7EBE700F1F1
      F100DDE6DD00DDE6DD00B4D0B5004E827E000102D7000D19C200E3E7F0000000
      00000000000000000000000000000000000000000000E6E6E600ACACAE008384
      890075777C0066767E0010899E0000728A00005367005175800075777C007577
      7C009192960075777C0075777C0075777C00ADADB00075777C0075777C007577
      7C008C8D9100FBFAFA000000000000000000000000000000000000000000ECE8
      E100D1C7B300F1EEE800F5F4F300D1CFCD00C0C0BE00C1C1BF005CAAD20035A9
      DF0027A5DD002CABE0002EB6E7002FA5D2002A97C80048BCEE0023ACE80055B5
      E400E5F5FB00000000000000000000000000000000000000000000000000D3F6
      FD0027DCFD0032E4FF00223A9C002027A0001F249B001E269A001E2798001D2B
      9600203B9A00214FA2002265AE002278B700248CC30029BDE30023E3FF0020DF
      FF004CDEFA00BDEDFC0000000000000000000000000000000000000000000000
      000000000000000000005E70C3000B10D20045896600BFD7C100F2F2F200F2F2
      F200F2F2F200EDEDF2008A8AE7001313DA000000D9000101D8005D74BC000000
      0000000000000000000000000000000000000000000000000000F2F2F200D6E8
      ED003DBBD30027C9EA0067E1FE003FD8FD0050DFFE0060DFF7000DA7C70080B6
      C200E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7
      E700ECECEC000000000000000000000000000000000000000000FDFDFC00D4CB
      BA00E4DED200FBFAF900D4D4D300C1C0C000C4C4C400C6C6C50077C0DF0023AC
      E80020A7E30029A8E00029ABE1002AB1E5002BA3D4008EC1D800CDE4EB00F0F5
      F600000000000000000000000000000000000000000000000000000000000000
      000034D3FB0023D6FD00253FA5002231A5001F2DA200202CA1001F2AA1001F27
      A0001F25A0001E27A1001E279F001F269F001F279F004062B400A9F4FD00CBF7
      FD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B35CD002C41B90052A257008EC09100F3F3F300F3F3
      F300D8D8F0005454E2000000D9000303D9008285E2002747A6001420C5000000
      0000000000000000000000000000000000000000000000000000CEEFF8000FD0
      EC00296FF7002823F1001A41F300155DF5001754F500222EF200322DF20039A0
      F50060B6C9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EDEAE400D5CB
      B900F1EEE700F5F3F000C8C7C400BBB9B800BFBFBC00C0C0BD00BDBEBD0091BF
      D3003AB7EC001F9FDC00158ACB00209FDD0045C1F300BDE2EF00F4F2ED00F9F8
      F700000000000000000000000000000000000000000000000000000000000000
      00003BD1FB0011D1FD002743AD00223CAB002139A9002138A9002236A9002236
      A4002134A000202EA1002031A400202FA300202EA2005866BB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003C43D400476AA60054A6590054A65900A4CDA700AFAF
      EC001D23D2000000D9001B1DD900A8A8EC00F4F4F4006B8BAF000E1BC4000000
      000000000000000000000000000000000000000000000000000036E1FB001856
      F1001E38F30009A8FA0000C9FC0000CBFC0000CCFD0008A2FA002316F1002B10
      F0003995F000AED6DF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6CDBC00F1EE
      E800F5F2EE00FEFEFE00D1D2D100C4C4C400C7C7C700C8C8C800C7C7C700C8C8
      C800C7C7C700C6C6C600C8C8C800F4F4F400FFFFFF00FBFAF800F5F3EE00F9F8
      F700000000000000000000000000000000000000000000000000000000000000
      000024CBFA0013D3FD00294BB2002548AB00233CA200233EA3002236A0002F72
      BF0040B7E0003381C4002237A500223CA800223AA8005D74C300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003C42D4004B6BAE0056AA5B0053A55F002C5699000204
      D6000000D900162BB90051937700C3DDC500F5F5F5008896D2000D1BC5000000
      0000000000000000000000000000000000000000000090E7FC003687EA00292B
      F2001FD1FE000EDAFF0003D4FE0000CFFD0006AEFA002023F1002700EF002026
      F200332EF2001FAED20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F3F0EB00FCFB
      FA00F4F1ED00FCFBFB00CECECE00C0C0BF00C4C4C400C5C5C500C4C4C400C5C5
      C500C4C4C400C1C1C100DADADA00FFFFFF00FFFFFE00FCFBF900F6F4F000F9F9
      F70000000000000000000000000000000000000000000000000000000000B6EE
      FC000EC3FA0014D3FD002D53B7002435A2001F229A001F269B001F239800274A
      A900347ABB002F6CB70022309B0023369F0023399F005F7AC100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002E39CC00464ED6004D986D001B35B4000000D9000000
      D900284EA20054A5640058AE5E0062B26700F6F6F600515ECD001724C4000000
      0000000000000000000000000000000000000000000078E4FC002D38EA00408E
      F90037E5FF001EDFFF000EDAFE0009B3FC002026F2002700EF00184DF40003C0
      FC00222DF2003F7FF000BED8DF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFAF900F9F8
      F600F5F3EE00FCFAF900D0D0CF00C3C2C200C7C7C700C7C7C700C7C7C700C7C7
      C700C6C6C600C7C7C700F3F3F300FEFDFD00FEFDFD00FDFCFA00F7F5F200FAF9
      F800000000000000000000000000000000000000000000000000000000006DDE
      FB0008C1FB0017D5FD002E56B900202FA300202CA1001F2AA0001F289F001F22
      9A001E2298001E2198001E229B001E219B001E239A005D67B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007488CA000D0EDA001014D4000000D900080FCF003B72
      8B005BB260005BB260005BB260005BB26000D9D9F3000D12D2006580BE000000
      000000000000000000000000000000000000000000007DE3F7003434ED005BCB
      FD0050EAFF0036E4FF001EBFFD002326F2002700EF001853F50001CCFE0000CE
      FD001757F500363EF3007EB3C100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FAF9F700F8F7
      F500F5F2EE00FBFAF800CECDCC00BFBFBF00C3C3C300C5C5C500C4C4C400C6C6
      C600C0C0C000DBDADA00FEFEFD00FDFDFC00FDFDFC00FCFCFC00F7F5F200FAFA
      F8000000000000000000000000000000000000000000000000000000000026CD
      FA0007C0FB001BDAFE002E63C0002557BA002453B7002450B600244BB4002448
      B1002242AF00223FAC00233DAB002239A9002135A7005E6ABB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B2B30083838E002E3EC7000000D9002C33D50067A58C005DB7
      62005DB762005DB762005DB7620098C8A6003940D7001625C300000000000000
      0000000000000000000000000000000000000000000080D5E9003F38EC0074D9
      FD0064F0FF0049C6FD002A28F2002700EF001E4FF40004CDFD0000D4FE0000D2
      FE001461F6002D33F2007EBFD000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F7F400F8F6
      F300F4F3EF00FBF9F800CFCECC00C1C0C000C5C4C400C6C6C600C7C7C700C6C6
      C600C7C7C700F3F3F200FDFDFD00FDFDFC00FDFDFC00FEFDFC00F8F6F300FBFA
      F900000000000000000000000000000000000000000000000000A9ECFC000BC5
      FC0007C2FB0021E0FF002C5FBC00245ABC00255DBF002560C0002761BE002561
      C1002561C1002763C0002660BF00255DBE00265BBD005F84CA00000000000000
      00000000000000000000000000000000000000000000EFEFEF00DEDCDC00E1DF
      DF00B5B4B5009E9E9F00858587008997A0002936CB001C1DDC00A4A4EE00DADA
      F500A3CFB10054A67100698BB7002224DA001320C900ACBBCE00000000000000
      0000000000000000000000000000000000000000000089E7FE003D2FE90090BE
      FB0071D1FD00322CF2002700EF002C59F5001CD9FF000DD9FE0002D5FE0000D4
      FE001A44F4004256F5009EC5D000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F6F200F6F4
      F000F4F2ED00FAF9F700CECDCB00C0BFBE00C3C3C300C5C5C500C5C5C500C1C1
      C100DBDBDA00FEFDFD00FDFDFC00FDFDFC00FDFDFC00FDFCFB00F8F7F400FCFB
      FB0000000000000000000000000000000000000000000000000068DEFC0007C1
      FB000BC6FB0026E5FF0035C1EC002DA6DF002BA4D9002876C3002238A100337D
      C3002C71C400203FA700335FB9003663BD00305DB9007BA7DC00000000000000
      00000000000000000000000000000000000000000000EFEEEE00A1BACF00D0CB
      CB00DDD5D5009895970096929500D0C9CA00C7C5CF004E63BF001316D7001718
      DA003133DC00181BD9001013D7003C54BB00B7BCC900D9D5D500000000000000
      00000000000000000000000000000000000000000000ADEDFC005753E4005742
      F3003C27F2002700EF003D58F5004EE2FE0034E4FF001BDFFF000DD9FE0009AF
      FB002A23F1002B9AE900DEEBEE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F6F4F000F6F4
      EF00F6F4EF00FAF9F600CDCCCA00C0BFBE00C4C3C200C5C5C500C4C4C400C6C6
      C600F1F1F100FDFDFC00FDFCFC00FCFCFC00FDFDFC00FDFCFB00F9F8F600FCFC
      FC000000000000000000000000000000000000000000D6F5FD0032D1FB0003BE
      FB0013CFFC002AE8FF0027E4FF0027E4FF0026E4FF002CD8F7003B6FBF002D98
      D1003294D6002D7DC100D3E4F100E1E6F200D5DCEF0000000000000000000000
      00000000000000000000000000000000000000000000CACCCC0065666A004042
      4900B0ADAF00E1DBDB00E1DBDB00E1DBDB00E1DBDB00E1DBDB00D9D9D400C1D4
      BE00C1D4BE00C1D4BE00D1D8CD00E1DBDB00E1DBDB00DBD8D800000000000000
      00000000000000000000000000000000000000000000BEF0FC008FB7E4002E0A
      EE002700EF00595CF5007AEFFF0062EFFF004EEAFF0034E4FF001CD0FE002037
      F3003D6FF7003FB1CC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F5F3EF00F5F4
      EF00F6F5F000FAF8F600CDCCC900BEBDBB00C2C1C000C5C4C300BFBFBF00D9D9
      D800FDFCFB00FCFCFB00FCFBFB00FDFDFB00FDFDFC00FDFCFB00FAF9F600FCFC
      FC000000000000000000000000000000000000000000B1EDFC0016C9FA0003BC
      FA001EDAFD002CE9FF002AE6FF0029E6FF0029E6FF0028E5FF0021E0FF001ADC
      FF0017D9FF003FDAFC0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C900CECCCC001B1D
      270023262F00494A52004D4E550079797E0071717600717176008B8A8E007171
      7600717176008B8A8E008B8A8E007171760071717600B9B8BA00000000000000
      00000000000000000000000000000000000000000000000000008EE6FC00666C
      E400310FEE006555F4008BB8FB0070D3FD0057C4FC003E8EF900292DF2001E5B
      F50015C0E200DEEEF10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F3F1EC00F4F2
      EE00F4F2EE00F7F6F100CCCAC800BDBCBA00C1C0BE00C2C1C000C4C4C200F1F0
      EF00FCFBFA00FBFBF900FBFBF900FDFCFC00FEFDFE00FBFBF900F8F7F400FBFA
      F900000000000000000000000000000000000000000090E5FC000AC2FA0005BF
      FA0029E3FE002EE9FF002CE8FF002CE8FF002BE7FF0023E3FF001DDEFF001CDD
      FF0017D6FE0059DDFC0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EFEFEF003D404700191C
      2600191C2600191C2600191C26004D4E5600191C2600191C26004D4E5600191C
      2600191C26004D4E56004D4E5600191C2600191C26009B9C9F00000000000000
      0000000000000000000000000000000000000000000000000000000000008EE6
      FC008EB9E4005553E4004439EA00454CEB003644ED002A3CEC00168DF1000FD3
      EF00CEEAF1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F2EFE900F4F1
      ED00F4F2EE00F4F2EE00C7C5C200B8B7B400BBBAB800B9B8B500D4D3D000F9F7
      F500F9F7F500F8F7F500F9F8F500FAF9F800FAF9F700F9F7F400F6F5F100FAF9
      F80000000000000000000000000000000000000000007AE0FB0004BEFA000EC7
      FA0032ECFF0030EBFF002FEAFF002FEAFF002FEAFF002DE8FF002CE8FF0024E1
      FF0015D4FE008DE7FC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C9C9CA00CACA
      CC00C1C1C400C1C1C400ADAEB100BBBCBE00ADAEB100ADAEB100BBBCBE00ADAE
      B100ADAEB100BBBCBE00BBBCBE00ADAEB100ADAEB100DDDDDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BEEFFC00A7ECFC0083E9FE005BCCE30058DCF3004BE2FC0082E7FC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0ECE600F2EF
      E900F4F1EC00F4F2ED00D4D3CE00CAC9C600CDCBC800CCCBC700E7E7E400FAF9
      F800FBFAF800FBFAF900FBFBFA00FDFCFB00FBFAF900F7F5F100F0EDE600F8F7
      F50000000000000000000000000000000000000000009BE5FC0020C5F90024DB
      FB0036F0FF0033ECFF0032ECFF0031EBFF002FEAFF002AE6FF0020DFFF001ED5
      FC0052DBFC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEEAE200EFEC
      E500F1EEE800F3F0EB00F3F1EC00F5F3EF00F6F4F000F7F6F300FAF8F600FBFA
      F800FCFBFA00FDFCFB00FDFDFC00FBFAF800F6F4F000EFEBE500E6E1D600F5F4
      F000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F8F7F500F9F8
      F600F9F8F700FAF9F700F9F9F700FAF9F700FAFAF900FBFBFA00FBFBFA00FCFB
      FB00FCFCFB00FCFCFC00FCFCFB00FBFAF900F9F8F700F7F6F400F5F3F0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEF4FB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F5F9FD00E9F2FD00DCECFD00D3E7FD00D0E6FD00CDE3FD00CDE4
      FD00D0E5FD00D2E6FD00DBEBFD00E6F1FD00F4F8FD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EBEAEA00B6B5B4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E0EFFB0072E1F70091F0F800BAF3FA00DBF8FC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E9E9E800B1B0AE00CBC8
      C800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F1F7
      FD00D3E7FD00C5E1FF00C5E1FF00C5E1FF00C5E1FF00C5E1FF00C5E1FF00C5E1
      FF00C5E1FF00C5E1FF00C5E1FF00C5E1FF00C5E1FF00C5E1FF00DAEBFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCBCA0058565200D0CF
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008DC9F5004FD5F70051DEF80052DEF80053DEF6006CE2
      F7008BE8F800ABEEFA00CBF4FB00E6F8FC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1DFDD0081838200AAA4
      A200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7EAFD00C5E1
      FF00C5E1FF00ABC3FB007F92F5005662EF00363EEA002C32E8002429E7002429
      E7002B31E800333AEA00525EEE00798BF400A6BEFA00C3DFFF00C5E1FF00D6E9
      FD00000000000000000000000000000000000000000000000000000000000000
      0000F2F2F20075736F00D0CFCE000000000000000000C5C4C30055524E00D0CF
      CE00000000000000000000000000000000000000000000000000B9B8B600A4A3
      A000000000000000000000000000000000000000000000000000000000000000
      000000000000D5EAFA004DAFF0004CCDF7004DD2F8004DD1F8004ED2F8004ED3
      F8004ED4F8004FD6F80052D5F60061DAF60079E0F8009DE7F900C9F1FB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C9C9C800E1E0E0000000000000000000C5DFE80083645500A3A7
      A30000000000000000000000000000000000000000000000000000000000D6D6
      D5000000000000000000000000000000000000000000E1EEFD00C5E1FF00B9D4
      FD006F7FF0002B31E4000A0BDF000000DD000000DD000000DD000000DD000000
      DD000000DD000000DD000000DD000708DE00252AE3006674EF00B3CDFC00C5E1
      FF00D0E6FD000000000000000000000000000000000000000000000000000000
      0000E7E7E70066646000A1A09E0000000000000000008BB6C6002E7C960068C4
      E200AEE8FB00BFECFB0000000000000000000000000000000000989794007573
      6F00000000000000000000000000000000000000000000000000000000000000
      00000000000080C2F40045B0F40049C4F8004BC6F8004BC7F8004BC8F8004BC9
      F8004BC9F8004CCAF8004CCBF8004CCCF8004CCDF8004DCEF8005ED2F6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E9E8E700826E6400B4BEC0000000000000000000C4D9E2007B6054008CB5
      BF00000000000000000000000000000000000000000000000000FDEFEA007A77
      7300AFABA90000000000000000000000000000000000D1E6FD00C5E1FF00363E
      E2000000D7000000D7000000D700051DBB001643A7001F5BA7001154A900013F
      93000025680000156800000C9A000001D2000000D7000000D700292FDF00A1B8
      F800C5E1FF00DCECFD0000000000000000000000000000000000000000000000
      0000E1E0E000586D720041A7CA0020BEF70002B7F90002B7F90001B1F40001B3
      F50002B7F70002BAF90002BBF90030C6F80060D3F9009FE3FB0072878C007877
      7300000000000000000000000000000000000000000000000000000000000000
      0000CFE6FA0047AAF10046B4F60045B9F70043B7F60044B8F60046BBF60047BD
      F70048BFF70048C0F70049C0F70049C2F70049C2F7004AC3F7005AC8F5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E8E0DD007955460088AFBB00B3E8FB0083DEFD004BBAE8001C9ACA001FB2
      E5003DCDFA0051D0F90072D8FA0093E1FA00BFECFC0000000000D3E3E8007D58
      4700AEAAA70000000000000000000000000000000000C5E1FF00C5E1FF001313
      D8000F0FD6000B0BD500194AA5005283BB00567BAF0040639600285186000E3D
      760005275C000118460000173F0000135B000107BA000101D1000000D100282E
      DA00C5E1FF00CFE5FD0000000000000000000000000000000000000000000000
      00006DD6F3000AC5FB000AC5FB000AC5FB000AC5FB000AC5FB000AC4FB0008BB
      F70005B5F40002B2F40002B5F60002B9F80002BBF90002BBF90002BBF90015B6
      EC0060D3F9000000000000000000000000000000000000000000000000000000
      0000A7D5F70044AEF30045B8F8004BB9F8005AC9FB0053C3FB0049B7F70044B1
      F60043B0F50043B1F50044B3F50046B6F60046B7F60046B9F70054BBF500E0F2
      FC00000000000000000000000000000000000000000000000000000000000000
      0000C1E0E8004998B10023AFDE0021C4FB0010BEF90000B9FA0000BBFF0000B4
      F90000AEF30000B1F50007B4F50014BAF50025C0F80039C7FA0046C0EB003D88
      A20081B5C70000000000000000000000000000000000C5E1FF00C5E1FF003636
      E2003C3CE5004141E7003F72A7004A659100657C9E004D7AAF003D7ABB00245F
      A00016396B000B26540004204E0000164300071B54000000CB000000CB00252A
      D500C5E1FF00CEE4FD000000000000000000000000000000000000000000C3F2
      FD0015D5FE0015D5FE0015D5FE0015D5FE0015D5FE0015D5FE0015D5FE0015D5
      FE0015D5FE0015D5FE0015D5FE0011CEFC0011CFFC000DC9FC000CC8FB0006C1
      FA0002BBF9007FDBFA0000000000000000000000000000000000000000000000
      0000A1D3F70048B6F90044A3E500448CC6005BAFD6004EA3D3003A89C4004296
      CF0049A3DD004EB4F2004AB2F80045ACF50042AAF40042AAF3004CAFF100DAED
      FB00000000000000000000000000000000000000000000000000000000000000
      000057D8F7000FCBF70000CDFF0000C9FE0000C8FC0003C9FD0006C9FE0008C5
      FB0008C0F90008BFF90007BEF80005BDF80004BDFA0001BCFA0000BAF90001B7
      F30017BCF40042CAFB00B7EAFC000000000000000000D1E6FD00C5E1FF006D73
      F1005B5BF0006161F3002559930081ACD900F8FFFF00A5D4FE001682E200035B
      B400032F6800041F4E0003225300001B4B00152248000D0DCC002126D0009CB2
      F300C5E1FF00DCECFD000000000000000000000000000000000000000000C5F4
      FD0023E1FF0028D4F2003580BA003168AB004184B90082BFDA00C8EAF400DDF7
      FB00DCF9FD00D0F9FE0087F3FF0036EAFF002BE7FF0027E5FF0025E3FF0023E2
      FF002DDEFC00C3F1FC0000000000000000000000000000000000000000000000
      000093D2F80053B7F8003C7EC2002F67AB003174B6002A96D90021AFF40025A5
      E900299ADB003185C5004190CB0054B2EB0053B6F4004FB1F6004DAAF300C4E3
      F90000000000000000000000000000000000000000000000000000000000C6F3
      FD0029DDFD001BE1FF002FE0FF003FE2FE0043E4FF003CE5FE0034E7FF002EE8
      FF0029E6FF0024E2FE0020DFFD001FDBFD001DDAFE0019D7FD0014D4FE000ED5
      FF000DD0FF000DC3F800A5E5FB000000000000000000DFEDFD00C5E1FF00BED8
      FE0098A7FB007D82F9004385CE0091CCFF00FFFFFF00DEEAF7001F7BCE00004B
      9E0000265B00001B4900001E4F00001547004F56A8007380EA00B2CBFA00C5E1
      FF00CFE5FD000000000000000000000000000000000000000000000000000000
      000010CEFD003794C5001E3999001D2797006570B700E6E9F400EFF1F800D0DB
      EC00CDDDED00EEF6FA00EAF4F800A2DDEC005ED9EE007EF1FD0096F2FD00BCF5
      FD0000000000000000000000000000000000000000000000000000000000A3DE
      F80064C6F9004BA2E0003173B500337BBB002794DF001DAAFD001DACFD001DAE
      FD001DAFFD001DB1FD002A95D900337EBD003D95CE0045A3D9004CADE40084C9
      F500BFE2FA00000000000000000000000000000000000000000000000000D9F6
      FD003ADBFB002DDEFE0052E6FF0062E9FF005EE9FF0054EAFF004DECFF004AEE
      FF0048F0FF0044F0FD0042F0FD003FEEFD003EECFD0043ECFD0049EAFD0058EA
      FD0074EBFD00A5EEFC0000000000000000000000000000000000D7E9FD00C5E1
      FF00C5E1FF00C5E1FF008BB0D8005FA6E700ADCCE700A9CDEF003588D5000C52
      9C00021E4B0000153E00001440005F759600C4DFFD00C5E1FF00C5E1FF00D5E8
      FD00000000000000000000000000000000000000000000000000000000000000
      00000FCBFC002968B3002137A100676EC000F9F9FC00ACAFDC003F45AD001F26
      9F0020269E002B34A3009DA2D300FFFFFF00949ACC0000000000000000000000
      0000000000000000000000000000000000000000000000000000B1E6FA0061CB
      F90059BEF4003688C600307EBC003082C5001D9BFC001D9DFC00298DDA00337E
      BD002792DF001DA5FD001EA4F9003281C100308EC8002C92C7003A98D9007BB8
      F300000000000000000000000000000000000000000000000000000000000000
      000048D6FB001CD3FD002BDAFE002BDCFE0026D9FE0026D9FE0026D9FE0028DB
      FE002ADCFE0042E2FC0090F4FD00BCF9FD00BAF8FD00C0F8FD00C7F8FD00D4F9
      FD0000000000000000000000000000000000000000000000000000000000EFF6
      FD00DCECFD00CEE5FD00C5E0FD0080A7CF00519BE1006CACE90069A3DC003D82
      C5001B5EA300083E7E0027446E00BCD7F400CDE4FD00DBEBFD00ECF4FD000000
      000000000000000000000000000000000000000000000000000000000000E0F7
      FD000DC8FC002E7BC700445BB500EDEEF800A5ADDB002133A6002132A5001F2A
      A0001E259E003A43AC00CFD1EB00DFE1F200F4F4FA00FDFDFD00000000000000
      000000000000000000000000000000000000000000000000000070D3F60063CC
      FA0049A8DF002F86C2003284C1002884DA001C8CFB001E8EF700337FBD003286
      C3003280C1001D97FC001D9AFC002C88D2003095CB00389FDD004FA1F20055A8
      F300A9D7F8000000000000000000000000000000000000000000000000000000
      000045D2FA0010D0FD0011D7FE000ED8FE000ED6FE0010D6FE0010D5FE0010D4
      FE000ED3FE002BDBFC00B0F4FD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D2E1F0004E99E2004794D8003884C8000B4C
      920009427F000557A700648CB600000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A4EA
      FC000BC6FB00328CD30094A3D800E8EBF6003B54B000233FA8002239A6002C65
      B8004C8ECA00DEE4F300CACEEA00384BB000CCD0EB00FDFDFD00000000000000
      00000000000000000000000000000000000000000000A7E7F90066D2F800A6DF
      F9006EB9F10050A8EA003C8DCC00257CE2001C7DFB00217FEF003382C0003090
      C800337FBE001E88F7001C8BFB002885DA003494D0004DA0F10055A8F3005AB1
      F40061B9F500CFEBFB000000000000000000000000000000000000000000D4F4
      FC0030CCF90013D2FD001BDBFF001ADCFE0019DBFE0019DAFE001ADAFE0019D9
      FE0019DAFE0025E0FC008DEFFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEDFF1006EB6DA0080C7F6000749
      9000081B44008EA8C50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004AD6
      FB0009C3FB003198DC00C0CBE900BDC4E300202D9A0022329C00202D99004D8D
      CB00E3F4FA00D0E1F1003445A600233CA3008B99D000FDFDFD00000000000000
      000000000000000000000000000000000000000000008FE2F900D4F1FB00E3F4
      FC0071C5F70067C2F9004494D1002372E6001C6EFA002274EA003C8BCA004CA9
      E7003583C2001F7BF2001C7CFA00277EDE003E8FD50054A5F30059AFF4005FB9
      F70064C2F7007BCFF6000000000000000000000000000000000000000000A0E9
      FC001AC4F90012D3FD001BDDFF001BDDFF001ADCFF001ADCFF0019DBFF0018DA
      FF001EDFFF0026E3FD0082EDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000087B5CE008DDBFF001256
      9D00435477000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0F7FD000ECA
      FC0006C0FA002C9FDF00C5CEEA00B3B5DE001E239C001E229B003A3CA600DEDF
      F000CDD0E800323DA4001F249A0020269A007C83C400FDFDFD00000000000000
      000000000000000000000000000000000000000000000000000000000000C0EC
      FA0075D4F90073D1F9004393CD002166E9001B5FF9002169E9004291CD0069C3
      FA003A87C5001E6EF2001B6DFA002575E200408BD00057ADF3005EB7F70063C0
      F80069C9F8007BD3F60000000000000000000000000000000000000000005DDA
      FB000AC0F90015D5FE001EE0FF001EDFFF001DDDFF001DDDFF001ADDFF001CDE
      FF0023E2FF0024E2FD007EEBFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7C2D30085D5FA001455
      9A00748096000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000095E7FC000CC7
      FC0004BDFA0030B2E600AEBEE400D5DBF0002644AF003B54B500DCE0F200CED2
      EB003342AC00202FA200212EA2001F2BA000B0B3DD00FDFDFD00000000000000
      000000000000000000000000000000000000000000000000000000000000ACF0
      FA0084E8FA0081E5FA004C9FD100316AE5001B52F800215FE8004595CD0074D2
      F9003B89C5001E61F1001B5EF900266FDD0065A2D7005CB5F60062BFF70069C7
      F80080D3F700DEF4FB0000000000000000000000000000000000D3F5FD0027CB
      FA0007C0FB0018D7FE0020E1FF001EE0FF001FDFFF001EDFFF001CDFFF0021E1
      FF0027E5FF0020DFFD0080EAFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F90B2003F72A5002853
      8800506C9000CDD8E40000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003BD3FB000AC4
      FB0007C1FA0031B9E9006588CF00F6F9FC008AA9DD00CEDBF100CBD9F0003567
      C200255ABC002659BB002555B9004A70C300FAFBFD00FDFDFD00000000000000
      000000000000000000000000000000000000000000000000000000000000E3FA
      FC00CFF8FB00BDF6FA0062ACD4004E7EE2004064F9001F53EC004393C90083E7
      FA003885C1001D52F4001B51F800286AD9009ABFDE008ACDF70067C6F80087D4
      F700E5F5FC00000000000000000000000000000000000000000090E7FC0014C5
      F90008C2FB001EDDFE0024E3FF0021E0FF0021E1FF0020E1FF0021E1FF0026E4
      FF0024E3FF001DDBFD0085EAFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ABBCCF000C3C7D00163468001E3C
      6D000F3E7D00537FB10000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000ECBFC0007C1
      FB0010CBFB0031D3F500398CD1009FC1E600FFFFFF00DFE6F4002F54B1002C63
      BD00275DBC002553B6004D7ACA00DAE3F400CAD8EF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009EC1DE006A98DA008B9DFB00385AF4003B84C000A7E7
      F300317AC1001A44F8001A45F8002B6CD100B9D2E700E3F2FC00A1DDF900E8F6
      FC000000000000000000000000000000000000000000DDF6FD0052D8FC0007BE
      F9000DC7FB0023E1FE0027E5FF0025E3FF0025E2FF0024E3FF0026E4FF0025E4
      FF001EDFFF001EDAFD008FEAFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000899BB30000285D0000275F000023
      590006275A0041577F0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C2F1FC000DC8FC0005BF
      FA001CD6FD002AE7FF002BE4FE0034DFFB00A9F1FC00F0F9FC00BCC7E4008BD0
      EB0088B7E200ACC1E100F5F7FA00E7EBF5009CB1DE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E3EDF4004E8FC600FCFDFF00A3AFFC00396CD900337E
      BD00265ADC001A3BF7001C40F300317AC1000000000000000000000000000000
      00000000000000000000000000000000000000000000B3EEFC0028CEFA0002BB
      FA0014CEFC0027E5FF0029E6FF0026E4FF0026E4FF0027E5FF0027E5FF0021E1
      FF001ADCFF0023D8FD0097EBFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D5DDE5001746810000469200004C9D000047
      9400053D7D0000225B008E97A800000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A4EAFC000BC6FB0003BC
      F90028E3FE002DE8FF002DE8FF002CE8FF0032E8FF008EEDFD00DEEDF800D6EA
      F700D5E8F700DFF3F900FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000085B1D600A0C3E000FFFFFF00EFF1FE008898
      FB003B55F8001A38F700275DD80094BADB000000000000000000000000000000
      0000000000000000000000000000000000000000000089E5FC0017C8FA0002BB
      FA001DD8FD002BE8FF002AE7FF0028E6FF0029E5FF0028E5FF0023E2FF001CDE
      FF0018DBFF0029D8FD00A3ECFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A1B2C7000053A7000168C9000D74D400096D
      CB000054AA0000357A00586E8F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000085E2FB0008C3FB0008C1
      FA0030EAFF0030EAFF002FEAFF002FEAFF002EE9FF002CE7FF002AE6FF0021DF
      FE0015D3FE006AE0FC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000085B1D60092BADC00FFFFFF00FFFF
      FF00ADBCF800326AD50085B1D600000000000000000000000000000000000000
      000000000000000000000000000000000000000000006BDDFC000EC1F90006BE
      FA0025E0FD002FEAFF002CE8FF002BE7FF002BE7FF0026E4FF001FDFFF001CDE
      FF0019DAFE0034D8FC00B6EFFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AFC0D2000469C90073B4EF009BCAF600489B
      EA00096ECD0000449600788CA700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000092E4FC0006C0FA001BD3
      FC0033ECFF0032ECFF0032ECFF0032ECFF002FEAFF0027E4FF001BDBFE0015D5
      FE0020D2FB00E0F7FD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000085B1D600337EBD00337E
      BD003F85BF0094BADB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000059D8FB0008BCF8000EC6
      FA002DE7FE0032ECFF002FEAFF002EE9FF002EE9FF002BE7FF002AE7FF0026E4
      FF001BD9FF0048DAFC00D8F6FD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005294D400C4E1FC00F0F8FF0072B3
      F3001377D6001154A100D1D6DD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D1F4FC00A4F5
      FD0099F4FD0098F4FD0096F2FD0092F0FD008EEDFD008BEBFD008AE9FC00B4F0
      FD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000069D9FB0010BFF80021D9
      FC0033EDFF0033EDFF0031EBFF0031EBFF0031EBFF002FEAFF0028E5FF001CDA
      FF0021D3FB0092E7FC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEDFEF0090C0EF00A6CFF6006DAE
      ED003486D40095B0CF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009EBFDD009ABBD9009ABBD9009ABBD9009ABBD9009ABBD9009ABBD9009ABB
      D9009ABBD9009ABBD9009ABBD9009ABBD9009ABBD9009ABBD9009EBFDD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEDEDE00DEDEDE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D5D5D500E5E5
      E500000000000000000000000000000000000000000000000000CCCCCD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E9D8C400E0D0
      BD00EADAC800F5E5D200FAEAD800F2E2D000E9D9C600DFCFBD00D8C5AF00F9F2
      EB00000000000000000000000000000000000000000000000000BECFDE004EA4
      EF0082C4FF00C0E2FF00C0E2FF00C0E1FF00C0E1FF00C0E1FF00C0E1FF00BFE1
      FF00BFE1FF00BFE1FF00BFE1FF00BFE1FF00BFE1FF00BFE1FF0099CFFF004EA4
      F300AEC7DD0000000000000000000000000000000000B7B7B700C3C3C300BCBC
      BC00BDBDBD00BCBCBC00B9B9B900B8B8B800BCBCBC00BCBCBC00B5B5B500A6A6
      A6008494A3006687A5006082A0006082A0006384A3005D7E9C00698BA900D1D1
      D100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F5F5F500F1EFEF00FBFAFA00C3C3C400828284006868
      6B00BBBABB00CBCBCB00CFCFCF00DCDCDC00DCDCDC0087878800737376006C6D
      6E00DCDCDC00E4E4E400F3F3F300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDB55600FFA4
      2B00FFA42B00F2A93700ECB75D00F0B85E00FFA52C00FFA52C00FFA42800F4DC
      BB0000000000000000000000000000000000000000000000000049A1EB00A3D6
      FF00A3D6FF00B3DBFB00CCE3F600CCE3F600CCE3F600CCE3F600CCE3F600CCE3
      F600CCE2F600CCE2F700CCE2F700CCE2F700CCE2F700BDDDFA00A0D2FF00A0D2
      FF0051A2EA0000000000000000000000000000000000D3D3D300FFFFFF00F7F7
      F700F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F5F5F500E5E5E500ACBE
      CC0083C6FF00B9DDFC00BFDFFB00BFDFFB00BFDEFB00BEDEFB00B1D9FD0075B5
      ED00D5D5D5000000000000000000000000000000000000000000000000000000
      00000000000000000000F5F4F400ACC6DB00E3DDDD00A9A5A70066676A007978
      7B00D7D1D100E3DDDD00E3DDDD00E3DDDD00E3DDDD009694960067686B008E8C
      8E00E3DDDD00E3DDDD00EFECEC00000000000000000000000000D1D1D100CECE
      CE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00F1B65100FFB0
      2800FFB02900F4BF5900E8BA3A00EEC56300FFB12900FFB12900FFB22900C7B3
      9200C3C3C30000000000000000000000000000000000000000003FABFF007DC6
      FF00C3DCF100ECECEC00EFEFF000EDEDED00E8E8E800EDEDEE00EFEFEF00ECEC
      EC00ECECEC00EEEEEE00F0F0F000E9E9EA00EEEEEF00F0F0F100C5DEF40079C1
      FF003CA5FF0000000000000000000000000000000000CECECE00CBCBCB00C1C1
      C100CCCCCC00BCBCBC00CDCDCD00BDBDBD00C9C9C900BFBFBF00ADADAD007F9B
      AE0088CBFA00FFFCEA00F8F6EE00F9F7EC00FFFDF000FCFCFC00F1F1FF002FA3
      FF00C7C7C7000000000000000000000000000000000000000000000000000000
      00000000000000000000C1C1C3009A989A008A888B00DAD3D300DED7D700DED7
      D700DED7D700DED7D700DED7D700DED7D700DED7D700DED7D700DED7D700DED7
      D700DED7D700DED7D700ECE9E9000000000000000000A5A5A500787878006F6F
      6F006F6F6F006F6F6F006F6F6F006F6F6F006F6F6F006F6F6F00D9AC4200FFC3
      3500FFC33500F5CB6100D39D4500E6C58C00FFC43600FFC43600FFC535007685
      6B0079797900B6B6B600000000000000000000000000DEDEDE0028A5FF006EC0
      FC00F6F6F600FFE48500FFF19A00F9F4E400F5EDDF00FFEC8600FFF3B000F4F4
      F400FFE7A200FFF19900FEF5CE00F4F4F400DFBBFF00EBD1FF00F9F9F9006BBC
      FD00259EFF00DEDEDE00000000000000000000000000CFCFCF00C4C4C400B8B8
      B800C1C1C100B6B6B600C3C3C300B6B6B600BFBFBF00B6B6B600A3A3A300638B
      A3007FCFFE00F7F4E800F6F4EC00F6F4E900F7F2DF00F7F4FB00F7F3F9000199
      FF00BFBFBF000000000000000000000000000000000000000000000000000000
      00000000000000000000AAABAE009191940020232D0066666C00A3A1A400A3A1
      A400B0AEAF00A3A1A400A3A1A400BDBABB00A3A1A400A3A1A400B0AEAF00A3A1
      A400A3A1A400A7A5A700ECEAEA000000000083CBE2005ABFE00056BDDF0057BE
      DF0057BEDF0057BEDF0057BEDF0057BEDF0057BEDF0057BEDF00D5D06900FFD6
      4100FFD64200F6DB7600BA712A00D4A67200FFD74200FFD74200FFD842008DCA
      BE0067A6BA009C9FA200000000000000000000000000DEDEDE000D9FFF0051B8
      FD00F6F6F600FBFBFB00FCFCFC00F9F9F900F9F9F900FDFDFD00FCFCFC00F8F8
      F800FCFCFC00FDFDFD00FCFCFC00FAFAFA00FDFDFD00FDFDFD00FBFBFB004FB3
      FE000B96FF00DEDEDE00000000000000000000000000D1D1D100D4D4D400C9C9
      C900D4D4D400C4C4C400D5D5D500C5C5C500D1D1D100C7C7C700B2B2B2006D98
      AD007CD2FB00FFFCEC00FBF8F000F6F4EA00FEFCF000FBFBFB00FAF5FE0000A4
      FF00BEBEBE000000000000000000000000000000000000000000000000000000
      00000000000000000000B6B6B9006B6D72002B4835003E7444004A924E004A92
      4E004A894F0038663F001F2B2B007F7D8300191C2600191C26004C4D5400191C
      2600191C2600191C2600E3E3E300000000006ECAF200277F9D002A89A2002988
      A2002987A2002D87A1002984A1002A85A1002985A1002B86A200CAD16900FFEC
      6A00FFEC6A00FFEC6A00FFF5A300FFF28D00FFED6B00FFED6B00FFED6300629C
      8A0059A4BD00589BB200000000000000000000000000DEDEDE00019EFF0040B5
      FE00F7F7F800F4EED200F4EFCE00FDFDFD00F0EDE600F4EECB00F6F3E000FAFA
      FA00F4F0E000F4EEC800FBFAF200F2F2F300EDE4F400EDE4F400FAFAFA0040B0
      FE000196FF00DEDEDE00000000000000000000000000D2D2D200CBCBCB00BEBE
      BE00C9C9C900BCBCBC00CACACA00BCBCBC00C6C6C600BDBDBD00A8A8A8006795
      A7007EDAFE00F6EFF400F8F3F700F6EFF300F6EAF200FBFBFB00F9F2F60000AF
      FF00BEBEBE000000000000000000000000000000000000000000000000000000
      00000000000000000000CDD2CF0059945D004B934F005599590093BB95006AA4
      6D004B934F004B934F004B934F0087A38B0075777C0075777C00919195007577
      7C0075777C0075777C00EFEFEF000000000051C0EF001F5B66001F5B66001F5B
      66001F5B66001F5B66001F5B66001F5B66001F5B66001F5B66009FB09A00E0DF
      CB00EAE9D500F5F3DF00FAF9E500F2F1DD00E9E8D300DFDECA00D6D5BC004172
      70003C8499004E9BB500000000000000000000000000DEDEDE0001A3FF0040B9
      FE00FDFDFD00FFECAA00FFF3AF00FEFBF300FBF4E500FFF2A900FFF6C600FDFD
      FD00FFEFC000FFF3AA00FEF9E200FBFBFB00E7CCFF00EFDBFF00FDFDFD0040B4
      FE00019BFF00DEDEDE00000000000000000000000000D3D3D300D0D0D000C7C7
      C700D1D1D100C3C3C300D3D3D300C4C4C400CFCFCF00C5C5C500B0B0B0006C9D
      AC0040D2FE0080E2FF007FE1FE007FE0FE0080E0FF007FDFFE0080DFFF0000BB
      FF00BEBEBE000000000000000000000000000000000000000000000000000000
      0000000000000000000076AE79004D975100579D5B00D2E0D300F1F1F10094BE
      970076AD7900579D5B004D9751004D975100B8D4B900FAFAFA00FAFAFA00FAFA
      FA00FAFAFA00FAFAFA00F7F7F7000000000056CBF1001F5F6C001F5F6C001F5F
      6C001F5F6C001F5F6C001F5F6C001F5F6C0020606C0020606C0020606C005585
      8E00D4C2900020606C0020606C0020606C00CFD5B200E3DE88001F5F6C001F5F
      6C00408A9F004E9BB500000000000000000000000000DEDEDE0000A8FF0040BC
      FE00F9F9FA00F5F5F500F8F8F800FCFCFC00F7F7F700F5F5F600F7F7F700FCFC
      FC00F7F7F700F8F8F900F7F7F700F9F9FA00F5F5F500F5F5F500FCFCFC0040B7
      FE0000A0FF00DEDEDE00000000000000000000000000D4D4D400D0D0D000CBCB
      CB00D3D3D300C5C5C500D5D5D500C6C6C600D1D1D100C7C7C700B2B2B2006FA1
      AD002BCFF500B9E2CF00B7E0CD00B7E0CD00A8CABB007C938B0089ADA7000AC9
      FF00C0C0C0000000000000000000000000000000000000000000000000000000
      000000000000B0D1B2006DAC71004F9C5300C9DCCA00F1F1F100F1F1F100F1F1
      F100F1F1F100E7ECE7008CBB8E004F9C530058A05C0000000000000000000000
      0000000000000000000000000000000000005FCBF0002BC1F30021BEF40014B7
      F40012B7F40011B9F40012BAF40016BCF40046CEF60048CFF60048CFF60071D6
      F300BBA3720042CCF6003DCBF60036C9F500C6D5B800D3D082001DBFF50023C1
      F6006ECEEE004E9BB500000000000000000000000000DEDEDE0000ACFF003FC0
      FE00F5F5F500FFEFAF00FFF6BC00FBF9F000F4ECDE00FFF5B500FFF7CB00F8F8
      F800FCEEC000FFF6BA00FCF7E000F3F3F300EAD1FF00F2E2FF00FDFDFD003FBA
      FE0000A4FF00DEDEDE00000000000000000000000000D5D5D500CBCBCB00C5C5
      C500CFCFCF00C2C2C200D0D0D000C2C2C200CCCCCC00C4C4C400B1B1B10082AA
      B00073E0E700AECFBC00ABCCB900ACCDBA009CB6A7007B8882008BAA990055E1
      FF00C8C8C8000000000000000000000000000000000000000000000000000000
      000000000000A1C9A40051A0550051A05500E8EDE800F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200F2F2F2008DBE900051A05500B1D3B200000000000000
      00000000000000000000000000000000000056C8F1001ABBF40017BAF50012B8
      F40012BAF40013BCF40017BEF5001CC0F5003FCCF60053D3F60053D3F6006ED6
      F3008F672B0091B9B9006CD1EE0074C6D900C1AB6800B0BF920028C4F60029C4
      F6006FCEEE004E9BB500000000000000000000000000DEDEDE0000B1FF003FC4
      FE00FDFDFD00FEF6D700FEF6CB00FDFDFD00FDF9F200FEF5C900FEF9E300FDFD
      FD00FEF9E900FEF5C200FEFCF400FDFDFD00F5EAFE00F4E8FE00FDFDFD003FBE
      FE0000A9FF00DEDEDE00000000000000000000000000D4D4D400D6D6D600D4D4
      D400DEDEDE00CECECE00DFDFDF00CFCFCF00DBDBDB00D2D2D200C5C5C5009CB8
      BC0085E3EE00C1DFCF00C1DFCF00C1DFCF00C1DFCF00C1DFCF009BD5CC0083D8
      E500D8D8D8000000000000000000000000000000000000000000000000000000
      000000000000C1DAC20053A4580053A4580085BD8800F3F3F300F3F3F300D5E4
      D600E9EEE900F3F3F300F3F3F300E9EEE9005DA8610087BF8A00000000000000
      0000000000000000000000000000000000005DCDF2002AC5F6002DC5F50015BB
      F40015BDF5001DC0F50024C2F6002AC4F60038C9F6005DD7F7005ED8F7004FD2
      F7008F896E00895F28009E7C4C009D783C00B29760005AC8E20030C7F50031C6
      F60071D0EE004E9BB500000000000000000000000000DEDEDE0000B6FF003FC8
      FE00F7F7F700F3F3F300F6F6F600FAFAFA00F5F5F500F3F3F400F8F8F800F9F9
      FA00F3F3F300F3F3F400FAFAFA00F7F7F700F3F3F300F5F5F600FCFCFC003FC2
      FE0000AEFF00DEDEDE00000000000000000000000000D4D4D400C8C8C800C4C4
      C400CDCDCD00C0C0C000CECECE00C0C0C000CACACA00C5C5C500BEBEBE00B8B8
      B800A6A6A600C6C6C600BFBFBF00BFBFBF00BFBFBF00ABABAB0097979700D8D8
      D800000000000000000000000000000000000000000000000000000000000000
      0000D3E7D500CCE1CE0055A85A0055A85A0055A85A007DBB8100D6E6D7007DBB
      81005FAC6400B9D8BA00F4F4F400F4F4F40087BF8A007EBC8100000000000000
      0000000000000000000000000000000000005FCEF2002DC2F50030C1F50028BE
      F50022C0F50029C4F60031C6F60038C8F6003ECAF60067DBF70054D3F7005DD7
      F60061D9F70087DAEF00A4E1F1008CDCF20054D0F40042CDF60038C9F50038C9
      F60073D0EE004E9BB500000000000000000000000000DEDEDE0000BBFF003FCB
      FE00FBFBFB00FFB9E300FFC7EA00FEF1F900F6E9F000FFBCE700FFD4F000FBFB
      FB00FFC8E800FFC7E900FFE4F600F6F6F600FFB9E500FFCAEB00FEFEFE003FC6
      FE0000B3FF00DEDEDE00000000000000000000000000D4D4D400D6D6D600D4D4
      D400DEDEDE00CECECE00DFDFDF00CFCFCF00DBDBDB00D5D5D500D2D2D200D6D6
      D600C6C6C600ECECEC00EAEAEA00EAEAEA00EAEAEA00D0D0D000B2B2B2000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C4DEC5007FBE820057AC5C0057AC5C0057AC5C0057AC5C0057AC
      5C0057AC5C0057AC5C00C4DEC600F5F5F5009CCC9F0095C99700000000000000
      0000000000000000000000000000000000005EC4EB002066A1002E5687002773
      A7003488B8004BD0F70043CCF60046CCF6004BCEF70064D9F70072DFF70071DF
      F7006DDDF70068DBF70062D9F7005AD6F70052D3F60049CFF6003FCBF6003DCB
      F60074D1EE004E9BB500000000000000000000000000DEDEDE0000C0FF003FCF
      FE00FCFCFC00FDFDFD00FEFEFE00FCFCFC00FDFDFD00FEFEFE00FDFDFD00FCFC
      FC00FDFDFD00FEFEFE00FDFDFD00FCFCFC00FEFEFE00FEFEFE00FCFCFC003FC9
      FE0000B8FF00DEDEDE00000000000000000000000000D4D4D400CBCBCB00C6C6
      C600D0D0D000C3C3C300D1D1D100C3C3C300CDCDCD00C8C8C800C7C7C700CDCD
      CD00CBCBCB00FFFFFF00FCFCFC00F8F8F800FCFCFC00DEDEDE00BEBEBE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7D2AA00CFE4D00059B05F0059B05F0059B05F0059B05F0059B0
      5F0059B05F0059B05F0081C18400F6F6F60077BD7B00BFDFC000000000000000
      00000000000000000000000000000000000061C2E6002068A9001F84BF002072
      AF003A8CBF0066DBF7004ACEF70051D1F70057D3F70077E1F7007BE3F6007CE4
      F70076E1F70070DEF70069DBF70060D9F70058D5F7004FD1F60044CDF60042CC
      F60076D1EE004E9BB500000000000000000000000000DEDEDE0001C6FF0001C5
      FF0001C5FF0001C4FF0001C4FF0001C3FF0001C3FF0001C2FF0001C2FF0001C1
      FF0001C1FF0001C0FF0001C0FF0001C0FF0001BFFF0001BFFF0001BEFF0001BE
      FF0001BDFF00DEDEDE00000000000000000000000000D4D4D400D0D0D000CDCD
      CD00D6D6D600C8C8C800D8D8D800C9C9C900D4D4D400CECECE00CECECE00D5D5
      D500CDCDCD00F8F8F800F2F2F200EDEDED00F2F2F200D7D7D700BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BCDDBE00E4EFE500BDDEBF0065B86A005CB461005CB461005CB4
      61005CB461005CB4610096CD9900DAEBDB0063B7690000000000000000000000
      00000000000000000000000000000000000063C2E8002A68B2003587C7003175
      B7003480BD0061D8F70057D3F70065D9F70062D7F8006EDCF80075DFF70084E6
      F6007CE4F70077E1F7006FDEF70066DBF7005CD7F70053D3F60048CFF60046CE
      F60077D1EE004E9BB500000000000000000000000000DEDEDE0001CBFF0001CA
      FF0027A7EF009ED8E9009ED8E9009ED8E9009ED8E9009ED8E9009ED8E9009ED8
      E9009ED8E9009ED8E9009ED8E9009ED8E9009ED8E9009ED8E90042B6EF0001C3
      FF0001C2FF00DEDEDE00000000000000000000000000D4D4D400D0D0D000CDCD
      CD00D6D6D600C8C8C800D8D8D800C9C9C900D4D4D400CECECE00CECECE00D3D3
      D300C6C6C600EDEDED00E7E7E700E2E2E200E5E5E500D1D1D100BDBDBD000000
      0000000000000000000000000000000000000000000000000000EEEDED00EEEB
      EB00F6F4F400AEADAF0083BC8600EFF5EF00EFF4EF00B5DCB700ABD8AE0071C0
      76005EB963007BC47F00E5F1E6007BC57F00AECAB000D3D2D300EBEAEA000000
      00000000000000000000000000000000000066C9ED004F6EBB003B4CA7005E7D
      C0005097D1006DDDF7006FDEF70082E6F70082E6F70086E7F8007BE2F90085E6
      F70088E9F7007CE4F7007AE2F80072DFF80069DCF8005DD7F70054D4F70049CF
      F60078D1EE0056A3BC00000000000000000000000000DEDEDE0003D0FF0006D0
      FF0060C5E300BBE7D200B7E1CC00BAE6D000B6E0CB00BAE6D000B7E1CC00BAE6
      D000B7E1CC00B3DBC80088A59800AAD0BF0085A39400A6CCBA0061C4E30009C9
      FF0005C8FF00DEDEDE00000000000000000000000000D4D4D400CBCBCB00C6C6
      C600D0D0D000C3C3C300D1D1D100C3C3C300CDCDCD00C8C8C800C5C5C500C5C5
      C500BCBCBC00E0E0E000D1D1D100C9C9C900DADADA00C0C0C000D6D6D6000000
      0000000000000000000000000000000000000000000000000000F3F1F100A7BF
      D300D8D2D200D1CBCB00878A88008ABD8D00D3EBD500FAFAFA00FAFAFA00A3D7
      A600ADDBB000E7F2E7007FC583008DAE8E00DED7D700DED7D700D9D6D6000000
      0000000000000000000000000000000000005ECEF10046CFF5005BD6F70060D8
      F7006CDCF7007DE3F80084E5F8009AECF900AAF1FA00ABF1FB00A6EEFB008EE6
      FA0090E8F9007BDFF90074DEF800A4EEFA00A0EDFA0098E9FA0089E4F90046CD
      F50072CFEE0069B6D000000000000000000000000000DEDEDE001AD9FF0035DD
      FF005FC0D700AFD9C300A9D4BD00A3CFB700A0CDB400A0CEB500A9D4BD00A8D2
      BC00AED7C20091AFA10099BBAB007489810092B1A300708A7D0060BFD70039D8
      FF001DD2FF00DEDEDE00000000000000000000000000D4D4D400D6D6D600D4D4
      D400DEDEDE00CECECE00DFDFDF00CFCFCF00DBDBDB00D5D5D500CFCFCF00CDCD
      CD00BABABA00E0E0E000DCDCDC00DFDFDF00DEDEDE00CBCBCB00000000000000
      0000000000000000000000000000000000000000000000000000A4A4A7007172
      75005C5D6200CDC8C900E0DADA00E0DADA00C0D3BD00A6D3A700C6E2C700B6E0
      B800BBDDBB00A2CFA200D0D7CC00E0DADA00E0DADA00E0DADA00DBD8D8000000
      00000000000000000000000000000000000063CEF2002BC4F60039C8F70051D1
      F70062D7F7006EDBF800A8EDF80093E8F80091EBF70098ECF8009BEAF900ABED
      FB008DE4FA0078DEF900A0E8FA0062D5F8004DCEF70040CAF7005CD3F8003AC7
      F60079D1EF007AC7E100000000000000000000000000DEDEDE0033E2FF0066E9
      FF005EBACB00B3D9C300B1D6C100B1D7C200AFD4BF00B1D7C200B1D6C100B1D7
      C200B1D6C100A6C8B50093AB9F009BB8A90093AB9F009BB8A9005FB9CB006AE5
      FF0035DBFF00DEDEDE00000000000000000000000000D4D4D400C8C8C800C4C4
      C400CDCDCD00C1C1C100CFCFCF00C1C1C100CBCBCB00C4C4C400BBBBBB00B8B8
      B800A8A8A800EFEFEF00FFFFFF00F1F1F100C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000B5B5B800A8A8
      AA001C1F29003A3C440071717600717176008A8A8E0071717600717176008A8A
      8E0071717600717176008A8A8E00717176007171760071717600C0C0C0000000
      00000000000000000000000000000000000006A6DB000EAEE20016B0E3001DB3
      E30024B5E3002BB7E30031BAE40037BCE4003CBEE40041C0E40043C1E4003FBF
      E40039BDE40033BBE4002DB8E40027B6E30020B3E30018B1E30011AFE3000BAD
      E20002A0D400DEF1F700000000000000000000000000000000003EE7FF0091F1
      FF005CB6BF00BBDBC800BBDBC800BBDBC800BBDBC800BBDBC800BBDBC800BBDB
      C800BBDBC800BBDBC800BBDBC800BBDBC800BBDBC800BBDBC8005DB5BF0094EE
      FF0040E1FF0000000000000000000000000000000000D4D4D40050B6D2002EAD
      D0003EB9DB0039AACA003EBADD0039ABCB003DB6D80039AFCF0037ADCD002CB0
      D500A5A5A500F2F2F200EEEEEE00C5C5C5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5B5B8004F51
      5800191C2600191C2600191C2600191C26004C4D5500191C2600191C26004C4D
      5500191C2600191C26004C4D5500191C2600191C2600191C26009B9C9F000000
      000000000000000000000000000000000000AEDEEE007ECBE5007ECBE5007ECB
      E5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECB
      E5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECB
      E500DEF1F70000000000000000000000000000000000000000005DD3E100A2F5
      FF0074CAE00041ABC20047AEC70047AEC70047AEC70047ADC70047ADC70047AD
      C70047ADC70047ACC70047ACC70047ACC70047ACC70041A8C20075C7E000A7F3
      FF0050D0E40000000000000000000000000000000000D6D6D600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9F900EEEEEE00E2E2
      E200DDDDDD00E7E7E700C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E4E6E600BFC0
      C100ADAEB000ADAEB00092939800898A8F00A5A6AA00898A8F00898A8F00A5A6
      AA00898A8F00898A8F00A5A6AA00898A8F00898A8F00898A8F00CFCFCF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D4E1E30061D5
      E1006BF1FF007AF2FF007AF2FF007AF2FF007AF2FF007AF2FF007AF2FF007AF2
      FF007AF2FF007AF2FF007AF2FF007AF2FF007AF1FF007AF1FF006BEFFF0055D3
      E400D2DFE10000000000000000000000000000000000CECECE00F5F5F500F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F0F0F000EAEAEA00E3E3
      E300CECECE00CCCCCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F300FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00F8F8F8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1D1D1007E7E8100BDBDBD00000000000000000059C5
      D60075D4E3000000000000000000000000009E9E9E0082838500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D900BCBCBC00B5B5B500B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B600B6B6B600B9B9B900C2C2C200CBCBCB00CECECE00CECECE00CECE
      CE00D1D1D1000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5CBAE00EED6B800F8DDBC00F9DD
      B800F3DAB500EED7B500E7D0AE00E6D2B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E6E4E400ECEA
      EA00F9F8F800D4D3D400828283008A8A8C006D6D6F00AEAEAE00CBCACA00CBCA
      CA00D8D7D700DCDBDB00DCDBDB00767678007E7E7F008686880083828400DCDB
      DB00DCDBDB00DFDEDE000000000000000000000000000000000098A09E003A43
      4000293433002833300026322F0025322F0023302D00222F2C00222F2C00222F
      2C002D3936002C3835002C3835002C3735002B3735002B3735002A3634002A37
      3400303B3900B9BEBB0000000000000000000000000000000000CDE0E60078A8
      B800577E8A00496F7C004A727E004A727E004A727E004A727E004A727E004A72
      7E004A727E004A727E00576B7100696969006D6D6D006F6F6F006F6F6F006F6F
      6F0078787800A5A5A50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEA02900FE9F2500F9A93E00F7B9
      6300FBB04C00FFA32800FFA42B00FDAB3B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E6E3E30093BD
      DC00E3DDDD00E3DDDD006362670077787B0069686D00D7D1D200E3DDDD00E3DD
      DD00E3DDDD00E3DDDD00E3DDDD00A9A5A70065666A006F7073009D999C00E3DD
      DD00E3DDDD00E3DDDD00000000000000000000000000000000006E7977002C37
      33002B3734002D3935002C3935002C3935002C3935002C3935002C3935002C39
      35002C3935002C3935002C3935002C3935002D3935002D3935002C3935002D39
      35002C373400878F8C00000000000000000000000000DEF1F7006BC6E50081D0
      EC007CD0EB007BCFEB007BCFEB007ACEEA007ACDEA007ACDEA007ACDEA007ACD
      EA007BCFEB007BCFEB007ACDE80078CBE60078CBE60078CBE60078CBE60080CE
      E70068B2C900598C9E00DADADA00000000000000000000000000DADADA00CECE
      CE00CECECE00CECECE00CECECE00CECECE00FFAB2400FFA71900F2BF5C00E8D2
      8100F6CA7200FFAB2300FFAB2300F5B03D00CECECE00CECECE00CECECE00CECE
      CE00CECECE00DADADA0000000000000000000000000000000000AFADAE00BAB5
      B600A19EA000D9D1D100DCD4D400DCD4D400DCD4D400DCD4D400DCD4D400DCD4
      D400DCD4D400DCD4D400DCD4D400DCD4D400DCD4D400DCD4D400DCD4D400DCD4
      D400DCD4D400DCD4D40000000000000000000000000000000000798583003545
      4100283432002A3332002B3533002C3635002C3634002C3634002B3634002C36
      34002C3634002C3635002C3735002D3735002D3736002D3836002C383600303C
      390034413E007A8682000000000000000000000000007ECBE5005CC2EB003ABF
      F5003CCBF60037C8F5003AC8F5003FC5F5003BC3F5003BC3F5003CC5F50039C4
      F50040CAF6003DCAF7003ECBF60037C7F60034C1F5002EB8F4002EB6F4002FB5
      F40072CBF2002195BB00DADADA000000000000000000DADADA00939393006F6F
      6F006F6F6F006F6F6F006F6F6F006F6F6F00FFC03300FFC02C00EEC35A00D1A2
      4C00EFC36A00FFC43700FFC13200E6B33B006F6F6F006F6F6F006F6F6F006F6F
      6F006F6F6F0093939300DADADA0000000000000000000000000065676C007B7C
      7F002F3239008D8C8F00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DD
      DD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DD
      DD00E3DDDD00E3DDDD0000000000000000000000000000000000818D8A004356
      5300323F3D00323B3A00343E3D00343E3D00343E3C00343E3D00353E3C00343E
      3E00343E3E00343F3E00343F3E0035413F0035403F0035413F0033413E003643
      42003C4B4A006D818300E1F2FB0000000000000000007ECBE50043BCE8002AC5
      F40030C7F40037CBF40033C8F4001FBCF40033C8F4003CCDF40041D0F40037CA
      F5003ECEF40036CAF50044D1F40032C9F50037CBF40039CAF40033C5F30024BF
      F40060C8F1002195BB00DADADA000000000068C3E10063C2E20056BDDF0056BD
      DF0056BDDF0056BDDF0056BDDF0056BDDF00FFD23E00FFD33700EFCF6C00C083
      5200E4BC7500FFDB4400FFD43D00E5D0570056BDDF0056BDDF0056BDDF0056BD
      DF0063C2E20067A9BF00CECECE00000000000000000000000000AEAEB1009797
      99001A1D27001A1D27003E4047003E4047004D4E55009B999D004D4E55004D4E
      55004D4E5500747379004D4E55004D4E55004D4E5500747379004D4E55004D4E
      55004D4E55009C9B9E000000000000000000000000004ABCF3004B8291004F64
      5F003D4E4A003747430038494500384844003848440039484400394844003848
      4400384844003848440038484400374742003646430036454300354441003948
      4600455654003573880096D7F70000000000000000003FB3D9004BC6F00014B7
      F40020BDF40014B6F40012B6F40012B8F40012B9F40033C7F50040CCF60040CC
      F6003FCCF6003CCBF60038C9F50038CAF50034C9F50024C0F4001FBAF3001CBF
      F40062CBF2002195BB00DADADA0000000000009CCF0045BCF50024B8F4002BC5
      F60027C2F60027C2F60028BBF40027B9F400FFEB5500FFEA5200FFEB5D00F8E7
      8700FDEB6C00FFEC5200FFED5700E3E7680029BDF40024B4F30024B3F3001EB0
      F30052C1F60079CBE600CECECE0000000000000000000000000077787E006263
      6800191C2600191C2600191C2600191C2600191C26007E7D8200191C2600191C
      2600191C26004C4D5400191C2600191C2600191C26004C4D5400191C2600191C
      2600191C2600737479000000000000000000000000000FAAF2004D8A95006077
      71005C726D005B706C005A716C005A706B005A706B005A706B005A706B005A6F
      6A005A6F6A005A706B005A6F6B00586D6900576C6900566A6800546966005468
      6500586B6900367E900086D2F60000000000000000003FB3D9004BC2EF0017B8
      F4001FBCF40012B7F40011B9F40012BBF40015BCF40034C8F5004CD1F6004DD1
      F6004CD0F6004ACFF60045CEF60040CCF60038C9F5002CC5F5001EBEF5001DC0
      F50064CFF2002195BB00DADADA0000000000009CCF00216778001F5B66001F5B
      66001F5B66001F5B66001F5B66001F5B6600C8CF9700CED69F00C8D39D00C9D5
      9A00C4CF9800C9D29B00C4CC95009CAF83001F5B66001F5B66001F5B66001F5B
      66001F5B66003A819300CECECE00000000000000000000000000B9BABC00B5B5
      B60075767B0075767B0075767B0075767B0075767B00ACADAF0075767B007576
      7B0075767B009192950075767B0075767B0075767B009192950075767B007576
      7B0075767B00ACACAF0000000000000000000000000014B7F4004CCEF50026BF
      F40025BFF30025C0F4001CBBF4001FBEF40026C2F40037CAF50041CFF5003CCB
      F50042CFF5003BCBF5003CCCF5003ACBF5002FC6F50033C9F5002AC3F5001BB8
      F3001FBBF30017BEF40087D7F700000000000000000039B1D80051CAF00027C4
      F60024C1F50012BAF40015BCF4001BBFF50022C1F6002AC4F60052D3F60059D6
      F7005BD7F60056D4F60047CFF6004BD0F60043CDF6003ACAF5002FC7F50026C3
      F60067D0F2002195BB00DADADA0000000000009CCF00236D7F001F5B66001F5B
      66001F5B66001F5B66001F5B66001F5B6600235E690026606B00205C6700205C
      6700205C6700908B5200466E6300205B66001F5B66001F5B6600296167001F5B
      6600205D69003E869800CECECE000000000000000000000000000000000089BE
      C50087CBD500A9DFE800A9DFE800B2C5C900B2C5C900B7CACE00B5C8CB00B7CA
      CE00B5C8CB00B7CACE00B5C8CB00B7CACE00B2CED300A9DFE800A9DFE800B0C8
      CC00C1D9DC00ECECEC000000000000000000000000001BBCF40033C0F50022BF
      F4001EBCF40012B6F40012B8F40011B9F40012BAF40037C8F60045CEF60047CE
      F60047CEF60045CEF60043CDF6003FCCF60039C9F60035C8F5002FC6F50016B7
      F4001BBDF50018BFF50089DBF700000000000000000028ACD80056CBF10030C7
      F5003CCAF60025C2F50020C1F50029C4F60031C6F60037C8F60056D4F7005AD6
      F7004BD0F6004FD2F70052D3F70054D4F6004DD1F60044CDF60039CAF5002EC6
      F5006BD1F3002195BB00DBDBDB0000000000009CCF0046C8F50025BFF40020BE
      F50013B7F40012B8F40011B9F40012BAF40029C3F50047CEF60048CFF60048CF
      F60047CEF600908954005AB7C2003BCAF60034C8F50026C2F50098C59B001BBF
      F50041C9F7006CC6E300CECECE0000000000000000000000000043A1B000159B
      B00039BED70062B4C60012AECD001892A500353535002AA0B20001DAFC0001DA
      FC0001DAFC000BBBD700323F41002569730002CBED0054B6C90055B3C60002C5
      E7001E7D8C006AC7D60000000000000000000000000011B1F30035C1F5001DBC
      F40012B7F40011B9F40012BAF40014BCF40017BEF50039CBF50050D2F60051D2
      F60051D2F60050D2F6004DD1F6004AD0F600E0F7FD00FEFFFF00FAFEFF00F9FD
      FF00FCFEFF00B6EBFC008CDDF80000000000000000001AA9D7005ACAF0003561
      9000264C7D001F699C0042C3ED0043CDF60040CAF60047CDF6005AD5F7006DDD
      F7006BDDF7006ADCF70064DAF7005DD7F70055D4F6004CD0F60041CCF60036C8
      F5006ED3F3002397BC000000000000000000009CCF0036C2F5001EBEF50012B6
      F40011B8F40012BAF40014BCF40019BEF50021C1F50053D3F60053D3F60053D3
      F60052D3F60078785200738A6F0048CAEF003DCAF60055B6C200C0AC5A0024C3
      F60046CBF7006CC6E300CECECE0000000000000000007FEAFB001B88990029C4
      DC005F5A5200524D45005E646100109FB90035353500353535003FA3B20001DA
      FC000BBBD700323F410035353500159CB100478F980056514800504B44004D93
      A00001DAFC001E7D8C00BEF4FC0000000000000000001EC1F50043CBF70021BF
      F50011B9F40013BBF40018BEF5001EC0F50024C2F60029C3F6004ED2F7005BD6
      F7005BD6F70049D0F60046CEF60047CFF500EAFAFE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00BFEEFC008EDEF800000000000000000009A6D90058BEE5002648
      8C00227DB600235A970058CBEF0058D4F7004DCFF70054D2F7006DDDF70079E2
      F70078E2F70074E0F7006DDDF70065DAF7005CD7F70052D3F60047CFF6003CCA
      F60071D3F200269AC0000000000000000000009CCF003FCAF7002DC6F50029C3
      F50012BBF40017BEF5001FC0F50026C3F6002CC4F60040CCF6005ED7F7005ED7
      F70044CEF60051B1C4007759270079724900788768009777350078A892002CC6
      F5004CCDF8006CC6E300CECECE000000000000000000CEF6FC002C7E8B003A89
      92001F1C19000D0C0900312D260004C5E700159CB100353535003C41420034A1
      B200323F410035353500159CB10001DAFC00306164000C0B08000E0D0B004576
      7C00159CB10043A1B00000000000000000000000000025C3F6004BCEF60039CA
      F5001FC0F5001ABFF50023C2F6002AC4F60031C6F60037C8F6004ED1F70065DB
      F70057D5F60050D2F7005DD7F7005CD7F700C4F0FC00DBF6FD00D4F4FD00D3F3
      FD00D3F3FD009DE4FA0091DFF90000000000B4E9FA0008A5D90063C1E7002B56
      A50059ADDD002B46940054C2E80056D3F70063D8F70060D6F8006CDBF80070DD
      F80083E6F6007BE3F70074E0F7006BDCF70061D9F70057D5F6004CD0F60041CC
      F60071D2F100319BBE000000000000000000009CCF0049CEF7004BD0F60054D3
      F70043CDF6002AC4F6002CC4F60034C7F6003AC9F6004ED0F60065DAF70058D5
      F6005CD6F70063D9F7005ED8F70058D5F70051D2F60048CFF6003FCBF60034C8
      F50051D0F8006CC6E300CECECE00000000000000000000000000CEF6FC00397C
      8600413D3B0075727100256F7A0001D9FB0001DAFC000BBBD700323F41003535
      350035353500159CB10001DAFC0001DAFC00179DB1005F5B5B004B5454003775
      7E0043A1B0000000000000000000000000000000000026A8DB003E9DCF002E87
      B80047A2CA0037ACDB0039C9F60039C9F6003FCAF60045CCF60051D1F7006ADC
      F70069DCF7006CDDF70069DCF70064DAF700ADEBFB00BBEEFC00B3EBFB00AFEA
      FB00B0EAFB0083DDF90094E0F900000000004394AA000798C7006ECCEC004592
      D4004257AF003755AE005DD7F70071DFF80086E8F80085E7F7008AE9F8007BE1
      F90085E6F70086E8F7007EE4F70076E1F8006BDDF70066DCF80058D5F70044CD
      F6006CCEEC0055A2BC000000000000000000009CCF0043A3D3002067A100375A
      88001F689E0049BDE6004CD0F70041CBF60048CDF60051D1F6006CDDF70072DF
      F70070DEF7006CDDF70066DBF7005FD8F70058D5F7004FD2F60046CEF6003BCA
      F60056D1F7006CC6E300CECECE0000000000000000000000000000000000CEF6
      FC002C7E8B000BBBD70001DAFC0001DAFC0001DAFC0035C2D700323F41003535
      3500456E73000CDCFC0001DAFC0001DAFC0001DAFC0001DAFC00159CB10043A1
      B000000000000000000000000000000000000000000022ABE4005392C0002452
      8C003690C5002F80B30061D9F7004CCFF6004ACEF70050D0F7005DD6F70078E2
      F70078E2F70075E1F70071DFF7006CDDF700EDFBFE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6F0FC0096E0F800000000001D627100088CB50047C5F0005DD5
      F60066D8F7007FE0F9006ADCF7008FE6F9009BEBF9009EEEF800A3F0F9009FEC
      FB0095E8FA0090E7F90083E2F90089E5F9009CEBFA0085E3F90090E7F90049D0
      F6006BCEEC0068B5CF000000000000000000009CCF00469ECF0023599A002084
      BF00235A980055C0E70060D8F6004CCFF70054D1F70062D8F70078E2F70077E1
      F7007BE3F70074E0F7006EDDF70066DBF7005ED8F70055D4F6004BD0F60040CC
      F6005AD2F7006CC6E300CECECE00000000000000000000000000000000000000
      0000CEF6FC002C7E8B000BBBD70008C5E3002F4A4E003535350035353500159C
      B100159CB1005FA8B2000CDCFC0001DAFC0001DAFC00159CB10043A1B0000000
      0000000000000000000000000000000000000000000025AFE6003F7CB80027B1
      E6003870AC004397C90062D9F70054D2F70055D2F7005BD4F80069DAF70074DF
      F70078E2F70078E1F70079E2F70072E0F700DAF6FD00EDFBFE00ECFAFE00EBFA
      FE00EAFAFE00B4EBFC0098E0F800000000001989AE000993BE0064CFF2003CC8
      F6004CCDF7005AD1F7006BD8F80088E3F80096E9F80091E8F9009BEBF9009EEA
      FA00A3EAFB008FE4FA0085E1FA0089E1F90061D4F80053D0F70058D1F80057D0
      F70072CFEE0079C6E0000000000000000000009CCF00489DD4002C57A4003688
      C7002C59A2005CC3E9005DD6F7005FD7F70064D8F80068D9F8006FDDF8007DE3
      F70080E5F6007CE3F70074E0F7006CDDF70063D9F70059D6F7004FD2F60044CD
      F6005DD3F7006CC6E300CECECE00000000000000000000000000000000000000
      000000000000CEF6FC002C7E8B002569730025697300323F41004863670001DA
      FC0001DAFC00159CB1006AAAB20016DDFC00159CB10043A1B000000000000000
      000000000000000000000000000000000000000000002CB2E8004F87C4005C91
      CA004B85C1004496CD0069DCF7005AD4F70079E2F70069DAF80079E1F70071DD
      F90083E6F60086E7F6007FE5F70078E2F7006FDEF70067DBF70060D9F70057D5
      F6004BD0F60041CCF600B3E9F900000000000FA9F20016ACE3000DA3D300009C
      CF00009CCF00009CCF000AA3D40017AAD9001AACDA001EADDA0020AEDA0021AE
      DA001FADDA001CACDA0019ABD90016AAD90012A8D90011A9DB0014B0E3000CAD
      E20003A2D600CEEAF4000000000000000000009CCF004CA4DC00536FBB004950
      A8005371B90076CAEC006DDDF70077E1F80081E6F70085E6F70080E4F80080E4
      F80089E8F60085E8F70079E2F7007AE3F80074E1F80076E2F8005BD6F70050D2
      F70060D4F8006CC6E300D5D5D500000000000000000000000000000000000000
      00000000000000000000CEF6FC0030737E00159CB100323F41001B88990001DA
      FC0001DAFC0001DAFC001B889900285E670043A1B00000000000000000000000
      0000000000000000000000000000000000000000000051C7F00073A5DA003E56
      AF004780C7005AA4D90071DFF70072DFF8008BE9F8008BEAF7008DEAF70089E7
      FA007FE3F90082E5F7007EE4F80080E3F80084E6F80095ECFA007DE3F80074DF
      F80064DAF70042CCF600BFEDFA0000000000C2E7FA0076CDF6002CB4F10016B8
      F4001EC1F50037C4EB0026A7CC002295B3001C7F9A00186F8600176B8000176B
      8000176B8000167590001386A8001598C40016A8D80057C6EA007ECBE5007ECB
      E500CEEAF400000000000000000000000000009CCF0039C8F50051D3F5005ED7
      F7005ED7F70070DDF7007CE1F80084E6F800A2EEF900AFF2FA00A8F0FA0093E8
      FA008DE6FA0081E2F90088E3FA0082E2F900AFF2FA0084E3F90093E7FA005FD8
      F6004FCEF7006AC5E30000000000000000000000000000000000000000000000
      0000000000000000000000000000CEF6FC0030737E00159CB10001DAFC0001DA
      FC0001DAFC0001DAFC00159CB10043A1B0000000000000000000000000000000
      000000000000000000000000000000000000000000001BBFF40055D2F60049CF
      F60061D9F60066DBF70078E1F80097E8F900A5EEF9009BEDF800A3F0F8009DEC
      F900AAEEFB00B3F0FB0088E3FA0097E7FA008AE2F90080E0F90070DAF80070DB
      F9007BDEF90035C7F600B0E7FA0000000000000000000000000000000000E0F4
      FC0095E0F80050CCF6001CC0F50027C3F5002BC1EF0038BADB00319FBB00217E
      98001E6676001F5B66001F5B66001F5B66001F616E00C2E9FA00000000000000
      000000000000000000000000000000000000009CCF003EC8F60026C3F5003CCA
      F6004ED0F6005FD6F60071DCF8009DE8FA0085E4F8008EEAF60091E9F800A2EC
      FA009AE9FA0080E0F90084E0F90083DFF9004FCFF70041CBF60032C6F60044CB
      F7004BCBF70078CBE60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CEF6FC002C7E8B000BBBD70001DA
      FC0001DAFC00159CB10043A1B000000000000000000000000000000000000000
      000000000000000000000000000000000000D1F0FB0014BCF40079DAF9006DD7
      F90078DAF90084DFF9008EE2F9009AE6FA009DE8FA00A5EAFA00ABEDFA00AEEE
      FA00A9ECFB00A2E9FB009BE6FB0093E3FA008BE1F90083DDF9007ADAF9006FD8
      F90066D4F90062D3F800C3EDFA00000000000000000000000000000000000000
      0000000000000000000000000000A5E0F8006ACCF6001FB5F1001FBAF30029BB
      EC0027B0DB002F9DB900267F950020697A002172860000000000000000000000
      00000000000000000000000000000000000068C3E1006CCCEC0062CBEC0069CC
      ED006DCEED0072CFED0076D1ED007AD2ED007DD3ED0081D5ED0084D6ED0084D6
      ED0081D5ED007DD3ED0079D2ED0075D0ED0071CFED006CCEED0067CCED0061CA
      EC006ECDEC0095D5EA0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEF6FC002C7E8B000BBB
      D700159CB10043A1B00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3ECFA00C6EDFA00CAEE
      FB00CDEFFB00D0F0FB00D3F2FB00D6F3FB00D9F4FB00DBF5FB00DEF6FB00DEF6
      FB00EEF9FC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2E9FA0079D2
      F6002FC3F3001CC1F50024C5F5002CC0F30068C9F50000000000000000000000
      000000000000000000000000000000000000000000008ED2E8007ECBE5007ECB
      E5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECB
      E5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECBE5007ECB
      E5008ED2E8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEF6FC00239C
      AF003FACBC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2F5FC009CE3F9004ABDF300C2E7FA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D3EDFC0098D5FA008ACAF80089C5F60088C1
      F50086BDF300B3D6F700E0EEFB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071D1FC003DCEF9001AA4F900189BF5001591F2001387
      EF00107EEC00107EEC00138EF200A5D8FA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D1D0D0000000000000000000000000000000
      000000000000000000000000000000000000E3E3E300DADADA00000000000000
      0000000000000000000000000000000000000000000000000000FFFEFA00FEF9
      F400FEF9F400FEF9F400FEF9F400FDF7F300E7F4FD00F7F7F400FEF9F400FEF9
      F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9
      F400FEF9F400FEF9F400F7EFEC0000000000000000000000000000000000BBBB
      BB00D2D2D200CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
      CD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00D3D3D300ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000005DD0FB003CCBF9001AA5F900189CF6001592F2001388
      EF00107FEC00107DEC00138DF1007AC6F9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F3F3F300FAFA
      FA00FDFDFD00F1F1F1009D9C9D006F6F71007C7C7F00C5C5C500AEAEAE00B7B7
      B700D5D5D500DCDCDC00DCDCDC00B6B6B70069696B005E5F61009E9E9F00DCDC
      DC00DCDCDC00F0F0F00000000000000000000000000000000000FFFFFF00FFFF
      FE00FEF9F400FEF9F400FEF9F400DDF4FF00B2E3F800CBF0F900E0F7FD00FAF4
      F000FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FEF9
      F400FEF9F400FFFFFF00FDFDFD0000000000000000000000000000000000D6D6
      D600FCFCFC00F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400EDF4F500EEF4F500F4F4F400FFFFFF00BBBB
      BB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049CBFD003AC8FA001AA6F900189CF6001693F3001389
      EF00117FEC00107CEB00138BF1004EB4F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E4E400EBE8
      E800EFECEC00D6D4D400696A6C00B3B3B30071717400D6D4D400EFECEC00EFEC
      EC00EFECEC00EFECEC00EFECEC009A989A00A1A0A100A9A9AA007A7A7D00EFEC
      EC00EFECEC00EBE8E80000000000000000000000000000000000FFFFFD00FFFF
      FF00FFFFFE00FEF9F400FAF4F000BEF1F900A8DCF400C1E8F800BAE4F500B6EE
      F700E0F6FE00FAF4F300FEF9F400FEF9F400FEF9F400FEF9F400FEF9F400FFFD
      F900FFFFFF00FFFEFD00FDFDFD0000000000000000000000000000000000D4D4
      D400F6F6F600EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEEEE00EEEE
      EE00EEEEEE0094E4F30030D6F60071E6F90067E7FA00A2E6F200FDFDFD00B8B8
      B800000000000000000000000000000000000000000000000000000000000000
      000000000000D4F0FD005AD2FD003AC8FA001BA7F900189DF6001694F300138A
      F0001180EC00107CEB001289F00032A7F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E5E0E00089B0
      CE00D6CFCF00DCD4D400ABA6A80095919400ABA6A800DCD4D400DCD4D400DCD4
      D400DCD4D400DCD4D400DCD4D400DCD4D4009390930087858800CFC9C900DCD4
      D400DCD4D400DCD4D40000000000000000000000000000000000FFFFFE00FEF9
      F400FFFFFF00FFFFFF00E0F4FE00A7E0F5009FD7F3009FD7F300AADCF400B3E1
      F600AADEF500B8EEF700E0F9FF00FAF7F300FEF9F400FEF9F400FFFDF900FFFF
      FF00FEF9F400FFFDFA00FDFDFD0000000000000000000000000000000000D5D5
      D500FAFAFA00F1F1F100F1F1F100EDEDED00E2E2E300ECECEC00F1F1F100E4E4
      E30083D6EF0045D5F40027DDFB0040ECFE006DE4FA0088E2F700E3F9FE00BABA
      BA00000000000000000000000000000000000000000000000000000000000000
      000000000000B8E7FD0068D7FC0039C6FA001BA8FA00189EF6001694F300138B
      F0001181ED000F7BEB001288EF00169CF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000727376008787
      89005A5B6000CAC5C600DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9
      D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9D900DFD9
      D900DFD9D900DFD9D90000000000000000000000000000000000FFFFFF00FEF9
      F400FEF9F400FFFDFA00DCF5FB00A2D9F3009ED7F3009FD7F3009FD7F300A2D9
      F300ABE0F400B6E1F600B3E4F600C4F3F900E7F9FE00FFFEFD00FFFFFF00FEF9
      F400FEF9F400FFFDFA00FDFDFD0000000000000000000000000000000000D7D7
      D700FDFDFD00F4F4F400D9D9D800BBBBBB00DCDCDC00D8D8D700AFAEAB00B8B7
      B60036BCE60018C4F100069DE10027BFED006FF1FF0056D7F6005DE7FC00BBBB
      BB00000000000000000000000000000000000000000000000000000000000000
      0000000000008ED9FD0075DCFC0034C2FB001BA8FA00199FF7001695F300148B
      F0001182ED00107BEB001287EF00169AF600D3EDFC0000000000000000000000
      000000000000000000000000000000000000000000000000000089898D008B8B
      8E001F222C003C3E4600A3A1A400A7A5A700B3AFB200CCC8CA00B3AFB200B3AF
      B200B3AFB200BFBCBE00B3AFB200B3AFB200B3AFB200CCC8CA00B3AFB200B3AF
      B200B3AFB200D1CDCE0000000000000000000000000000000000FFFFFF00FEF9
      F400FEF9F400D8F7FF00B4D1E500CCE3EF00A2D9F300A1D9F300A4DBF300A7C4
      D900ABC5D900B1DCEC00AEE1F400CAECF800D9F0FA00E0F8FB00E7F4FA00FDF7
      F300FEF9F400FFFDFA00FDFDFD0000000000000000000000000000000000D7D7
      D700FFFFFF00F7F7F700B9B9B800B4B4B300D6D6D600E0E0E000DADADA00D5D4
      D4004CBBE20014BAED000090DC008FE8F80052EEFF0034D0F500BDF3FD00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      00000000000081D7FD0075DCFC0036C4FB001BA9FA0019A0F7001696F400148C
      F1001183ED00107BEB001185EE001598F500C4E7FC0000000000000000000000
      00000000000000000000000000000000000000000000000000008D8E93007D7E
      8200191C2600191C2600191C2600191C2600191C26007F7E8300191C2600191C
      2600191C26004C4D5400191C2600191C2600191C26007F7E8300191C2600191C
      2600191C26007273780000000000000000000000000000000000FFFFFF00FEF9
      F400F4F3F300BCE4F6009FB4CF00A8BCD100CAE1ED00A4E1F80095BED900939A
      BC00949CC100939CC2009AB4D100DBEFF600C5E7F300A8DCF400BAE7F700C6F5
      FA00E6F4FA00FFFDFA00FDFDFD0000000000000000000000000000000000D8D8
      D800F8F8F800CBCBC900E7E9EA00DDDEDF00EBEDEE00E6E8E800E1E2E200B5D1
      DE000AA5E50015BCEE0018C4F10026DCFA0038E8FD0033CCF30076E5FB00BEBE
      BE00000000000000000000000000000000000000000000000000000000000000
      0000000000007CD5FD0075DCFC003BC9FA001BAAFA0019A0F7001797F400148D
      F1001283EE000F7BEB001184EE001596F5008AD1FB0000000000000000000000
      00000000000000000000000000000000000000000000000000007C7D82006B6C
      7000191C2600191C26001B6578001C7E93001C7E930051B2C4001C7E93001C7E
      93001C7E93003698AC001C7E93001C7E93001C7E930051B2C4001B596A00191C
      2600191C260074757A0000000000000000000000000000000000FFFFFE00FEF9
      F400D6F7FF00AEC4E300A1BAD900B1C5DC009BE1F6001EB1EF000C2B6800090D
      47000A0F50000A1054002280B10039C1F300C2EAF800ADE0F400AEE0F600C1E7
      F800A5E2F700FCF6F300FDFDFD0000000000000000000000000000000000D6D6
      D500B5B4B200BABBBA00D4D6D700ECEEF000EEF0F100D8D9DA00BABABA00BDBC
      BB00BBCDD60011B2EA0010B3EA0021D6F80026C4F000D0F7FC00D7F9FE00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000005FCEFF0075DCFC003BCAFA001CABFB0019A1F7001798F400148E
      F1001284EE00107BEB001183ED001595F4007BCBFA0000000000000000000000
      0000000000000000000000000000000000000000000000000000EDEDED00E8E8
      E800D9E5E70043E0FA0025BDD600318592003185920031859200318592003185
      920031859200318592003185920031859200318592003185920025BDD60043E0
      FA00E5E5E500E5E5E50000000000000000000000000000000000FFFFFE00F3F3
      F000B6F3FB00AACCE800BECAE3005C9ED4002DBEF10022B3F1001D86BF00080F
      4300090D4400090D48000B134C0021B4EF0033BAF300B7E8F800A1D9F300A4DB
      F300B3E1EF00FFFDF900FDFDFD0000000000000000000000000000000000D7D7
      D700CBCCCC00B0B0AE00B2B2B100D6D8D900E9EBED00EFEFF000BDBDBC00A09F
      9B00A9A8A50077C7E4002CD2F5008DE3F80041DDF900DEFCFF00FFFFFF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000E2F4FD006ECFFE006BCBF80034B0F4001A95F400188DF1004CA4F0003C95
      EC001276EA00106FE8001177EA00148AF10050BBFA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5EEFA0028B2C800337A8400318592003185920031859200318592003185
      9200318592003185920031859200318592003185920031859200337A840025BD
      D6009CE5F100EFEFEF0000000000000000000000000000000000FFFFFE00F7F7
      F400BAE4F000B1E5F80063D1F60035C4F10079E1F6004DC1EC00237EB000090B
      3900090B3D00090C3E00184D820025B7EF001BB0EF0019ADEF00A4E1F800ACDE
      F400E9F2F400FFFDF900FDFDFD0000000000000000000000000000000000D9D9
      D900FFFFFF00C2C2C000ACACAA00CAC9C900D2D1D100F3F3F400DDDCDB007B79
      740081807B00CDCCCC00D7D6D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000CCDCE700B1C9E500CFD8E200D4D4D400E3E3E200ECECEC00E9E9E900E3E3
      E200DBDBDB00D5D5D400CACACA009FB1C70094B0CA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008DEDFD0031859200337A8400442B2400442B2400442B2400442B2400442B
      2400442B2400442B2400442B2400442B2400442B2400442B2400318592002F90
      9F008DEDFD000000000000000000000000000000000000000000FFFEFD00FEF9
      F400F9F9F800AAD5DC002EC4ED003ECAF3009FECF800ADF1FB005DC4E80046A5
      CE00173869000B103D0030B1DC0028BCF1001EB3EF0014AAEF0012A7EF00A3EB
      F600FFFDF900FFFAF700FDFDFD0000000000000000000000000000000000D9D9
      D900FAFAFA00B3B3B100D5D6D600E3E3E400E2E3E300E5E6E700DCDCDC006D6B
      6500C9CAC900DFDFDF00DEDEDF00E3E4E400FDFDFD00FFFFFF00FFFFFF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000D2D2D200E3E3E300E2E2E200D1D1D100DCDCDB00DFDFDF00DADADA00DADA
      D900DDDDDD00DBDBDB00CBCACA00BFBFBF00B1B1B000E8E8E800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6F5FD0023C9E400318592003D4D4D003B585B001EDFFF001EDFFF0020D4
      F1001EDFFF001EDFFF001EDFFF001EDFFF003B585B003B585B003185920023C9
      E400D4F7FD000000000000000000000000000000000000000000FFFDFA00FFFF
      FF00F3EDEA00E3DDDC00DBD5D4007BCDDB0039CCEF0054DBF10095EDF600D6F8
      FD008ADCF30031B7E70036C4F1002ABCF1001FB3EF0014AAEF000CA5F100B1D0
      DB00FFFFFF00FFFFFD00FDFDFD0000000000000000000000000000000000D9D9
      D900CBCBCA00ADACAA00AAAAA800ADADAC00CCCDCD00EDEEF000EDEEF000EDEE
      EF00ECEEEF00ECEEEF00BFBFBD00E3E4E400FFFFFF00FEFEFE00FFFFFF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000E3E2E200BBBBBB008E989C0057B7D80041C3F1002CBCF20038BFF30073D4
      F6008FD8F40086D2F20087A8B50095969700BFBFBF00F0F0F000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000054E5FD00318592002C9CAD00423632003B585B003D4D4D003863
      68002AA7BB00366F76003B585B003B585B00442B24002C9CAD003185920054E5
      FD00000000000000000000000000000000000000000000000000FFFFFF00E9E3
      E100E3DDDC00E3DDDC00E3DDDC00E3DDDC00DAD5D4007ACAD90045D2F10076E0
      FA0061D2F40088E3FA0064CEEF003BC2F1001EB3EF0014AAEF003DBEF100E3DD
      DC00E3DDDC00FFFEFD00FDFDFD0000000000000000000000000000000000D9D9
      D900E2E2E100C9C8C500BBBAB80085847F0091908D00E4E6E800E8EBED00E9EC
      EE00E9ECEE00CACBCB00D1D0CF00F5F5F500F9F9F900F5F5F500FFFFFF00BCBC
      BC00000000000000000000000000000000000000000000000000000000000000
      0000F6F6F600DDDDDD0070C4E00035B5E2001EBFF5000EBBF6000EB9F4002490
      CC0058BFE5006BD6F70066CEF3005EC7E900A3D8EB00F8FAFB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D4F7FD0020D4F100366F760038636800442B2400442B24003B58
      5B001EDFFF003B585B00442B2400442B2400366F7600366F760020D4F100E2F9
      FD00000000000000000000000000000000000000000000000000FDFDFD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F7008EE3
      EE003ECFF60064D6F60079DEF8009FEAF80044B3E50013B0F300E3FFFF00FFFF
      FF00FFFFFF00FFFFFF00FDFDFD0000000000000000000000000000000000D9D9
      D900FFFFFF00FFFFFF00F8F8F800B4B3B2009A999600E5E8EB00CCCDCE00ABAA
      A800DADCDE00E7E9EC00FBFBFB00F3F3F300EEEEEE00EBEBEB00FAFAFA00B8B8
      B800000000000000000000000000000000000000000000000000000000000000
      000000000000D9F4FB003293C9002675AB002B9DCE0029CFFF002698D000272D
      7F00294294003B9BD10058D4F90068D0F3005FCAF20075CBF300B8E4F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071E9FD002C9CAD002C9CAD00442B2400442B24003D4D
      4D001EDFFF0042363200442B2400423632002C9CAD002C9CAD007FEBFD000000
      0000000000000000000000000000000000000000000000000000FDFDFD00FDFD
      FD00FEFAF900FFFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EDF4F4006FDCEE0020BEF4002DBAF30043C4F4004BD5FA00FFFFFF00FFFD
      FA00FFFFFE00FDFDFD000000000000000000000000000000000000000000D9D9
      D900FFFFFF00FFFFFF00FFFFFF009C9B9800C8C9CA00EFF0F100D2D2D200BFC0
      C100DBDCDE00F5F5F600F1F1F100EAEAEA00E2E2E200DCDCDC00ECECEC00B7B7
      B700000000000000000000000000000000000000000000000000000000000000
      0000000000007CD0F0004580C3002D7BBB0045B0DA004AD8FD002D64A000272A
      7A00272E83003C77B00041CCF40031C9F70057C9F30080CDF0002BB3F100B6E3
      F900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000002BDFFD00366F760031859200442B24003B58
      5B001EDFFF003B585B00442B240031859200366F76002BDFFD00000000000000
      000000000000000000000000000000000000000000000000000000000000FDFD
      FD00FDFBF900F4F0EE00FDF9F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E5F0F10066D3E6002DC6F100E7F7FA00F7F3F000FDF9
      F700FDFDFD00000000000000000000000000000000000000000000000000D9D9
      D900FFFFFF00FFFFFF00FFFFFF00F5F6F600FCFDFD00FFFFFF00F6F7F700F5F6
      F700FAFAFA00F1F1F100E7E7E700D8D8D800CBCBCB00C8C8C800E2E2E200B7B7
      B700000000000000000000000000000000000000000000000000000000000000
      00000000000040C7F40057AFE2005BA3D60067DAF7005BDBFD00419ECA002426
      6E00252371002E4889004BC5EB0042D2FA0020C0F50019BCF40055C7F4000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008DEDFD0028B2C80031859200423632003B58
      5B001EDFFF003B585B003F423F00337A840025BDD6009BEFFD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFC00F7F3F000FEF9F700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFCFB00F9F4F300FFFDFA00FDFD
      FD0000000000000000000000000000000000000000000000000000000000D9D9
      D900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FE00F3F3F300E9E9E900DEDEDE00E4E4E400E3E3E300EDEDED00C7C7C7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D9F5FC0065DFFB0068DFFA00A5E8F9009FE8FC006BC2E200345F
      960021216600498BB6005EE1FF0048CFF70035C9F60025C2F400BDE8FA000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039E1FD00366F76002F909F003F42
      3F00318592003F423F002C9CAD00337A840047E3FD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD00FAF7F400FEF9F700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFD00FAF7F300FDFCFB00FDFDFD000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8
      F800EEEEEE00DFDFDF00D5D5D500FBFBFB00FFFFFF00CDCDCD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B4F1FC008AE7F900A9EEF900C6F5FE00A3E6
      F80065B7D50064D2EF0059DAFA004BD0F60038C9F50066D4F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B7F3FD0023C9E400318592003B58
      5B00442B24003B585B00337A840020D4F100C6F5FD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDFDFD00FEF9F700FEFAF700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFD00FDF9F400FDFDFD00FDFDFD00000000000000
      000000000000000000000000000000000000000000000000000000000000D9D9
      D900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00F5F5
      F500EAEAEA00D9D9D900D0D0D000FFFFFF00CACACA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B2F1FC0096E9F900ACEC
      FD00A1EDFF0099E5F9006CD7F40044CEF5003CC8F400D0F1FB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000054E5FD00318592002C9C
      AD00423632002C9CAD003185920064E7FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00FFFDFA00FFFAF900FFFF
      FF00FFFFFF00FFFEFD00FEFAF900FDFDFD00FDFDFD0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DBDB
      DB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9
      F900EFEFEF00E0E0E000E5E5E500C9C9C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A9EF
      FC007EE1F9008BE0FA00AEE7F9007DD9F60079D9F70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E2F9FD0020D4F100366F
      760031859200386368001EDFFF00E2F9FD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00FFFEFD00FFFD
      FA00FFFDFA00FFFDFA00FDFDFD00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CDCD
      CD00E7E7E700E5E5E500E4E4E400E4E4E400E5E5E500E5E5E500E5E5E500E4E4
      E400DEDEDE00D5D5D500C7C7C700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000098E9FB0064D8F70057D0F600D3F1FB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8F1FD002BDF
      FD001EDFFF002BDFFD00A8F1FD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFD00FFFF
      FF00FFFFFE00FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6F5FD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BCBCBC00D1D1D10000000000000000000000
      000000000000000000000000000000000000DFDFDF00B2B2B400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F5
      F500F2F2F200F3F3F300F4F4F400F4F4F400F4F4F400F5F5F500FAFAFA00E3E3
      E300B3B0AF00A0999800978E8D00857F7F00A29E9D00E2E2E000000000000000
      0000000000000000000000000000000000000000000000000000F6F5F500EAE8
      E800E7E7E700E9E9E9009595950078797A006F6F7100A0A0A000C5C5C500C5C5
      C500C6C6C600C0C0C000C0C0C000ACACAC0079797A00828284006A6A6C00C0C0
      C000C0C0C000DADADA0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DADADA00C3C2C200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D4D4D400777778005E5E6100BDBDBF00AFAFAE00A9A9
      A900BCBCBC00D6D6D700D6D6D700D4D4D5009E9E9E006D6D6F007E7F8100D4D4
      D500D6D6D700E0E0E000000000000000000000000000EBEBEB00DFDFDF00E3E3
      E300E8E8E800ECECEC00EEEEEE00EFEFEF00EFEFEF00F0F0F000DAD9D900918B
      8900746764005E504C005C4E4A0063585400736A6600807C7A00D7D6D6000000
      0000000000000000000000000000000000000000000000000000F4F3F300F1EE
      EE00ECE9E900ECE8E800737376008F8F90008D8E8F00ACAAAB00ECE8E800ECE8
      E800ECE8E800ECE8E800ECE8E800C6C3C40067676A00939393006A6A6D00ECE8
      E800ECE8E800ECE8E800F8F7F70000000000000000000000000000000000E9E9
      E80000000000000000000000000000000000A1A09E007E7C7900000000000000
      0000D5D4D30000000000000000000000000000000000928D8800E7E4E1000000
      0000000000000000000000000000000000000000000000000000EAE9E900E6E3
      E300F0EEEE00F4F2F2008F8E90009F9FA0008788890088878900F4F2F200F4F2
      F200F4F2F200F4F2F200F4F2F200DBD9D9006E6F70009797990075757700CECD
      CD00F4F2F200F4F2F200EEEDED0000000000F3F3F300DCDCDC00E1E1E100E5E5
      E500EBEBEB00EFEFEF00EFEFEF00EFEFEF00F0F0F000E8E7E6007C716F004B3D
      380032201B00301E190038322F00C6C4C300B8B1AF008075710068605E00B0AE
      AC00000000000000000000000000000000000000000000000000E6E4E4008FB1
      CA00C1C3C800D8D1D100CFC8C9009E9A9D00B7B1B300DBD4D400DBD4D400DBD4
      D400DBD4D400DBD4D400DBD4D400DBD4D400B7B1B3009E9A9D00CFC8C900DBD4
      D400DBD4D400DBD4D400F4F2F200000000000000000000000000ADABAA007D7B
      7800000000000000000000000000BFECFB0079A6B3005984920000000000C8C6
      C40058565200E1E4E600000000000000000000000000727E7F00D6D9DA000000
      00009A938F00F6F4F30000000000000000000000000000000000F4F2F200A4BD
      D200C2CAD500DDD6D600D1CBCB00727075007D7B7F00C5BFC000DDD6D600DDD6
      D600DDD6D600DDD6D600DDD6D600DDD6D600A49FA20063626700A19D9F00DDD6
      D600DDD6D600DDD6D600ECE8E80000000000F4F4F400DCDCDC00E0E0E000E4E4
      E400E8E8E800ECECEC00EEEEEE00EEEEEE00ECEBEB009A918E0058504D00B5B2
      B1004435310032211C0037343300000000000000000000000000948B87006E64
      6200B8B6B5000000000000000000000000000000000000000000A6A7A9008080
      830046484F008B898D00E0DADA00E0DADA00E0DADA00E0DADA00E0DADA00E0DA
      DA00E0DADA00E0DADA00E0DADA00E0DADA00E0DADA00E0DADA00E0DADA00E0DA
      DA00E0DADA00E0DADA00F5F4F40000000000000000000000000099AFB500478C
      A10060D3F90030C6F80002BAF90002B7F70002B3F40003B9F80003B9F90021B6
      E900387C90009EBFCB008FD2ED005EBCE10042B4E200289DCB0043B0DC0076C6
      E5005F808C00ECEFEF0000000000000000000000000000000000C6C6C7008282
      84007D7E800099989A00DED8D800DED8D800DED8D800DED8D800DED8D800DED8
      D800DED8D800DED8D800DED8D800DED8D800DED8D800DED8D800DED8D800DED8
      D800DED8D800DED8D800ECE9E90000000000F3F3F300DBDBDB00DDDDDD00E5E5
      E500EEEEEE00F1F1F100EBEBEB00ECECEC00C0B9B8003A2F2B00B9B7B600EDED
      ED0089817E00372520001F141100A8A8A8000000000000000000000000008D82
      7F00635D5B000000000000000000000000000000000000000000BCBCBE00B8B6
      B7001D202A001D202A0071717600A4A2A500A4A2A500A4A2A500B1AFB000A4A2
      A500A4A2A500B1AFB000A4A2A500A4A2A500A4A2A500BEBBBC00A4A2A500A4A2
      A500A4A2A500B1AEB000F7F6F60000000000000000008EDFFA0002BBF90006C0
      FA0008C3FA000BC6FB000CC5FA000FC8FA0012CFFD0012CFFD0012CFFD0012CF
      FD0012CFFD0015C3F20024ACDB0027ADDA0029AFDA0029B7E2002AB8E00029B8
      E1002DB7DE00A6DEEE0000000000000000000000000000000000C2C3C6008E8C
      8F0044464E002A2D36009C9B9D00D6D2D200D6D2D200D6D2D200D6D2D200D6D2
      D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2D200D6D2
      D200D6D2D200D6D2D200F0EDED0000000000F3F3F300DADADA00DCDCDC00E1E1
      E100E8E8E800EAEAEA00E8E8E800F9F9F90074676200322A2300E9E9E900E9E9
      E900BDB9B80047383300322420004B484800000000000000000000000000BBB5
      B500837B78009C99980000000000000000000000000000000000B5B6B8008788
      8B00191C2600191C2600191C2600191C2600191C2600191C26004C4D5400191C
      2600191C26004C4D5400191C2600191C2600191C26007E7D8200191C2600191C
      2600191C26003D404700F9F8F8000000000000000000B6F0FC0022E1FF0025E3
      FF0028E5FF002BE7FF0032ECFF0036ECFF0046EDFF0062F0FF0070EDFF005CEA
      FF0032E6FF0027D5F60049CEE2004DD3E40054D7E60059D6E70063D4E80068D4
      E9004ACEE70085D9ED0000000000000000000000000000000000D8D8D900ABAB
      AE003D404700191C2600191C2600191C2600191C2600191C2600807F8500191C
      2600191C2600191C26004D4E5500191C2600191C26004D4E5500191C2600191C
      2600191C260022252E00E3E2E2000000000000000000D9D9D900DADADA00DDDD
      DD00E1E1E100E4E4E400F3F3F300FAFAFA0053453D003A342100FAFAFA00E9E9
      E900B8B5B5004C403B005548430034282400544B4B0096909000CBC7C500BEB9
      B70088807B007876740000000000000000000000000000000000D8D8D9006F71
      750022252E00191C2600191C2600191C2600191C2600191C26004F515900191C
      2600191C26004F515900191C2600191C2600191C260086878C00191C2600191C
      2600191C260046484F00FAFAFA0000000000000000000000000000000000CAF8
      FD00CCF9FD00A2F6FD007FF2FD0047E4FE003EDFFE0016D7FE0017D7FE0017D7
      FE0010CDFD0065DBF900D3F3F700A3E7F00044C8E4003FC5E3003FC4E30042C6
      E3003AC0E100A2DDEF0000000000000000000000000000000000F3F3F3003D40
      47003D404700191C2600191C2600191C2600191C2600191C260082828700191C
      2600191C2600191C26004D4F5600191C2600191C26004D4F5600191C2600191C
      2600191C2600191C2600E4E4E4000000000000000000E3E3E300D9D9D900DCDC
      DC00DEDEDE00E1E1E100F5F5F500F5F8F80053494200332E1E00FAFAFA00C0BE
      BE00625A58007B726A00C6C3B900958C87004B3D34005A614D003E3133004938
      350084797600787472000000000000000000000000000000000000000000F3F3
      F300E9E9E900EFEFEF00F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F4F4F400F7F7F700000000000000000000000000000000000000
      0000000000000000000092EFFD0020DFFE0018D9FE0018D9FE0018DAFE0018DA
      FE000FCDFC0057D7FB0000000000B0E9F20036C3E20031C1E10032C2E10032C3
      E1002EBDE00090D6EC000000000000000000000000000000000000000000BABA
      BC00C9C9CA00ADAEB000ADAEB000ADAEB000ADAEB000ADAEB000C9C9CB00ADAE
      B000ADAEB000ADAEB000BBBCBD00ADAEB000ADAEB000BBBCBD00ADAEB000ADAE
      B000ADAEB000B6B7B900F0F0F0000000000000000000F6F6F600D9D9D900DADA
      DA00DBDBDB00E7E7E700F6F6F600E6EAEB0070645300261F1C006A6767007771
      6F006C636100857D7800F0F0EC00BAB7B6005F4D3F0076787200484351005040
      3900827774007974730000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DDDDDD0076767800A9A9
      AA00BCBCBC00B7B7B700CECECF00D7D7D800D7D7D800A5A5A50075757700CCCC
      CC00D7D7D800EBEBEB00000000000000000000000000000000009E9A96000000
      0000000000000000000078DFF00025E3FF001ADCFF001ADCFF001ADCFF001BDC
      FF000FCCFC0018C6F900000000009FE3EF003ECAE30037C3E20036C4E20038C6
      E30031BEE00058C1E30000000000000000000000000000000000000000000000
      0000EDE8DB00F5EB7700E9E27B00DCDAD200E9E7E700F8F6F600F8F6F600F8F6
      F600F8F6F600F8F6F600F8F6F600F8F6F600F8F6F600F2F1F100E3E3E300E9D1
      A700F4C26E00F6E2C30000000000000000000000000000000000F6F6F600DEDE
      DE00D9D9D900EBEBEB00F7F7F700DCE9F600858A8900594D49004D4441009F99
      9500A29C9A0076706E00A5A19E00A6A19F00A39E9C00A6A5A400958E8A006C60
      5C00877C79007874730000000000000000000000000000000000000000000000
      00000000000000000000EDEBEB00EBE7E700F0EDED00838385008D8D8F006565
      6800F0EDED00F0EDED00F0EDED00F0EDED00CBC8C9007F7F81008F8F9100A6A5
      A600F0EDED00EBE8E800000000000000000000000000000000006D8289008FB2
      BE0079A5B6006396A9003AB6D10022E1FF0021E1FF001DDEFF001EDFFF001EDF
      FF0016D4FD0007C2FB0090DCF1007ECEE0003ECAE3003CC9E30039C8E3003CCA
      E40037C3E1002BB0DB00D1EEF600000000000000000000000000000000000000
      0000F8EDAD00F4E64B00DDD59800DCDBDB00CFCECE00F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500EAE8E800C2C1C100D9D3
      CB00F2B34B00EEB55D0000000000000000000000000000000000000000000000
      0000ECECEC00E8E8E800BDD2E8004384CD005A94C700706F7200665F5C00635D
      5B00CCCACA00E7E6E6000000000000000000000000000000000000000000CAC6
      C400928885007976760000000000000000000000000000000000000000000000
      00000000000000000000D5D4D50080A2BC00C5C0C000CFC9C900ABA6A800C3BD
      BE00DCD4D400DCD4D400DCD4D400DCD4D400DCD4D400B7B1B300ABA6A800DCD4
      D400DCD4D400DCD4D400000000000000000000000000000000005C9BAD005D99
      AA00649DAB0066A0AD0041BED7001CDEFF0025E3FF0021E1FF0022E1FF0023E2
      FF001DDAFE0005BEFA0024B5DE0048A5BE003AC7E30041CCE4003ECAE3003FCB
      E3003DC8E20027B0DC0092D8ED00000000000000000000000000000000000000
      0000F4DB7300F4E04E00DEDACB00F7F5F500F7F5F500F7F5F500F7F5F500F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5
      F500D9A75400EDA6390000000000000000000000000000000000000000000000
      000000000000000000005290D300498BD7004D95E0005A86B50079727000423D
      3C00D7D4D400000000000000000000000000000000000000000000000000B6AF
      AE00817B7900B3B2B20000000000000000000000000000000000000000000000
      000000000000000000007D7E82005C5D630041434A00CFCBCB00E3DDDD00E3DD
      DD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DDDD00E3DD
      DD00E3DDDD00E3DDDD0000000000000000000000000000000000B1D1D500A4CA
      CE00A1C9CD0094C1C5004AC5DD0019DAFE001FE0FF0026E4FF0026E4FF0026E4
      FF0027E4FF0003BBF90012C5F7005CB2C40034C3E2003DCAE30042CDE40043CE
      E40044CDE4002BB2DD005CC4E300000000000000000000000000000000000000
      0000F4E37500F4DC5B00C1C0BE00E3E1E100F7F5F500F7F5F500F7F5F500F7F5
      F500E0DFDF00D7D6D600F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500D6D4
      D400E9B96E00EDA73900F7E8D600000000000000000000000000000000000000
      000000000000E8F0F9005097E00056A0EF0057A4F20056A5F1007E99B6006B63
      62003E3635009B95950000000000000000000000000000000000B1ABA9008A81
      7E007C7A7A000000000000000000000000000000000000000000000000000000
      00000000000000000000B6B7B80066676D001A1D27001A1D27003D4047003D40
      470064646A003D4047003D40470064646A003D4047003D40470064646A003D40
      47003D4047006D6D730000000000000000000000000000000000000000000000
      000000000000B8D5D80042B7D10016D6FE001BDCFF0023E2FF0029E6FF002AE7
      FF002BE7FF000CC5FB0009C4FB0061BFD40034C0E1003BC9E30043CEE40046D0
      E4004AD3E50033BBDF003CB5DE00000000000000000000000000000000000000
      0000F4DE7400F4D75C00A6A6A400C8C7C700F7F5F500F7F5F500F7F5F500F7F5
      F500BEBEBC00B9B8B700C4C4C100E3E1E000F7F5F500F7F5F500F7F5F500C2C1
      C100EFBC6D00EBA33700F5E1C800000000000000000000000000000000000000
      00000000000079ADE400569DE8005FA9F30062B0F40061B3F6005FB2F500C0C3
      C800827A7700594E4C00514442007A6E6C008B807E00776D6900746D6B008383
      8300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094969A0054565C00191C2600191C2600191C2600191C
      26004F505800191C2600191C26004F505800191C2600191C26004F505800191C
      2600191C2600595A610000000000000000000000000000000000000000000000
      000000000000A7CBD00055B1C40014D2FD001DDCFE0022E1FF002CE8FF002EE9
      FF002EE9FF0018D1FC0006C0FA0063BDD1003AB7D8003FCAE20048D1E4004AD1
      E4004CD4E40041C6E0003CB4DE00000000000000000000000000000000000000
      0000F3D37100F4CE5100DEDBD500F7F5F500F7F5F500F7F5F500F7F5F500C4C4
      C100D9D7D600F7F5F500DEDCDB00BBBBB700BDBEBA00F7F5F500F7F5F500F7F5
      F500D49D4B00E89E330000000000000000000000000000000000000000000000
      000090BBE8005196DF005DA3ED0069B3F4006FBDF5006FC1F8006BBFF700D7EA
      FA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F2F2F200F4F4F400F8F8F800EAEAEA00E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500EAEAEA0000000000000000000000000000000000000000000000
      000000000000A3C8CE0070AAB30022C7EF0017D6FE0023E1FF002CE8FF0032EB
      FF0033ECFF002DE6FE0007C0FA006FB6C8006EA7B1006BA5AF006BA5B00069A4
      AF00689CAB00E1EBED0000000000000000000000000000000000000000000000
      0000F5D99200F3C44400E6DABE00EAE8E800CFCECE00F7F5F500C7C6C300D9D7
      D600F7F5F500F7F5F500F7F5F500F7F5F500F3F1F100E3E1E100C2C1C100DEDC
      DA00E89D3300E7A4480000000000000000000000000000000000000000000000
      0000599ADE005092D70063ABEF0071BBF40078C5F6007CCBF8007DCEF900AED4
      F300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EAEAEA00D4D4D4008B8B8E00E2E2E200EAEAEA00EAEAEA00C8C8C8009C9C
      9D00E2E2E200F3F3F30000000000000000000000000000000000000000000000
      000000000000A6C8CF006CA9B20070ACB4005DB1C10059B6C70057B3C4004EA9
      BD00A9E4EC00CCF9FD000000000086B5BD0071AAB3006EA8B1006FA8B1006EA9
      B1005F97A700B3CDD50000000000000000000000000000000000000000000000
      0000F8E8CC00F2BD4300E7C37600CFCECE00C2C1C100BFC0BD00DCDBD900F7F5
      F500F7F5F500F7F5F500F7F5F500F7F5F500F7F5F500EAE8E800C2C1C100CFB2
      8800E5993000ECBA790000000000000000000000000000000000000000000000
      00006B8DB2003150730065B5F1006DBEF70078C7F80090D5F80091D9F900ABCB
      E200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F2
      F200AFC9DE00BDB9BA0086858700CCC7C800E5DFDF00E5DFDF00A29FA0008685
      8700D8D3D300EAE5E50000000000000000000000000000000000000000000000
      000000000000AECCD30068A5B0006EAAB40071ACB50073ADB60070AAB4005C96
      A800AAC8D100000000000000000089B5BE006CA7B00071ABB30072ABB40074AD
      B500639BA90086AFBC00E6EFF100000000000000000000000000000000000000
      000000000000EFBA5F00F2B24100E1CDAF00F7F5F500D6D6D400CFCECE00F7F5
      F500F7F5F500F7F5F500F7F5F500EAE8E800EAE8E800F7F5F500DED8D100DE97
      3600E3942C00F9EFE30000000000000000000000000000000000000000000000
      00002F486900233448004A86BC005799CF005C9ECF00679CC10079BFE9009BAC
      BC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B2B3
      B50056585D0096939700D3CFCF00D3CFCF00D3CFCF00D3CFCF00D3CFCF00D3CF
      CF00D3CFCF00E0DDDD0000000000000000000000000000000000000000000000
      000000000000BCD5DB0067A4AE006CA9B30073ADB50076B0B60076B1B700619A
      AA008EB5C100000000000000000093BAC3006AA4AF0070AAB20075ADB50077AF
      B7006AA2AE006297A700BED5DB00000000000000000000000000000000000000
      000000000000F8EAD700F1AD3E00ECAD4400E1CFB400DCDBDB00B4B3B300F7F5
      F500CFCECE00B4B3B300F7F5F500CFCECE00DCDBDB00E6E2DE00DDAF6B00E49B
      3A00EEC593000000000000000000000000000000000000000000000000000000
      0000223E6000203043002B3E5600293B520021364F00293F5900384E6800939D
      A900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BABB
      BD0035384000191C2600191C26004D4E5600191C26004D4E5600191C26004D4E
      5600191C260075767B0000000000000000000000000000000000000000000000
      000000000000E5EEF0007CADB90079AFB7007EB4BB0080B5BB0083B7BD0075AA
      B40096BAC6000000000000000000BFD5DB0073A8B3007CB1B90080B4BA0082B6
      BB007DAFB7006D9FAD00BAD1D800000000000000000000000000000000000000
      00000000000000000000F5D8B100EFAA3C00EFAB3E00D2AF7800DDD8D100F7F5
      F500CFCECE00C2C1C100F7F5F500E6E4E300D4C8B100E7BD7A00EAB36200ECBF
      8300000000000000000000000000000000000000000000000000000000000000
      00004357700020304300273A51002A405A00244061001D3E64002D47660096A1
      AF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EEEE
      EF00CACACC00C0C1C400C0C1C400CFCFD100C0C1C400CFCFD100C0C1C400CFCF
      D100C0C1C400DEDEDF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F5DDBD00EAA64200ECA53800EBA63E00D4A1
      5400D6AD7200D6B27C00E1BD8700E8C18000F0C88300EDBD7300F0CDA0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D4D8DD004C5B6E00283D54002D456100304F750031547F002F486700AEB6
      BF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1CB9700E8A64A00E69B
      3100E5993000E69D3900E8A94F00E8B06200EFCC9A00F9EFE300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BAC1C8005F6F830062758E006F809700AEB6BF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F5E1C800F5E1C800F9EFE300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F6EFE300E6D1AA00DDBE8600DBB57100DDB8
      7400DCB77400DAB57000DABC6D00E8D2AD00F3E9D90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000050515400414346004043
      4700515354000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003F4041004447
      4B00414346005B5E5F0000000000000000000000000000000000484A4C004245
      47003A3D41007374760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D8D9D9003638
      3B0045484D0041424600686A6C00000000000000000000000000000000000000
      000000000000FAF5EE00E4C89600D7B16B00DAB57000E0BB7900E6C28200E9C5
      8600E8C38400E5C07F00D9BE6400E0BA7800DCB67300E1C49000F5EEE1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004044
      4900515353000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000036393900464A
      5000000000000000000000000000000000000000000000000000000000000000
      0000393D41007878780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D3D3D3002628
      2A0051555C000000000000000000000000000000000000000000000000000000
      000000000000F1DFBF00D9B36E00D8B26C00DDB77400E4BF7E00EAC68700EDC9
      8C00EBC78900E4C87800E4CD6500E3BE7D00E1BB7A00DFBA7800DAB77700F6EF
      E300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004044
      4900555858000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003D3D3F00464A
      5000000000000000000000000000000000000000000000000000000000000000
      00003A3C41007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D3D3D3002D2F
      3100565960000000000000000000000000000000000000000000000000000000
      000000000000F0DEBE00D8B26D00D8B26C00DEB87500E4C07F00EAC68900EDC9
      8B00EBC78800E0CF6700EAD57100E0BD7700E2BC7B00E3BD7C00E2BD7C00E8CD
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004144
      4900565757000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003D3D3D004549
      4F00000000000000000000000000000000000000000000000000000000000000
      00003A3C41007C7C7C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D3D3D3002D2F
      3100565A60000000000000000000000000000000000000000000000000000000
      000000000000F1DFBF00D9B36F00D8B26C00DEB87500E5C18100EBC78A00ECC8
      8B00E3CD7700E4D46F00EADE8E00E1C47400E0BB7800E2BD7B00E5C07F00ECD3
      A700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D6D6D600EBEBEB0000000000000000000000
      000000000000000000000000000000000000EEEEEE00D3D3D300000000000000
      0000000000000000000000000000000000000000000000000000000000004144
      4900555858000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003D3D3D004549
      4E00000000000000000000000000000000000000000000000000000000000000
      00003A3C41007C7C7C000707E3000A0AE4000A0AE4000A0AE4000A0AE4000909
      E3000909E3000909E3000909E3000909E3000A0AE4000808E4002929DF002D2F
      3100565A60000000000000000000000000000000000000000000000000000000
      000000000000F1DFBF00D9B36F00D7B16C00DEB97500E6C28200ECC88B00E8CB
      8200ECDF7600E2DDA000E9E0A700E2CA7000E1C17300E4C67400E4C07D00F1DF
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BAB9B9006767690065666800CFCFD100AEAEAE00AEAE
      AE00C5C6C600DADADA00DADADA00D6D6D7007F7F80005E5E61009D9D9F00DADA
      DA00DADADA00ECECEC0000000000000000000000000000000000000000004144
      490055565800000000000000000000000000D8D8D800D1D1D100CECECE00CDCD
      CD00CBCBCB00CDCDCD00CECECE00D2D2D200D9D9D900D6D6D6003B3C3C004347
      4D00000000000000000000000000000000000000000000000000000000000000
      00003A3D41007B7B7B00CCD5FC00CCD5FC00CCD5FC00002CEE00CCD5FC00002D
      EE00CCD5FC00CCD5FC00CCD5FC00CCD5FC00002CEE00002CEE002247E7002C2E
      300055595F000000000000000000000000000000000000000000000000000000
      000000000000F6EBD800DBB67200D7B16C00DEB97600E8C38500E8C58800E8D3
      7B00EBD98400E2F5EB00EAE3B800EDD97200D3AF6D00DDB87500E2BD7C00F2E3
      C700000000000000000000000000000000000000000000000000EAE8E800E8E5
      E500F8F7F700F8F7F70063646500919294007F7F8100A2A1A300F8F7F700F8F7
      F700F8F7F700F8F7F700F8F7F7009D9C9E0088888A009D9D9F004E4F5200F8F7
      F700F8F7F700EDEBEB0000000000000000000000000000000000000000004044
      4900555555000000000000000000D1D1D100C1C1C100B7B7B700B1B1B100ADAD
      AD00ACACAC00ADADAD00B2B2B200B8B8B800C3C3C300C8C8C800383939004246
      4B00000000000000000000000000000000000000000000000000000000000000
      00003A3D4100797979000082FD00CCE6FF00CCE6FE000082FD00CCE6FF000081
      FC00CCE6FF000082FC00CCE6FF00CCE6FE00CCE6FE000081FD00238CF0002A2C
      2E0055585E000000000000000000000000000000000000000000000000000000
      00000000000000000000E3C28A00D7B16B00DBB67200E1BD7D00DBBD7700E6CB
      7500E7E1B400E4F6F700E3E3C200E3CB6B00D2AD6900DBB57100E0BD7F00FAF5
      EE00000000000000000000000000000000000000000000000000E7E5E50094BD
      DC00E4DEDE00E4DEDE007F7E81007D7E800053545900D7D2D200E4DEDE00E4DE
      DE00E4DEDE00E4DEDE00E4DEDE00CBC6C7005E5F6300707174008D8B8E00E4DE
      DE00E4DEDE00E4DEDE00EAEAEA00000000000000000000000000000000004043
      48005454540000000000D6D6D600C0C0C000A9A9A9009A9A9A00909090008989
      8900868686008A8A8A00919191009C9C9C00ADADAD00BABABA00353636004144
      4A00000000000000000000000000000000000000000000000000000000000000
      00003A3D410079797900CCE3FE00CCE3FE000074FA000074FA00CCE3FE000074
      FA00CCE3FE000074FA00CCE3FE00CCE3FE000074FA00CCE3FE002280EC00292B
      2E0054575D000000000000000000000000000000000000000000000000000000
      00000000000000000000F7F0E400D6B37200D6B06A00CFAE6900DFC26700E1C8
      7900E9F2FA00CDE5F700F7F0D900E7CB7200CEAC6300D9B36E00F0E2C9000000
      0000000000000000000000000000000000000000000000000000D5D4D400A8B9
      C900C4BFBF00DBD3D300DBD3D300B6B1B300DBD3D300DBD3D300DBD3D300DBD3
      D300DBD3D300DBD3D300DBD3D300DBD3D300CEC8C800C2BCBD00DBD3D300DBD3
      D300DBD3D300DBD3D300EAEAEA00000000000000000000000000000000003F43
      48005454540000000000CECECE00B3B3B3009797970082828200757575006D6D
      6D00696969006D6D6D0077777700868686009D9D9D00AFAFAF00333434004044
      4900000000000000000000000000000000000000000000000000000000000000
      0000393C410078787800CCD2FB00CCD2FB00CCD2FB00CCD2FB00CCD2FB00CCD2
      FB00CCD2FB00CCD2FB00CCD2FB00CCD2FB00CCD2FB00CCD2FB001A32E100292A
      2C0054565D000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E3CB9F00D0AD6300DBBE6200B6C0
      B2005197D70060AFE800AFC9C300DEC16600D9BF8900F3EAD900000000000000
      0000000000000000000000000000000000000000000000000000898A8D007071
      75004E4F5500AFACAE00E0D9D900E0D9D900E0D9D900E0D9D900E0D9D900E0D9
      D900E0D9D900E0D9D900E0D9D900E0D9D900E0D9D900E0D9D900E0D9D900E0D9
      D900E0D9D900E0D9D900EAEAEA00000000000000000000000000000000004043
      48005353530000000000C7C7C70046484B006464650072727200616161005757
      570053535300585858004D4E4F003C3D410090909000A8A8A800323333003F43
      4800000000000000000000000000000000000000000000000000000000000000
      0000393C4100787878002929E4002C2CDF002626D9002020D3001B1BCF001818
      CB001515C9001515C9001717CA001A1ACD001E1ED2002020D9003939CE00282A
      2B0052565C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D7DDE1006F7C8F0060646500A1925900558B
      C500488AD0004F9CE10081A6B200949CA000A7B4C30000000000000000000000
      000000000000000000000000000000000000000000000000000096969A008786
      890022252E003E404800C9C6C700D6D2D200D6D2D200E5E0E000E5E0E000E5E0
      E000E5E0E000E5E0E000E5E0E000E5E0E000E5E0E000E5E0E000E5E0E000E5E0
      E000E5E0E000E5E0E000EAEAEA00000000000000000000000000000000003F43
      480053535300DDDDDD0093949600949596009C9D9F006F717300A6A7A800A4A5
      A600A8A9AA00898A8C009D9E9F00949496006B6D6D00A2A2A200313232003E42
      4700000000000000000000000000000000000000000000000000000000000000
      0000393D41007676760000000000CECECE0055585A004F5152005C5E5E004E4E
      500044454500444446004D4D4E003A3C4000676A6A00A4A4A400A2A2A2002729
      2B0052555B000000000000000000000000000000000000000000000000000000
      00000000000000000000C2CCD7002C40590024344A0024354B00315170004B8D
      D7005299E600529BEA004D93DC00304C6E002C415B00A6B1BF00000000000000
      0000000000000000000000000000000000000000000000000000AAAAAD00AAAA
      AD001A1D27001A1D27001A1D27001A1D27001A1D270064656B003E4047003E40
      47003E4047008B8B8F003E4047003E4047003E40470064656B003E4047003E40
      47003E40470084848800EAEAEA00000000000000000000000000000000004043
      490051535300DCDCDC009FA2A2007F809500BABBBC00797B7D00757679008283
      850093949600BDBEBE00C4C4C50085859B00676A6A00A0A0A000313232003E42
      4700000000000000000000000000000000000000000000000000000000000000
      00003A3D410076767600000000009D9D9F008D8E90008B8C8E0081828500D2D3
      D300E1E1E200AFB0B1006F7073009C9D9E00999999009D9D9D00A0A0A0002627
      290051555C000000000000000000000000000000000000000000000000000000
      00000000000000000000C2CAD600233347001F2D3F003946560037608E00549C
      E9005AA5F3005BAAF4005AACF4004886C300213145007E8B9D00000000000000
      000000000000000000000000000000000000000000000000000094969A003D40
      4700191C2600191C2600191C2600191C2600191C26004B4C5300191C2600191C
      2600191C26007D7C8100191C2600191C2600191C26004B4C5300191C2600191C
      2600191C260073747900EAEAEA00000000000000000000000000000000004043
      490051535300DCDCDC00ADAEAF00CDCDCC00E2E2E200E1E1E100E0E0E000E0E0
      DF00DFDFDE00DEDEDE00DEDEDD00CECDCD0074767600A1A1A100313132003E42
      4700000000000000000000000000000000000000000000000000000000000000
      0000393C41007575750000000000A1A1A3009293A800B9B9BB00939496007071
      740075767900AEAFB000AEAFAF00A5A5B0009B9BA5009D9D9D009F9F9F002627
      290051555C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000506174001E2C3E002B3F580065A2E3005CA3
      EE0065AFF40068B7F50066BAF70061B3F5001E2C3E0000000000000000000000
      0000000000000000000000000000000000000000000000000000BFBFC0007475
      7A003D4047003D40470034373F00191C2600191C260050525900191C2600191C
      2600191C260087888D00191C2600191C2600191C260050525900191C2600191C
      2600191C26007D7E8300EAEAEA00000000000000000000000000000000004043
      480053535300DEDEDE00B7B7B700CDCDCC00E2E2E200E1E1E100E0E0E000E0E0
      DF00DFDFDE00DEDEDE00DEDEDD00CECDCD0086868700A6A6A600323333003F42
      4800000000000000000000000000000000000000000000000000000000000000
      00003A3D40007676760000000000C0C1C100D2D2D200E0E0E000E1E1E100E0E0
      E000E0E0DF00DFDFDE00DEDEDD00D8D8D700A8A8A800A3A3A300A2A2A2002729
      2B0052555B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D8DEE400202F42005795D600659FDC0062A9
      F0006EB8F40073C1F60073C5F80070C3F7002A435F0000000000000000000000
      0000000000000000000000000000000000000000000000000000F8F8F800EEED
      ED00F8F8F800F8F8F800EFEFEF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E5E5E500EAEAEA00F3F3F300000000000000000000000000000000004043
      4800535353000000000093949500555553004D4D4C004A494900464646004343
      43003F3F410045444300454443004E50520093959500ADADAD00333434003F43
      4800000000000000000000000000000000000000000000000000000000000000
      0000393D40007676760000000000BBBBBC008586880092939400929395009293
      94009192940091929300919293008E8E900086878800ADADAD00A8A8A8002829
      2B0052565C000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000025364C006FA8E4003F648A0069B3
      F30073BEF5007CC8F70085D1F80081D0F8002F4D6A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F3F3F300EAEAEA00F7F7F700FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00F7F7F70000000000000000000000000000000000000000003F43
      48004D4E4E000000000081848600908F8E00696764005A5959004C4C4E003E3F
      42003032370022242C0021232A002729300092939500BDBDBD002E3030004144
      4A00000000000000000000000000000000000000000000000000000000000000
      0000393D41007373730000000000DCDCDC0068686700696764005A5958004F4E
      4F0043434500393A3D0039393B0048494C0070717300BDBDBD00AFAFAF002324
      26004C5056000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000024354A002B4563003253740064B5
      F20067BBF60076C5F60093D5F6008BD5F80024384D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000494B4F008E8D8C00696764005A5959004C4C4E003E3F
      42003032370022242C00191C26002729300091929400D8D8D800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000072757900737373006E6C69005A5959004B4B
      4D003B3C40002B2D34001C1F280021232C0040424600D0D0D000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D4B5D001F2E400024364B003758
      7C003D5F80003C5D7C004B7192004D7CA0003B49590000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000065676B007A7B7C00696764005A5959004C4C4E003E3F
      42003032370022242C00191C260027293000A0A2A40000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009192950068696A006E6C69005A5959004B4B
      4D003B3C40002B2D34001C1F280021232C006D6F710000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009CA3AD001D2B3C00213245002639
      5000263A51001E3652001C3756003E526C00818C960000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C4C4C5008F969E009898990094959600919193008182
      84007A7B7E0076777B007475790071788200C5C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DADADC006C727B0067686900626365005E5F
      62004B4C500047494D0043454A004C4E53009495980000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004A58670022344700283C
      53002B435F0027466B00244770002E466500CACFD60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EBF2F80000000000DCDCDD00DADBDB00D9D9
      D900D8D8D900E7E8E80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EBEBEC00C2C3C400C0C0
      C100BBBCBC00C7C7C800DEDEDF00F0F0F0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D4D8DD005A697A00293E
      56002E466300314F750032527B006D7C8E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E3E6
      E900C9CED400C9CFD700C9CED500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D7EDFA0092C8F100AACDEE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CCE8F9008DC8F1008ABBE800DDECF8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C8E5
      F80087C7F2006EB8EF00549ADB00A2CAEB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7EBF9008AC5
      EF0062B2EE0071BDF1004992DA004B91D400A6CEEE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC00F0ECE700E6E1D800F8F7F500F7F6F300F6F5F200F5F4
      F100F5F3EF00F4F2EE00F3F0EC00F2EFEA00F1EEE900EFEDE700EEEBE500F5F4
      F000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D2E8F80087C1EE005DA9
      E80070B8F0006FBAF100438AD7003881CF0067A8DD00C1DEF300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E1EFF9009ACAF000529EE4007EB4
      E60092C6EF006EBCF3004B91DC00377BD0003B89D2006AADDF00C2E0F4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F9F8F700D3C9B600CEC3AF00E3DCD100F4F1EC00F3F1EC00F2EF
      E900F0EDE600EEEBE400ECE8E100EAE6DD00E8E3DA00E6E1D600E4DED300EEEB
      E500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EDDBC500DEB78C00EAD1B6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DBEDFA0093C5EF004F9AE10077AEE600CCD9
      E700A0CFF20067B7F100468ADA003B7ED4003985D3003E92D60082BDE7000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E6F3FB00AAD8F7005CA5E500609CDF00B5CFEC00F9F2
      EB00B7D9EF0067B9F2004B91DC003B7DD4003D85D600398AD4004097D70095CA
      EC00000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00F0ECE600C7BBA300E5DFD400ECE8E000ECE8E100F5F3EE00F4F1
      EC00F2EFEA00F0EDE700EFEBE400EDE9E100EBE6DE00E9E4DA00E7E1D700F0ED
      E700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EDDBC500D1791900C9761A007B532900ECF2
      F600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E5F2FB00A6D6F6006EBBF0004F97E000ACC3E500F7F4F100FFF9
      ED00A4D2F30066B5F0004589D9003C7ED4003F87D6003D8CD7003C93D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B2D9F5006EB7EE006EBDF300529AE200CAD6E600FFF9EE00FEF5
      EC00A6D1F20066B7F200498EDB00397AD3003E85D600408ED9003B90D60065AF
      E100000000000000000000000000000000000000000000000000000000000000
      0000FCFBFB00D6CDBB00D5CCBA00F4F2ED00FCFBFA00E6E1D700F3F1EC00EBDB
      C700DAB18300E9D7C300F1EDE700EFEBE400EDE9E100EBE7DE00E9E4DB00F1EE
      E900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F9C58900FF941500FB9B2A00616F770079AB
      CF0094BAD500C8DBE90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ACD6F40065AFEA0066B3EF006CBCF2005C9EE100EBE8E600F8F1E800C9DB
      EC007CC0F30064B4EF003E84D700397BD3003E85D6003F8DD7004095D8000000
      000000000000000000000000000000000000000000000000000000000000BEDE
      F6006CB1E90066AAE70080BCEF006DBDF400579EE300D3D8E200DFE2E70090BF
      EA0068B7F2007BC2F4004F94DD00367CD4003C82D4003F8BD7003D91D7006CB3
      E300000000000000000000000000000000000000000000000000000000000000
      0000F1EFEA00C9BDA600E8E3D900FCFCFB00F3F0EA00D5CCBA00EEE2D400DC7F
      1700D1791900D19A5D00F2F0EA00F1EEE800EFECE500EDE9E200EBE7DF00F2F0
      EB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDCC8C00FFAD3F00FFCC8800B6B09A0096CC
      EB006EB1D8001698D2002FA5D700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDDCF50065AB
      E8005DA3E400ABCAE6009ACCF10066BAF3005E9FE100C4CFE1008FBAE70059A9
      EB0079C3F500A5D5F70070ABE500418AD8003B84D5003E8AD7003E93D8000000
      00000000000000000000000000000000000000000000000000007BB5E9005399
      E00091BBE800E4E6EA00B6D6EE0068BBF500579DE20086ACDF0060A5E6005FB1
      EF009BD3F700BDE3FB00ADD5F50070ADE600438FDB003E8AD8003B8ED5006BB2
      E30000000000000000000000000000000000000000000000000000000000FCFC
      FC00DED7C800D9D1C100F6F4F100FBFAF800EAE5DC00F8F6F300FBE0BE00FFA0
      2A00F09F3F00D5A36B00F4F2ED00F3F0EB00F1EEE800EFECE500EDEAE200F3F1
      ED00000000000000000000000000000000000000000000000000000000000000
      0000EDDBC500EDDBC500EDDBC500F6BF7100FFB23F00FFCA7B00BF80370093DA
      F9001BB8EF0000A5E4000093D2002FA5D7000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004F99DF0088B0
      E100E2E8F000FFF8EC00A7D2F10066B9F3005498E0005496DF005BABEC0098D1
      F600B9E1FB00ABDDFB00B6E1FC009ECCF2005EA4E2004090DA003D91D7000000
      00000000000000000000000000000000000000000000000000006AA3E000B7CB
      E600FFF9F000FFF8EC00B1D6F10069BBF300529EE4004E9BE40082C4F200B5E0
      FA00AEDDFA008CCEF80098D5FA00B5E0FB009BCCF1005DA6E3003E93D9006BB1
      E30000000000000000000000000000000000000000000000000000000000F7F6
      F300CEC4AF00ECE7DF00FDFCFB00F9F7F400FCFCFB00FCFBF900FCE4C100FFAF
      3F00F0B16000DCB38600F6F4F000F4F2ED00F3F0EB00F1EEE800EFECE500F4F2
      EF0000000000000000000000000000000000000000000000000000000000E9C2
      8E00E09D4200E09A3900E0973000F0A12800FFB73F00FFCC7900E09C410035C5
      D80000CCFC0000B6F20000A5E4000093D2002FA5D70000000000000000000000
      00000000000000000000000000000000000000000000000000005FA0E000E4E4
      E800FFF7EB00E5E8EC008BC6F30068B9F10058A5E70080C1F100B2DFF900ABDB
      FB008CCDF7007FC8F60085CBF700A2D9FA00B3DDF90087C2EE0051A2E1000000
      000000000000000000000000000000000000000000000000000075ABE300D8DD
      E400F1ECE700B2CFEB0077BBF1006FBDF20062ADE900A2D6F900B3DFFC0091CE
      F7007FC6F60081C7F60080C7F60083C8F700A0D6FA00AEDBF90080BFED006CB2
      E50000000000000000000000000000000000000000000000000000000000DED8
      CA00DDD6C700F8F7F400FEFEFE00E7C08D00E0A55600E0A45600E7A64A00FFB6
      3F00F3B55700D8923900DEA25400DEA25300E8CEAC00F3F1EC00F2EFEA00F5F4
      F10000000000000000000000000000000000000000000000000000000000FDE0
      A700FFD98D00FFCF7200FFC65700FFBC3A00FFBD3F00FFD07700FFD78900CFCD
      880010CDF20000CCFC0000B6F20000A5E4000093D2002FA5D700000000000000
      000000000000000000000000000000000000000000000000000063A2E100D4D9
      E200B4CCE8006FB2ED006CBCF40070BCF00068ADE700A1D3F7008ECCF8007DC4
      F6007FC5F60081C5F60080C5F6007DC3F60084C7F700A1D5F900A1D4F5000000
      000000000000000000000000000000000000000000000000000075A9E200A3BD
      E00080B3E6005CADEE0068B9F10074C0F30059A1E0006BADE40075BBF1007EC1
      F5007FC1F5008FC7F100C4D5DB00B9D2DE007CBEF10084C6F500B7E0F900D0E9
      F900000000000000000000000000000000000000000000000000F9F7F600D2C7
      B400F1EEE800F5F3EF00F6F5F200FDD38200FFD58300FFC96200FFBE4100FFBC
      3F00FFD68800FFD38000FFC75F00FFBB3E00FBD38C00F7F6F300F4F2EE00F6F5
      F200000000000000000000000000000000000000000000000000000000000000
      0000FDECCA00FDECCA00FDECCA00FDD57E00FFC33F00FFCC5A00DA9C4900FDEC
      CA00CDE6D2000ECEF80000CCFC0000B6F20000A5E4000093D2002FA5D7000000
      00000000000000000000000000000000000000000000000000005C9DDF006FA2
      E0005CA8EA005CB0EE0065B4EF0072BDF1004A93DA00418ED40061ACE7007ABD
      F3007DBEF5007BBDF40079BCF40076BAF30079BDF20095CEF500D6EEFB000000
      00000000000000000000000000000000000000000000000000006AA4E200569C
      E20056A9EB005AABEA0068B1ED0074C0F4004E97DD00337DCD004795D70064AE
      E80094C5EA00BFC5DA00524DDE006E68DC00C0CFD900C4E2F200EFF7FC000000
      0000000000000000000000000000000000000000000000000000E1DACF00E8E3
      D900FAF9F800FDFEFE00FEFEFE00FFF7E500FFEECB00FFEECB00FFD87F00FFC4
      3F00F3B94800E8B97600FFEECB00FFEECB00FFFBF200FCFBFA00F5F4F000F6F4
      F20000000000000000000000000000000000000000000000000000000000E6C6
      9C00D1892300D1892300D1882300E8A82D00FFCA3F00FFCE5000D1882200D188
      2200D1882200AA9A56000DCDF70000CCFC0000B6F20000A5E4000093D2002FA5
      D7000000000000000000000000000000000000000000000000005AA4E40052A2
      E70051A2E70077B0E6008BC3EF006FBDF3004B92DC00367AD0003B8AD100A4C3
      D300D5BE6300D4BF6900D3BF6A00D5BE6700DFC26400EDEDE500000000000000
      000000000000000000000000000000000000000000000000000071B3EA004F9F
      E5005FA2E400ADCAE700B6D5ED0071C0F5004F97DF003C7DD5003A83D2007EB1
      D400B3B8D900332BDF000800DD000800DE004841E000CBCBD800F4F4F0000000
      0000000000000000000000000000000000000000000000000000F0EEE900FCFB
      FA00F8F6F400FCFBFA00FCFCFB00E8BD7500E0A64600E0A43C00F0B73800FFCC
      4000F7C54B00E0A64500E0A33A00E0A03000F0D2A100FCFCFB00F7F5F100F7F5
      F20000000000000000000000000000000000000000000000000000000000FDEA
      AE00FFEDB400FFE59200FFDD7100FFD54F00FFD14100FFD96000FFECAF00FFE3
      8D00FFDB6C00FFD24900CADBAB000FCFFB0000CCFC0000B6F20000A5E4000093
      D2002FA5D70000000000000000000000000000000000000000005CA6E5005C9C
      E000A7C7EA00F0EEEA00B8D9F00068B9F2004D92DC003C7DD4003E86D600B0C4
      C600E1A70000E2A90100E2AA0500E1A80100E1A80100F6EFDA00000000000000
      000000000000000000000000000000000000000000000000000067A6E30083AD
      E100E2E7EF00FFFBED00C8DFEF006DBEF4004F96DE003C7DD40091B4D300A0A1
      DC001F18E0000B00DE001908DF001807DF000600E2002D28E200B6B5D800F3F2
      EA00000000000000000000000000000000000000000000000000FCFAF900FAF9
      F600F7F5F100FCFAF800FCFBFA00FFEBA400FFE78F00FFE07100FFD95300FFD5
      4300FFDE6B00FFE68C00FFDE6E00FFD75000FEEAA900FDFCFB00F8F6F200F8F6
      F40000000000000000000000000000000000000000000000000000000000FDF6
      DA00FDE99F00FDE99F00FDE99F00FDDC5800FFD94300FFD94300E5B44800FDE8
      9E00FDE89E00FDE89E00FDF8E600CEF4FD000FCFFB0000CCFC0000B6F20000A5
      E4000093D200439EC5000000000000000000000000000000000061A3E300C2D0
      E600FFFAEE00FFF7EB00AAD3F20077C0F3006AA2E100588ED8005A98DC00BBCB
      CA00E2AC0D00E3AE0F00E3AF1200E3AD1000E2AB0B00F4ECD300000000000000
      0000FBF9F40000000000000000000000000000000000000000006CA7E300C4D2
      E500FFF8EA00E3E6EA0096C8F1006ABCF2005095DB009EB7D2008481E000110A
      E3000D00E0001706E0001606E0001406E1001504E2000900E3001916E6009998
      D900EFEFE6000000000000000000000000000000000000000000FAF9F700F9F8
      F500F7F5F100FBFAF700FCFAFA00FDFCFC00FEFEFE00FFFFFF00FFEFA200FFDF
      4600F0C33B00D49E6300FEFDFD00FDFDFC00FDFDFC00FDFCFC00F8F6F300F8F7
      F400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FDE77400FFE24800FFE14800C5791E00E6C8
      A80000000000000000000000000000000000CEF4FD000FCFFB0000CCFC0000B6
      F2000D93C700626C73000000000000000000000000000000000064A6E400D4D9
      E300E6E6E7009DC5EB006AB7F200D9E6E900E5C36000DDB95300DDBC5C00E2B8
      4400E2AA1000E3AB1000E3AA1100E3AB1000E3AD0F00E3BC4500E7C76900E7C5
      6100E7C46700EEDFC000000000000000000000000000000000006EA8E300B6C8
      E000B6CDE60068ACEA0063B5F100A3D3F100BCCBD7006966E4000701E4001100
      E2001604E2001504E2001504E2001304E2001402E3001402E4000A00E5000D0B
      E9008886DD00EBEAE200F9F9F800000000000000000000000000F8F7F500F7F6
      F300F7F6F200FAF9F700FBFAF800FCFBFA00FDFDFD00FEFDF300FFED6300FFE9
      4D00FFEB6600D8A13B00D8A67000FDFDFC00FDFCFC00FEFDFD00F8F7F400F9F8
      F600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDF6BC00FFEB4E00FFEA4D00FFED6B00F3D75F00C57A
      1E00E6C8A80000000000000000000000000000000000CEF4FD000FCFFB0004AA
      D300525F6A00000000000000000000000000000000000000000065A7E30091B2
      DF0069A8E6005AADED0091CEF600DEEEF700E2C16E00E39E0000E29A0000E39E
      0600E4A01000E4A01000E4A01000E3A41200E3A91100E2A90700E2A80000E2A6
      0000E1BF5E00F0EADB00000000000000000000000000000000006CA6E3005C97
      DD0053A1E7007AC1F200B3DEF900CAD2E5003E3AE5000000E4000000E3000600
      E4001200E3001401E4001401E4001202E5001301E4000E00E6000200E6000000
      E7000000E9006F6CE000E9E8E400000000000000000000000000F7F5F200F6F5
      F000F5F3EF00FAF9F600FAF9F800FCFAF900FDFCF200FFF77400FFF45F00FFF3
      5400FFF56D00FFF79900D8A43F00CC8C4500F9F3ED00FEFDFC00F8F8F500FAFA
      F800000000000000000000000000000000000000000000000000000000000000
      000000000000FDFAC800FFF45400FFF45E00FFF35300FFF46000FFF79800F3DD
      6600C57A1F00DAAE7E0000000000000000000000000000000000CEF4FD00E5F2
      F5000000000000000000000000000000000000000000000000005EA3E3004B95
      E10077BDF000B0DDF900B4E0FA0092D2F800B4D5EB00DFC69500E99E1600E693
      0500E5981100E5971100E5971100E59C1200E49F1100E3A10900E5A90900DAC1
      7C00ECEEF400000000000000000000000000000000000000000064A8E50063AC
      EA00A0D5F600B7E0FA009AD4F900C1D6F500767EEF00787FEF008186EE006B6C
      EA00170AE6000F00E7001200E7001101E6000C00E7002D22E500908DEB009995
      ED008F8DEC00A9A6ED00F4F4F400000000000000000000000000F6F4F100F6F4
      F000F6F4F000F9F8F500FAF9F600FBF9F700FEFD8C00FFFD6E00FFFE7200DCAE
      4100FFFC7800FFFD7600FFFDA700D8A64300CC8C4500F9F4EE00F9F8F600FBFA
      FA00000000000000000000000000000000000000000000000000000000000000
      0000FDFDDE00FDFA6200FFFC7600FFFC6B00DCAD3500FAF06700FFFB6700FFFC
      A400F3E26D00C57B1F00D6A56F00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006BB3E90098CF
      F500B0DDFA0097D2F80080C7F60081C8F60080C7F600A0CBEB00D9CBB300EA9B
      2600E88B0100E7911000E7901100E7961300E6940400E79F1400DCC69900EBED
      F100000000000000000000000000000000000000000000000000A9D6F500ADDB
      F80098CEF60080C5F5007DC4F50089C9F50089C8F50083C5F5008ACAF600B8D3
      F600231AE7000D00E7001300E7001302E6000400E600615DE900FBFBF9000000
      0000000000000000000000000000000000000000000000000000F5F2EE00F5F3
      EF00F5F4EF00F9F7F500FAF8F600FDFC9500FFFF7000FFFF9600DCAF4600F2E2
      D200FCFCF100FEFE7900FFFF7C00FFFFB300D8A74600D8A67000FAF8F600FBFB
      FA0000000000000000000000000000000000000000000000000000000000FDFD
      E900FDFD6300FFFF7600FFFF8A00DAAD4200E6C8A80000000000FDFD7800FFFF
      6B00FFFFAE00F3E57200C57B1F00DAAE7E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D4EBFA00B6DE
      F8007CBFF20075BDF3007EC1F5007FC2F5007FC2F5007CC1F5008DC2ED00D0CE
      CA00E99E3F00EA830100E98A1000E9890300E89B2700DACBB300F0F2F8000000
      0000000000000000000000000000000000000000000000000000F3F9FD00D6EC
      FA0093C9F10077BBF10077BBF3007BBEF4007BBEF40078BCF30075BBF200AACE
      F300120DE6000000E6000400E6000400E6000000E5005451E700FCFDFB000000
      0000000000000000000000000000000000000000000000000000F3F0EB00F4F2
      EE00F4F3EE00F6F5F100FBF9CE00FFFF6900FFFFB400EFDB7600F5EADE00FCFB
      FA00FCFBFA00FCFBEF00FEFE7900FFFF7A00FFFF7400DBAF7D00F9F8F400F9F8
      F70000000000000000000000000000000000000000000000000000000000FDFD
      7800FFFF7300FFFFA500E9D15A00F1E3D300000000000000000000000000FDFD
      7800FFFF6C00FFFFB600F0DC5E00CF9353000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFF7
      FC00BEE1F80083C2F20072B6F10075B8F30075B7F20073B8F20083C4F400BBDC
      F300D6D7D900E8A15400ED7E0100E89C4100DED7CF00F4F5F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEF7FC00BBE0F8007FC0F2006FB2F0006EB1F00079BCF200A4D6F600DFEA
      F6007D7CEB007575EC007977EC007977EC007371EC00A6A5ED00FCFCFA000000
      0000000000000000000000000000000000000000000000000000F1EEE800F3F1
      EC00F4F2EE00F5F3EE00F6F5DC00FEFD7C00F4E99C00F3ECE300F7F6F300F8F7
      F400F9F7F500F9F7F500F8F8EA00FDFD8C00F2E38A00F6F0E700F7F5F200F7F6
      F300000000000000000000000000000000000000000000000000FDFDD500FFFF
      5B00FFFFBE00E9D16F00F1E3D300000000000000000000000000000000000000
      0000FDFD7800FFFF6800F7ED5900EAD1B6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E0F1FB00A0D3F60073B8F00074B7F100A0D5F600DBF0FB000000
      0000F7F7F800DFDDDE00E6C3A300E3DEDB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DCF0FB009BD1F5008FC9F300CAE9FA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFECE500F2EF
      E900F4F1EC00F4F2ED00F4F2ED00F5F2EF00F5F3EF00F6F4F100F8F6F300FAF9
      F700FBFAF800FBFAF800FCFBF900FDFCFB00FCFBF900F7F6F300F2EFE900F3F1
      ED0000000000000000000000000000000000000000000000000000000000FDFD
      A100FDFD9700F9F4E50000000000000000000000000000000000000000000000
      000000000000FDFDAC00F9F4D100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EDE9E200EFEC
      E500F1EEE800F2F0EA00F4F2ED00F4F2EE00F6F4F000F7F6F300F9F8F500FBFA
      F800FCFBF900FCFCFB00FDFDFC00FBFBF900F7F5F200F0EDE700E8E3D900EEEA
      E400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F8F7F500F9F8
      F600F9F8F700F9F9F700FAF9F700FAF9F700FAF9F800FBFAF900FBFBFA00FCFB
      FB00FCFCFB00FCFCFC00FCFCFB00FBFBFA00FAF9F700F8F7F400F5F4F100F8F7
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEDDDC00D1D1D100EBEBEB00000000000000
      000000000000CBCBCB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C1C1C100E1DFDC00D9D8D800BDBDBE00DDDDDE000000
      0000A2A2A20095959500AFAFAF00C2C2C200D6D6D60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BECEC30061B57C0065B983006CBF8B0071C3
      920074C797005EBE8A008ABFA400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D8E1DA0071AD
      83006CAC8500CCD9D10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EAEAEA00CFCFCF00D4D4D400CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCD
      CD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CDCDCD00CECECE00D2D2D200D8D8
      D800000000000000000000000000000000000000000000000000000000000000
      000000000000B9B9B900DAD8D600DEDDDA00DBDAD900E4E4E500BEBFC0008F8D
      8F00A6A6A800D1D0D000FFFFFF00FFFFFF00DEDEDE00BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005CB0750006C145000CC44E0019CE5C0037DB
      78004BE88A0028D1770014A15E00D4E4DD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000419B590018B1
      3F0029B35D00319B600000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DDDD
      DD00D5D5D500E6E6E600E9E9E900E9E9E900E9E9E900E8E8E800E8E8E800EAEA
      EA00EAEAEA00E9E9E900E8E8E800E8E8E800E9E9E900E9E9E900E8E8E800E5E5
      E500C8C8C8000000000000000000000000000000000000000000000000000000
      0000C4C4C400D3D1CF00E0DEDC00CECCCB00DFDEDC00F0EFEE00EEEEED00C3C2
      C300A0A1A000E4E4E100F3F3F200F8F8F800FFFFFF00FBFBFB00BCBCBC00E5E5
      E500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005DB4780000BC3F0000BF430000C7480018D2
      630029E074002FD780001AAB6B00D3E5DD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063A2750017B23F0003A5
      2E002BB856003EC379004DA67900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0E0E000D5D5
      D500F4F4F400E6E6E600E6E6E600E6E6E600E9E9E900EFEFEF00EFEFEF00E9E9
      E900E7E7E700EBEBEB00EFEFEF00EBEBEB00E7E7E700E6E6E600E6E6E600EBEB
      EB00F6F6F600C5C5C5000000000000000000000000000000000000000000DADA
      DA00C6C6C400E2E1DF00CDCBCA00CFCECE00E8E8E600EDEDEC00F2F0EF00EFEF
      EE00D1D1D000C9CBC800DDDDDC00ECECEB00F6F5F500FFFFFF00FFFFFF00D9D9
      D900C4C4C4000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005EB47C0000BD410000C0470000C84A0015D3
      62002DE077003ADD8A001BB17200D4E6DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082A98D0019AE400005A8300000A9
      300015B74A0046CA740043CD880071B593000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D2D2D200EFEF
      EF00E6E6E600E7E7E700E6E6E600EEEEEE00EBEBEB00C0C0C000909090007F7F
      7F008383830091919100AFAFAF00DCDCDC00EFEFEF00E8E8E800E7E7E700E6E6
      E600EFEFEF00DADADA00D1D1D10000000000000000000000000000000000BBBA
      B900E4E1E000CDCBCA00CBC9C900E1E0DF00EBEBE900ECEBE900EEEDED00F6F6
      F400F9F8F800E7E7E600D4D5D300DADAD800E8E8E700F3F3F200FCFCFC00FFFF
      FF00E0E0E0000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005FB67E0000BE420000C2470000C94C000FD3
      5E002EE278003DE190001CB77800D4E6DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A9C0B0001DA9410009A9330000A8310000AF
      360015BB4D0027C55E005AD88B0037CB8B0097C0AD0000000000000000000000
      0000000000000000000000000000000000000000000000000000E2E2E200EBEB
      EB00E8E8E800E7E7E700F1F1F100DDDDDD007D7D7D004E4E4E005E5E5E007C7C
      7C008989890080808000727272007F7F7F00BEBEBE00F0F0F000EAEAEA00E8E8
      E800EAEAEA00E4E4E400D0D0D000000000000000000000000000CDCDCD00DCDA
      D800CFCDCD00C7C5C500DADAD900E9E8E700E8E7E600ECECEA00F4F3F200EAE9
      E800F1F1F000FEFDFC00F8F7F700E7E7E600DEDFDD00E3E4E100F5F5F300E7E7
      E600B0B0B100D7D7D70000000000000000000000000000000000000000000000
      000000000000000000000000000063B8800000BF420000C2470000C94C000AD2
      5A002CE1760036E18F001CB97F00DFEEE8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6D2C90028A047000DAC360000A62F0000AF370000B3
      3A0011BF4D002ACA660031D06B005DE29A0029CB8A00BDD0C700000000000000
      0000000000000000000000000000000000000000000000000000E1E1E100ECEC
      EC00EAEAEA00F0F0F000E1E1E100646464003A3A3A0080808000CFCFCF00E9E9
      E900EFEFEF00E8E8E800C3C3C3008888880072727200B7B7B700F1F1F100EAEA
      EA00ECECEC00E4E4E400CECECE00000000000000000000000000CDCDCD00CFCD
      CD00C7C6C700D6D5D400E6E5E400E6E5E400EAE9E900F2F2F000A2A0A0007170
      700092908F00BDBCBB00EFEFEE00FFFFFF00F6F6F500EEEDEC00C5C5C5009190
      92009B9B9B0000000000000000000000000000000000BAD0BC009FC2A400A3C6
      AA00A6C8AF00A8CBB300A2C8AE003BAF620005BE430000C1460000C94C0007D1
      58002AE0750033E3870014CF7D0082D5AF00AFDFC900AFDFCB00B4E0CF00AAE0
      CE00A9DDCC00D9E7E20000000000000000000000000000000000000000000000
      000000000000000000003D9B520012AD390000A42C0000AB340000B33A0000B8
      3E000DC24E002BD06A002ED470003EDC7B004BE8A0002CCA9200DAE7E3000000
      0000000000000000000000000000000000000000000000000000E2E2E200EDED
      ED00EDEDED00F3F3F3007E7E7E002C2C2C008B8B8B00FAFAFA00FFFFFF00FDFD
      FD00FAFAFA00FFFFFF00FFFFFF00E2E2E2008E8E8E0074747400CFCFCF00F3F3
      F300EDEDED00E5E5E500CFCFCF00000000000000000000000000CECECE00BFBD
      BE00D9D8D700E5E4E200E4E2E100E5E5E300F3F3F200999998002C2B2D003B3A
      3B00535253006665640086858400C8C7C700FEFEFD00FFFFFF00E5E5E5009D9D
      9F00AAA9AA00CDCDCE0000000000000000000000000032994000109327000A95
      260011A0320016A93E001DB3480014B8480001B83E0000C0460000C84C0005D1
      560027DD73002FE57D003FEC890059EE9A0074EFAB008CF2BB00B1F5CC0071F6
      C2000DEFA7006CD8B60000000000000000000000000000000000000000000000
      0000000000005596630016AD3A0001A12A0000A8310000AF380000B73E0000BD
      42000AC64F002AD26D0031D9750036DF7C0046E589002CF1A40040C99B000000
      0000000000000000000000000000000000000000000000000000E3E3E300EFEF
      EF00F5F5F500CDCDCD00353535005D5D5D00F5F5F500DDDDDD0091919100EAEA
      EA00FFFFFF00BABABA00C6C6C600FFFFFF00D4D4D4007777770099999900F1F1
      F100F0F0F000E7E7E700D0D0D000000000000000000000000000D0D0D000CDCC
      CC00EBEAE800E3E2E000E4E3E100EDECEB00BAB9B9004A4749003B3A3C003433
      3700302F3200454445005E5B5C006C6A6A00AFAEAE00F9F9F900FFFFFE00FFFF
      FF00F6F7F600D7D6D7000000000000000000000000007EA4800018922B000897
      23000097200000A0290000A72E0000AF350000B83E0000BF440000C64A0003CE
      530025DA710030E37C003EE989005BEC9A0076EFAB0094F2BA009AF5C60025FF
      C0004ECFA600D3E8E10000000000000000000000000000000000000000000000
      000075A37E0019A73700049F290000A32C0000AC340000B23A0000BA410000C0
      450009C952002AD66F0031DD780037E3810042E8880051EB990013F9AB0065C7
      A700000000000000000000000000000000000000000000000000E4E4E400EFEF
      EF00FBFBFB009696960024242400AFAFAF00FFFFFF008B8B8B00333333007F7F
      7F00A6A6A6007D7D7D0098989800EFEFEF00FDFDFD009797970078787800E1E1
      E100F5F5F500E8E8E800D0D0D000000000000000000000000000D9D9D900DBDB
      DA00F7F6F500EBEAE700E6E6E400C4C2C100716E6E0063616100585657005C5A
      5C00858487004443460036353700504F50005D5B5B00B7B6B500FFFFFF00FDFC
      FC00FFFFFE00FCFCFC000000000000000000000000000000000081A585001A9F
      3300059A2600009E280000A62F0000AE360000B53C0000BC430000C3480003CC
      500025D86E0030E07B0036E683004BEB910068EEA20080EFAF002EFFBC0035DA
      A9000000000000000000000000000000000000000000000000000000000097B1
      9900189A3200079D2800009F280000A6300000AF360000B53C0000BD430000C4
      470007CC54002AD9720030E07B0038E684004AEB91006CEDA1005FF3AD0007FB
      B1008FCEBB000000000000000000000000000000000000000000E6E6E600F2F2
      F200FBFBFB007474740033333300D3D3D300FCFCFC00E7E7E700838383004A4A
      4A005D5D5D0085858500E5E5E500FDFDFD00FEFEFE00B1B1B1006C6C6C00D2D2
      D200F9F9F900EAEAEA00D0D0D00000000000000000000000000000000000D5D5
      D500BEBDBD00C9C9C800B1B1B200D6D5D500A2A09F007C7978006C6A6A006462
      620087858600ABAAAC0064636500302E310036343600A6A5A500FFFFFF00F7F7
      F700FBFAFA00FCFDFC000000000000000000000000000000000000000000639A
      6C0017A83800029D280000A42D0000AB340000B23A0000BA400000C1460003C8
      4E0025D56C0031DC780035E3800040E88A005CEB980036F6A90018E0A000D2E0
      DD0000000000000000000000000000000000000000000000000093AC9500208F
      32000B9B27000098210000A12A0000A82F0000B0370000B73F0000C0460000C6
      4A0008CF560029DC75002FE37C003EE9890059EC9A0074EFAA0096F1B80062FC
      C1000EF3B300B2DACD0000000000000000000000000000000000E6E6E600F4F4
      F400FCFCFC006C6C6C0037373700DADADA00F9F9F900FAFAFA008E8E8E003A3A
      3A00494949006B6B6B00C8C8C800F8F8F800FEFEFE00B4B4B40066666600CDCD
      CD00FBFBFB00EAEAEA00D0D0D000000000000000000000000000000000000000
      0000D1D1D10078777A00C9C9CA00FFFFFF00F1F0F100CDCBCC00999796007573
      71005E5B5B006967670068676800323032004E4D5000EAEAEA00F3F3EF00DDE0
      DD00F9FBF900FCFBFB0000000000000000000000000000000000000000000000
      00004593560014AB380000A0290000A9310000AF380000B63E0000BD430005C5
      4C0027D26A0030D9750036E07D0040E5830041EC9C0009E89F00AECDC2000000
      0000000000000000000000000000000000000000000000000000329D4100129B
      2A00059924000AA42F000DAD370010B6400005B53E0000B93F0000C1470000C9
      4C000AD2590029DE760030E57D004AED8F0068F3A40085F8B500A0FBC500BFFC
      D5004EFFC6000ADA970097CFBE00000000000000000000000000E7E7E700F5F5
      F500FFFFFF00818181002B2B2B00C8C8C800FFFFFF0093939300151515004D4D
      4D00929292004C4C4C005A5A5A00DFDFDF00FFFFFF009999990060606000DADA
      DA00FCFCFC00EBEBEB00D1D1D100000000000000000000000000000000000000
      0000908E9000ACABAC00F7F7F700FFFFFF00FBFCFC00F6F6F700EAE9EA00C3C1
      C100908D8D00747171006462610055535400C5C3C300FDFDFD00E8E8E600E7E8
      E700FAFAFA00FCFCFC0000000000000000000000000000000000000000000000
      0000D6DBD6002E9B48000FA9360000A42D0000AC350000B33B0000B93F0007C1
      490028CE67002FD5710033DB77004EE592001EDD970088CDB400000000000000
      000000000000000000000000000000000000000000000000000076AD7C005099
      5A005DA46B0063A9750067AE7B005EAB76001FB3500001BC400000C2470000CA
      4C000CD35C002CE178002EE4820025DC830063D39D007ED3AB0085D5B20093D6
      B90071D6B30064D0AC00BAE2D400000000000000000000000000E9E9E900F6F6
      F600FFFFFF00B1B1B100212121008B8B8B00FFFFFF00D0D0D0006B6B6B00BFBF
      BF00FFFFFF00AAAAAA009F9F9F00FCFCFC00E9E9E900646464006E6E6E00F0F0
      F000FBFBFB00EDEDED00D1D1D10000000000000000000000000000000000CBCB
      CB0099989800E6E5E500FFFFFF00FFFFFF00FFFFFF00FDFCFC00F5F5F500F0F0
      F100E7E5E7009694950067656400C3C1C100FCFCFB00EAEAE900F1F1F000F8F8
      F700FBFBFB000000000000000000000000000000000000000000000000000000
      000000000000B3C7B80021A242000AAA340000A6300000AF380000B43B0009BE
      48002ACB66002AD069004DDA850041E4A00060BF9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000035AA5E0001C2430000C3480000CB
      4D000ED55E0032E37B002DDD8D0030C189000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EBEBEB00F9F9
      F900FCFCFC00ECECEC004B4B4B0034343400CACACA00FFFFFF00FAFAFA00F7F7
      F700F2F2F200F9F9F900FFFFFF00FDFDFD008D8D8D003C3C3C00A6A6A600FFFF
      FF00FAFAFA00EEEEEE00D1D1D100000000000000000000000000000000008C8C
      8D00BBB9B800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FAFA
      F900F6F6F60057565A0089888900FCFCFB00E5E6E500EFEFED00F3F3F300FAFA
      FA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094B89F0018AA3D0007A6310000A9320000B036000FBA
      480026C65F003FD073005CE09F0044B283000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003AB2640000C0420000C3490000CB
      4D0013D5620035E47E0033DB8D0036BC88000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ECECEC00FBFB
      FB00F9F9F900FFFFFF00B3B3B3002828280044444400BEBEBE00FDFDFD00FFFF
      FF00FDFDFD00FEFEFE00EBEBEB00898989003232320065656500F0F0F000FCFC
      FC00FCFCFC00EFEFEF00D2D2D20000000000000000000000000000000000B3B2
      B200E5E5E500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00B1B2B30077777800F4F3F200EFEFEE00EBEBEB00F0EFEE00FAF9F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EA27C0019B03F0003A7300000AB300011B6
      450030C460005DD7920032B97C00D6DEDB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000038AF600000BF420000C2480000C9
      4D0018D5650035E47D0035D88A0034B880000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EDEDED00FBFB
      FB00F9F9F900FAFAFA00FFFFFF00A0A0A0002B2B2B002A2A2A006B6B6B009E9E
      9E00A8A8A8008C8C8C004C4C4C002525250058585800DDDDDD00FFFFFF00F9F9
      F900FDFDFD00EFEFEF00D2D2D200000000000000000000000000000000000000
      0000D6D6D600CCCCCC00F6F7F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFC
      FC0085848400E6E6E60000000000F2F2F100F3F3F300FAFAFA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000050A0650015B03D0000A42C0018B3
      46004AC8790025B06A00B9D1C400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000038AD600000BE410000BF450000C8
      4C001AD466002FE178002BD17F0034B37B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0F0F000FCFC
      FC00FBFBFB00FAFAFA00FDFDFD00FFFFFF00BEBEBE005F5F5F002C2C2C002222
      220022222200252525003F3F3F008A8A8A00E8E8E800FFFFFF00FBFBFB00FBFB
      FB00FEFEFE00F4F4F400D4D4D400000000000000000000000000000000000000
      000000000000D7D7D700AAA9AA00C8C7C700F2F3F300FFFFFF00FFFFFF00D1D0
      CF00A4A2A4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000349E510011AD38002BB2
      57001FAD600094B8A40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002FAA580003BE410003C046000ECA
      55002AD770003CE3810023C974002DAB70000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D9D9D900FEFE
      FE00FEFEFE00FDFDFD00FCFCFC00FEFEFE00FFFFFF00F6F6F600D2D2D200B0B0
      B000A7A7A700BEBEBE00E6E6E600FFFFFF00FFFFFF00FDFDFD00FDFDFD00FDFD
      FD00FFFFFF00E7E7E700D4D4D400000000000000000000000000000000000000
      0000000000000000000000000000CECDCD00AEAEAE00C9C7C900E4E4E4008888
      8800E8E8E9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6D4C9004EB36A0045B3
      6F0080AF93000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007BB48C0042C76E0050CA7D005FD2
      8C0074DC9E0074DFA00041C6800073B996000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E1E1E100E2E2
      E200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C7C7C70000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E1E0E000DEDEDE00BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000076AD7C0076AD7C0076AD7C0076AD
      7C0076AD7C0076AD7C0076AD7C0076AD7C000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E0E0
      E000DEDEDE00F5F5F500FAFAFA00F9F9F900F9F9F900F9F9F900F9F9F900F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F3F3
      F300CCCCCC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ECECEC00D4D4D400DEDEDE00D7D7D700D8D8D800D8D8D800D8D8D800D8D8
      D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800D8D8D800DBDB
      DB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B3C8
      B6008CBB940087BA8D009DB89F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DDE7FB00B8CF
      FB00DFEAFD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DAE5F900B8CB
      F300CED0ED000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000081AD8800588E
      61005A916400678D6B0093959300919591008C948C0090959100919591009094
      900090949000949492008C918C00688D6E00548B5C0055895B005A8F64005D93
      6700578F6000A4AEA5000000000000000000000000000000000000000000B0CD
      B300B3D7B70000000000000000000000000000000000C1D4C4007BB5890051B6
      6A0045B8600042B45B003FA7520063A56C00A4BBA60000000000000000000000
      0000000000000000000000000000000000000000000000000000D5DFF8007490
      DC0084A4EB00B4CCFB00DDE9FD00000000000000000000000000000000000000
      0000000000000000000000000000E5EEFD00CBDBFB00AAC1F50096AFF0008EA3
      ED00A3A7DE00000000000000000000000000000000000000000084AD810099B9
      940099B7910098B5900098B58F0099B48E0097B38D0091AF86008EAC800091AE
      86009BB18D009BB08C0092AA820080A06F00779A67008EA57C0097AA8600809E
      6E007696610094A585000000000000000000000000000000000021B843002CCB
      610020C5500046B55600E2DDE00083D0A0005CC98300BBD5C500EAE0E600DADB
      DA00D7D8D700E1D8DD00C9CECB0056C87D0018C14A0013AC2D0020BC47002FCF
      650026D3550068956E0000000000000000000000000000000000000000004CB3
      5E004CC266008FC5950000000000000000007BAF870042CD6F003CE276003BD9
      700041CF6D0049C86B0046C6650045C5610043B65600609E6400CFDECF000000
      000000000000000000000000000000000000000000000000000000000000B3B6
      C2006F7692005B72B7005878D0007E9EE7008CA8E50084A3E6009CBAF30090AF
      F100B4CCFB00ADC7F90089A9F0007493E7008096E400A1ADE700C5C8E100A7AE
      E4008890DA000000000000000000000000000000000000000000C4DCC400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFE00FAFEFA00EBF7EB00E5F3E500F4FB
      F500F9FEF900EEF8EE00B2D6B00092C48F00A8D0A500E4F2E400FFFFFF0090C1
      870084B8770095A586000000000000000000000000000000000031B7570033C4
      6E0026BC5C0046AA5800D3D1D10042C2750013BF550099C7AB00E9D8E200D1D3
      D200CECFCE00D5CDD300BFC3C10058C185001FBC590015A2340025B4500035C8
      72002CCC62006F997900000000000000000000000000000000000000000050B6
      630044C6650052C9700076BF820062C17C003DEA7E0021E66E001FDE68002AD9
      690035D1690041C9680042C0600039B9550036B8500042BD580050A85900C8DC
      C80000000000000000000000000000000000000000000000000000000000D3D2
      D0008C8B8400898884008688930082899F009296A1009A9DA700979EB300A0A6
      BA008B9CCD008496CE0096A1CE00B3B9D300D0D1DB00E1E0DD00CCCABE00AEB6
      D3007782D8000000000000000000000000000000000000000000B7D5B600F3FC
      F300FFFFFF00FFFFFF00FFFFFF00F9FCF800F8FCF800F7FBF700F0F7EF00DAEB
      D800C1DFC000D1E7D000BAD9B800BDDBBC00BDDBBB0099C89700F8FDF900ABCC
      A3006EA35D009DAA8D000000000000000000000000000000000031B7560031C4
      6B0023BA580046A95800DAD9D90051C57F0023BF6000A3CCB300F2E1EB00DADB
      DB00D6D8D600DFD6DB00C6C9C70057C183001EBB5600159E300022AF4C0033C7
      6F002BCB6000709A7800000000000000000000000000000000000000000057B7
      670045C365003DC965004DDA7D004EE8890036E97E003BED850044ED880050EA
      8B005DE78F0067DE8E0068D4860057C972003FBA59002AAD42003AB54E0058A8
      5E0000000000000000000000000000000000000000000000000000000000F9F9
      F900DEDEDE00AEADAC009F9E9900A09E9800ACAAA700C2C0BC00C9C6C100BBB9
      B400C0BDB700C8C5C000D1CFC900DAD8D200E2E1DE00BABAB900ADADAA00BCC1
      CD006879D400D6D7EF0000000000000000000000000000000000AAD0AA00D9EF
      D700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FBF700DEEDDC00D4E8
      D200DAECD900EEF6EE00EAF3E800AED3AD0083BB7F0081B97E00E1EFDF00EFF5
      EC0080A36C008EA27F000000000000000000000000000000000031B7560031C4
      6B0021B254004AA65A00EAE5E9004AC67B0017BE5800A9D4BB00FFF1FA00EBE9
      EA00E6E5E600F0E4EC00D6D5D6005DC689001DBE5800159D300020A5470031C2
      6D002BCB6000709A780000000000000000000000000000000000000000005DB8
      6C0041C3620047CB6E005CDD890064E896005DEF980050F6970059FA9D0055DC
      850058BF730064B7720065B571005BB3690059BD6C0052C1650028AB3E0039AE
      48007FB380000000000000000000000000000000000000000000000000000000
      0000FDFDFD00FAFAFA00EAEAEA00DEDEDE00DDDDDD00D9D9D900E3E3E300E7E7
      E700D9D9D900DADAD900DDDDDD00E0E0E000DFDFDF00B7B7B700A9A9A700C4C6
      C6007083D200B6BAE50000000000000000000000000000000000ABD1AB00C2E5
      C100EFF9F100FFFFFF00FDFFFE00FDFFFE00FCFEFD00F8FCF900F9FCF900F8FB
      F700DBECD900C3DFC100CDE4CC00BAD9B800C0DCBE00B5D6B30099C79600FDFF
      FD00A1B68F00859A75000000000000000000000000000000000032B7560030BE
      680021AB510046A65600F0EAED0088D2A7005EC58700CCE0D700FFF9FF00FBF2
      FB00F7EEF700FFEEFE00DFDCE0005AC3830019B74D00159C2D0021A448002FBA
      69002BCA5F00709A780000000000000000000000000000000000000000005EB8
      6D0055CA720086DC9E0083E4A30073E89E0067EE9C0063ED9A0065BE7B00ABCC
      AC0000000000000000000000000000000000ABCCAC0067AE6E0058BC67002CAB
      3C0043A24B00D2E3D20000000000000000000000000000000000000000000000
      000000000000F5F5F500F9F9F900F8F8F800EDEDED00DEDEDE00D9D9D900F6F6
      F600FAFAFA00F7F7F700F0F0F000E7E7E700E1E1E100CACACA00A7A7A600C7C6
      C0008395D0009098DA0000000000000000000000000000000000B4D5B300B1DE
      B30082CFA50086D1AD008DCBA50085BC8C0083B17A00D9E4D300FEFFFF0091BF
      8E004E9546006BA36000D9E9D700DDEDDB009EC99B0086BD82009DC99900EEF6
      EE00D1DAC9008FA181000000000000000000000000000000000032B755002FB7
      650025AF59001C9F3C006AB270007DB7820072B078007CB982007EBE86007DBE
      84007BBC830081BA870063AD6E001A9F370000981C000997250023AC52002FB6
      68002AC55D00709A7800000000000000000000000000000000000000000070BF
      7D008DDBA00097DEA90089E1A5007DE5A20076ECA3007DDF9E00A0C29E000000
      000000000000000000000000000000000000000000000000000080B4830055B7
      60002EA63B0093BF930000000000000000000000000000000000000000000000
      000000000000F9F9F900F5F5F500F5F5F500F1F1F100E7E7E700D9D9D900E6E6
      E600F6F4F300E3D4CF00D7C1B800D8C8C300E0DFDE00D6D6D600ACACAC00C3C1
      BA009DAACD006977CE0000000000000000000000000000000000B6D6B700B9E1
      B80058B97A000F9446001E903F001B7D2100216E0900B9CBA800C9E4CF002988
      30000065000068A05D00D4E6D100D7EAD600C2DCBF00C4DEC10095C49100A1CC
      9E00F1F6F000C2C9BC000000000000000000000000000000000031B454002DB4
      620026AF57001DA04000129024001D92290020942C0016932500119523001296
      2400139624001393240010902100159225001E932C00209F3D0024AE54002DB4
      630029C15A00709A7800000000000000000000000000000000000000000098CD
      9F009ADEAA0092DAA30091DEA50089E1A40080E2A00089EBAC007DC58C00CCDD
      CC000000000000000000000000000000000000000000000000000000000080B4
      820068BD6F0088B9890000000000000000000000000000000000000000000000
      00000000000000000000F5F5F500F5F5F500F5F5F500EFEFEF00E2E2E200D3C8
      C500C6927600C27C4500BF733000C99C8400E2E1E100DDDDDD00B8B8B800BAB8
      B400B9BFCD005469C600CFD0ED00000000000000000000000000B2D6B400C2E5
      BE00A8D6A70054A461001A7A1E003682280099B68400D2E4CF0060B579000783
      22004FA05800DAEADA00E5F1E400E9F4E900BFDBBC008CC0890083BB8000C3DE
      C200FFFFFF00F7F6F9000000000000000000000000000000000030B0520026AF
      59003AAC5900AAC8AE00B8D6BE00B0D2B500B1D2B600B2D4B700B2D4B700B2D5
      B700B3D5B700B2D5B700B4D4B900B9D4BC00BDD7C200AFCBB30046AF620023B0
      570027BE5900709A780000000000000000000000000000000000000000009BCC
      A000BDEECA00B7EBC400B7ECC700B6EDC600B2EEC500AEF0C300C2F9D5008CB9
      8C00000000000000000000000000000000000000000000000000000000000000
      0000ABCAAB000000000000000000000000000000000000000000000000000000
      00000000000000000000F7F4F400E0D0CC00D7B8AD00D1AC9E00CCA79A00BF85
      6200D0945400C57D3300C99B7F00ECECEC00E4E4E400E0E0E000C6C6C600B2B1
      AF00CBCCCB005D73C600A5ABE000000000000000000000000000B9D9BB00C5E6
      C400BBE2B900A7CEA100387A2300225F0B0092A774008ED3AB0020A95A0027A0
      4E00AED7B600E0EFDD00BDDCBB00D3E8D100D4E7D200DEEDDE00FFFEFF00EBEF
      E800C3D1B900C1CBBA000000000000000000000000000000000030AF520020AC
      53004FAF6400FFEDF900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF0FF0065B475001CAB
      500025BC5700709878000000000000000000000000000000000000000000AECE
      AE009EC69F009AC59C009AC59C009AC59C009AC59C009BC69D009BC59C00AACC
      AA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2CAC100CA957900CC926400D29A6300D2975800D0905000D092
      4F00CB853B00C27A3600DBC2BA00EEEEEE00E7E7E700E0E0E000D2D2D200B0B0
      B000D0CEC7008192CD007987D300000000000000000000000000BDDBC100D8EE
      D600BEE3BE00CEEBCD0093AD7C00204900003279250036C07C0020B66C0086CF
      A300EFF6EC00EEF5E900ECF5EB00FFFFFF00F4F6F400C8DCC40098C1900069AD
      5E007DAD6F0095A788000000000000000000000000000000000030AF530020AC
      52004FAF6400F7F0F300FEFEFD00F7F8F700F8F8F800F8F8F800F8F9F800F8F8
      F800F8F8F800F8F8F800F8F8F800F7F8F700FEFEFD00FBF3F80063B575001DA9
      500025BC57007098780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BEE7C8008ED79F008ED59E008CD29A0089CD950085C9900081C6
      8B007EC08600AFD2B10000000000000000000000000000000000000000000000
      0000D2A89400C98A4E00D8995000D4914500D0873600CD812C00CD802A00CB7F
      2D00C87B2900C97F2F00C7885300D5B8AE00E9E9E900E1E1E100DADADA00B7B8
      B800CAC8C100B3BDDB00B7C0E700000000000000000000000000BDDCC000DFF1
      DD00CAE7CA00D3EFD500E4E5D60074945B0023A0530025CD890062D5A200E7F9
      F100FFFFFF00F4F9F700CFE5D000A2CBA20078B572005CAA560051A84A004DAD
      48008DC184009BAD91000000000000000000000000000000000030B0540020AB
      53004DAF6300F5EFF100FEFDFD00F6F6F600F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F6F6F600FEFDFE00F9F1F60062B474001DA9
      4F0025BC58007098780000000000000000000000000000000000000000000000
      0000B1D1B1000000000000000000000000000000000000000000000000000000
      00000000000093D4A00067D787004CCE720052CE760055CC750054C771004FC4
      6A004BC3660063B870000000000000000000000000000000000000000000D6AF
      9D00CD894100D48C3700D1853000D0842C00D9974E00FFFFFF00FFFFFF00D28A
      3700D0833000CD812E00D0863100C8854700D9C6C000E3E3E300DEDEDE00C3C3
      C400D9D8D3000000000000000000000000000000000000000000BEDDC200DFF1
      DE00CFE9CF00D6ECD400F0F7ED008ED2AC0024BD750027B7730086BA9300DCE9
      DB00AFDCB90086C3890070B96E0061B35D005FB4590063B85F0068BB640068BD
      660098C891009DB092000000000000000000000000000000000031B4550020AB
      52004DAF6300F5EEF100FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00F9F1F60062B474001DA9
      4F0026BF5900709A780000000000000000000000000000000000000000008FBC
      8F004BAD53007AB07A0000000000000000000000000000000000000000000000
      000000000000D1EAD60066D0850035D86E002FD1650039CC660043C7660042C2
      61003BBE590067BD750000000000000000000000000000000000E1C8C000C986
      4A00DA913B00D78D3900D9923E00D88F3600E3AA6600FFFFFF00FFFFFF00DB96
      4400D68D3700D58C3A00D1883400D28B3500C7947100E9E7E600E8E8E800E6E6
      E600000000000000000000000000000000000000000000000000C0DEC500E1F2
      E000D5EBD600DFF0DB00AADAB3003DB36D0024B164002E8641005266310095B3
      8A008AD18F0071C06E0073BF6F0075C2700077C3720076C2710074C16F0074C3
      6F009CC995009CB092000000000000000000000000000000000032B7570020AD
      53004DAE6300F5EEF300FDFCFD00F2F2F200F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400F2F2F200FDFAFC00FBF1F70062B574001DA9
      4F0027C25A00709A7900000000000000000000000000000000000000000093BF
      93002AA4360036A7440085B68500000000000000000000000000000000000000
      00000000000000000000A9D5B00043D979001CDD640027D4630034CC63003FC4
      61003DC15D005EB86D0000000000000000000000000000000000D2A58800D68F
      3D00DC943E00DE984400E09C4700E1994000E9B16B00FFFFFF00FFFFFF00E29F
      4C00DD984000DB964200D8903D00D8903A00CD8C520000000000000000000000
      0000000000000000000000000000000000000000000000000000C0DFC600E3F2
      E200E4F4E300CBE7CC004DA55D0013923A0051B06F0061855000314B0A00607A
      4600B2D6AC00A9DFA80095D092008FCD8A0088CA830084C8800080C77B007EC9
      7B00A1CC9B009BB093000000000000000000000000000000000032B7570021B2
      56004DAE6200F5EEF200FFFEFE00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FEFEFE00F9F1F60062B374001EAB
      500028C85D00709A79000000000000000000000000000000000000000000D1E1
      D10041A2490020A6320043B1540071AE7600C1D8C20000000000000000000000
      000000000000BEDBC10084CB93006AEE9F0058EC930061E5920065DD8D0068D4
      87005FCD7B0067BC760000000000000000000000000000000000D4A58100E1A4
      5A00E4A25100E5A04900E7A34C00E9A24700EFBA7400FFFFFF00FFFFFF00E9A8
      5500E5A04700E29E4700DF974300DF9B4600D392550000000000000000000000
      0000000000000000000000000000000000000000000000000000B7DABE00EEF8
      EE00E1F2DF007AB276000B740F002F903B00B2DEBA00B7CBAD00456527002C4B
      0900899E7600C7E7C600B8E4B800B0DCAE00AEDCAB00ABD9A800A8D9A500A9DC
      A700B3D5AF009AB192000000000000000000000000000000000032B7580024BA
      5C004EB16400F4EDF100FEFEFF00F9F9F900FAFAFA00FAFAFA00FAFAFA00FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00F9F9F900FFFEFF00FAF0F70062B3740020B3
      550029CB5E00709A790000000000000000000000000000000000000000000000
      00007BB27D0048B5560042B555006FCB800079C384007FBD86008BC390008DC6
      940084C992007DDD9E007CF9B1006EF8A9007EF3AD008BEEB0009AEBB600A4E6
      B800ADE7BC009CD1A60000000000000000000000000000000000D9B09500EBBB
      7F00F0C08200EFBB7600F0B66700F1B15900F3BA6A00FFFFFF00FFFFFF00F0AF
      5900EDAC5500EBAD5C00E8AE6500ECB87100D7A2770000000000000000000000
      00000000000000000000000000000000000000000000000000009BCAA600F1FB
      F300A5C69D0017680500106903007EB27B00E6F8E600DBF4DC0086A476003051
      0F0039561800A3BA9600C8EAC700BCE3BA00BAE1B800B8E0B600B8E0B600BDE5
      BC00BCDAB7009AB29300000000000000000000000000000000002CB850001FB9
      52004EB36300F5EDF300FEFCFE00F4F4F400F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F500F4F4F400FFFCFF00FBF0F60062B8760024BF
      5D002BCF6300709A780000000000000000000000000000000000000000000000
      0000DBE7DB0065AE6A006EC97D0060C2710070CE850083D9980090E0A6008EE6
      AB0084ECAB0078F1A8006EF1A40071F2A7007CF2AB009DF5C000A9F1C300A2E7
      B700ADE7BD009FD1A70000000000000000000000000000000000E4CEC600E5B9
      8E00FBDCAC00F7D2A000F9D6A200FBD39900F9D19900F9DFBA00F8D6A600F9CB
      8B00F6CD9100F5CB9200F5CF9800F3C68B00DDC1B50000000000000000000000
      0000000000000000000000000000000000000000000000000000BAD9C200B7DB
      BE00D6E4D0009FC29800AECEA800D0E7CE00DCF0DB00D5EFD600C9E3C600ACC8
      A4009CBB9300B4D0AE00C8E5C500C4E5C300C1E3C000C1E3BF00C0E3BE00C5E7
      C400BFDCBC009AB39400000000000000000000000000000000003C9D4C0069B9
      760050A95B00F8F1F700FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FBF2F90064BA79001094
      2D001AAD3F00709A780000000000000000000000000000000000000000000000
      000000000000C0D8C00065B16B0077CF88006FCC820075CF890080D5950083DB
      9C007DE39F007BE8A2007AEBA60086F4B2009DF7C0007FC08C0079B37E00A7E3
      B600B5ECC5009DD2A5000000000000000000000000000000000000000000E1C2
      B100FAE4C000FEEDCB00FEE3BC00FFE4BB00FDECD000FFFFFF00FFFFFF00FEE1
      B800FDDEB300FCE3BD00FFE8BD00DEB89A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7FAF800ABD2
      B500C2E2C900FCFEFA00EAF6E900DEF0DE00DAEDD900D6ECD600D7EED600D7EF
      D700D4EFD500CEEBCE00CAE8CB00CAE6C800C9E6C800C7E6C600C6E6C600CDEB
      CD00C5DEC1009AB49600000000000000000000000000000000003A88400084A6
      870051A55800FAEDFA00FFF8FF00FFF7FF00FFF7FF00FFF7FF00FFF7FF00FFF7
      FF00FFF7FF00FFF7FF00FFF7FF00FFF7FF00FFF9FF00FEEAFB0067B87E000480
      1800119B2A006A96720000000000000000000000000000000000000000000000
      00000000000000000000C5DBC5006CAF700076C985007FD2900084D5960089DA
      9D0089E0A20089E5A80090ECB10083D79D007FB88500DDE8DD000000000085B7
      8700ADE3B90093CC9A0000000000000000000000000000000000000000000000
      0000E9CBB700F3E0C600FFFBEE00FFFBE900FFF3DF00FFFFFF00FFFFFF00FFF7
      E200FFF8E300F8E2C000E1BFA700000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F6F8
      F700ACD0B500A6D2AF00DBEEDC00E3F1E400E0EFE000DEEFDE00DDEFDD00DBEE
      DB00D9EDDA00D8EDD900D6ECD600D6ECD500D5EAD500D5EAD400D4EAD300DBEE
      DB00C6DEC40091AF8E000000000000000000000000000000000044B4540024A1
      38003EAF4F007BBC81007CC183007BC182007BC182007BC182007BC182007BC1
      82007BC182007BC182007BC182007BC182007CC284007BBC810048B259002CB0
      4C0029BA480091AE960000000000000000000000000000000000000000000000
      0000000000000000000000000000D7E5D70083B886007EC4890095D9A3009DDD
      AD00A2E1B2009DE0B10085CA920096C199000000000000000000000000000000
      00008CBD8F0092BF930000000000000000000000000000000000000000000000
      000000000000F0E3DB00EACFB900F0DAC300F4E6D500EEDFD400F3E3CF00F1D9
      C200E8CBB400F5E8DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BEDAC40097C8A20097C9A40099CAA50098C9A30098C8A20098C7
      A00098C7A00097C59F0097C49D0097C49B0097C29A0097C0980097BF970099BF
      980089B48700A4BDA20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E6D3B900E6D3B900E6D3B900E6D3B900E6D3
      B900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DBDBDB00D4D4D400CECE
      CE00C9C9C900C7C7C700C9C9C900CDCDCD00D2D2D200D8D8D800000000000000
      0000D0C7C600DFDDDD0000000000000000000000000000000000B7B7B700C3C3
      C300BDBDBD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00B9BAB900A2AD9F0098A693009DAB98009DA59B000000
      0000000000000000000000000000000000000000000000000000B7B7B700C0C0
      C000BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BEBEBE00C5C5C500B1B1B1000000
      00000000000000000000000000000000000000000000B6B6B600C0C0C000BDBD
      BD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BABABA00B5B5B800B9B9BA00BCBCBC00C5C5C500A9A9A900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DADADA00D4D4
      D400CFCFCF00CCCCCC00CBCBCB00CECECE00D1D1D100DBDBDB0000000000B494
      9000F19A8C00D4817D00C7BFBF00000000000000000000000000CECECE00FFFF
      FF00F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800E1E8E0003E8C38001F7F1D001C7E1A0054924C00DBDD
      DB00000000000000000000000000000000000000000000000000E9E9E900FEFE
      FE00F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800FBFBFB00FFFFFF00B2B2B2000000
      00000000000000000000000000000000000000000000E0E0E000FEFEFE00F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F3F3
      F400D7D7E3007474B100B7B7D000ECECF000FAFAFC00A8A8AE008383B900ADAD
      D100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2A7A400FF9E
      8F00FF837C00FF918700D4998900000000000000000000000000CBCBCB00F6F6
      F600EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00EDEDED00D4DBD20017811A00007D0B00007D0A0037883400DADE
      D900000000000000000000000000000000000000000000000000E0E0E000F2F2
      F200EDEDED00EBEBEB00E9E9E900EBEBEB00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EFEFEF00FAFAFA00B2B2B2000000
      00000000000000000000000000000000000000000000D9D9D900F2F2F200EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00DADA
      E1005757A5000404C2002525A300B0B0C700DCDCE800535394000505C0002525
      B100A6A6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DABCBA00FF9E8E00FF82
      7B00FE847C00FFD2BA00D9B8A300000000000000000000000000CDCDCD00F9F9
      F900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000DDE3DB00218D2B00008A1700008A1600419242000000
      0000000000000000000000000000000000000000000000000000E2E2E200F5F5
      F500F0F0F000E3E3E300B3BBBF00D6D6D600E8E8E800EFEFEF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F2F2F200FDFDFD00B3B3B3000000
      00000000000000000000000000000000000000000000DBDBDB00F5F5F500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000D0D0
      DB002929CD000000CC000000D1002929A8005757AF000808C9000000CE000404
      D3002222AB009393BD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DFC4C100F6968600FF837B00FF86
      7E00FFD1BA00DECAB800D6C7C500000000000000000000000000CECECE00FCFC
      FC00F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300B7CA
      B20098B89000A0BC99008EB2870017962D0000962100009722002A9236008FAD
      8800A4C29E009FC09900D3DECF00000000000000000000000000E5E5E500F8F8
      F800F3F3F300D5D5D5006FA0B00079AEC900B3BEC400DADADA00EBEBEB00F2F2
      F200F3F3F300F3F3F300F3F3F300F3F3F300F5F5F500FFFFFF00B3B3B3000000
      00000000000000000000000000000000000000000000DBDBDB00F9F9F900F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300D6D6
      E0006B6BD9001615DA000000D8000101DD000303DC000000DB000000D9000303
      D9004C4CA000B7B7CD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DCC5C300EF948400FF827B00FE877F00FFD3
      BD00D7C3B300D8C8C80000000000000000000000000000000000CECECE00FFFF
      FF00F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600429B
      48000298220006992600059D280001A12C0000A12B0000A02A00019E29000297
      230004932100018F1A0074AD7400000000000000000000000000E5E5E500FBFB
      FB00F6F6F600DADADA00B0D8DE0087DFFF0063BDEC008CB5CD00BDC4C100E7E7
      E700F4F4F400F6F6F600F6F6F600F6F6F600F8F8F800FFFFFF00B4B4B4000000
      00000000000000000000000000000000000000000000DEDEDE00FCFCFC00F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600E7E7
      EC00B9B9D2006767DB001010E5000000E4000000E5000000E5000909E2005B5B
      B100D9D9E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DBD3D400E2908500FF847C00FF898200FFD3BF00D5BC
      AC00DCCDCC000000000000000000000000000000000000000000CFCFCF00FFFF
      FF00F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F90042A5
      520003AC330000A9300000AD310000AD330000AD330000AC320000A9300000A6
      2C0000A2290005A32E0072AF7600000000000000000000000000E6E6E600FEFE
      FE00F9F9F900ECECEC00B2C0C400A2E6F90084DCDB0034B0800026812D00A0B1
      9F00E7E7E700F7F7F700F9F9F900F9F9F900FBFBFB00FFFFFF00B4B4B4000000
      00000000000000000000000000000000000000000000DFDFDF00FEFEFE00F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F1F1
      F400CBCBDB00807FCE004242F5000D0DF0000000F0000000F4001313D400ABAB
      CA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C1B8BA00C39D9E00E87E7500FFD3BC00D2B9A800DDD0
      CF00000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB005FB4
      6F003ACB6C0030C663002BCA62001AC1530016BF4F0015BD4D001BC0520029C3
      5C0031BF5D003CC4660080B88300000000000000000000000000E6E6E600FFFF
      FF00FBFBFB00F8F8F800DADADA009ACBD8004EC4760000960300008B10001E7B
      1D00A2B3A200E9E9E900F9F9F900FBFBFB00FDFDFD00FFFFFF00B5B5B5000000
      00000000000000000000000000000000000000000000E1E1E100FFFFFF00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00EAEA
      F0008383C9006463F3005151FB004646FB001111FC000000F9000000F8002C2C
      C600BDBDD7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DAD3D500CDC3C500C6BABD00CDC2C400DAD2
      D300EDEAEA00DCD4D400B2A1A100A8999C00D4C0B900C8A89400DDD1D1000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00B4D4
      B7009CD2A800A2D5AD0094C99E005DD4870048DA81004BDA830063CA830091C4
      9C00A0D2A9009DD3A700C6DAC800000000000000000000000000E6E6E600FFFF
      FF00FEFEFE00FEFEFE00F2F2F200BAC8C60020C150000CAC2E0001A122000493
      170020801F00A5B7A400EBEBEB00FCFCFC00FFFFFF00FFFFFF00B6B6B6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00DEDE
      E9006D6DF8005D5DFF005C5CFF006B6BFC006969F5002F2FFF000202FF000000
      FF002626C8009696C70000000000000000000000000000000000000000000000
      000000000000DBD4D600D9D1CF00F5EFE300FEF5E600FEF5E400F9F0E200E7E0
      DA00C1B5B800B09D9D008D727200A6939200C7BEBF00DCD1D100000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F4EF006CD38E0064EB9D0069EDA10073BE83000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FDFDFD00E9E9E9008ABC980027C3540019B6390002AD
      2600089F1F0022882000A9BBA900EDEDED00FDFDFD00FFFFFF00B6B6B6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0
      EB008181F2007575FF007D7EFE007C7CD2009A9ACD00817FE1005757FF002323
      FF002C2CC9009696C70000000000000000000000000000000000000000000000
      0000DBD4D500F0E8E000FFF7E300FEF3DF00FDEFDA00FDF4E400FEF8EA00FFF5
      DE00FDF4E100C6BBBE00A5939300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E2EBE1007DE0A00086F8BB0088FABD007BC78F00DCE0
      DC00000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E6E6E60089BB970033CD600021C2
      450004BD2D000DAC250029932800ABBCAB00EDEDED00FDFDFD00B6B6B6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEF
      F400A0A0CD009897EA008B8BD300DDDDE900E8E8F0008080A5008F8EEB007070
      D700B8B8D200000000000000000000000000000000000000000000000000EBE7
      E800E8DED700FFF4DC00FBF0DC00FAE8C800FBEED800FCF6ED00FDFBF900FDF7
      EE00FEECCE00FBF1DE00C2B6B900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E9EFE90092E1AC00B2FAD400B0FCD40085C89400DDE1
      DD00000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E6E6E60094BFA1003ED6
      6D0027CF4E0006C6310011B028002C932900A9BBA900ECECEC00B5B5B5000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFC
      FD00E3E3ED00A8A7D200CCCBE300F7F7FA00FDFDFD00ACACB100A1A0D700B1AF
      DA0000000000000000000000000000000000000000000000000000000000DBD3
      D500FDEED700FCF3E000F8E3BC00F9E7C400FBEDD600FCF2E300FCF5EA00FCF2
      E400FBECD500FFEBC200E0D9D500E5DFE0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FDFDFD00C9E3CE00BDE2C600BFE6C800B6C9BA000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E6E6E60094C1
      A30041DF73002CD2520007C4300010AA2500288D2600A7B8A700A6A6A6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FBFBFC00F4F4F800F5F5F700F5F5F500FFFFFF00B6B6B800000000000000
      000000000000000000000000000000000000000000000000000000000000DBCE
      CC00FFEED500FAEED300F7DCAB00F9E4BC00FAEACA00FBECD400FBEDD800FBED
      D400FAEACC00FBE5B600EFE4D000CFC6C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFDFD00F7F7F700F1F1F100EDEDED00F5F5F500D6D6D6000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E5E5
      E50096C2A40043DF75002ECD4F0005B626000B9C1C0026812600778777000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FBFBFB00F5F5F500F0F0F000EBEBEB00FCFCFC00B7B7B700000000000000
      000000000000000000000000000000000000000000000000000000000000DCCB
      C500FFEDD400F9EACA00F7DAA400F8E0B400F9E4BC00F9E8C500FAE8C700F9E8
      C500F8E5BD00FAE1B300F4E6CC00C6BCC0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDFDFD00F4F4F400EDEDED00E7E7E700E1E1E100E7E7E700D2D2D2000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
      FB00E0E0E0008DBC9C003EDA6F0026BD3F0003A01900058611001A6A1A00ABB6
      AB000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
      FB00F2F2F200EBEBEB00E5E5E500DEDEDE00F0F0F000B7B7B700000000000000
      000000000000000000000000000000000000000000000000000000000000DECE
      CE00FDE6C700FCF1DD00FBEDD300FBEDD500F8E3BB00F8E0B300F8E2B600F8E1
      B600F8DDAC00FAE0B100F2E4CC00D0C8CB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
      FD00F4F4F400EBEBEB00DEDEDE00D1D1D100C8C8C800DDDDDD00BDBDBD000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9
      F900ECECEC00CECECE007FAE8F0036CE63001CAB3200028F1200007707002D6F
      2E00C1C1BF0000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00F2F2
      F200E8E8E800DADADA00CECECE00C9C9C900E4E4E400B9B9B900000000000000
      000000000000000000000000000000000000000000000000000000000000E2D9
      DB00FADBBB00FEF9ED00FEFBFE00FDF9F800F9E9CA00F6DAA400F7DBA600F7D8
      A000F8DEAC00FAE2B700E9DFD300E1DBDD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
      F700EDEDED00E1E1E100E0E0E000DCDCDC00E1E1E100D9D9D900CFCFCF000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00F2F2
      F200E7E7E700DCDCDC00C8C8C80080AD8E002BC056000EA2260000880200317C
      3300B5AEAE00B6BAC000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00F4F4F400E9E9
      E900DFDFDF00E0E0E000DADADA00EAEAEA00C4C4C40000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECE9
      EA00EFD3C900FBE2C800FFFFFF00FDFBFA00F8E1B700F5D08C00F5D39300F8DE
      A900FBE4C100F4DEBE00D3CCCF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00F2F2
      F200E6E6E600D4D4D400F2F2F200FFFFFF00ECECEC00CFCFCF00000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700ECEC
      EC00DADADA00DEDEDE00FBFBFB00E4E4E40078A0820020AF45002F933A00BAC4
      BA00D3CAC300697EAE00A8B1C2000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9F900EFEFEF00DFDF
      DF00D8D8D800FDFDFD00FFFFFF00D3D3D300E5E5E50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E6E1E300F2CCBF00F9D8BD00FDF3DE00FCEDCD00FAE7BE00FBE9C600FAE1
      C100F2D1B200E5DEDC00E4DFDF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700EDED
      ED00E0E0E000CCCCCC00F9F9F900E8E8E800CCCCCC0000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00F2F2F200E8E8
      E800D3D3D300DBDBDB00FFFFFF00BFBFBF00D6D6D600A3B6A800B9B3B800C8BC
      B600B5BFD3002859CA00496BBC000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00F5F5F500EBEBEB00D8D8
      D800D2D2D200FFFFFF00CFCFCF00E4E4E4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E6E1E300EACDC500F0C3AA00F5CCB000F5CFB700F2CCB100EDD2
      BF00E0D8D900E3DDDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D1D1D100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F800EEEE
      EE00E0E0E000DCDCDC00E2E2E200CDCDCD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8E8E800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00F3F3F300E8E8
      E800D9D9D900E9E9E900CACACA00000000000000000000000000BEBABF0087AD
      D0004188F1003369DA009EA8BE000000000000000000E4E4E400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F5F5F500EBEBEB00DBDB
      DB00E8E8E800CFCFCF00E4E4E400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EEEBEC00E4DEE000DFD1D200DACACA00DDD4D500E1DC
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CCCCCC00F5F5
      F500F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F0F0F000EAEA
      EA00E2E2E200CACACA00D1D1D100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DDDDDD00F5F5
      F500F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300EDEDED00E7E7
      E700D6D6D600C9C9C90000000000000000000000000000000000000000009EB9
      D200508EDE0093A7CB00000000000000000000000000DBDBDB00F5F5F500F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300EEEEEE00E8E8E800DBDB
      DB00C2C2C200E5E5E50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000680100000100010000000000E01000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFF807000000800003FF
      FFFFE00007000000800003FFFFCFE00007000000800003FFFF0FE00007000000
      800003FF010FE00007000000800003FE000FE00007000000800003FE00CFE000
      07000000800003FE00CFE00007000000800003FF003FE00007000000800003C0
      0007E00007000000800003C00007E00007000000800003C00007E00007000000
      800003C00007E00007000000800003C00007E00007000000800003C00007E000
      07000000800003C00007E00007000000800003C00007E00007000000800003C0
      0007E00007000000800003C00007E00007000000800003C00007E00007000000
      800003C00007E00007000000800003C00007E00007000000FE7FCFC0000FE000
      07000000FFFFFFFFFFFFFFE007000000FFFFFFFFFFFFFFFFFFFFFFFFE0000380
      0003800003800003C00001800003800003800003C00001800003800003800003
      C00001800003800003800003C00001800003800003800003C000018000038000
      03800003C00001800003800003800003C00001800003800003800003C0000180
      0003800003800003C00001800003800003800003C00001800003800003800003
      C00001800003800003800003C00001800003800003800003C000018000038000
      03800003C00001800003800003800003C00001800003800003800003C0000180
      0003800003800003C00001800003800003800003C00001800003800003800003
      C00007800003800003800003E001FF800003800003800003FFFFFFFE7FCFFEFF
      CFFE7FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7FF80
      003FFFFFFFFFFFFFFF00FF80001FFC813FFF81FFFC003F80000FF0000FFE007F
      F8001F80000FF4002FF8001FF0000F800007F8001FF0000FE00007800003F000
      0FE00007C00007800003E0000FE00007C00003800003E00007C00003C0000380
      0001C07E07C00003C00001800003C0FF03C00001C00001800003C0FF03C00001
      C00001800003C1FF83C00001C00001800007C1FF83C00001C00001800007C0F9
      03C00001C0000380000FC0F803C00001C0000380003FC07807C00003E0000780
      003FE0F807E00007E0000F80007FF0F80FE00007F0000F8000FFF1F80FF0000F
      F8001F8001FFFFF807F8001FFC007F8003FFFFF807FC003FFFFFFF8007FFFFFF
      FFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FBFFF
      F807FFFFFFFEFF3FE00003E00003E03FFFE00003C00001C00001C00003C00001
      C00001C00001C00001C00001C00001C00003C00001C00001C00001C00003C000
      01C00001C00001C00003C00001C00001C00001C00003C00001C00001E00001E0
      0003C00001C00001E00003E00007C00001E00003E00003E0000FC00001FD80FF
      E00003E0000FC00001FC001FE00003E00007C00001FC001FE00003E00007C000
      01C00001E00003E00007C00001C00001E00003F00007C00003C00001E00003E0
      0007C00003C00001F80007E00007F00003C00001FC000FE00007FFA983C00001
      FE001FE00007FFC7FFC00001FF003FF000FFFFC7FFC00001FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF031FF8
      000FFFFFFFFF9FFFF80003800003F8000FFF8FFFF80003800003F00007F19FCF
      F80003800003F00003F183CFF80003800003F00003F0000FF80003800003E000
      03F00007F80003800003E00007E00003FC001F800003E00007E00003FC001FC0
      0007C0000FF0000FFC001FC007FFC0000FF0003FFC001FC003FFC0000FF0003F
      FC001F8003FFC0000FE0003FFC001F8001FFC0000FE0003FFC001F8001FFC000
      0FE0003FF8003F8001FFC0000FC0003F80003F8001FFC0000FC0003F80003F80
      01FFC0000F80007F80003F8003FFC0000F8003FF80003FC003FFC0000F8003FF
      80003FE007FFC0000F8003FFC0003FF01FFFC0000F8007FFFFFFFFFFFFFFC000
      0FFFFFFFFFFFFFFFFFFFC0001FFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFF8007FFF
      9FFFFC1FFFFF8FFFE0001FFF8FFFFC00FFFF8FFFC0000FF18FCFF8001FF98FEF
      800007F183CFF8001FF18FC7800003F0000FF0001FF00047800003F00007F000
      0FF00007800003E00003F0000FF00001800003E00003F0000FE00001800007F0
      000FE00007E00003C0000FF0007FC0000FF0000FE0001FE0003FC00007F001FF
      FE01FFE0003F800003E001FFFF03FFE0003F800003E001FFFF87FFC0003FE000
      03E001FFFF87FFC0003FE00003C001FFFF83FFC0003FE00007C001FFFF03FFC0
      007FFC000F8001FFFF03FF80007FFC00FF8001FFFE01FF8001FFFE00FF8001FF
      FE01FF8003FFFF01FF8001FFFE01FF8003FFFF83FF8001FFFF01FFC00FFFFFFF
      FF8003FFFF03FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
      001FFFFE7FFFCFDFFFC00FC0000780000FFC0001FFC00FC00007800007FC0001
      C00007C00007800007FC0001800003800003800007FC00010000038000038000
      07FC0001000003800003800007FC0001000003800003800007FC000100000380
      0003800007F8007F000003800003800007F8003F000003800003800007F8003F
      00000380000380000FF0003F00000380000380001FF8003F0000038000038000
      1FF8003F00000380000380001FF8007F00000380000380001FC0001F00000380
      000380001FC0001F00000380000380003FC0001F00000380000380007FC0001F
      000003C000078000FFC0001F000007C000078001FFC0001FFFFFFFC000078003
      FFF0001FFFFFFFF8003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFC673FFFFFFFE00007FF00FFC00003C00003C00003FF00FF
      C00003C00003800001C00003C00003C00003800001800001C00003C000018000
      01000001C00003800001800001000001C00003800001800001000001C0000380
      0001800001000001E00003800001800001000001C00003800001800003000001
      800001800001800003000001800003800001000003000001C000078000010000
      03000001E0000F800001000003000001F0001F800001000003000001F8003F80
      0001000003000001FC007F800001000007000003FE00FF800001E0003F000003
      FF01FF000001FE007F000003FF83FF8007FFFFC07F800007FFC7FFFFFFFFFFF8
      7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE01FFFFFFFFFFFFFFFFFFFFFC00FFFE
      FF3FC00001E0000FFC00FFC00003C00001E0000FFC00FFC00003C00001E0000F
      F800FFC00003C00001E0000FF800FFC00003C00001E0000FF8007FC00003C000
      01E0000FF8007FC00003C00001E0000FF8007FC00003C00001E0000FF8007FC0
      0003C00001E0000FF0007FF00003C00001E0000FF0007FF00007C00001E0000F
      F0003FF00007C00001E0000FF0003FF8000FC00001E0000FF0003FF8000FC000
      01E0000FF8001FFC001FC00003E0000FF8000FFE003FE00007E0000FF8001FFE
      003FF8000FE0001FF8001FFF007FFC001FE0003FFE003FFF007FFE003FE0007F
      FF803FFF80FFFF007FE000FFFFE07FFF80FFFF81FFE001FFFFF87FFFC1FFFFC3
      FFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
      7F3FFFFFFFFFFFFFE0003FC00003FF3FFFFC000380001FC00001EF379FC00001
      00000FC00001CE2393C000010001C7C00001C00003C000010000E7C000018000
      03C000010000E3C00001800003C00001800003C00001E00003C00001800003E0
      0001FC0203E00001800003FF8003DC0203F00003C00003FC0003C00001F00003
      F003E3FC0003C00001F00003FC07E3FC0003C00001F00001F803C7FC0003F800
      01F00001F8000FFC0003F80001F00003F00FFFFC0003F80003F00003F00FFFFF
      F003F80203F00003F00FFFFFE003F80601F80003F00FFFFFE003F80601F80007
      F00FFFFFE003F80601FC000FF00FFFFFE003FFFFFFFE001FF00FFFFFFFFFFFFF
      FFFF803FFC1FFFFFFFFFFFFFFFFFF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFE007FFFFFFF87FFC3C3FFC1F8001FFFFFFFE7FFCFF3FFC7F8000F
      FFFFFFE7FFCFF3FFC7F8000FFFFFFFE7FFCFF3FFC7F8000FFE7F3FE7FFCFF000
      07F8000FFC0003E7000FF00007F8000FC00003E6000FF00007FC000FC00001E4
      000FF00007FC001FC00001E4000FF00007FF003FC00001E4000FF00007FE007F
      C00001E0000FF20007FC003FC00001E0000FF20007FC003FC00001E0000FF200
      07FE007FC00001E0000FF20007FE007FC00001E4000FF20007FF007FF00003E4
      000FF20007FF007FFFFFFFFC003FFE003FFF007FFFFFFFFC007FFE007FFF007F
      FFFFFFFC007FFE007FFF807FFFFFFFFE83FFFF80FFFF80FFFFFFFFFFFFFFFFFF
      FFFFE1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1FFFF
      F0FFFFFFFFFFFFFFFFE0FFFFC07FF8000FFFFFFFFF803FFF001FF8000FFF1FFF
      FE001FFC000FF0000FFE0FFFF8001FF8000FF0000FFE03FFF0001FE0000FF000
      0FFE01FFC0001FC0000FE0000FF000FFC0001FC0000FE0000FE0007FC0001FC0
      000FE0000FE0003FC0001FC0000FC0000FF0001FC0001FC0001FC0000FE0000F
      C0003FC0001FC0000FE00007C0003FC0000FC0000FE00003C00037C00007C000
      0FFE0F03C00003C00001C0000FFC0787C00003C00001C0000FF803CFC00007C0
      0001C0000FF001FFC0000FC0001FC0000FE040FFC0001FC0001FC0000FE0E0FF
      E0003FF0001FC0000FC1F0FFF810FFFC3FFFC0000FE3F9FFFFFFFFFFFFFFC000
      0FFFFFFFFFFFFFFFFFFFC0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3BFFFF
      FFFFFFFFFFFFFFFFFC107FFE01FFFFC3FFF0000FF8003FFE00FFFFC3FFE00007
      F0000FFE00FFFF81FFC00003E00007FE00FFFF00FFC00001E00007FE00FFFE00
      7FC00001C00003FE00FFFC003FC00001C00007800003FC001FC00001C0000380
      0003F8001FC00001C00003800003F0000FC00001C00003C0000FE00007C00001
      E00003E0000FC00003C00001F00003F0001FC00001C00001F00003F0003FC000
      01C00001E00007F8007FFF00FFC00001E0000FFC00FFFF00FFC00001E0001FFE
      00FFFF00FFC00001F0023FFF01FFFF00FFC00001F807FFFF83FFFF00FFC00001
      FE07FFFF87FFFF00FFC00003FF8FFFFFFFFFFF00FFE00007FFFFFFFFFFFFFFFF
      FFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      E1FFC7FFC7FFFFFFC00003E7807FC1FE07C00003C00003E3001FE00007C00003
      C00003E0000FE00007C00003C00003E0000FE00003C00003C00003E00007F000
      03C00003C00003E00F03F80003C00003C00003E01FC3F80003C00003C00003E0
      0FE3FC0001C00003C00003E00FF7FC0001C00003C00003E00FFFF80001C00003
      C00003FFF803F00001C00003C00003F7F803E00007C00003C00003E3F803C000
      0FC00003C00003E1FC03C0007FC00003C00003E07803C0007FC00003C00003F0
      0003C0007FC00003C00003F00003C0007FC00003C00003F80003E000FFC00003
      C00003FC0023F001FFE00003C00003FE00F3F803FFF80003FFFFFFFFFFFFFE0F
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8033C0
      001FC0001F80003FFFC021C0000FC0001F80000FFFFFC1C0000FC0001F800007
      FFFF81C0001FC0001F800003FFFF01C00001C0001F800003FFFE03C00001C000
      1F800007FFFC07C00001C0001F80000FFFFC0FC00001C0001F800007FE001FC0
      0001C0001F800003F8003FC0001FC0001F800003F001FFC0000FC0001F800007
      E001FFC0000FC0001F80000FE000FFC0001FC0001F80003FE000FFC0001FC000
      1F80003FE000FFC0001FC0000F80003FE000FFC0001FC0000780003FE000FFC0
      001FC0000380007FE001FFC0003FC0000180007FF001FFC0007FC000018000FF
      F803FFC000FFC001C18001FFFC0FFFC001FFC003E38003FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  inherited ilToolBarDisable: TImageList
    Left = 160
    Top = 272
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'insuranceMap'
    QueryAddress = 'query/queryInsurance'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_i!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_t!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_i!polnumber'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_i!insuranceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_st!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_i!insurancestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_i!customerid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_c!mobilephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_i!sellway'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_i!paymethod'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orderno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ise!id'
        ParamType = ptInput
      end>
    StoreDefs = True
    Left = 238
    Top = 271
    object wdstrngfldResultticketname: TWideStringField
      FieldName = 'ticketname'
    end
    object wdstrngfldResultticketno: TWideStringField
      FieldName = 'ticketno'
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
    end
    object wdstrngfldResultdeparttime: TWideStringField
      FieldName = 'departtime'
    end
    object wdstrngfldResultendname: TWideStringField
      FieldName = 'endname'
    end
    object wdstrngfldResultinsuranceno: TWideStringField
      FieldName = 'insuranceno'
    end
    object wdstrngfldResultcustomername: TWideStringField
      FieldName = 'customername'
    end
    object wdstrngfldResultmobilephone: TWideStringField
      FieldName = 'mobilephone'
    end
    object wdstrngfldResultcertificateno: TWideStringField
      FieldName = 'certificateno'
    end
    object wdstrngfldResultinsurername: TWideStringField
      FieldName = 'insurername'
    end
    object wdstrngfldResulttypename: TWideStringField
      FieldName = 'typename'
    end
    object wdstrngfldResultinsurancestatus: TWideStringField
      FieldName = 'insurancestatus'
    end
    object wdstrngfldResultinsurancestatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'insurancestatusname'
      LookupDataSet = jcdsstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'insurancestatus'
      Lookup = True
    end
    object wdstrngfldResultsellname: TWideStringField
      FieldName = 'sellname'
    end
    object wdstrngfldResultselltime: TWideStringField
      FieldName = 'selltime'
    end
    object wdstrngfldResultpaymethod: TWideStringField
      FieldName = 'paymethod'
    end
    object wdstrngfldResultpaymethodname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodname'
      LookupDataSet = jcdspaymethod
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'paymethod'
      Lookup = True
    end
    object wdstrngfldResultsellway: TWideStringField
      FieldName = 'sellway'
    end
    object wdstrngfldResultsellwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'sellwayname'
      LookupDataSet = jcdssellway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'sellway'
      Lookup = True
    end
    object wdstrngfldResultpolnumber: TWideStringField
      FieldName = 'polnumber'
    end
    object dtfldResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object fltfldResultpremium: TFloatField
      FieldName = 'premium'
    end
    object fltfldResultinsureamount: TFloatField
      FieldName = 'insureamount'
    end
    object jcdsResultsellip: TWideStringField
      FieldName = 'sellip'
    end
    object wdstrngfldResultinsuranceprintdatetime: TWideStringField
      FieldName = 'insuranceprintdatetime'
    end
    object fltfldResultywmoney: TFloatField
      FieldName = 'ywmoney'
    end
    object fltfldResultshmoney: TFloatField
      FieldName = 'shmoney'
    end
    object fltfldResultemoney: TFloatField
      FieldName = 'emoney'
    end
    object fltfldResultemmoney: TFloatField
      FieldName = 'emmoney'
    end
    object wdstrngfldResultreprintnum: TWideStringField
      FieldName = 'reprintnum'
    end
    object wdstrngfldResultoutletsaddress: TWideStringField
      FieldName = 'outletsaddress'
      Size = 0
    end
    object wdstrngfldResultreturnorcancelby: TWideStringField
      FieldName = 'returnorcancelby'
    end
    object wdstrngfldResultreturnorcanceltime: TWideStringField
      FieldName = 'returnorcanceltime'
    end
    object wdstrngfldResultinsurersbankcode: TWideStringField
      FieldName = 'insurersbankcode'
    end
    object wdstrngfldResultstartname: TWideStringField
      FieldName = 'startname'
    end
    object wdstrngfldResultinsuretypecode: TWideStringField
      FieldName = 'insuretypecode'
    end
    object blnfldResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object wdstrngfldResultseatno: TWideStringField
      FieldName = 'seatno'
    end
    object wdstrngfldResultsellby: TWideStringField
      FieldName = 'sellby'
    end
    object wdstrngfldResultorgcode: TWideStringField
      FieldName = 'orgcode'
    end
    object wdstrngfldResultcertificatetype: TWideStringField
      FieldName = 'certificatetype'
    end
    object wdstrngfldResultcertificatetypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certificatetypename'
      LookupDataSet = jcdscertificatetypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Lookup = True
    end
    object jcdsResultsellorg: TWideStringField
      FieldName = 'sellorg'
    end
    object jcdsResulthtsellorg: TWideStringField
      FieldName = 'htsellorg'
    end
  end
  inherited dsResult: TDataSource
    Left = 41
    Top = 274
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 312
    Top = 272
  end
  object jcdsstatus: TjsonClientDataSet
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
    Left = 163
    Top = 353
  end
  object jcdspaymethod: TjsonClientDataSet
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
    Left = 276
    Top = 354
  end
  object jcdssellway: TjsonClientDataSet
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
    Left = 365
    Top = 350
  end
  object dlg1: TSaveTextFileDialog
    DefaultExt = '.txt'
    FileName = #21806#31080#21592#21806#20445#38505#35760#24405
    Filter = #25991#26412#25991#20214'(.txt)|.txt|xml'#25991#20214'(.xml)|.xml'
    InitialDir = 'D:'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Title = #20445#23384#21806#31080#21592#21806#20445#38505#25991#20214
    Top = 276
  end
  object jcdscertificatetypename: TjsonClientDataSet
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
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'certificatetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 487
    Top = 345
  end
end
