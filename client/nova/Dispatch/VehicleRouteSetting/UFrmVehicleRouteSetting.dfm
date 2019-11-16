inherited FrmVehicleRouteSetting: TFrmVehicleRouteSetting
  Caption = #36710#36742#36816#33829#32447#36335#35774#32622
  ClientHeight = 0
  ClientWidth = 927
  ExplicitWidth = 943
  ExplicitHeight = 38
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 927
    ExplicitWidth = 927
    object Label4: TLabel
      Left = 416
      Top = 24
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl3: TLabel
      Left = 206
      Top = 24
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object cbborg: TNovaCheckedComboBox
      Left = 50
      Top = 21
      Width = 135
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
    object Nvehicleno: TNovaHelp
      Left = 260
      Top = 21
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
    object NRoute: TNovaHelp
      Left = 490
      Top = 21
      Width = 142
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 2
      OnIdChange = NRouteIdChange
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 927
    ExplicitWidth = 927
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
    Width = 927
    Height = 489
    ExplicitWidth = 927
    ExplicitHeight = 313
    inherited GroupBox1: TGroupBox
      Width = 927
      Height = 489
      ExplicitWidth = 927
      ExplicitHeight = 313
      inherited dbgrdhResult: TNvDbgridEh
        Width = 923
        Height = 471
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = '   '#36710#29260#21495
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = '       '#33829#36816#32447#36335
            Width = 177
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Title.Caption = '   '#21019#24314#20154
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = '       '#21019#24314#26102#38388
            Width = 174
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Title.Caption = '   '#20462#25913#20154
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = '       '#20462#25913#26102#38388
            Width = 186
          end
          item
            EditButtons = <>
            FieldName = 'routeid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'vehicleid'
            Footers = <>
            Visible = False
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object NvDbgridEh1: TNvDbgridEh
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsResult
            Flat = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -15
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeMode = imClose
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ParentFont = False
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = #23435#20307
            TitleFont.Style = [fsBold]
            ExpOpenType = AutoOpen
            AutoSetMultiSelect = False
            AutoSetCtrlKey = False
            PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
            PrintInfo.TitleFont.Color = clWindowText
            PrintInfo.TitleFont.Height = -21
            PrintInfo.TitleFont.Name = #23435#20307
            PrintInfo.TitleFont.Style = [fsBold]
            PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
            PrintInfo.GridHeadFont.Color = clWindowText
            PrintInfo.GridHeadFont.Height = -32
            PrintInfo.GridHeadFont.Name = #23435#20307
            PrintInfo.GridHeadFont.Style = [fsBold]
            PrintInfo.TitleNullLine = 0
            PrintInfo.PrintPageFooter = True
            PrintInfo.PrintPrintFooterTime = True
            PrintInfo.PageFooterRight = #21335#20940#31185#25216
            PrintInfo.PageSize.BottomMargin = 1.000000000000000000
            PrintInfo.PageSize.LeftMargin = 1.000000000000000000
            PrintInfo.PageSize.RightMargin = 1.000000000000000000
            PrintInfo.PageSize.TopMargin = 1.000000000000000000
            PrintOptions = [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]
            PrintAutoNewLine = False
            ParentName = 'SimpleCRUDForm'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'id'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'vehicleno'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'routename'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'createby'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'createtime'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'updateby'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'updatetime'
                Footers = <>
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 112
    Top = 288
  end
  inherited ilToolBarDisable: TImageList
    Left = 200
    Top = 288
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultlist'
    QueryAddress = 'dispatch/qryvehiclerouteset'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_vr!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_vr!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_vr!routeid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 264
  end
  inherited dsResult: TDataSource
    Left = 16
    Top = 264
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 312
    Top = 304
  end
  object jcdsdelctrl: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/delvehicleroutectrl'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 200
  end
end
