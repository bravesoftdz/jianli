inherited FrmQryPackMonthBalance: TFrmQryPackMonthBalance
  Caption = #36135#29289#26376#32467#31639#34920
  ClientHeight = 456
  ClientWidth = 918
  OnShow = FormShow
  ExplicitWidth = 934
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 918
    ExplicitWidth = 116
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object Label2: TLabel
      Left = 204
      Top = 20
      Width = 14
      Height = 14
      Caption = #33267
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 56
      Top = 17
      Width = 133
      Height = 22
      Date = 42155.000011574070000000
      Format = 'yyyy-MM'
      Time = 42155.000011574070000000
      Checked = False
      TabOrder = 0
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 238
      Top = 16
      Width = 110
      Height = 22
      Date = 42155.999988425930000000
      Format = 'yyyy-MM'
      Time = 42155.999988425930000000
      TabOrder = 1
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 918
    ExplicitWidth = 116
    ExplicitHeight = 490
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
    Width = 918
    Height = 353
    ExplicitTop = 548
    ExplicitWidth = 116
    inherited GroupBox1: TGroupBox
      Width = 918
      Height = 353
      ExplicitWidth = 116
      inherited dbgrdhResult: TNvDbgridEh
        Width = 914
        Height = 335
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'departdate'
            Footer.Alignment = taCenter
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #26085#26399
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'packdepartinvoices'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #24494#26426#32467#31639#21333#37329#39069
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'packdepartinvoicesother'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25163#24037#32467#31639#21333#37329#39069
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taRightJustify
            Title.Caption = #21512#35745
            Width = 120
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 64
    Top = 256
  end
  inherited ilToolBarDisable: TImageList
    Left = 120
    Top = 176
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'qryPackBalancelist'
    QueryAddress = 'pack/qryPackMonthBalance'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end>
    Left = 232
    Top = 176
    object jcdsResultpackdepartinvoicesother: TFloatField
      FieldName = 'packdepartinvoicesother'
    end
    object jcdsResultpackdepartinvoices: TFloatField
      FieldName = 'packdepartinvoices'
    end
    object jcdsResulttotalfee: TFloatField
      FieldName = 'totalfee'
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
  end
  inherited dsResult: TDataSource
    Top = 224
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 352
    Top = 176
  end
end
