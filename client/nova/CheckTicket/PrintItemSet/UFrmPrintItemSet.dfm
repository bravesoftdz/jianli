inherited FrmPrintItemSet: TFrmPrintItemSet
  Caption = #19981#25171#21360#39033#30446#35774#32622
  ClientHeight = 325
  ClientWidth = 871
  OnCreate = FormCreate
  ExplicitWidth = 879
  ExplicitHeight = 359
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 871
    ExplicitWidth = 871
    object lbl3: TLabel
      Left = 418
      Top = 24
      Width = 60
      Height = 18
      Caption = #33829#36816#36710#29260
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 22
      Top = 28
      Width = 56
      Height = 14
      Caption = #25171#21360#31080#25454
    end
    object Label2: TLabel
      Left = 217
      Top = 26
      Width = 56
      Height = 14
      Caption = #25171#21360#39033#30446
    end
    object NovaHelpVehiclenos: TNovaHelp
      Left = 490
      Top = 22
      Width = 111
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
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'brandname'
          Title.Caption = #21378#29260
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHCbbTypes: TNovaHComboBox
      Left = 84
      Top = 22
      Width = 118
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
      OnChange = NovaHCbbTypesChange
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
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'PrintBillHelp'
        end>
    end
    object NovaHCbbTypeItems: TNovaHComboBox
      Left = 278
      Top = 22
      Width = 134
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
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
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'PrintBillItemHelp'
        end
        item
          DataType = ftWideString
          Name = 'filter_EQL_t!printtemplatetype.id'
          ParamType = ptInput
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 871
    ExplicitWidth = 871
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
    Width = 871
    Height = 222
    ExplicitWidth = 871
    ExplicitHeight = 222
    inherited GroupBox1: TGroupBox
      Width = 871
      Height = 222
      ExplicitWidth = 871
      ExplicitHeight = 222
      inherited dbgrdhResult: TNvDbgridEh
        Width = 867
        Height = 204
        Columns = <
          item
            EditButtons = <>
            FieldName = 'templatename'
            Footers = <>
            Title.Caption = #25171#21360#31080#25454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'itemname'
            Footers = <>
            Title.Caption = #25171#21360#39033#30446
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495#30721
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createdname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'updatedname'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 150
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'printlist'
    QueryAddress = 'system/queryPrintItemSet'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ps!printtemplatetypeitemid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ps!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_p!id'
        ParamType = ptInput
      end>
  end
  object jscdDelItem: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/deletePrintItemSet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'printtemplateitemset.id'
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
    Left = 536
    Top = 192
  end
end
