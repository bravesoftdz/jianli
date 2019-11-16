inherited FrmSyncSaleLocal: TFrmSyncSaleLocal
  Caption = #24322#31449#21806#26412#31449#27719#24635#34920
  ClientHeight = 538
  ClientWidth = 1010
  OnShow = FormShow
  ExplicitWidth = 1026
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1010
    Height = 100
    ExplicitWidth = 1010
    ExplicitHeight = 100
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 217
      Top = 25
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object lbldate: TLabel
      Left = 221
      Top = 61
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object Label1: TLabel
      Left = 420
      Top = 60
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl1: TLabel
      Left = 18
      Top = 60
      Width = 56
      Height = 14
      Caption = #26085#26399#31867#22411
    end
    object NovaSchOrgs: TNovaCheckedComboBox
      Left = 78
      Top = 20
      Width = 134
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object NovachkPorg: TNovaCheckedComboBox
      Left = 263
      Top = 19
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 479
      Top = 19
      Width = 125
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOtherOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object ChkAllOrg: TCheckBox
      Left = 399
      Top = 21
      Width = 75
      Height = 17
      Caption = #20195#21806#26426#26500
      TabOrder = 3
      OnClick = ChkAllOrgClick
    end
    object dtpstartdate: TDateTimePicker
      Left = 263
      Top = 57
      Width = 127
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 4
    end
    object dtpenddate: TDateTimePicker
      Left = 479
      Top = 57
      Width = 125
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 5
    end
    object cbbdatetype: TComboBox
      Left = 80
      Top = 57
      Width = 135
      Height = 22
      TabOrder = 6
      OnChange = cbbdatetypeChange
      Items.Strings = (
        #21806#31080#26085#26399
        #21457#36710#26085#26399)
    end
    object CheckBox1: TCheckBox
      Left = 625
      Top = 61
      Width = 153
      Height = 17
      Caption = #20351#29992#28151#26816#21069#21457#36710#26085#26399
      TabOrder = 7
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1010
    ExplicitWidth = 1010
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
    Top = 145
    Width = 1010
    Height = 393
    ExplicitTop = 161
    ExplicitWidth = 1010
    ExplicitHeight = 377
    inherited GroupBox1: TGroupBox
      Width = 1010
      Height = 393
      ExplicitWidth = 1010
      ExplicitHeight = 377
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1006
        Height = 375
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'sellorgname'
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #34987#21806#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'selldate'
            Footers = <>
            Title.Caption = #21806#31080#26085#26399
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'sellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'totalprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25968
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'returnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#36824#20056#23458#31080#27454
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'returnfee'
            Footers = <>
            Title.Caption = #36864#31080#25163#32493#36153
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#25968
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'cancelmoeny'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#31080#27454
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'receivemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#25910
          end
          item
            EditButtons = <>
            FieldName = 'divideprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20998#37197#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'localincome'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21010#20837#26412#31449#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'payprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24322#31449#25910#20837
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31449#21153#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#24494#26426#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31354#35843#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#38468#21152#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#37197#27700#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20445#38505#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20854#20182
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#29123#27833#36153
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23567#35745
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'baseprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22522#26412#36816#36153
            Width = 70
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 152
    Top = 248
  end
  inherited ilToolBarDisable: TImageList
    Left = 216
    Top = 272
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/querySyncSaleLocal'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'datetype'
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
        Name = 'saleorgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isolddate'
        ParamType = ptInput
      end>
    Left = 312
    Top = 232
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 224
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 376
    Top = 272
  end
end
