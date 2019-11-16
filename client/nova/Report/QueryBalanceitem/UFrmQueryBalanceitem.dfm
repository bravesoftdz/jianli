inherited FrmQueryBalanceitem: TFrmQueryBalanceitem
  Caption = #36816#36153#32467#31639#26126#32454#34920
  ClientHeight = 421
  ClientWidth = 906
  ExplicitWidth = 922
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 906
    Height = 86
    ExplicitWidth = 906
    ExplicitHeight = 86
    object lbl1: TLabel
      Left = 17
      Top = 21
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl2: TLabel
      Left = 491
      Top = 21
      Width = 56
      Height = 14
      Caption = #32467#31639#26085#26399
    end
    object lbl3: TLabel
      Left = 696
      Top = 21
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 31
      Top = 57
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label4: TLabel
      Left = 252
      Top = 21
      Width = 56
      Height = 14
      BiDiMode = bdLeftToRight
      Caption = #32467#31639#21333#20301
      ParentBiDiMode = False
    end
    object lblroute: TLabel
      Left = 252
      Top = 57
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label2: TLabel
      Left = 491
      Top = 57
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object nvcbbNovaCkbOrg: TNovaCheckedComboBox
      Left = 719
      Top = 74
      Width = 133
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpstartdate: TDateTimePicker
      Left = 556
      Top = 17
      Width = 127
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 722
      Top = 17
      Width = 116
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      TabOrder = 2
    end
    object nvhelpvehicleno: TNovaHelp
      Left = 79
      Top = 54
      Width = 139
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
      Left = 314
      Top = 17
      Width = 139
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
    object sellOrgid: TNovaCheckedComboBox
      Left = 79
      Top = 17
      Width = 138
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhlproute: TNovaHelp
      Left = 314
      Top = 54
      Width = 139
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
          FieldName = 'id'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25805#20316#30721
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 190
      HelpOptions.HelpWidth = 270
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteEndHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object EditBalanceno: TEdit
      Left = 556
      Top = 54
      Width = 127
      Height = 22
      TabOrder = 7
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 906
    ExplicitWidth = 906
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
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
  end
  inherited Panel1: TPanel
    Top = 131
    Width = 906
    Height = 290
    ExplicitTop = 131
    ExplicitWidth = 906
    ExplicitHeight = 290
    inherited GroupBox1: TGroupBox
      Width = 906
      Height = 290
      ExplicitWidth = 906
      ExplicitHeight = 290
      inherited dbgrdhResult: TNvDbgridEh
        Width = 902
        Height = 272
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryBalanceitem'
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
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
        Name = 'vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routename'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
  end
end
