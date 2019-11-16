inherited FrmQueryInsuranceDetail: TFrmQueryInsuranceDetail
  Caption = #20445#38505#38144#21806#27719#24635#34920
  ClientHeight = 0
  ClientWidth = 116
  ExplicitWidth = 132
  ExplicitHeight = 38
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 490
    Width = 116
    Height = 124
    ExplicitWidth = 116
    ExplicitHeight = 124
    object lbl1: TLabel
      Left = 307
      Top = 14
      Width = 56
      Height = 14
      Caption = #21806#20445#26426#26500
    end
    object Label6: TLabel
      Left = 843
      Top = 14
      Width = 56
      Height = 14
      Caption = #34987#21806#26426#26500
    end
    object Label7: TLabel
      Left = 53
      Top = 14
      Width = 56
      Height = 14
      Caption = #19978#32423#26426#26500
    end
    object Label8: TLabel
      Left = 560
      Top = 14
      Width = 56
      Height = 14
      Caption = #19978#32423#26426#26500
    end
    object lbl2: TLabel
      Left = 53
      Top = 51
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl3: TLabel
      Left = 320
      Top = 51
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl7: TLabel
      Left = 560
      Top = 51
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl14: TLabel
      Left = 885
      Top = 51
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label9: TLabel
      Left = 53
      Top = 85
      Width = 56
      Height = 14
      Caption = #20445#38505#20844#21496
    end
    object cbbOrgid: TNovaCheckedComboBox
      Left = 386
      Top = 11
      Width = 150
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object cbb1: TNovaCheckedComboBox
      Left = 920
      Top = 11
      Width = 150
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'notnetOrg'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbbNovachkPorg: TNovaCheckedComboBox
      Left = 138
      Top = 11
      Width = 150
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object cbb2: TNovaCheckedComboBox
      Left = 664
      Top = 11
      Width = 150
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpstartdate: TDateTimePicker
      Left = 138
      Top = 48
      Width = 150
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      ShowCheckbox = True
      Checked = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 4
      OnChange = dtpstartdateChange
    end
    object dtpenddate: TDateTimePicker
      Left = 386
      Top = 48
      Width = 150
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      ShowCheckbox = True
      Checked = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 5
      OnChange = dtpenddateChange
    end
    object dtpBselldate: TDateTimePicker
      Left = 662
      Top = 48
      Width = 150
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 6
      OnChange = dtpBselldateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 920
      Top = 48
      Width = 150
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
      OnChange = dtpEselldateChange
    end
    object cbb3: TNovaCheckedComboBox
      Left = 138
      Top = 82
      Width = 150
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'InsurerHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 116
    Height = 490
    ExplicitWidth = 116
    ExplicitHeight = 490
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Left = 0
      Wrap = True
      ExplicitLeft = 0
      ExplicitHeight = 53
    end
    inherited tbtnInsert: TToolButton
      Left = 0
      Top = 53
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 53
    end
    inherited tbtnEdit: TToolButton
      Left = 0
      Top = 98
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 98
    end
    inherited tbtnDelete: TToolButton
      Left = 0
      Top = 143
      ExplicitLeft = 0
      ExplicitTop = 143
    end
    inherited ToolButton50: TToolButton
      Left = 70
      Top = 143
      ExplicitLeft = 70
      ExplicitTop = 143
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 88
      Top = 143
      ExplicitLeft = 88
      ExplicitTop = 143
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 0
      Top = 143
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 143
      ExplicitHeight = 53
    end
    inherited tbtnSave: TToolButton
      Left = 0
      Top = 196
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 196
    end
    inherited tbtnCancel: TToolButton
      Left = 0
      Top = 241
      ExplicitLeft = 0
      ExplicitTop = 241
    end
    inherited ToolButton52: TToolButton
      Left = 70
      Top = 241
      ExplicitLeft = 70
      ExplicitTop = 241
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 88
      Top = 241
      ExplicitLeft = 88
      ExplicitTop = 241
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 0
      Top = 241
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 241
      ExplicitHeight = 53
    end
    inherited tbtnInfo: TToolButton
      Left = 0
      Top = 294
      ExplicitLeft = 0
      ExplicitTop = 294
    end
    inherited tbtn5: TToolButton
      Left = 0
      Top = 294
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 294
      ExplicitHeight = 53
    end
    inherited tbtnExcel: TToolButton
      Left = 0
      Top = 347
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 347
    end
    inherited tbtnPrinter: TToolButton
      Left = 0
      Top = 392
      ExplicitLeft = 0
      ExplicitTop = 392
    end
    inherited tbtn6: TToolButton
      Left = 0
      Top = 392
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 392
      ExplicitHeight = 53
    end
    inherited tbtnClose: TToolButton
      Left = 0
      Top = 445
      ExplicitLeft = 0
      ExplicitTop = 445
    end
  end
  inherited Panel1: TPanel
    Top = 614
    Width = 116
    Height = 373
    ExplicitTop = 614
    ExplicitWidth = 116
    ExplicitHeight = 373
    inherited GroupBox1: TGroupBox
      Width = 116
      Height = 373
      ExplicitWidth = 116
      ExplicitHeight = 373
      inherited dbgrdhResult: TNvDbgridEh
        Width = 112
        Height = 355
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'sellorg'
            Footer.ToolTips = True
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#20445#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'htsellorg'
            Footers = <>
            Title.Caption = #34987#21806#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'irsname'
            Footers = <>
            Title.Caption = #20445#38505#20844#21496
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'sellisnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#20445#25968
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'sellismount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21806#20445#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'returnisnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#20445#25968
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'returnismount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#20445#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'cancelisnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#20445#25968
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'cancelimount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#20445#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'subtotal'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23567#35745
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'stationget'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36710#31449#25152#24471
            Width = 100
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 232
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Left = 192
    Top = 320
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'insuranceMap'
    QueryAddress = 'query/queryInsurancedetail'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_i!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_t!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_irs!id'
        ParamType = ptInput
      end>
    Left = 320
    Top = 272
  end
  inherited dsResult: TDataSource
    Left = 128
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 376
    Top = 288
  end
end
