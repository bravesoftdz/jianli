inherited FrmScheduleReport: TFrmScheduleReport
  Caption = 'FrmScheduleReport'
  ClientHeight = 434
  ClientWidth = 500
  OnShow = FormShow
  ExplicitWidth = 506
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 500
    Height = 432
    ExplicitWidth = 500
    ExplicitHeight = 432
    inherited Bevel1: TBevel
      Top = 424
      Width = 466
      Height = -8
      Visible = False
      ExplicitTop = 316
      ExplicitWidth = 403
      ExplicitHeight = -8
    end
    object Label4: TLabel
      Left = 45
      Top = 53
      Width = 42
      Height = 14
      Caption = #32456#28857#31449
    end
    object Label1: TLabel
      Left = 14
      Top = 19
      Width = 70
      Height = 14
      Caption = #25253#29677#36710#36742#65306
    end
    object LblVehicleNo: TLabel
      Left = 86
      Top = 16
      Width = 108
      Height = 16
      Caption = 'LblVehicleNo'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 320
      Top = 18
      Width = 84
      Height = 14
      Caption = #21407#35745#21010#29677#27425#65306
    end
    object LblVehicleSeatnum: TLabel
      Left = 271
      Top = 16
      Width = 27
      Height = 16
      Caption = '000'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 209
      Top = 19
      Width = 56
      Height = 14
      Caption = #24231#20301#25968#65306
    end
    object oldschcode: TLabel
      Left = 403
      Top = 16
      Width = 68
      Height = 16
      Caption = #26410#26597#35810#21040
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object grp1: TGroupBox
      Left = 26
      Top = 86
      Width = 433
      Height = 332
      Caption = #36816#34892#29677#27425#20449#24687
      TabOrder = 0
      object nvdbgrdhResult: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 429
        Height = 314
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = ds1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnKeyDown = nvdbgrdhResultKeyDown
        OnKeyUp = nvdbgrdhResultKeyUp
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = GB2312_CHARSET
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
        ParentName = 'FrmIC'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'endstationname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #24050#21806
            Width = 50
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object NHelpRoute: TNovaHelp
      Left = 95
      Top = 48
      Width = 184
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 1
      OnKeyUp = NHelpRouteKeyUp
      OnIdChange = NHelpRouteIdChange
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
          Title.Caption = #32456#28857#31449
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25805#20316#30721
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteEndHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object chktempvehicle: TCheckBox
      Left = 320
      Top = 49
      Width = 75
      Height = 18
      Caption = #39030#29677#21542
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited pnlOperation: TPanel
    Top = 432
    Width = 500
    Height = 2
    Visible = False
    ExplicitTop = 432
    ExplicitWidth = 500
    ExplicitHeight = 2
  end
  inherited ImageList: TImageList
    Top = 296
  end
  object ds1: TDataSource
    Left = 416
    Top = 264
  end
end
