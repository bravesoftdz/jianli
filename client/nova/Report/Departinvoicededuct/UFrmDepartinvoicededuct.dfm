inherited FrmDepartinvoicededuct: TFrmDepartinvoicededuct
  Caption = #22266#23450#25187#36153#39033#30446
  ClientHeight = 504
  ClientWidth = 843
  OnShow = FormShow
  ExplicitWidth = 851
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 843
    ExplicitWidth = 843
    object lbl1: TLabel
      Left = 19
      Top = 19
      Width = 28
      Height = 14
      Caption = #26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 207
      Top = 19
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl2: TLabel
      Left = 401
      Top = 19
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl3: TLabel
      Left = 558
      Top = 19
      Width = 70
      Height = 14
      Caption = #24320#36816#37327#21333#20301
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cbbOrgid: TNovaCheckedComboBox
      Left = 53
      Top = 16
      Width = 138
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
    object dtpstartdate: TDateTimePicker
      Left = 271
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 422
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
    object cbbdepart: TNovaHComboBox
      Left = 640
      Top = 16
      Width = 140
      Height = 22
      ImeMode = imClose
      TabOrder = 3
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'param'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Size = 1000
          Value = 'OrgManagerHelp'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 843
    ExplicitWidth = 843
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
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
  end
  inherited Panel1: TPanel
    Width = 843
    Height = 401
    ExplicitWidth = 843
    ExplicitHeight = 401
    inherited GroupBox1: TGroupBox
      Width = 843
      Height = 401
      ExplicitWidth = 843
      ExplicitHeight = 401
      inherited dbgrdhResult: TNvDbgridEh
        Width = 839
        Height = 383
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'rname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32447#36335
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'stationfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'computefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25187#36153'1'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'additionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #38468#21152#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'collairfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31354#35843#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'waterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37197#27700#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#23427
            Width = 80
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/qryDepartinvoicededuct'
    Params = <
      item
        DataType = ftString
        Name = 'printorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
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
      end>
  end
end
