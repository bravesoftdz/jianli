inherited FrmScheduleBalancePrice: TFrmScheduleBalancePrice
  Caption = 'FrmScheduleBalancePrice'
  ClientHeight = 391
  ClientWidth = 1027
  OnShow = FormShow
  ExplicitWidth = 1043
  ExplicitHeight = 429
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1027
    Height = 96
    ExplicitWidth = 1027
    ExplicitHeight = 96
    object lblroute: TLabel
      Left = 408
      Top = 66
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label2: TLabel
      Left = 8
      Top = 66
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lblworkways: TLabel
      Left = 409
      Top = 29
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object Label10: TLabel
      Left = 202
      Top = 29
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 22
      Top = 30
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object Label3: TLabel
      Left = 202
      Top = 68
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label4: TLabel
      Left = 570
      Top = 29
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object nvhelpRoute: TNovaHelp
      Left = 472
      Top = 61
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 0
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
    object dtpstartdate: TDateTimePicker
      Left = 70
      Top = 61
      Width = 102
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 1
    end
    object nvcbbworkways: TNovaCheckedComboBox
      Left = 472
      Top = 24
      Width = 79
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
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
          Value = 'schedule'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'workways'
        end>
    end
    object NovaChkSaleOrg: TNovaCheckedComboBox
      Left = 264
      Top = 24
      Width = 120
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
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
    object NovachkPorg: TNovaCheckedComboBox
      Left = 70
      Top = 24
      Width = 120
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpenddate: TDateTimePicker
      Left = 264
      Top = 61
      Width = 102
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 5
    end
    object CobIsovertime: TComboBox
      Left = 635
      Top = 23
      Width = 64
      Height = 22
      ItemIndex = 0
      TabOrder = 6
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #27491#29677
        #21152#29677)
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1027
    ExplicitWidth = 1027
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
    Top = 141
    Width = 1027
    Height = 250
    ExplicitTop = 141
    ExplicitWidth = 1027
    ExplicitHeight = 250
    inherited GroupBox1: TGroupBox
      Width = 1027
      Height = 250
      ExplicitWidth = 1027
      ExplicitHeight = 250
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1023
        Height = 232
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'reachname'
            Footers = <>
            Title.Caption = #32456#21040#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'VEHICLENO'
            Footers = <>
            Title.Caption = #36710#29260#21495#30721
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'ticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#29677'|'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'balanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#29677'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'lostnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26410#36208'|'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'lostprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26410#36208'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'hcdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28779#36710'|'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'hcbalanceprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #28779#36710'|'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'zwticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#22806'|'#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'zwprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#22806'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'hjsellticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#21512#35745'|'#20154#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'hjsellticketprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#21512#35745'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'hjdepartnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#36710#21512#35745'|'#20154#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'hjdepartprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21457#36710#21512#35745'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'remark'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 120
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 112
    Top = 296
  end
  inherited ilToolBarDisable: TImageList
    Left = 192
    Top = 296
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/qryScheduleBalancePrice'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
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
        Name = 'workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isovertime'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 208
    Top = 160
  end
  inherited dsResult: TDataSource
    Left = 520
    Top = 304
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 432
    Top = 296
  end
end
