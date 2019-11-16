inherited FrmPrintItemSetEdt: TFrmPrintItemSetEdt
  Caption = 'FrmPrintItemSetEdt'
  ClientHeight = 306
  OnCreate = FormCreate
  ExplicitWidth = 443
  ExplicitHeight = 338
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Height = 261
    ExplicitHeight = 261
    inherited Bevel1: TBevel
      Top = 253
      ExplicitTop = 253
    end
    object lbl3: TLabel
      Left = 70
      Top = 146
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
      Left = 74
      Top = 56
      Width = 56
      Height = 14
      Caption = #25171#21360#31080#25454
    end
    object Label2: TLabel
      Left = 74
      Top = 104
      Width = 56
      Height = 14
      Caption = #25171#21360#39033#30446
    end
    object NovaHelpVehicleno: TNovaHelp
      Left = 144
      Top = 146
      Width = 160
      Height = 22
      CharCase = ecUpperCase
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
    object NovaHCbbType: TNovaHComboBox
      Left = 144
      Top = 53
      Width = 160
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = NovaHCbbTypeChange
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
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'PrintBillHelp'
        end>
    end
    object NovaHCbbTypeItem: TNovaHComboBox
      Left = 144
      Top = 97
      Width = 160
      Height = 22
      Style = csDropDownList
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
  inherited pnlOperation: TPanel
    Top = 261
    ExplicitTop = 261
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 32
    Top = 192
  end
  object jscdsavePrintItemSet: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/savePrintItemSet'
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
        Name = 'printtemplateitemset.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplateitemset.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplateitemset.isprint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplateitemset.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplateitemset.printtemplatetypeitemid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplateitemset.vehicleid'
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
      end
      item
        DataType = ftBCD
        Name = 'operationid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 136
  end
end
