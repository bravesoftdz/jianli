inherited FrmTicketmixcheck: TFrmTicketmixcheck
  Caption = #28151#26816#26597#35810
  ClientHeight = 508
  ClientWidth = 1255
  ExplicitWidth = 1271
  ExplicitHeight = 546
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1255
    Height = 92
    ExplicitWidth = 1255
    ExplicitHeight = 92
    object lbl4: TLabel
      Left = 14
      Top = 24
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label1: TLabel
      Left = 241
      Top = 24
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label2: TLabel
      Left = 444
      Top = 24
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lblroute: TLabel
      Left = 17
      Top = 60
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl17: TLabel
      Left = 437
      Top = 60
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl2: TLabel
      Left = 255
      Top = 60
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbl9: TLabel
      Left = 607
      Top = 24
      Width = 42
      Height = 14
      Caption = #21040#36798#31449
    end
    object dtpstartdate: TDateTimePicker
      Left = 301
      Top = 20
      Width = 115
      Height = 22
      Date = 40846.783073773150000000
      Time = 40846.783073773150000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 470
      Top = 20
      Width = 120
      Height = 22
      Date = 40846.783073773150000000
      Time = 40846.783073773150000000
      TabOrder = 2
    end
    object nvhlproute: TNovaHelp
      Left = 78
      Top = 57
      Width = 140
      Height = 22
      CharCase = ecUpperCase
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
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 55
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edtTicketno: TNovaEdit
      Left = 472
      Top = 57
      Width = 111
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 4
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
    object nvhlpendstation: TNovaHelp
      Left = 654
      Top = 20
      Width = 102
      Height = 22
      CharCase = ecUpperCase
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
          Width = 85
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
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 78
      Top = 20
      Width = 140
      Height = 22
      ColorNotFocus = clWhite
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
      Left = 301
      Top = 57
      Width = 115
      Height = 22
      CharCase = ecUpperCase
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1255
    ExplicitWidth = 1255
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
    inherited tbtn4: TToolButton
      Visible = False
    end
    inherited tbtnInfo: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 137
    Width = 1255
    Height = 371
    ExplicitTop = 137
    ExplicitWidth = 1255
    ExplicitHeight = 371
    inherited GroupBox1: TGroupBox
      Width = 1255
      Height = 371
      ExplicitWidth = 1255
      ExplicitHeight = 371
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1251
        Height = 353
        FooterRowCount = 1
        SumList.Active = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #26426#26500
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'oldroutename'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21407#32447#36335
            Width = 124
          end
          item
            EditButtons = <>
            FieldName = 'oldstartstation'
            Footers = <>
            Title.Caption = #21407#21457#36710#31449
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'olddepartdate'
            Footers = <>
            Title.Caption = #21407#21457#36710#26085#26399
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'oldschdulecode'
            Footers = <>
            Title.Caption = #21407#29677#27425
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'olddeparttime'
            Footers = <>
            Title.Caption = #21407#21457#36710#26102#38388
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'oldseatno'
            Footers = <>
            Title.Caption = #21407#24231#20301#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'oldendstation'
            Footers = <>
            Title.Caption = #21407#21040#36798#31449
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #28151#26816#31080#21495
            Width = 70
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'mixchecktype'
            Footers = <>
            Title.Caption = #28151#26816#31867#22411
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'oldticketno'
            Footers = <>
            Title.Caption = #34987#28151#26816#31080#21495
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'startstation'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'newroutename'
            Footers = <>
            Title.Caption = #28151#26816#21518#32447#36335
            Width = 126
          end
          item
            EditButtons = <>
            FieldName = 'newdepartdate'
            Footers = <>
            Title.Caption = #28151#26816#21518#21457#36710#26085#26399
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'newdeparttime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'newschedulecode'
            Footers = <>
            Title.Caption = #28151#26816#21518#29677#27425
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'newseatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'ticketstats'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'isdepartinvoices'
            Footers = <>
            Title.Caption = #26159#21542#24050#24320#36816#37327#21333
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createbyname'
            Footers = <>
            Title.Caption = #26816#31080#20154
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #26816#31080#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'actualvehicleseatnum'
            Footers = <>
            Title.Caption = #26032#29677#27425#24231#20301#25968
            Visible = False
            Width = 100
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 208
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 208
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/findTicketmixcheck'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_nrt!id_OR_ort!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_tm!olddepartdate_OR_tm!newdepartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_tm!olddepartdate_OR_tm!newdepartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_os!code_OR_ns!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_est!id_OR_oest!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_tm!ticketno'
        ParamType = ptInput
      end>
    Left = 208
    Top = 192
  end
  inherited dsResult: TDataSource
    Left = 24
    Top = 224
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Top = 192
  end
end
