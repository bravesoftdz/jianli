inherited FrmQryTakeTicketLog: TFrmQryTakeTicketLog
  Caption = #21462#31080#26085#24535#26597#35810
  ClientHeight = 425
  ClientWidth = 923
  OnShow = FormShow
  ExplicitWidth = 939
  ExplicitHeight = 463
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 923
    Height = 102
    ExplicitWidth = 923
    ExplicitHeight = 102
    object lbl1: TLabel
      Left = 240
      Top = 22
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object lbldate: TLabel
      Left = 19
      Top = 63
      Width = 56
      Height = 14
      Caption = #21462#31080#26085#26399
    end
    object Label2: TLabel
      Left = 257
      Top = 63
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label3: TLabel
      Left = 474
      Top = 22
      Width = 42
      Height = 14
      Caption = #21462#31080#28857
    end
    object lbl6: TLabel
      Left = 19
      Top = 22
      Width = 56
      Height = 14
      Caption = #21462#31080#26426#26500
    end
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 309
      Top = 19
      Width = 142
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
    object dtpstartdate: TDateTimePicker
      Left = 85
      Top = 60
      Width = 138
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 309
      Top = 60
      Width = 142
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object Nvtaketicketplace: TNovaCheckedComboBox
      Left = 532
      Top = 19
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'TicketoutletCheckCombox'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object NovaHCbbOrg: TNovaCheckedComboBox
      Left = 81
      Top = 19
      Width = 142
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
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
  end
  inherited tlbShortCut: TToolBar
    Width = 923
    ExplicitWidth = 923
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
    Top = 147
    Width = 923
    Height = 278
    ExplicitTop = 147
    ExplicitWidth = 923
    ExplicitHeight = 278
    inherited GroupBox1: TGroupBox
      Width = 923
      Height = 278
      ExplicitWidth = 923
      ExplicitHeight = 278
      inherited dbgrdhResult: TNvDbgridEh
        Width = 919
        Height = 260
        Columns = <
          item
            EditButtons = <>
            FieldName = 'sellorgname'
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
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
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schcode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #19978#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'tickettypename'
            Footers = <>
            Title.Caption = #31080#31181
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ticketprice'
            Footers = <>
            Title.Caption = #31080#20215
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            Title.Caption = #21462#31080#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #36523#20221#35777#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #25163#26426#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #36141#31080#26102#38388
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'taketime'
            Footers = <>
            Title.Caption = #21462#31080#26102#38388
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #25805#20316#29366#24577
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            Title.Caption = #35746#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'password'
            Footers = <>
            Title.Caption = #21462#31080#23494#30721
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'takeway'
            Footers = <>
            Title.Caption = #21462#31080#26041#24335
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'operatorname'
            Footers = <>
            Title.Caption = #25805#20316#21592
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'operatorgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutletsname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'takecompute'
            Footers = <>
            Title.Caption = #21462#31080#30005#33041'IP'
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'remark'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 200
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 560
    Top = 216
  end
  inherited ilToolBarDisable: TImageList
    Left = 632
    Top = 216
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'taketicketlogmap'
    QueryAddress = 'query/qryTakeTicketLog'
    Params = <
      item
        DataType = ftString
        Name = 'operatorgname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellticketorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'dtpenddate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 440
    Top = 288
  end
  inherited dsResult: TDataSource
    Left = 384
    Top = 288
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 856
    Top = 48
  end
end
