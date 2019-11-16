inherited FrmPackTurnoverError: TFrmPackTurnoverError
  Caption = #34892#21253#24046#38169#26126#32454#34920
  ClientHeight = 518
  ClientWidth = 932
  OnShow = FormShow
  ExplicitWidth = 948
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 932
    ExplicitWidth = 932
    object lbl4: TLabel
      Left = 23
      Top = 25
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object lbl3: TLabel
      Left = 185
      Top = 25
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 372
      Top = 25
      Width = 56
      Height = 14
      Caption = #26597#35810#26041#24335
    end
    object lblreason: TLabel
      Left = 623
      Top = 25
      Width = 56
      Height = 14
      Caption = #25968#25454#26469#28304
    end
    object dtpstartdate: TDateTimePicker
      Left = 57
      Top = 20
      Width = 111
      Height = 22
      Date = 42005.639888414350000000
      Time = 42005.639888414350000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 218
      Top = 20
      Width = 111
      Height = 22
      Date = 42034.639888414350000000
      Time = 42034.639888414350000000
      TabOrder = 1
    end
    object cbQueryType: TComboBox
      Left = 435
      Top = 21
      Width = 145
      Height = 22
      ItemIndex = 0
      TabOrder = 2
      Text = #20840#37096
      OnChange = cbQueryTypeChange
      Items.Strings = (
        #20840#37096
        #38271#27454
        #30701#27454)
    end
    object Cobdatafrom: TComboBox
      Left = 685
      Top = 21
      Width = 120
      Height = 22
      ItemIndex = 0
      TabOrder = 3
      Text = #21457#36135
      Items.Strings = (
        #21457#36135
        #21040#36135
        #23567#20214#23492#23384)
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 932
    ExplicitWidth = 932
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
    end
    inherited tbtnEdit: TToolButton
      Caption = #24046#38169#35843#25972
      OnClick = tbtnEditClick
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
    Width = 932
    Height = 415
    ExplicitWidth = 932
    ExplicitHeight = 415
    inherited GroupBox1: TGroupBox
      Width = 932
      Height = 415
      ExplicitWidth = 932
      ExplicitHeight = 415
      inherited dbgrdhResult: TNvDbgridEh
        Width = 928
        Height = 397
        UseMultiTitle = True
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 184
  end
  inherited ilToolBarDisable: TImageList
    Left = 160
    Top = 224
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'pack/queryPackErrorReport'
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
        Name = 'querytype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'title'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packdatafrom'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    Left = 304
    Top = 216
  end
  inherited dsResult: TDataSource
    Left = 16
    Top = 152
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 480
    Top = 192
  end
end
