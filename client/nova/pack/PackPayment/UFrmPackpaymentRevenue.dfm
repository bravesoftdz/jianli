inherited FrmPackpaymentRevenue: TFrmPackpaymentRevenue
  Caption = #34892#21253#26085#33829#25910#21333
  ClientHeight = 515
  ClientWidth = 1004
  OnShow = FormShow
  ExplicitWidth = 1020
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1004
    Height = 76
    ExplicitWidth = 1004
    ExplicitHeight = 76
    object lbl4: TLabel
      Left = 10
      Top = 30
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object lbl3: TLabel
      Left = 180
      Top = 29
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lblreason: TLabel
      Left = 367
      Top = 29
      Width = 56
      Height = 14
      Caption = #25968#25454#26469#28304
    end
    object Label1: TLabel
      Left = 594
      Top = 30
      Width = 42
      Height = 14
      Caption = #21150#29702#21592
    end
    object dtpstartdate: TDateTimePicker
      Left = 47
      Top = 26
      Width = 111
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 213
      Top = 26
      Width = 111
      Height = 22
      Date = 41502.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41502.639888414350000000
      TabOrder = 1
    end
    object Cobdatafrom: TComboBox
      Left = 429
      Top = 26
      Width = 120
      Height = 22
      ItemIndex = 0
      TabOrder = 2
      Text = #21457#36135
      OnChange = CobdatafromChange
      Items.Strings = (
        #21457#36135
        #21040#36135
        #23567#20214#23492#23384)
    end
    object cbbuser: TNovaCheckedComboBox
      Left = 641
      Top = 26
      Width = 111
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'SellTicketUserHelp'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'UserHelp'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1004
    ExplicitWidth = 1004
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
    Top = 121
    Width = 1004
    Height = 394
    ExplicitTop = 121
    ExplicitWidth = 1004
    ExplicitHeight = 394
    inherited GroupBox1: TGroupBox
      Width = 1004
      Height = 394
      ExplicitWidth = 1004
      ExplicitHeight = 394
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1000
        Height = 376
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #24037#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'packnum'
            Footers = <>
            Title.Caption = #29992#31080
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'sendpacktnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21463#29702#33829#25910'|'#20214#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'sendpackamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21463#29702#33829#25910'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'pickupsnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25552#39046#33829#25910'|'#20214#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'pickupamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25552#39046#33829#25910'|'#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packstrike'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20914#36134
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'moneypayable'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#32564#27454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'actupmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#32564#27454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'longlost'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24046#38169'|'#38271#27454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'shortlost'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24046#38169'|'#30701#27454
            Width = 70
          end
          item
            EditButtons = <>
            Footers = <>
            Title.Caption = #20313#39069
            Visible = False
            Width = 70
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 152
    Top = 264
  end
  inherited ilToolBarDisable: TImageList
    Left = 216
    Top = 160
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'packturnoverMap'
    QueryAddress = 'pack/queryRevenueOfDay'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_tt!moneydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_tt!moneydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_tt!userid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packdatafrom'
        ParamType = ptInput
      end>
    Left = 288
    Top = 216
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 248
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 408
    Top = 176
  end
end
