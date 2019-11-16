inherited frmInsuretypeticketprice: TfrmInsuretypeticketprice
  Caption = #20445#38505#31867#22411#31080#20215
  ClientHeight = 434
  ClientWidth = 837
  ExplicitWidth = 853
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 837
    ExplicitWidth = 837
    object lblorg: TLabel
      Left = 16
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#36710#31449
    end
    object Label1: TLabel
      Left = 232
      Top = 22
      Width = 56
      Height = 14
      Caption = #20445#38505#31867#22411
    end
    object cbborgid: TNovaHComboBox
      Left = 77
      Top = 19
      Width = 141
      Height = 22
      ImeMode = imClose
      TabOrder = 0
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
      HelpOptions.DisAll = True
      HelpOptions.AutoSelectFirst = True
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
          Value = 'OrgHelp'
        end>
    end
    object NHInsuranceType: TNovaHelp
      Left = 291
      Top = 19
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
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
          Title.Caption = #20445#38505#31867#22411
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #20445#38505#32534#30721
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'InsuretypeHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 837
    ExplicitWidth = 837
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
    Width = 837
    Height = 331
    ExplicitWidth = 837
    inherited GroupBox1: TGroupBox
      Width = 837
      Height = 331
      ExplicitWidth = 837
      inherited dbgrdhResult: TNvDbgridEh
        Width = 833
        Height = 313
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#36710#31449
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'insuretypename'
            Footers = <>
            Title.Caption = #20445#38505#31867#22411
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'fromprice'
            Footers = <>
            Title.Caption = #36215#22987#20215
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'endprice'
            Footers = <>
            Title.Caption = #25130#27490#20215
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 112
    Top = 280
  end
  inherited ilToolBarDisable: TImageList
    Left = 168
    Top = 280
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'map'
    QueryAddress = 'base/qryinsuretypeprice'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_s!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!orgid'
        ParamType = ptInput
      end>
    Left = 448
    Top = 256
  end
  inherited dsResult: TDataSource
    Left = 376
    Top = 248
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 608
    Top = 320
  end
  object jscdDelinsuretypeprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/deleteinsuretypeprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'insuretypeticketprice.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 200
    Top = 176
  end
end
