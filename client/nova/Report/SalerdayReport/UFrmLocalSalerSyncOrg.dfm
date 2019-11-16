inherited FrmLocalSalerSyncOrg: TFrmLocalSalerSyncOrg
  Caption = #26412#31449#21806#24322#31449#31080#27719#24635#34920
  ClientHeight = 546
  ClientWidth = 1001
  OnShow = FormShow
  ExplicitWidth = 1017
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1001
    Height = 84
    ExplicitWidth = 1001
    ExplicitHeight = 84
    object lbldate: TLabel
      Left = 220
      Top = 56
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object Label1: TLabel
      Left = 445
      Top = 54
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label2: TLabel
      Left = 22
      Top = 23
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object lbl1: TLabel
      Left = 13
      Top = 56
      Width = 56
      Height = 14
      Caption = #26085#26399#31867#22411
    end
    object dtpstartdate: TDateTimePicker
      Left = 283
      Top = 52
      Width = 141
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 482
      Top = 51
      Width = 137
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 1
    end
    object nvcbbNovachkPorg: TNovaCheckedComboBox
      Left = 70
      Top = 18
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      OnCheckClick = nvcbbNovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 283
      Top = 17
      Width = 141
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOtherOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object ChkSchedule: TCheckBox
      Left = 203
      Top = 20
      Width = 77
      Height = 17
      Caption = #29677#27425#26426#26500
      TabOrder = 4
      OnClick = ChkScheduleClick
    end
    object cbbdatetype: TComboBox
      Left = 75
      Top = 53
      Width = 126
      Height = 22
      TabOrder = 5
      Text = #21806#31080#26085#26399
      OnChange = cbbdatetypeChange
      Items.Strings = (
        #21806#31080#26085#26399
        #21457#36710#26085#26399)
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1001
    ExplicitWidth = 1001
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
    Top = 129
    Width = 1001
    Height = 417
    ExplicitTop = 129
    ExplicitWidth = 1001
    ExplicitHeight = 417
    inherited GroupBox1: TGroupBox
      Width = 1001
      Height = 417
      ExplicitWidth = 1001
      ExplicitHeight = 417
      inherited dbgrdhResult: TNvDbgridEh
        Width = 997
        Height = 399
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
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #34987#21806#26426#26500
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'selldate'
            Footers = <>
            Title.Caption = #21806#31080#26085#26399
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 89
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
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25968
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'returnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#36824#20056#23458#31080#27454
            Width = 65
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
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'cancelmoeny'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#31080#27454
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'receivemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#25910
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'divideprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20998#37197#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'payprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21010#36716#37329#39069
            Width = 100
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
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 208
  end
  inherited ilToolBarDisable: TImageList
    Left = 200
    Top = 208
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/querySalerSyncOrgRevenue'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
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
        Name = 'orgid'
        ParamType = ptInput
      end>
    Left = 296
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 480
    Top = 216
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 384
    Top = 264
  end
end
