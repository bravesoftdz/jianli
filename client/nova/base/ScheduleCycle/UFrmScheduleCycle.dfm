inherited FrmScheduleCycle: TFrmScheduleCycle
  Caption = #29677#27425#24490#29615#31649#29702
  ClientHeight = 496
  ClientWidth = 1043
  OnShow = FormShow
  ExplicitWidth = 1059
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1043
    Height = 99
    ExplicitWidth = 1043
    ExplicitHeight = 99
    object Label2: TLabel
      Left = 417
      Top = 26
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label3: TLabel
      Left = 645
      Top = 27
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label1: TLabel
      Left = 208
      Top = 25
      Width = 70
      Height = 14
      Caption = #24490#29615#26377#25928#26399
    end
    object Label4: TLabel
      Left = 9
      Top = 26
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl3: TLabel
      Left = 222
      Top = 63
      Width = 56
      Height = 14
      Caption = #24490#29615#36710#36742
    end
    object lblvehicletypeid: TLabel
      Left = 9
      Top = 63
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#22411
    end
    object lbl1: TLabel
      Left = 631
      Top = 62
      Width = 56
      Height = 14
      Caption = #21378#29260#22411#21495
    end
    object lblunitid: TLabel
      Left = 417
      Top = 63
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 694
      Top = 23
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 3
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
          Title.Caption = #29677#27425#21495
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object DateTpDepartDate: TDateTimePicker
      Left = 286
      Top = 21
      Width = 120
      Height = 22
      Date = 40621.664476805560000000
      Time = 40621.664476805560000000
      ShowCheckbox = True
      TabOrder = 1
    end
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 72
      Top = 21
      Width = 120
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object ChkIsOvertime: TCheckBox
      Left = 823
      Top = 26
      Width = 97
      Height = 17
      Caption = #21152#29677#29677#27425
      TabOrder = 4
    end
    object NovaHelpVehicleTypes: TNovaHelp
      Left = 72
      Top = 58
      Width = 120
      Height = 22
      MaxLength = 50
      TabOrder = 5
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
          Title.Caption = #36710#22411#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25805#20316#30721
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehicletypeHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpBrand: TNovaHelp
      Left = 694
      Top = 58
      Width = 120
      Height = 22
      MaxLength = 50
      TabOrder = 8
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
          Title.Caption = #21378#29260
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #22411#21495
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclebrandmodelHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpUnits: TNovaHelp
      Left = 479
      Top = 58
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 7
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
          Title.Caption = #21333#20301#21517#31216
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
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpVehicleno: TNovaHelp
      Left = 288
      Top = 58
      Width = 118
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
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
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
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
    object NovaEdtName: TNovaHelp
      Left = 479
      Top = 21
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 2
      OnKeyPress = NovaEdtNameKeyPress
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
    Width = 1043
    ExplicitWidth = 1043
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
    Top = 144
    Width = 1043
    Height = 352
    ExplicitTop = 144
    ExplicitWidth = 1043
    ExplicitHeight = 352
    object Splitter1: TSplitter [0]
      Left = 0
      Top = 174
      Width = 1043
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 162
      ExplicitWidth = 775
    end
    object Splitter2: TSplitter [1]
      Left = 879
      Top = 0
      Height = 174
      Align = alRight
      ExplicitLeft = 552
      ExplicitTop = 144
      ExplicitHeight = 100
    end
    inherited GroupBox1: TGroupBox
      Width = 879
      Height = 174
      Caption = #24490#29615#32452#20449#24687
      ExplicitWidth = 879
      ExplicitHeight = 174
      inherited dbgrdhResult: TNvDbgridEh
        Width = 875
        Height = 156
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #24490#29615#32452#21517
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'startdate'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #24320#22987#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'enddate'
            Footers = <>
            Title.Caption = #32467#26463#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicleperiod'
            Footers = <>
            Title.Caption = #36710#36742#24490#29615'|'#21608#26399
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'vehiclestep'
            Footers = <>
            Title.Caption = #36710#36742#24490#29615'|'#38388#38548
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'driverperiod'
            Footers = <>
            Title.Caption = #39550#39542#21592#24490#29615'|'#21608#26399
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'driverstep'
            Footers = <>
            Title.Caption = #39550#39542#21592#24490#29615'|'#38388#38548
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'drivernum'
            Footers = <>
            Title.Caption = #39550#39542#21592#24490#29615'|'#24403#29677#20154#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'stewardperiod'
            Footers = <>
            Title.Caption = #20056#21153#21592#24490#29615'|'#21608#26399
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'stewardstep'
            Footers = <>
            Title.Caption = #20056#21153#21592#24490#29615'|'#38388#38548
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'stewardnum'
            Footers = <>
            Title.Caption = #20056#21153#21592#24490#29615'|'#24403#29677#20154#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'username'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 120
          end>
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 177
      Width = 1043
      Height = 175
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1043
        Height = 175
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel3'
        TabOrder = 0
        object GroupBox4: TGroupBox
          Left = 0
          Top = 0
          Width = 230
          Height = 175
          Align = alLeft
          Caption = #24490#29615#29677#27425
          TabOrder = 0
          object NvDbgridEh2: TNvDbgridEh
            Left = 2
            Top = 45
            Width = 226
            Height = 128
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = DsCycleschemesschedule
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeMode = imClose
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            ExpOpenType = AutoOpen
            AutoSetMultiSelect = False
            AutoSetCtrlKey = False
            PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
            ParentName = 'FrmScheduleCyle'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'helpcode'
                Footers = <>
                Title.Caption = #29677#27425#21495
                Width = 61
              end
              item
                EditButtons = <>
                FieldName = 'starttime'
                Footers = <>
                Title.Caption = #21457#36710#26102#38388
                Width = 69
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
          object ToolBar3: TToolBar
            Left = 2
            Top = 16
            Width = 226
            Height = 29
            ButtonHeight = 30
            ButtonWidth = 31
            Caption = 'ToolBar1'
            Images = ilToolBar
            TabOrder = 1
            object ToolButton20: TToolButton
              Left = 0
              Top = 0
              Width = 8
              Caption = 'ToolButton6'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton21: TToolButton
              Left = 8
              Top = 0
              Hint = #28155#21152
              Caption = 'ToolButton1'
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton21Click
            end
            object ToolButton23: TToolButton
              Left = 39
              Top = 0
              Hint = #20462#25913
              Caption = 'ToolButton2'
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton23Click
            end
            object ToolButton22: TToolButton
              Left = 70
              Top = 0
              Width = 8
              Caption = 'ToolButton4'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton26: TToolButton
              Left = 78
              Top = 0
              Hint = #27880#38144
              Caption = 'ToolButton8'
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton26Click
            end
            object ToolButton25: TToolButton
              Left = 109
              Top = 0
              Width = 8
              Caption = 'ToolButton5'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton29: TToolButton
              Left = 117
              Top = 0
              Caption = 'ToolButton29'
              ImageIndex = 9
              OnClick = ToolButton29Click
            end
            object ToolButton31: TToolButton
              Left = 148
              Top = 0
              Caption = 'ToolButton31'
              ImageIndex = 10
              OnClick = ToolButton31Click
            end
          end
        end
        object GroupBox5: TGroupBox
          Left = 230
          Top = 0
          Width = 401
          Height = 175
          Align = alClient
          Caption = #24490#29615#36710#22411'/'#36710#36742
          TabOrder = 1
          object NvDbgridEh3: TNvDbgridEh
            Left = 2
            Top = 45
            Width = 397
            Height = 128
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsVehicle
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeMode = imClose
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            ExpOpenType = AutoOpen
            AutoSetMultiSelect = False
            AutoSetCtrlKey = False
            PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
            ParentName = 'FrmScheduleCyle'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'vehicletypename'
                Footers = <>
                Title.Caption = #36710#22411
                Width = 110
              end
              item
                EditButtons = <>
                FieldName = 'brandname'
                Footers = <>
                Title.Caption = #21378#29260#22411#21495
                Width = 110
              end
              item
                EditButtons = <>
                FieldName = 'rationseatnum'
                Footers = <>
                Title.Caption = #24231#20301#25968
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'unitname'
                Footers = <>
                Title.Caption = #33829#36816#21333#20301
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'vehicleno'
                Footers = <>
                Title.Caption = #36710#29260#21495#30721
                Width = 70
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
          object ToolBar1: TToolBar
            Left = 2
            Top = 16
            Width = 397
            Height = 29
            ButtonHeight = 30
            ButtonWidth = 31
            Caption = 'ToolBar1'
            Images = ilToolBar
            TabOrder = 1
            object ToolButton1: TToolButton
              Left = 0
              Top = 0
              Width = 8
              Caption = 'ToolButton6'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton2: TToolButton
              Left = 8
              Top = 0
              Hint = #28155#21152
              Caption = 'ToolButton1'
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton2Click
            end
            object ToolButton3: TToolButton
              Left = 39
              Top = 0
              Hint = #20462#25913
              Caption = 'ToolButton2'
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton3Click
            end
            object ToolButton4: TToolButton
              Left = 70
              Top = 0
              Width = 8
              Caption = 'ToolButton4'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton6: TToolButton
              Left = 78
              Top = 0
              Hint = #27880#38144
              Caption = 'ToolButton8'
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton6Click
            end
            object ToolButton32: TToolButton
              Left = 109
              Top = 0
              Caption = 'ToolButton32'
              ImageIndex = 9
              OnClick = ToolButton32Click
            end
            object ToolButton33: TToolButton
              Left = 140
              Top = 0
              Caption = 'ToolButton33'
              ImageIndex = 10
              OnClick = ToolButton33Click
            end
          end
        end
        object GroupBox6: TGroupBox
          Left = 631
          Top = 0
          Width = 220
          Height = 175
          Align = alRight
          Caption = #24490#29615#21496#26426
          TabOrder = 2
          object NvDbgridEh4: TNvDbgridEh
            Left = 2
            Top = 45
            Width = 216
            Height = 128
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsDriver
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeMode = imClose
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            ExpOpenType = AutoOpen
            AutoSetMultiSelect = False
            AutoSetCtrlKey = False
            PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
            ParentName = 'FrmScheduleCyle'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'drivername'
                Footers = <>
                Title.Caption = #22995#21517
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'code'
                Footers = <>
                Title.Caption = #24037#21495
                Width = 50
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
          object ToolBar2: TToolBar
            Left = 2
            Top = 16
            Width = 216
            Height = 29
            ButtonHeight = 30
            ButtonWidth = 31
            Caption = 'ToolBar1'
            Images = ilToolBar
            TabOrder = 1
            object ToolButton7: TToolButton
              Left = 0
              Top = 0
              Width = 8
              Caption = 'ToolButton6'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton8: TToolButton
              Left = 8
              Top = 0
              Hint = #28155#21152
              Caption = 'ToolButton1'
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton8Click
            end
            object ToolButton9: TToolButton
              Left = 39
              Top = 0
              Hint = #20462#25913
              Caption = 'ToolButton2'
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton9Click
            end
            object ToolButton10: TToolButton
              Left = 70
              Top = 0
              Width = 8
              Caption = 'ToolButton4'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton12: TToolButton
              Left = 78
              Top = 0
              Hint = #27880#38144
              Caption = 'ToolButton8'
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton12Click
            end
            object ToolButton5: TToolButton
              Left = 109
              Top = 0
              Caption = 'ToolButton5'
              ImageIndex = 9
              OnClick = ToolButton5Click
            end
            object ToolButton11: TToolButton
              Left = 140
              Top = 0
              Caption = 'ToolButton11'
              ImageIndex = 10
              OnClick = ToolButton11Click
            end
          end
        end
        object GroupBox7: TGroupBox
          Left = 851
          Top = 0
          Width = 192
          Height = 175
          Align = alRight
          Caption = #24490#29615#20056#21153#21592
          TabOrder = 3
          object NvDbgridEh5: TNvDbgridEh
            Left = 2
            Top = 45
            Width = 188
            Height = 128
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsSteward
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            ImeMode = imClose
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            ExpOpenType = AutoOpen
            AutoSetMultiSelect = False
            AutoSetCtrlKey = False
            PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
            ParentName = 'FrmScheduleCyle'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'stewardname'
                Footers = <>
                Title.Caption = #22995#21517
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'code'
                Footers = <>
                Title.Caption = #24037#21495
                Width = 40
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
          object ToolBar4: TToolBar
            Left = 2
            Top = 16
            Width = 188
            Height = 29
            ButtonHeight = 30
            ButtonWidth = 31
            Caption = 'ToolBar1'
            Images = ilToolBar
            TabOrder = 1
            object ToolButton13: TToolButton
              Left = 0
              Top = 0
              Width = 8
              Caption = 'ToolButton6'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton14: TToolButton
              Left = 8
              Top = 0
              Hint = #28155#21152
              Caption = 'ToolButton1'
              ImageIndex = 1
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton14Click
            end
            object ToolButton15: TToolButton
              Left = 39
              Top = 0
              Hint = #20462#25913
              Caption = 'ToolButton2'
              ImageIndex = 2
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton15Click
            end
            object ToolButton16: TToolButton
              Left = 70
              Top = 0
              Width = 8
              Caption = 'ToolButton4'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object ToolButton18: TToolButton
              Left = 78
              Top = 0
              Hint = #27880#38144
              Caption = 'ToolButton8'
              ImageIndex = 3
              ParentShowHint = False
              ShowHint = True
              OnClick = ToolButton18Click
            end
            object ToolButton17: TToolButton
              Left = 109
              Top = 0
              Caption = 'ToolButton17'
              ImageIndex = 9
              OnClick = ToolButton17Click
            end
            object ToolButton34: TToolButton
              Left = 140
              Top = 0
              Caption = 'ToolButton34'
              ImageIndex = 10
              OnClick = ToolButton34Click
            end
          end
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 882
      Top = 0
      Width = 161
      Height = 174
      Align = alRight
      Caption = #24490#29615#21608#26399
      TabOrder = 2
      object NvDbgridRules: TNvDbgridEh
        Left = 2
        Top = 169
        Width = 157
        Height = 3
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsRules
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
        ParentName = 'FrmScheduleCyle'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #36816#33829#24773#20917
            Width = 94
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object ToolBar5: TToolBar
        Left = 2
        Top = 16
        Width = 157
        Height = 29
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'ToolBar1'
        Images = ilToolBar
        TabOrder = 1
        object ToolButton19: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object ToolButton24: TToolButton
          Left = 8
          Top = 0
          Hint = #28155#21152
          Caption = 'ToolButton1'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton24Click
        end
        object ToolButton27: TToolButton
          Left = 39
          Top = 0
          Hint = #35774#32622
          Caption = 'ToolButton2'
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton27Click
        end
        object ToolButton28: TToolButton
          Left = 70
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object ToolButton30: TToolButton
          Left = 78
          Top = 0
          Hint = #27880#38144
          Caption = 'ToolButton8'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton30Click
        end
      end
      object NvDbgridEh6: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 157
        Height = 124
        Align = alTop
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        RowDetailPanel.Color = clBtnFace
        TabOrder = 2
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
        ParentName = 'FrmScheduleCyle'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #24490#29615#31867#22411
            Title.TitleButton = False
            Width = 103
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 360
    Top = 152
  end
  inherited ilToolBarDisable: TImageList
    Left = 432
    Top = 160
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'cycleschemelist'
    QueryAddress = 'base/querycyclescheme'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_s!enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_cv!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_cv!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_cv!vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_cv!vehiclebrandmodelid'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 344
    Top = 224
  end
  inherited dsResult: TDataSource
    Left = 160
    Top = 144
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 88
    Top = 144
  end
  object jcdsqrySchedule: TjsonClientDataSet
    DataSourceName = 'cycleschemesschedulelist'
    QueryAddress = 'base/qryCycleschemesschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cyclescheme.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 32
    Top = 400
  end
  object jcdsqryVehicle: TjsonClientDataSet
    DataSourceName = 'cycleschemesvehiclelist'
    QueryAddress = 'base/qryCycleschemesvehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cyclescheme.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 376
  end
  object jcdsQryDriver: TjsonClientDataSet
    DataSourceName = 'cycleschemesdriverlist'
    QueryAddress = 'base/qryCycleschemesdriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cyclescheme.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 472
    Top = 352
  end
  object jcdsQrySteward: TjsonClientDataSet
    DataSourceName = 'cycleschemesstewardlist'
    QueryAddress = 'base/qryCycleschemessteward'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cyclescheme.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 968
    Top = 384
  end
  object DataSource1: TDataSource
    DataSet = jcdsQryRules
    Left = 680
    Top = 160
  end
  object DsCycleschemesschedule: TDataSource
    DataSet = jcdsqrySchedule
    Left = 24
    Top = 448
  end
  object dsVehicle: TDataSource
    DataSet = jcdsqryVehicle
    Left = 240
    Top = 432
  end
  object dsDriver: TDataSource
    DataSet = jcdsQryDriver
    Left = 480
    Top = 432
  end
  object dsSteward: TDataSource
    DataSet = jcdsQrySteward
    Left = 984
    Top = 328
  end
  object jcdsQryRules: TjsonClientDataSet
    DataSourceName = 'schedulecyclelist'
    QueryAddress = 'base/qrySchedulecycles'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cyclescheme.id'
        ParamType = ptInput
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsQryRulesAfterScroll
    Left = 568
    Top = 152
    object jcdsQryRulestype: TWideStringField
      FieldName = 'type'
      Size = 10
    end
    object jcdsQryRulestypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdsTypes
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Lookup = True
    end
    object jcdsQryRulesrule: TWideStringField
      FieldName = 'rule'
      Size = 200
    end
    object jcdsQryRulesid: TLargeintField
      FieldName = 'id'
    end
  end
  object jcdsDelScheduleCyle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delcyclescheme'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cyclescheme.id'
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
    Left = 216
    Top = 216
  end
  object jcdsTypes: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'schedulecycle'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 536
    Top = 160
  end
  object dsRules: TDataSource
    Left = 632
    Top = 280
  end
  object jcdsDelSchedulecycle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delSchedulecycle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedulecycle.id'
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
    Left = 600
    Top = 216
  end
  object jcdsDelSchedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delCycleschemesschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemesschedule.id'
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
    Left = 72
    Top = 288
  end
  object jcdsnextSchedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/nextCycleschemesschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cycleschemesschedule.id'
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
    Left = 144
    Top = 384
  end
  object jcdsPriorSchedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/priorCycleschemesschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cycleschemesschedule.id'
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
    Left = 128
    Top = 432
  end
  object jcdsDelVehicle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delCycleschemesvehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.id'
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
    Left = 216
    Top = 328
  end
  object jcdsNextVehicle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/nextCycleschemesvehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemesvehicle.id'
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
    Top = 384
  end
  object jcdsPriorVehicle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/priorCycleschemesvehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cycleschemesvehicle.id'
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
    Left = 312
    Top = 416
  end
  object jcdsDelDriver: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delCycleschemesdriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cycleschemesdriver.id'
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
    Left = 680
    Top = 432
  end
  object jcdsPriorDriver: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/priorCycleschemesdriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemesdriver.id'
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
    Left = 552
    Top = 376
  end
  object jcdsNextDriver: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/nextCycleschemesdriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cycleschemesdriver.id'
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
    Left = 664
    Top = 376
  end
  object jcdsDelSteward: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delCycleschemessteward'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemessteward.id'
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
    Left = 840
    Top = 424
  end
  object jcdsPriorSteward: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/priorCycleschemessteward'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemessteward.id'
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
    Left = 904
    Top = 376
  end
  object jcdsNextSteward: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/nextCycleschemessteward'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'cycleschemessteward.id'
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
    Left = 912
    Top = 432
  end
end
