inherited FrmSecuritycheckReport: TFrmSecuritycheckReport
  Caption = #36710#36742#23433#26816#26376#25253#34920
  ClientHeight = 417
  ClientWidth = 1041
  OnShow = FormShow
  ExplicitWidth = 1057
  ExplicitHeight = 456
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1041
    ExplicitWidth = 1041
    object Label8: TLabel
      Left = 215
      Top = 23
      Width = 56
      Height = 14
      Cursor = crDrag
      Caption = #23433#26816#26085#26399
    end
    object Label9: TLabel
      Left = 417
      Top = 24
      Width = 14
      Height = 14
      Cursor = crDrag
      Caption = #33267
    end
    object lbl1: TLabel
      Left = 5
      Top = 24
      Width = 56
      Height = 14
      Caption = #23433#26816#36710#31449
    end
    object startdate: TDateTimePicker
      Left = 277
      Top = 20
      Width = 100
      Height = 22
      Date = 40603.000000000000000000
      Time = 40603.000000000000000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 0
    end
    object enddate: TDateTimePicker
      Left = 459
      Top = 20
      Width = 101
      Height = 22
      Date = 40589.999988425930000000
      Time = 40589.999988425930000000
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 1
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 67
      Top = 20
      Width = 136
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1041
    ExplicitWidth = 1041
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
    Width = 1041
    Height = 314
    ExplicitWidth = 1041
    ExplicitHeight = 314
    inherited GroupBox1: TGroupBox
      Width = 1041
      Height = 314
      ExplicitWidth = 1041
      ExplicitHeight = 314
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1037
        Height = 296
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'checktime'
            Footer.Value = #21512#26684
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #23433#26816#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'count'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23433#26816#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'checkresult'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'light'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#22806#35266
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'mirror'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#20449#21495#28783
          end
          item
            EditButtons = <>
            FieldName = 'drive'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#20256#21160#31995
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'brake'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#34892#36710#21046#21160
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'turn'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#36716#21521#31995#32479
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'wheel'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#36710#36718
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'hang'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#24748#26550
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'leak'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#28082#20307#27844#38706
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'window'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#38376#31383
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'safety'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#23433#20840#35774#22791
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'camera'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#25668#20687#22836
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'returncheck'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21512#26684#26126#32454'|'#22238#31243#26816#26597
            Width = 80
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'securitymap'
    QueryAddress = 'check/qrySecuritycheckReport'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_s!checktime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_s!checktime'
        ParamType = ptInput
      end>
  end
end
