inherited FrmScheduleSeatReserve: TFrmScheduleSeatReserve
  Caption = #29677#27425#22266#23450#30041#20301#31649#29702
  ClientHeight = 489
  ClientWidth = 776
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 782
  ExplicitHeight = 521
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 776
    Height = 444
    ExplicitWidth = 776
    ExplicitHeight = 444
    inherited Bevel1: TBevel
      Top = 436
      Width = 742
      ExplicitTop = 384
      ExplicitWidth = 673
    end
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 776
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lbl1: TLabel
        Left = 33
        Top = 21
        Width = 42
        Height = 14
        Caption = #29677#27425#21495
      end
      object lbl2: TLabel
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
        MaxLength = 50
        ReadOnly = True
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
        Top = 16
        Width = 160
        Height = 22
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
    object grp1: TGroupBox
      Left = 0
      Top = 57
      Width = 776
      Height = 387
      Align = alClient
      Caption = #29677#27425#22266#23450#30041#20301#20449#24687
      TabOrder = 1
      object tlb1: TToolBar
        Left = 2
        Top = 16
        Width = 772
        Height = 29
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'tlb1'
        Images = ImageList
        TabOrder = 0
        object btn1: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'btn1'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btnAdd: TToolButton
          Left = 8
          Top = 0
          Hint = #28155#21152
          Caption = 'btnAdd'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = btnAddClick
        end
        object btnUpdate: TToolButton
          Left = 39
          Top = 0
          Hint = #20462#25913
          Caption = 'btnUpdate'
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUpdateClick
        end
        object btnDel: TToolButton
          Left = 70
          Top = 0
          Hint = #21024#38500
          Caption = 'ToolButton8'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDelClick
        end
      end
      object NvDbgridEh1: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 772
        Height = 340
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
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #33829#36816#36710#22411
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'brandname'
            Footers = <>
            Title.Caption = #21378#29260
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
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #30041#20301#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'seatnos'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 227
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #30041#20301#21407#22240
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 80
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
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
          end>
        object RowDetailData: TRowDetailPanelControlEh
          object pnl2: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object grp2: TGroupBox
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
            object pnl3: TPanel
              Left = 0
              Top = -179
              Width = 0
              Height = 179
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
              object spl1: TSplitter
                Left = -488
                Top = 0
                Height = 179
                Align = alRight
                ExplicitLeft = 536
                ExplicitTop = 56
                ExplicitHeight = 100
              end
              object grp3: TGroupBox
                Left = 0
                Top = 0
                Width = 569
                Height = 179
                Align = alClient
                Caption = #29677#27425#20572#38752#28857#20449#24687
                TabOrder = 0
                object tlb2: TToolBar
                  Left = 2
                  Top = 16
                  Width = 565
                  Height = 29
                  Caption = 'ToolBar1'
                  TabOrder = 0
                  object btn5: TToolButton
                    Left = 0
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton6'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn6: TToolButton
                    Left = 8
                    Top = 0
                    Hint = #28155#21152
                    Caption = 'ToolButton1'
                    ImageIndex = 9
                    ParentShowHint = False
                    ShowHint = True
                  end
                  object btn7: TToolButton
                    Left = 31
                    Top = 0
                    Hint = #20462#25913
                    Caption = 'ToolButton2'
                    ImageIndex = 0
                    ParentShowHint = False
                    ShowHint = True
                  end
                  object btn8: TToolButton
                    Left = 54
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton4'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn9: TToolButton
                    Left = 62
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton5'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn10: TToolButton
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
              object grp4: TGroupBox
                Left = -485
                Top = 0
                Width = 485
                Height = 179
                Align = alRight
                Caption = #29677#27425#38271#20572#22788#29702#20449#24687
                TabOrder = 1
                object tlb3: TToolBar
                  Left = 2
                  Top = 16
                  Width = 481
                  Height = 29
                  Caption = 'ToolBar1'
                  TabOrder = 0
                  object btn11: TToolButton
                    Left = 0
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton5'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn12: TToolButton
                    Left = 8
                    Top = 0
                    Caption = 'ToolButton2'
                    ImageIndex = 9
                  end
                  object btn13: TToolButton
                    Left = 31
                    Top = 0
                    Caption = 'ToolButton4'
                    ImageIndex = 8
                  end
                  object btn14: TToolButton
                    Left = 54
                    Top = 0
                    Hint = #27880#38144
                    Caption = 'btn14'
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
  end
  inherited pnlOperation: TPanel
    Top = 444
    Width = 776
    ExplicitTop = 444
    ExplicitWidth = 776
    inherited bbtnSave: TBitBtn
      Visible = False
    end
    inherited bbtnClose: TBitBtn
      Left = 314
      Top = 8
      ExplicitLeft = 314
      ExplicitTop = 8
    end
  end
  inherited ImageList: TImageList
    Left = 128
    Top = 160
  end
  object jcsdQryReaserve: TjsonClientDataSet
    DataSourceName = 'reservelist'
    QueryAddress = 'base/qryScheduleseatreserve'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 200
  end
  object ds1: TDataSource
    DataSet = jcsdQryReaserve
    Left = 112
    Top = 216
  end
  object jcsdQryDelReaserve: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delscheduleseatreserve'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleseatreserve.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.updateby'
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
    Left = 424
    Top = 176
  end
end
