inherited FrmQryCheckWorkMonth: TFrmQryCheckWorkMonth
  Caption = #26816#31080#21592#24037#20316#26376#25253
  ClientHeight = 474
  ClientWidth = 859
  OnShow = FormShow
  ExplicitWidth = 875
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 859
    Height = 108
    ExplicitWidth = 859
    ExplicitHeight = 108
    object lbl1: TLabel
      Left = 32
      Top = 26
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 36
      Top = 74
      Width = 42
      Height = 14
      Caption = #26816#31080#21592
    end
    object lbl5: TLabel
      Left = 492
      Top = 26
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl11: TLabel
      Left = 268
      Top = 26
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl7: TLabel
      Left = 268
      Top = 74
      Width = 56
      Height = 14
      Caption = #25171#21333#26085#26399
    end
    object lbl14: TLabel
      Left = 492
      Top = 74
      Width = 14
      Height = 14
      Caption = #33267
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 94
      Top = 22
      Width = 139
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhelpUserid: TNovaHelp
      Left = 94
      Top = 70
      Width = 133
      Height = 22
      CharCase = ecUpperCase
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
    object dtpEdepartdate: TDateTimePicker
      Left = 523
      Top = 22
      Width = 112
      Height = 22
      Date = 40413.000000000000000000
      Time = 40413.000000000000000000
      TabOrder = 2
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 330
      Top = 22
      Width = 127
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      TabOrder = 3
    end
    object dtpBselldate: TDateTimePicker
      Left = 330
      Top = 70
      Width = 126
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      TabOrder = 4
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 523
      Top = 70
      Width = 112
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      TabOrder = 5
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 859
    ExplicitWidth = 859
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
  end
  inherited Panel1: TPanel
    Top = 153
    Width = 859
    ExplicitTop = 153
    ExplicitWidth = 859
    inherited GroupBox1: TGroupBox
      Width = 859
      ExplicitWidth = 859
      inherited dbgrdhResult: TNvDbgridEh
        Width = 855
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #26816#31080#21592#24037#21495
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #26816#31080#21592
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26377#25928'||'#24320#21333#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sdepartinvoicesno'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26377#25928'||'#24320#21333#24352#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'stotalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26377#25928'||'#26816#31080#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'fticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#21333'||'#24320#21333#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'fdepartinvoicesno'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#21333'||'#24320#21333#24352#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ftotalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#21333'||'#26816#31080#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totalno'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#24320#21333#24635#25968
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 480
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Left = 528
    Top = 232
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/qrycheckworkmonth'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_dis!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_dis!printtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_sp!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_dis!printby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_dis!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_dis!printtime'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 480
    Top = 344
  end
  inherited dsResult: TDataSource
    Left = 408
    Top = 352
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 784
  end
end
