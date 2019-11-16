inherited FrmEachTickeIncomeSumRpt: TFrmEachTickeIncomeSumRpt
  Caption = #21508#31449#20114#21806#20114#36864#33829#25910#27719#24635#34920
  ClientHeight = 454
  ClientWidth = 973
  OnShow = FormShow
  ExplicitWidth = 989
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 973
    Height = 49
    ExplicitWidth = 973
    ExplicitHeight = 49
    object Label10: TLabel
      Left = 22
      Top = 20
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
      Left = 243
      Top = 20
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object Label2: TLabel
      Left = 441
      Top = 20
      Width = 14
      Height = 14
      Caption = #33267
    end
    object NovaChkSaleOrg: TNovaCheckedComboBox
      Left = 84
      Top = 18
      Width = 140
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
      Params = <>
    end
    object dtpBselldate: TDateTimePicker
      Left = 305
      Top = 16
      Width = 111
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      TabOrder = 1
    end
    object dtpEselldate: TDateTimePicker
      Left = 476
      Top = 16
      Width = 111
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      TabOrder = 2
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 973
    ExplicitWidth = 973
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
    Top = 94
    Width = 973
    Height = 360
    ExplicitTop = 94
    ExplicitWidth = 973
    ExplicitHeight = 360
    inherited GroupBox1: TGroupBox
      Width = 973
      Height = 360
      ExplicitWidth = 973
      ExplicitHeight = 360
      inherited dbgrdhResult: TNvDbgridEh
        Width = 969
        Height = 342
        FooterRowCount = 1
        SumList.Active = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'sellorg'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 135
          end
          item
            EditButtons = <>
            FieldName = 'scheduleorg'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #23545#26041#31449#28857
            Width = 112
          end
          item
            EditButtons = <>
            FieldName = 'sellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#21806#31080#24635#24352#25968
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'sellprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#21806#31080#24635#37329#39069
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#36864#31080#24352#25968
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'returnprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#36864#31080#37329#39069
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'returnfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#36864#31080#25163#32493#36153
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'canclenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#24223#24352#25968
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'cancleprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#24223#37329#39069
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'allnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#20195#21806#31080#24352#25968
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'allprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#38469#20195#21806#31080#37329#39069
            Width = 116
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/eachTickeIncomeSumRpt'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_ts!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ts!selldate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ts!selldate'
        ParamType = ptInput
      end>
    Left = 288
    Top = 176
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 432
    Top = 160
  end
end
