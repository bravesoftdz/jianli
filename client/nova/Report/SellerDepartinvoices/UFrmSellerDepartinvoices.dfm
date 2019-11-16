inherited FrmSellerDepartinvoices: TFrmSellerDepartinvoices
  Caption = 'FrmSellerDepartinvoices'
  ClientHeight = 426
  OnShow = FormShow
  ExplicitWidth = 1140
  ExplicitHeight = 464
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    ExplicitWidth = 116
    object Label2: TLabel
      Left = 220
      Top = 25
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl2: TLabel
      Left = 444
      Top = 25
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 24
      Top = 25
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object Label3: TLabel
      Left = 626
      Top = 25
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object dtpstartdate: TDateTimePicker
      Left = 299
      Top = 21
      Width = 121
      Height = 21
      Date = 40698.000000000000000000
      Time = 40698.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 481
      Top = 21
      Width = 121
      Height = 21
      Date = 40728.999988425930000000
      Time = 40728.999988425930000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object cbborg: TNovaCheckedComboBox
      Left = 75
      Top = 21
      Width = 121
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhlpseller: TNovaHelp
      Left = 691
      Top = 21
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 30
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
          FieldName = 'code'
          Title.Caption = #29992#25143#21517
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 80
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
    ExplicitWidth = 116
    ExplicitHeight = 490
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
    Height = 323
    ExplicitTop = 548
    ExplicitWidth = 116
    inherited GroupBox1: TGroupBox
      Height = 323
      ExplicitWidth = 116
      inherited dbgrdhResult: TNvDbgridEh
        Height = 305
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'seller'
            Footer.Value = #21512#35745':'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 80
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
            FieldName = 'departinvoicesnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#21333#25968#37327
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#24635#37329#39069
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#24635#37329#39069
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#38468#21152#36153
            Width = 91
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 656
    Top = 200
  end
  inherited ilToolBarDisable: TImageList
    Left = 688
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/qrysellerdepartinvoices'
    Params = <
      item
        DataType = ftString
        Name = 'departstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellerid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 680
    Top = 336
  end
  inherited dsResult: TDataSource
    Left = 624
    Top = 336
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 840
    Top = 16
  end
end
