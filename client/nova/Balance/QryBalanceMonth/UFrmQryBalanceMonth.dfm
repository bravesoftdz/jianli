inherited FrmQryBalanceMonth: TFrmQryBalanceMonth
  Caption = 'FrmQryBalanceMonth'
  WindowState = wsNormal
  OnShow = FormShow
  ExplicitWidth = 1132
  ExplicitHeight = 451
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    object lbl2: TLabel
      Left = 25
      Top = 26
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl3: TLabel
      Left = 238
      Top = 26
      Width = 14
      Height = 14
      Caption = #33267
    end
    object dtpBalancedStart: TDateTimePicker
      Left = 90
      Top = 22
      Width = 115
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      TabOrder = 0
    end
    object dtpBalancedEnd: TDateTimePicker
      Left = 262
      Top = 22
      Width = 116
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      TabOrder = 1
    end
  end
  inherited tlbShortCut: TToolBar
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
    inherited GroupBox1: TGroupBox
      inherited dbgrdhResult: TNvDbgridEh
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returnhandcharge'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25163#32493#36153
            Width = 128
          end
          item
            EditButtons = <>
            FieldName = 'returnmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#27454
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'outprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#22806#36865#27454
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'balancemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #32467#31639#20928#39046
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'income'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21512#35745
            Width = 120
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 136
    Top = 256
  end
  inherited ilToolBarDisable: TImageList
    Left = 384
    Top = 256
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'bilancemoneylist'
    QueryAddress = 'balance/queryBalancedMonth'
    Params = <
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 264
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 200
    Top = 304
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 496
    Top = 256
  end
end
