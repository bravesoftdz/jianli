inherited FrmBilldestroy: TFrmBilldestroy
  Caption = 'FrmBilldestroy'
  ClientHeight = 401
  ClientWidth = 1006
  ExplicitWidth = 1014
  ExplicitHeight = 435
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1006
    Height = 80
    ExplicitWidth = 1006
    ExplicitHeight = 80
    object lbl4: TLabel
      Left = 11
      Top = 21
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbllbcode: TLabel
      Left = 226
      Top = 21
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object Label1: TLabel
      Left = 27
      Top = 52
      Width = 42
      Height = 14
      Caption = #24223#31080#20154
    end
    object Label3: TLabel
      Left = 226
      Top = 52
      Width = 56
      Height = 14
      Caption = #36215#22987#26085#26399
    end
    object Label2: TLabel
      Left = 453
      Top = 52
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object cbborg: TNovaCheckedComboBox
      Left = 75
      Top = 18
      Width = 130
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
    object cbbbilltype: TNovaHComboBox
      Left = 288
      Top = 20
      Width = 145
      Height = 22
      ImeMode = imClose
      TabOrder = 1
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
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BilltypeHelp'
        end>
    end
    object NovaHBilldestoryer: TNovaHelp
      Left = 75
      Top = 52
      Width = 130
      Height = 22
      MaxLength = 50
      TabOrder = 2
      OnEnterColor = clSkyBlue
      OnExitColot = clWindow
      StopErrorKey = True
      OnFocusSelectAll = False
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object startDate: TDateTimePicker
      Left = 288
      Top = 52
      Width = 145
      Height = 22
      Date = 41872.857086759260000000
      Time = 41872.857086759260000000
      TabOrder = 3
    end
    object endDate: TDateTimePicker
      Left = 521
      Top = 52
      Width = 145
      Height = 22
      Date = 41872.857086759260000000
      Time = 41872.857086759260000000
      TabOrder = 4
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1006
    ExplicitWidth = 1006
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      OnClick = tbtnEditClick
    end
    inherited tbtnDelete: TToolButton
      OnClick = tbtnDeleteClick
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
    Top = 125
    Width = 1006
    Height = 276
    ExplicitTop = 125
    ExplicitWidth = 1006
    ExplicitHeight = 276
    inherited GroupBox1: TGroupBox
      Width = 1006
      Height = 276
      ExplicitWidth = 1006
      ExplicitHeight = 276
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1002
        Height = 258
        Columns = <
          item
            EditButtons = <>
            FieldName = 'billtypename'
            Footers = <>
            MaxWidth = 150
            Title.Caption = #31080#25454#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'destroyername'
            Footers = <>
            Title.Caption = #24223#31080#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'destroydate'
            Footers = <>
            Title.Caption = #24223#31080#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'destroyprice'
            Footers = <>
            Title.Caption = #24223#31080#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #26426#26500
            Width = 128
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 264
  end
  inherited ilToolBarDisable: TImageList
    Left = 248
    Top = 256
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'billdestroymap'
    QueryAddress = 'bill/listbilldestroy'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_org!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_bt!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_d!destroydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_d!destroydate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 240
  end
  inherited dsResult: TDataSource
    Left = 168
    Top = 272
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 496
    Top = 264
  end
  object jcdsDel: TjsonClientDataSet
    DataSourceName = 'dataSet'
    UpdateDataSet = 'jsonClientDel'
    QueryAddress = 'bill/listbilldestroy'
    SaveAddress = 'bill/delbilldestroy'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'delId'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 464
    Top = 200
  end
end
