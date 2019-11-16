inherited FrmRouteSaleTicketReport: TFrmRouteSaleTicketReport
  Caption = #32447#36335#20572#38752#28857#21806#31080#32479#35745#34920
  ClientHeight = 625
  ClientWidth = 1276
  Position = poDesigned
  OnShow = FormShow
  ExplicitWidth = 1292
  ExplicitHeight = 663
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1276
    Height = 40
    ExplicitWidth = 1276
    ExplicitHeight = 40
    object Label2: TLabel
      Left = 22
      Top = 18
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object Label4: TLabel
      Left = 490
      Top = 18
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object Label6: TLabel
      Left = 690
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbldistricttype: TLabel
      Left = 254
      Top = 18
      Width = 56
      Height = 14
      Caption = #21306#22495#31867#21035
    end
    object lbl6: TLabel
      Left = 1038
      Top = 18
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl1: TLabel
      Left = 858
      Top = 18
      Width = 56
      Height = 14
      Caption = #32479#35745#26041#24335
    end
    object NovaChkSaleOrg: TNovaCheckedComboBox
      Left = 92
      Top = 15
      Width = 135
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
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object startDate: TDateTimePicker
      Left = 555
      Top = 15
      Width = 109
      Height = 22
      Date = 41781.749066423610000000
      Time = 41781.749066423610000000
      Checked = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
    end
    object endDate: TDateTimePicker
      Left = 723
      Top = 15
      Width = 110
      Height = 22
      Date = 41781.751038078710000000
      Time = 41781.751038078710000000
      Checked = False
      TabOrder = 2
    end
    object nvhlpSellby: TNovaHelp
      Left = 1094
      Top = 15
      Width = 91
      Height = 20
      CharCase = ecUpperCase
      Ctl3D = False
      MaxLength = 50
      ParentCtl3D = False
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
    object cbbGroupType: TNovaCheckedComboBox
      Left = 936
      Top = 15
      Width = 81
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      OnChange = cbbGroupTypeChange
      OnCheckClick = cbbGroupTypeChange
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'groupHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NvCbbdistricttype: TNovaCheckedComboBox
      Left = 323
      Top = 15
      Width = 135
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = True
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
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1276
    ExplicitWidth = 1276
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
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited tbtn4: TToolButton
      Visible = False
    end
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 85
    Width = 1276
    Height = 540
    ExplicitTop = 85
    ExplicitWidth = 1276
    ExplicitHeight = 540
    inherited GroupBox1: TGroupBox
      Width = 1276
      Height = 540
      ExplicitWidth = 1276
      ExplicitHeight = 540
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1272
        Height = 522
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32447#36335
            Width = 126
          end
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #31449#28857
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'halfticketnum'
            Footers = <>
            Title.Caption = #21322#20215#31080#20154#25968
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'studentticketnum'
            Footers = <>
            Title.Caption = #23398#29983#31080#20154#25968
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'discountticketnum'
            Footers = <>
            Title.Caption = #25171#25240#31080#20154#25968
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returncharges'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25163#32493#36153
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footers = <>
            Title.Caption = #24223#31080#20154#25968
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20154#25968
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'totalprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#37329#39069
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24494#26426#36153
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31354#35843#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38468#21152#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37197#27700#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23567#35745
            Width = 60
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 64
    Top = 296
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 296
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryRouteIncome'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
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
        Name = 'districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seller'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'grouptypes'
        ParamType = ptInput
      end>
    Left = 200
    Top = 192
  end
  inherited dsResult: TDataSource
    Top = 224
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 296
    Top = 312
  end
end
