inherited FrmScheduleLongStopInfo: TFrmScheduleLongStopInfo
  Caption = #29677#27425#38271#20572#20449#24687
  ClientHeight = 458
  ClientWidth = 747
  OnDeactivate = nil
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 753
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 747
    Height = 413
    ExplicitWidth = 747
    ExplicitHeight = 413
    inherited Bevel1: TBevel
      Top = 405
      Width = 713
      ExplicitTop = 405
      ExplicitWidth = 713
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 57
      Width = 747
      Height = 356
      Align = alClient
      Caption = #29677#27425#38271#20572#22788#29702#20449#24687
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 2
        Top = 16
        Width = 743
        Height = 29
        Caption = 'ToolBar1'
        Images = ImageList1
        TabOrder = 0
        object ToolButton5: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object ToolButton2: TToolButton
          Left = 8
          Top = 0
          Caption = 'ToolButton2'
          ImageIndex = 9
          OnClick = ToolButton2Click
        end
        object ToolButton4: TToolButton
          Left = 31
          Top = 0
          Caption = 'ToolButton4'
          ImageIndex = 8
          OnClick = ToolButton4Click
        end
        object ToolButton6: TToolButton
          Left = 54
          Top = 0
          Hint = #27880#38144
          Caption = 'ToolButton8'
          ImageIndex = 7
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton6Click
        end
      end
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 743
        Height = 309
        Align = alClient
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
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        TabOrder = 1
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
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
        ParentName = 'FrmScheduel'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'startdate'
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
            FieldName = 'reason'
            Footers = <>
            Title.Caption = #21407#22240
            Width = 160
          end
          item
            EditButtons = <>
            FieldName = 'approvename'
            Footers = <>
            Title.Caption = #25209#20934#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createdname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 80
          end>
        object RowDetailData: TRowDetailPanelControlEh
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object GroupBox1: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 168
              Align = alClient
              Caption = #29677#27425#20449#24687
              TabOrder = 0
              object dbgrdhResult: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 1053
                Height = 150
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                Flat = False
                FooterColor = clWindow
                FooterFont.Charset = GB2312_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -14
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                ImeMode = imClose
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                SortLocal = True
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
                jsonConnection = DMPublic.jcon
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'orgname'
                    Footers = <>
                    Title.Caption = #25152#23646#36710#31449
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'routename'
                    Footers = <>
                    Title.Caption = #25152#23646#32447#36335
                    Width = 119
                  end
                  item
                    EditButtons = <>
                    FieldName = 'code'
                    Footers = <>
                    Title.Caption = #29677#27425#21495
                    Width = 83
                  end
                  item
                    EditButtons = <>
                    FieldName = 'STARTTIME'
                    Footers = <>
                    Title.Caption = #21457#36710#26102#38388
                    Width = 67
                  end
                  item
                    EditButtons = <>
                    FieldName = 'WORKTYPENAME'
                    Footers = <>
                    Title.Caption = #33829#36816#31867#21035
                    Width = 69
                  end
                  item
                    EditButtons = <>
                    FieldName = 'WORKWAYSNAME'
                    Footers = <>
                    Title.Caption = #33829#36816#26041#24335
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'DISTRICTTYPENAME'
                    Footers = <>
                    Title.Caption = #33829#36816#21306#22495
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TYPENAME'
                    Footers = <>
                    Title.Caption = #29677#27425#31867#22411
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'RUNTIME'
                    Footers = <>
                    Title.Caption = #36816#34892#26102#38388
                    Width = 66
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISPROPRIETARY'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#26412#31449#19987#33829
                    Width = 100
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISOVERTIME'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#21152#29677#29677#27425
                    Width = 100
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISSELLRETURNTICKET'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#21452#31243#29677#27425
                    Width = 100
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISLINEWORK'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#27969#27700#29677#27425
                    Width = 100
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISORIGINATOR'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#36807#36335#29677#27425
                    Width = 100
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISSALEAFTERREPORT'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#25253#21040#21518#21806#31080
                    Width = 114
                  end
                  item
                    Checkboxes = True
                    EditButtons = <>
                    FieldName = 'ISCANMIXCHECK'
                    Footers = <>
                    KeyList.Strings = (
                      'true'
                      'false')
                    Title.Caption = #26159#21542#20801#35768#28151#26816
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PLANSEATNUM'
                    Footers = <>
                    Title.Caption = #35745#21010#24231#20301#25968
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'VIASTATION'
                    Footers = <>
                    Title.Caption = #36884#24452#31449#28857
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PRINTINFO'
                    Footers = <>
                    Title.Caption = #29677#27425#25171#21360#20449#24687
                    Width = 127
                  end
                  item
                    EditButtons = <>
                    FieldName = 'REMARKS'
                    Footers = <>
                    Title.Caption = #22791#27880#20449#24687
                    Width = 137
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CREATETIME'
                    Footers = <>
                    Title.Caption = #28155#21152#26102#38388
                    Width = 140
                  end
                  item
                    EditButtons = <>
                    FieldName = 'username'
                    Footers = <>
                    Title.Caption = #28155#21152#20154
                    Width = 81
                  end
                  item
                    EditButtons = <>
                    FieldName = 'UPDATETIME'
                    Footers = <>
                    Title.Caption = #20462#25913#26102#38388
                    Width = 140
                  end
                  item
                    EditButtons = <>
                    FieldName = 'spacinginterval'
                    Footers = <>
                    Title.Caption = #38388#38548#26102#38388
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'endtime'
                    Footers = <>
                    Title.Caption = #26411#29677#21457#36710#26102#38388
                    Width = 70
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
            object Panel3: TPanel
              Left = 0
              Top = -179
              Width = 0
              Height = 179
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
              object Splitter2: TSplitter
                Left = -488
                Top = 0
                Height = 179
                Align = alRight
                ExplicitLeft = 536
                ExplicitTop = 56
                ExplicitHeight = 100
              end
              object GroupBox4: TGroupBox
                Left = 0
                Top = 0
                Width = 569
                Height = 179
                Align = alClient
                Caption = #29677#27425#20572#38752#28857#20449#24687
                TabOrder = 0
                object ToolBar3: TToolBar
                  Left = 2
                  Top = 16
                  Width = 565
                  Height = 29
                  Caption = 'ToolBar1'
                  Images = ImageList1
                  TabOrder = 0
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
                    ImageIndex = 9
                    ParentShowHint = False
                    ShowHint = True
                  end
                  object ToolButton23: TToolButton
                    Left = 31
                    Top = 0
                    Hint = #20462#25913
                    Caption = 'ToolButton2'
                    ImageIndex = 0
                    ParentShowHint = False
                    ShowHint = True
                  end
                  object ToolButton22: TToolButton
                    Left = 54
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton4'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object ToolButton25: TToolButton
                    Left = 62
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton5'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object ToolButton26: TToolButton
                    Left = 70
                    Top = 0
                    Hint = #27880#38144
                    Caption = 'ToolButton8'
                    ImageIndex = 7
                    ParentShowHint = False
                    ShowHint = True
                  end
                end
                object DBGridEh2: TNvDbgridEh
                  Left = 2
                  Top = 45
                  Width = 565
                  Height = 132
                  Align = alClient
                  ColumnDefValues.Title.TitleButton = True
                  DataGrouping.GroupLevels = <>
                  Flat = False
                  FooterColor = clWindow
                  FooterFont.Charset = GB2312_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -14
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  ImeMode = imClose
                  OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                  ReadOnly = True
                  RowDetailPanel.Color = clBtnFace
                  TabOrder = 1
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
                  ParentName = 'FrmScheduel'
                  TitleAlign = taLeftJustify
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'stationname'
                      Footers = <>
                      Title.Caption = #20572#38752#28857
                      Width = 106
                    end
                    item
                      Checkboxes = True
                      EditButtons = <>
                      FieldName = 'isdepart'
                      Footers = <>
                      KeyList.Strings = (
                        'true'
                        'false')
                      Title.Caption = #26159#21542#19978#36710#28857
                      Width = 82
                    end
                    item
                      EditButtons = <>
                      FieldName = 'departtime'
                      Footers = <>
                      Title.Caption = #21457#36710#26102#38388
                      Width = 68
                    end
                    item
                      EditButtons = <>
                      FieldName = 'runtime'
                      Footers = <>
                      Title.Caption = #36816#34892#26102#38388
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'ticketentrance'
                      Footers = <>
                      Title.Caption = #26816#31080#21475
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'vehiclepark'
                      Footers = <>
                      Title.Caption = #19978#36710#21345#20301
                      Width = 120
                    end>
                  object RowDetailData: TRowDetailPanelControlEh
                  end
                end
              end
              object GroupBox2: TGroupBox
                Left = -485
                Top = 0
                Width = 485
                Height = 179
                Align = alRight
                Caption = #29677#27425#38271#20572#22788#29702#20449#24687
                TabOrder = 1
                object ToolBar2: TToolBar
                  Left = 2
                  Top = 16
                  Width = 481
                  Height = 29
                  Caption = 'ToolBar1'
                  Images = ImageList1
                  TabOrder = 0
                  object ToolButton1: TToolButton
                    Left = 0
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton5'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object ToolButton3: TToolButton
                    Left = 8
                    Top = 0
                    Caption = 'ToolButton2'
                    ImageIndex = 9
                  end
                  object ToolButton7: TToolButton
                    Left = 31
                    Top = 0
                    Caption = 'ToolButton4'
                    ImageIndex = 8
                  end
                  object ToolButton8: TToolButton
                    Left = 54
                    Top = 0
                    Hint = #27880#38144
                    Caption = 'ToolButton8'
                    ImageIndex = 7
                    ParentShowHint = False
                    ShowHint = True
                  end
                end
                object NvDbgridEh2: TNvDbgridEh
                  Left = 2
                  Top = 45
                  Width = 481
                  Height = 132
                  Align = alClient
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
                  ImeMode = imClose
                  OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                  ReadOnly = True
                  RowDetailPanel.Color = clBtnFace
                  TabOrder = 1
                  TitleFont.Charset = GB2312_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -14
                  TitleFont.Name = #23435#20307
                  TitleFont.Style = []
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
                  ParentName = 'FrmScheduel'
                  TitleAlign = taLeftJustify
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'startdate'
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
                      FieldName = 'reason'
                      Footers = <>
                      Title.Caption = #21407#22240
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'approvename'
                      Footers = <>
                      Title.Caption = #25209#20934#20154
                      Width = 80
                    end
                    item
                      EditButtons = <>
                      FieldName = 'createdname'
                      Footers = <>
                      Title.Caption = #28155#21152#20154
                      Width = 80
                    end>
                  object RowDetailData: TRowDetailPanelControlEh
                  end
                end
              end
            end
          end
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 747
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 33
        Top = 21
        Width = 42
        Height = 14
        Caption = #29677#27425#21495
      end
      object Label6: TLabel
        Left = 282
        Top = 22
        Width = 56
        Height = 14
        Caption = #25152#23646#32447#36335
      end
      object NovaHelpSchedule: TNovaHelp
        Left = 88
        Top = 18
        Width = 161
        Height = 22
        Enabled = False
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
      object NovaEdtRoute: TNovaEdit
        Left = 344
        Top = 18
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 50
        ReadOnly = True
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
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 413
    Width = 747
    ExplicitTop = 413
    ExplicitWidth = 747
    inherited bbtnSave: TBitBtn
      Left = 103
      Top = 6
      Width = 18
      Visible = False
      ExplicitLeft = 103
      ExplicitTop = 6
      ExplicitWidth = 18
    end
    inherited bbtnClose: TBitBtn
      Left = 328
      Top = 6
      Kind = bkCustom
      OnClick = bbtnCloseClick
      ExplicitLeft = 328
      ExplicitTop = 6
    end
  end
  object ImageList1: TImageList
    DrawingStyle = dsSelected
    Left = 312
    Top = 256
    Bitmap = {
      494C01010B000D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF0000000000000000007F7F7F000000
      000000000000000000007F7F7F000000000000000000000000007F7F7F000000
      000000000000000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF007F7F7F007F7F7F007F7F
      7F007F7F7F0000FFFF0000FFFF000000000000000000000000007F7F7F000000
      00007F7F7F00000000007F7F7F00000000007F7F7F00000000007F7F7F000000
      00007F7F7F00000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF00FFFFFF008484
      840000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600FFFFFF00840000000000FF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FFFFFF0084000000FF00FF00FF0000000000FF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F000000000000000000000000007F7F7F00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00C6C6C600FFFFFF00C6C6C600FF000000FFFFFF000000FF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60084848400C6C6
      C600FFFFFF00C6C6C600000000000000000000000000C6C6C600C6C6C600FFFF
      FF00FFFFFF008484840000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000007F7F7F007F7F7F00000000007F7F
      7F007F7F7F007F7F7F000000FF007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F000000FF007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF000084848400848484008484
      84008484840084840000FFFF0000FFFFFF00C6C6C600FFFFFF00FFFFFF00C6C6
      C600FFFFFF0000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000848400008484
      000084840000FFFF0000FFFFFF0000000000FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00FFFFFF0000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF00000000007F7F7F00000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00008484
      0000FFFF0000FFFFFF000000000000000000FFFFFF00C6C6C600FFFFFF00FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084840000FFFF
      0000FFFFFF0084848400FFFFFF00C6C6C600FFFFFF00FFFFFF00C6C6C600FFFF
      FF0084848400C6C6C600C6C6C600848484000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000007F7F7F007F7F7F00000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000FFFF0000FFFF
      FF00FFFF00008484000084848400FFFFFF00C6C6C600FFFFFF0084848400C6C6
      C600C6C6C6000000000084848400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C600FFFF0000FFFF0000FFFF000084848400C6C6C600C6C6C6000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60084848400C6C6C600C6C6C60000000000848484000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000007F7F7F007F7F7F00000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      000000000000000000007B7B7B00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000FF0000000000000000007B7B
      7B008400000084000000840000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000007B7B7B00000000007B7B7B00000000000000
      00000000FF000000FF000000FF00000000000000000084000000840000008400
      000084000000840000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000FF0000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000840000008400
      0000840000008400000084000000840000007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      000084000000840000007B7B7B000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF007B7B7B00000000007B7B7B000000FF000000
      FF000000FF0000000000000000000000000000000000000000007B7B7B008400
      00008400000084000000840000008400000084000000840000007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      00008400000084000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF00000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000008400000084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000840000007B7B7B00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF00000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000007B7B7B00000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      00008400000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000008400000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00007B7B7B0000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000840000000000000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000007B7B
      7B000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF00840000007B7B7B000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BDBD
      BD00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000007B7B7B00000000007B7B7B00000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF0084000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000FF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FF0000000000FF008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B008400000084000000840000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FF0000000000FF00840000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F0000000000000000007F7F7F00000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B008400000084000000840000008400
      00008400000084000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00007F7F7F007F7F7F0000FFFF00000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF0084000000840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0084000000840000008400000084000000840000008400
      0000840000007B7B7B00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00007F7F7F0000FFFF0000FFFF00000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00840000008400000084000000840000008400000084000000840000008400
      00008400000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000BDBDBD0000000000FF000000FF000000FF00
      00000000FF00FF000000FF0000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      00000000FF0000000000000000007F7F7F000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000007B7B
      7B0000000000000000000000000000000000000000007B7B7B00840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000007B7B7B0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000000000000000FF000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000000000000000000000000000FFFFFF0000000000BDBD
      BD00FFFFFF0000000000FFFFFF000000000000000000000000007B7B7B000000
      FF000000FF000000FF00000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF000000000000000000000000007F7F7F000000
      FF000000FF000000FF00000000000000000000000000FF000000FF000000FF00
      00000000000000000000000000000000FF0000000000000000007B7B7B008400
      000084000000840000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000FF000000FF000000FF0000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000007B7B7B0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFDFFF7EDDDD0000FF1F9001D5550000
      FC0FC00300000000F00FE003DFFF0000C007E00387FC00000007E003DBFB0000
      0003E0030000000000030001DDF70000800180009EEF0000C001E007DF1F0000
      C000E00F000000008001E00FDFFF00000007E0279FFF0000F01FC073DFFF0000
      F07F9E7900000000F9FF7EFEFFFF0000FFFFBF7CFFDFFFFF1FFF8F78FFCFFFFF
      07FFC760FFC7C63181FFC1410003E223C07FE0010001F007C01FE0030000F88F
      E007F0030001FC1FF001F0070003FE3F0000F8070007FC1FF003F80F000FF80F
      E00FFC0F001FF007E03FFC1F007FE223C0FFFE1F00FFC63183FFFE3F01FFFFFF
      8FFFFF3F03FFFFFF3FFFFF7FFFFFFFFFFF00FC00FEFFFFFFFF00FC00FE7FFFF8
      FF00FC00FC7FFFE0FF00FC00FC3FFF8100000000F83FFE0300000000F81FF803
      00000000F01FE00700000000F00F800F00230023E00F000000010001E007C00F
      00000000C007F00700230023C003FC07006300638283FF0300C300C38EC1FFC1
      010701071EF1FFF103FF03FF7EF9FFFC00000000000000000000000000000000
      000000000000}
  end
  object jcdsScheduleLong: TjsonClientDataSet
    DataSourceName = 'schedulelongstoplist'
    QueryAddress = 'base/qryschedulelongstop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedule.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 216
    Top = 168
  end
  object jscdDelScheduleLong: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delschedulelongstop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedulelongstop.id'
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
    Left = 96
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = jcdsScheduleLong
    Left = 320
    Top = 168
  end
end
