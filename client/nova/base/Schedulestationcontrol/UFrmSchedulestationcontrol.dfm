inherited FrmSchedulestationcontrol: TFrmSchedulestationcontrol
  Caption = #29677#27425#31449#28857#21806#31080#25511#21046
  ClientHeight = 454
  ClientWidth = 1051
  OnShow = FormShow
  ExplicitWidth = 1067
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1051
    Height = 49
    ExplicitWidth = 1051
    ExplicitHeight = 49
    object lbl2: TLabel
      Left = 29
      Top = 17
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
    end
    object lbl5: TLabel
      Left = 248
      Top = 17
      Width = 56
      Height = 14
      Caption = #32447#36335#21517#31216
    end
    object lblendstationname: TLabel
      Left = 484
      Top = 17
      Width = 56
      Height = 14
      Caption = #20572#38752#31449#28857
    end
    object nvhlpRoute: TNovaHelp
      Left = 309
      Top = 14
      Width = 148
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          Title.Caption = #21517#31216
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 220
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 91
      Top = 14
      Width = 137
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhlpendstation: TNovaHelp
      Left = 551
      Top = 14
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 180
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1051
    ExplicitWidth = 1051
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
      Caption = #21024#38500#31449#28857
      OnClick = tbtnDeleteClick
    end
    inherited ToolButton50: TToolButton
      Caption = #21024#38500#32447#36335
      ImageIndex = 3
      Visible = True
      OnClick = ToolButton50Click
      ExplicitWidth = 67
    end
    inherited ToolButton51: TToolButton
      Left = 355
      ExplicitLeft = 355
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 373
      Visible = False
      ExplicitLeft = 373
    end
    inherited tbtnSave: TToolButton
      Left = 381
      Visible = False
      ExplicitLeft = 381
    end
    inherited tbtnCancel: TToolButton
      Left = 451
      Visible = False
      ExplicitLeft = 451
    end
    inherited ToolButton52: TToolButton
      Left = 521
      ExplicitLeft = 521
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 539
      ExplicitLeft = 539
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 557
      Visible = False
      ExplicitLeft = 557
    end
    inherited tbtnInfo: TToolButton
      Left = 565
      ExplicitLeft = 565
    end
    inherited tbtn5: TToolButton
      Left = 635
      ExplicitLeft = 635
    end
    inherited tbtnExcel: TToolButton
      Left = 643
      ExplicitLeft = 643
    end
    inherited tbtnPrinter: TToolButton
      Left = 713
      ExplicitLeft = 713
    end
    inherited tbtn6: TToolButton
      Left = 783
      ExplicitLeft = 783
    end
    inherited tbtnClose: TToolButton
      Left = 791
      ExplicitLeft = 791
    end
  end
  inherited Panel1: TPanel
    Top = 94
    Width = 1051
    Height = 360
    ExplicitTop = 94
    ExplicitWidth = 1051
    ExplicitHeight = 360
    inherited GroupBox1: TGroupBox
      Width = 1051
      Height = 360
      ExplicitWidth = 1051
      ExplicitHeight = 360
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1047
        Height = 342
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departorgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425#26426#26500
            Width = 111
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335#21517#31216
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footers = <>
            Title.Caption = #31449#28857
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'cansellnum'
            Footers = <>
            Title.Caption = #21487#21806#24352#25968
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'canselltime'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36317#31163#21457#36710#26102#38388#21069#21487#21806#20998#38047#25968
            Width = 197
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 142
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 161
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'routeid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'stationid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'departorgid'
            Footers = <>
            Visible = False
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object nvdbgrdh1: TNvDbgridEh
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
            FooterRowCount = 1
            ImeMode = imClose
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ParentFont = False
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = #23435#20307
            TitleFont.Style = [fsBold]
            UseMultiTitle = True
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
            jsonConnection = DMPublic.jcon
            ParentName = 'SimpleCRUDForm'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orgname'
                Footer.DisplayFormat = #21512#35745
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #21806#31080#26426#26500
                Width = 135
              end
              item
                EditButtons = <>
                FieldName = 'type'
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #31867#22411
                Width = 69
              end
              item
                EditButtons = <>
                FieldName = 'typename'
                Footers = <>
                Title.Caption = #32447#36335#21517'/'#29677#27425#21495
                Width = 118
              end
              item
                EditButtons = <>
                FieldName = 'perserlldays'
                Footers = <>
                Title.Caption = #39044#21806#22825#25968
                Width = 72
              end
              item
                EditButtons = <>
                FieldName = 'createname'
                Footers = <>
                Title.Caption = #21019#24314#20154
                Width = 56
              end
              item
                EditButtons = <>
                FieldName = 'createtime'
                Footers = <>
                Title.Caption = #21019#24314#26102#38388
                Width = 142
              end
              item
                EditButtons = <>
                FieldName = 'updatename'
                Footers = <>
                Title.Caption = #20462#25913#20154
                Width = 56
              end
              item
                EditButtons = <>
                FieldName = 'updatetime'
                Footers = <>
                Title.Caption = #20462#25913#26102#38388
                Width = 161
              end
              item
                EditButtons = <>
                FieldName = 'oid'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'types'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'typeid'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'createid'
                Footers = <>
                Visible = False
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
          object nvdbgrdh2: TNvDbgridEh
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
            FooterRowCount = 1
            ImeMode = imClose
            ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ParentFont = False
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = #23435#20307
            TitleFont.Style = [fsBold]
            UseMultiTitle = True
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
            jsonConnection = DMPublic.jcon
            ParentName = 'SimpleCRUDForm'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orgname'
                Footer.DisplayFormat = #21512#35745
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #21806#31080#26426#26500
                Width = 135
              end
              item
                EditButtons = <>
                FieldName = 'type'
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #31867#22411
                Width = 69
              end
              item
                EditButtons = <>
                FieldName = 'typename'
                Footers = <>
                Title.Caption = #32447#36335#21517'/'#29677#27425#21495
                Width = 118
              end
              item
                EditButtons = <>
                FieldName = 'perserlldays'
                Footers = <>
                Title.Caption = #39044#21806#22825#25968
                Width = 72
              end
              item
                EditButtons = <>
                FieldName = 'createname'
                Footers = <>
                Title.Caption = #21019#24314#20154
                Width = 56
              end
              item
                EditButtons = <>
                FieldName = 'createtime'
                Footers = <>
                Title.Caption = #21019#24314#26102#38388
                Width = 142
              end
              item
                EditButtons = <>
                FieldName = 'updatename'
                Footers = <>
                Title.Caption = #20462#25913#20154
                Width = 56
              end
              item
                EditButtons = <>
                FieldName = 'updatetime'
                Footers = <>
                Title.Caption = #20462#25913#26102#38388
                Width = 161
              end
              item
                EditButtons = <>
                FieldName = 'oid'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'types'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'typeid'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'createid'
                Footers = <>
                Visible = False
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'base/findSchedulestationcontrolList'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sst!stationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptInputOutput
      end>
    Left = 288
    Top = 176
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 432
    Top = 160
  end
  object jcdsDel: TjsonClientDataSet
    DataSourceName = 'controlmap'
    QueryAddress = 'base/delcontrol'
    SaveAddress = 'base/delcontrol'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stationid'
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
    Left = 344
    Top = 224
  end
end
