inherited FrmInsuranceTypeFares: TFrmInsuranceTypeFares
  Caption = #20445#38505#31867#22411#31080#20215
  ClientHeight = 489
  ClientWidth = 849
  ExplicitWidth = 865
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 849
    ExplicitWidth = 849
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
    object NHInsuranceType: TNovaHelp
      Left = 291
      Top = 19
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
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
    object cbborgid: TNovaHComboBox
      Left = 78
      Top = 19
      Width = 141
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
  end
  inherited tlbShortCut: TToolBar
    Width = 849
    ExplicitWidth = 849
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
    Width = 849
    Height = 386
    ExplicitWidth = 849
    ExplicitHeight = 386
    inherited GroupBox1: TGroupBox
      Width = 849
      Height = 386
      ExplicitWidth = 849
      ExplicitHeight = 386
      inherited dbgrdhResult: TNvDbgridEh
        Width = 845
        Height = 368
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#36710#31449
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'insuretypename'
            Footers = <>
            Title.Caption = #20445#38505#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'fromprice'
            Footers = <>
            Title.Caption = #36215#22987#31080#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'endprice'
            Footers = <>
            Title.Caption = #25130#27490#31080#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 208
  end
  inherited ilToolBarDisable: TImageList
    Left = 168
    Top = 216
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'qryInsuranceTypeFaresList'
    QueryAddress = 'base/qryInsuranceTypeFares'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_s!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end>
    Left = 240
    Top = 256
  end
  inherited dsResult: TDataSource
    Top = 192
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 320
    Top = 280
  end
  object jscdDelinsuretypefares: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delinsuretypefares'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'insurancetypefares.id'
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
    Left = 408
    Top = 304
  end
end
