inherited FrmVehicleRouteSettingAdd: TFrmVehicleRouteSettingAdd
  Caption = 'FrmVehicleRouteSettingAdd'
  ClientHeight = 333
  ClientWidth = 522
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 528
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 522
    Height = 288
    ExplicitWidth = 522
    ExplicitHeight = 288
    inherited Bevel1: TBevel
      Top = 280
      Width = 488
      ExplicitTop = 280
      ExplicitWidth = 488
    end
    object Bevel2: TBevel
      Left = -134
      Top = 286
      Width = 656
      Height = 2
      Anchors = [akLeft, akRight, akBottom]
      ExplicitTop = 279
      ExplicitWidth = 571
    end
    object lbl3: TLabel
      Left = 38
      Top = 94
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label4: TLabel
      Left = 52
      Top = 46
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object NvDbgridEh1: TNvDbgridEh
      Left = 267
      Top = 23
      Width = 237
      Height = 246
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = DataSource1
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -14
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      ImeMode = imClose
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      PopupMenu = PopupMenu1
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -14
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      ExpOpenType = AutoOpen
      AutoSetMultiSelect = False
      AutoSetCtrlKey = False
      PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
      PrintInfo.TitleFont.Color = clWindowText
      PrintInfo.TitleFont.Height = -19
      PrintInfo.TitleFont.Name = #23435#20307
      PrintInfo.TitleFont.Style = []
      PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
      PrintInfo.GridHeadFont.Color = clWindowText
      PrintInfo.GridHeadFont.Height = -11
      PrintInfo.GridHeadFont.Name = 'Tahoma'
      PrintInfo.GridHeadFont.Style = []
      PrintInfo.TitleNullLine = 0
      PrintInfo.PrintPageFooter = True
      PrintInfo.PrintPrintFooterTime = True
      PrintInfo.PageFooterRight = #21335#20940#31185#25216
      PrintInfo.PageSize.BottomMargin = 1.000000000000000000
      PrintInfo.PageSize.LeftMargin = 1.000000000000000000
      PrintInfo.PageSize.RightMargin = 1.000000000000000000
      PrintInfo.PageSize.TopMargin = 1.000000000000000000
      PrintOptions = [pghOptimalColWidths]
      PrintAutoNewLine = False
      ParentName = 'FrmStandardpriceItem'
      TitleAlign = taLeftJustify
      Columns = <
        item
          Checkboxes = True
          EditButtons = <>
          FieldName = 'isselect'
          Footer.Value = #21512#35745
          Footer.ValueType = fvtStaticText
          Footers = <>
          Title.Caption = #36873#25321
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'name'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = '     '#32447'   '#36335
          Width = 143
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object Nvehicleno: TNovaHelp
      Left = 98
      Top = 91
      Width = 142
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      MaxLength = 50
      TabOrder = 1
      OnIdChange = NvehiclenoIdChange
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
          Title.Caption = #36710#29260#21495
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25253#21040#21345
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbborg: TNovaHComboBox
      Left = 98
      Top = 43
      Width = 142
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 288
    Width = 522
    ExplicitTop = 288
    ExplicitWidth = 522
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 72
    Top = 152
  end
  object jcdssave: TjsonClientDataSet
    DataSourceName = 'resultlist'
    SaveAddress = 'dispatch/savevehicleroute'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeids'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 208
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = jcdsSaveCtrl
    Left = 328
    Top = 176
  end
  object jcdsSaveCtrl: TjsonClientDataSet
    DataSourceName = 'resultlist'
    QueryAddress = 'dispatch/qryroutebyrid'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 344
    Top = 104
  end
  object PopupMenu1: TPopupMenu
    Left = 416
    Top = 128
    object N1: TMenuItem
      Caption = #20840#36873
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21453#36873
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20840#19981#36873
      OnClick = N3Click
    end
  end
end
