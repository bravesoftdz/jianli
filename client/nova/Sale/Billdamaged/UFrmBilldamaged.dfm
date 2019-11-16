inherited FrmBilldamaged: TFrmBilldamaged
  Caption = #22351#31080#30331#35760
  ClientHeight = 407
  ClientWidth = 843
  ExplicitWidth = 851
  ExplicitHeight = 441
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 843
    ExplicitWidth = 843
  end
  inherited tlbShortCut: TToolBar
    Width = 843
    ExplicitWidth = 843
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
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
    Height = 304
    ExplicitWidth = 843
    ExplicitHeight = 247
    inherited GroupBox1: TGroupBox
      Width = 843
      Height = 304
      ExplicitWidth = 843
      ExplicitHeight = 247
      inherited dbgrdhResult: TNvDbgridEh
        Width = 839
        Height = 286
        ImeMode = imDisable
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'billtypename'
            Footers = <>
            Title.Caption = #31080#25454#31867#22411
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'startno'
            Footers = <>
            Title.Caption = #36215#22987#31080#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'endno'
            Footers = <>
            Title.Caption = #25130#27490#31080#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'amount'
            Footers = <>
            Title.Caption = #25968#37327
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketname'
            Footers = <>
            Title.Caption = #36864#31080#28857
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'damageddscribe'
            Footers = <>
            Title.Caption = #25439#22351#25551#36848
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'recordname'
            Footers = <>
            Title.Caption = #30331#35760#32773
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'recordip'
            Footers = <>
            Title.Caption = #30331#35760'IP'
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'recordtime'
            Footers = <>
            Title.Caption = #30331#35760#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 168
  end
  inherited ilToolBarDisable: TImageList
    Left = 152
    Top = 168
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'billdamagedmap'
    QueryAddress = 'sell/qrybilldamaged'
    Left = 232
    Top = 168
  end
  inherited dsResult: TDataSource
    Left = 16
    Top = 168
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 296
  end
end
