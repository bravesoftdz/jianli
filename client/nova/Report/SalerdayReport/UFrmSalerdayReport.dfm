inherited FrmSalerdayReport: TFrmSalerdayReport
  Caption = #21806#31080#21592#21806#31080#24773#20917#26085#25253#34920
  ClientHeight = 469
  ClientWidth = 1045
  OnShow = FormShow
  ExplicitWidth = 1061
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1045
    Height = 68
    ExplicitWidth = 1045
    ExplicitHeight = 68
    object lbldate: TLabel
      Left = 403
      Top = 24
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object Label1: TLabel
      Left = 597
      Top = 24
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl1: TLabel
      Left = 188
      Top = 24
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object Label3: TLabel
      Left = 745
      Top = 24
      Width = 70
      Height = 14
      Caption = #31449#22806#21806#31080#28857
    end
    object dtpstartdate: TDateTimePicker
      Left = 467
      Top = 18
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 618
      Top = 18
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object chkByselldate: TCheckBox
      Left = 57
      Top = 46
      Width = 121
      Height = 17
      Caption = #25353#21806#31080#26085#26399#32479#35745
      TabOrder = 2
    end
    object chkByseller: TCheckBox
      Left = 207
      Top = 46
      Width = 113
      Height = 17
      Caption = #25353#21806#31080#21592#32479#35745
      TabOrder = 3
      OnClick = chkBysellerClick
    end
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 250
      Top = 18
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
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
      Left = 56
      Top = 18
      Width = 127
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Version = '1.2'
      OnCheckClick = NovachkPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object salebylist: TNovaCheckedComboBox
      Left = 316
      Top = 46
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.HelpType = 'SellTicketUserHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object Nvtaketicketplace: TNovaCheckedComboBox
      Left = 824
      Top = 18
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OutTicketoutletCheckCombox'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1045
    ExplicitWidth = 1045
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
    Top = 113
    Width = 1045
    Height = 356
    ExplicitTop = 113
    ExplicitWidth = 1045
    ExplicitHeight = 356
    inherited GroupBox1: TGroupBox
      Width = 1045
      Height = 356
      ExplicitWidth = 1045
      ExplicitHeight = 356
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1041
        Height = 338
        FooterRowCount = 1
        RowHeight = 24
        SumList.Active = True
        SumList.VirtualRecords = True
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #26426#26500
            Width = 102
          end
          item
            EditButtons = <>
            FieldName = 'selldate'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21806#31080#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #24037#21495
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'sellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#21806#31080'|'#24635#24352#25968
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'totalprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#21806#31080'|'#37329#39069
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#24223#31080'|'#24352#25968
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'cancelmoeny'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#24223#31080'|'#37329#39069
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#36864#31080'|'#24352#25968
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'returnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#36864#31080'|'#37329#39069
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'returnfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#36864#31080'|'#25163#32493#36153
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'servicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#26381#21153#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'normalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#23567#35745'|'#27491#24120#31080#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'nomaltotalprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#23567#35745'|'#21806#31080#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'damagednum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#22351#31080#25968
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'ticketreturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#20973#35777#25968'|'#36864#31080#20973#35777#25968
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'changenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#20973#35777#25968'|'#25913#31614#20973#35777#25968
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'adjustnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#20973#35777#25968'|'#34917#31080#20973#35777#25968
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'totalusenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#31080#24773#20917'|'#36710#31080#20351#29992#24635#24352#25968
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31449#21153#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#25187#36153'1'
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'coolairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#31354#35843#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#38468#21152#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#27700#36153
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20445#38505#36153
            Width = 60
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
            FieldName = 'datescheduleincome'
            Footers = <>
            Title.Caption = #24403#26085#24403#29677'|'#21806#31080#25910#20837
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#20854#20182
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #22266#23450#25187#36153'|'#23567#35745
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'upmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#32564#27454
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'stationincome'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#25910#20837
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20215#24046
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutlet'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 70
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 312
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Left = 408
    Top = 232
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/querySalerdayRevenue'
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
        Name = 'isbyselldate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isbyseller'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellerids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletid'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    Left = 96
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 512
    Top = 240
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    DBGridEh = dbgrdhResult
    Left = 200
    Top = 248
  end
end
