inherited FrmSecuritycheckFeeReport: TFrmSecuritycheckFeeReport
  Caption = #36710#36742#23433#26816#36153#32479#35745#34920
  ClientHeight = 425
  ClientWidth = 932
  ExplicitWidth = 948
  ExplicitHeight = 463
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 932
    Height = 94
    ExplicitWidth = 932
    ExplicitHeight = 94
    object Label8: TLabel
      Left = 259
      Top = 23
      Width = 56
      Height = 14
      Cursor = crDrag
      Caption = #23433#26816#26085#26399
    end
    object Label9: TLabel
      Left = 465
      Top = 23
      Width = 14
      Height = 14
      Cursor = crDrag
      Caption = #33267
    end
    object lbl1: TLabel
      Left = 37
      Top = 23
      Width = 56
      Height = 14
      Caption = #23433#26816#36710#31449
    end
    object Label1: TLabel
      Left = 273
      Top = 63
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label4: TLabel
      Left = 37
      Top = 63
      Width = 56
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = #36710#23646#21333#20301
      ParentBiDiMode = False
    end
    object Label3: TLabel
      Left = 449
      Top = 63
      Width = 42
      Height = 14
      Caption = #23433#26816#21592
    end
    object startdate: TDateTimePicker
      Left = 330
      Top = 20
      Width = 100
      Height = 22
      Date = 40603.000000000000000000
      Time = 40603.000000000000000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 0
    end
    object enddate: TDateTimePicker
      Left = 506
      Top = 20
      Width = 101
      Height = 22
      Date = 40589.999988425930000000
      Time = 40589.999988425930000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 1
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 99
      Top = 20
      Width = 136
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhelpvehicleno: TNovaHelp
      Left = 330
      Top = 60
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
    object nvhelpunitname: TNovaHelp
      Left = 99
      Top = 60
      Width = 136
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhelpcheckname: TNovaHelp
      Left = 506
      Top = 60
      Width = 101
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
          Title.Caption = #22995#21517
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 932
    ExplicitWidth = 932
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
    Top = 139
    Width = 932
    Height = 286
    ExplicitTop = 139
    ExplicitWidth = 932
    ExplicitHeight = 286
    inherited GroupBox1: TGroupBox
      Width = 932
      Height = 286
      ExplicitWidth = 932
      ExplicitHeight = 286
      inherited dbgrdhResult: TNvDbgridEh
        Width = 928
        Height = 268
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'checkno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #23433#26816#21333#21495
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'checkdate'
            Footers = <>
            Title.Caption = #23433#26816#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'checktime'
            Footers = <>
            Title.Caption = #23433#26816#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #36710#23646#26426#26500
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'securityfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23433#26816#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'checkby'
            Footers = <>
            Title.Caption = #23433#26816#20154#21592
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 576
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Left = 656
    Top = 232
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'checkitemmap'
    QueryAddress = 'check/qrySecuritycheckfeeReport'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_sec!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_sec!checktime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_sec!checktime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_v!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sec!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_sec!checkby'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 288
  end
  inherited dsResult: TDataSource
    Left = 272
    Top = 288
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 784
    Top = 56
  end
end
