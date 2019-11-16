inherited FrmTicketQuery: TFrmTicketQuery
  Left = 0
  Top = 0
  Caption = #21806#31080#38382#35759
  ClientHeight = 609
  ClientWidth = 863
  Font.Charset = ANSI_CHARSET
  Font.Name = #24494#36719#38597#40657
  KeyPreview = True
  OldCreateOrder = True
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 879
  ExplicitHeight = 647
  PixelsPerInch = 96
  TextHeight = 20
  object shpbackround: TShape
    Left = 400
    Top = 344
    Width = 52
    Height = 52
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Brush.Color = clRed
    Visible = False
  end
  object splbufferticket: TSplitter
    Left = 0
    Top = 604
    Width = 863
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    Beveled = True
    ResizeStyle = rsUpdate
    Visible = False
    ExplicitTop = 500
  end
  object pnlmain: TPanel
    Left = 0
    Top = 0
    Width = 863
    Height = 604
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object gbContextHit: TGroupBox
      Left = 0
      Top = 51
      Width = 863
      Height = 38
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = #19978#19979#25991#25805#20316#25552#31034
      TabOrder = 0
      object lblContextHint: TLabel
        Left = 2
        Top = 17
        Width = 859
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        Alignment = taCenter
        Caption = '???'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 21
      end
    end
    object gbseatplan: TGroupBox
      Left = 0
      Top = 400
      Width = 863
      Height = 204
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      Caption = #36873#20301'(F9)'
      TabOrder = 1
      Visible = False
      object scrlbxSeatPlan: TScrollBox
        Left = 334
        Top = 22
        Width = 527
        Height = 180
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
      end
      object pnlvip: TPanel
        Left = 2
        Top = 22
        Width = 332
        Height = 180
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
        object lbl10: TLabel
          Left = 5
          Top = 89
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #21345#20869#31215#20998
        end
        object lblviplastamount: TLabel
          Left = 69
          Top = 87
          Width = 65
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '1800.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl13: TLabel
          Left = 142
          Top = 89
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #21345#20869#20313#39069
        end
        object lblviplastmoney: TLabel
          Left = 206
          Top = 87
          Width = 65
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '1800.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object bvlvip: TBevel
          Left = 2
          Top = 82
          Width = 321
          Height = 3
          Shape = bsTopLine
        end
        object lbl14: TLabel
          Left = 158
          Top = 31
          Width = 44
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'IC'#21345#21495
        end
        object lbl15: TLabel
          Left = 6
          Top = 31
          Width = 59
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'IC'#21345#31867#22411
        end
        object lbl16: TLabel
          Left = 5
          Top = 55
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #39038#23458#22995#21517
        end
        object lbl17: TLabel
          Left = 142
          Top = 54
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #39038#23458#30005#35805
        end
        object lblvipname: TLabel
          Left = 69
          Top = 53
          Width = 34
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #24352#19977
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblvipcardno: TLabel
          Left = 206
          Top = 29
          Width = 80
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '88888888'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblvipcardtype: TLabel
          Left = 69
          Top = 29
          Width = 34
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #37329#21345
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblviptel: TLabel
          Left = 206
          Top = 52
          Width = 110
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '13812345678'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnclearvipinfo: TBitBtn
          Left = 6
          Top = 2
          Width = 103
          Height = 25
          Caption = '&C'#28165#31354'VIP'#20449#24687
          NumGlyphs = 2
          TabOrder = 0
          TabStop = False
        end
      end
    end
    object pnlinput: TPanel
      Left = 0
      Top = 0
      Width = 863
      Height = 51
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object gbschedulecondition: TGroupBox
        Left = 550
        Top = 0
        Width = 112
        Height = 51
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #21040#31449'/'#29677#27425'F2'
        TabOrder = 3
        object nvhelpSchedule: TNovaHelp
          Left = 3
          Top = 21
          Width = 104
          Height = 27
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          OnIdChange = nvhelpreachstationIdChange
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
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'starttime'
              Title.Caption = #22987#21457#26102#38388
              Width = 60
              Visible = True
            end>
          HelpOptions.HelpHeight = 200
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
        object nvhelpreachstation: TNovaHelp
          Left = 3
          Top = 21
          Width = 104
          Height = 27
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          Text = #21513#26519#30465#31449#21513#26519
          OnChange = nvhelpreachstationChange
          OnIdChange = nvhelpreachstationIdChange
          ValueTrim = #21513#26519#30465#31449#21513#26519
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
          HelpOptions.HelpHeight = 200
          HelpOptions.HelpWidth = 126
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
      object gb3: TGroupBox
        Left = 273
        Top = 0
        Width = 133
        Height = 51
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #26085#26399
        TabOrder = 1
        object dtpdepartdate: TDateTimePicker
          Left = 5
          Top = 20
          Width = 122
          Height = 23
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Date = 40645.642132337960000000
          Time = 40645.642132337960000000
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          ParentFont = False
          TabOrder = 0
          OnChange = dtpdepartdateChange
        end
      end
      object gb7: TGroupBox
        Left = 406
        Top = 0
        Width = 144
        Height = 51
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #21457#36710#31449
        TabOrder = 2
        object nvhlpdepartdistrict: TNovaHelp
          Left = 5
          Top = 21
          Width = 134
          Height = 27
          TabStop = False
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          Text = #21335#26124
          OnIdChange = nvhelpreachstationIdChange
          ValueTrim = #21335#26124
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
              FieldName = 'code'
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
          HelpOptions.HelpHeight = 100
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'NetStartDistrictHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
        object nvhelpdepartstation: TNovaHelp
          Left = 5
          Top = 21
          Width = 134
          Height = 27
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          Text = #21513#26519#30465#31449#21513#26519#30465#31449
          OnChange = nvhelpdepartstationChange
          OnIdChange = nvhelpreachstationIdChange
          ValueTrim = #21513#26519#30465#31449#21513#26519#30465#31449
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
          HelpOptions.HelpHeight = 100
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'StartStationHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
      end
      object grpSellNet: TGroupBox
        Left = 0
        Top = 0
        Width = 87
        Height = 51
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'F7'
        TabOrder = 4
        object chkSellNet: TCheckBox
          Left = 2
          Top = 22
          Width = 83
          Height = 27
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Caption = #21806#32852#32593#31080
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = checkBoxClick
        end
      end
      object grpshowdeparted: TGroupBox
        Left = 87
        Top = 0
        Width = 186
        Height = 51
        Align = alLeft
        Caption = 'F3'
        TabOrder = 5
        object chkshowdeparted: TCheckBox
          Left = 2
          Top = 22
          Width = 182
          Height = 27
          Align = alClient
          Caption = #26174#31034#24050#21457#29677#25110#28385#24231#29677#27425
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = chkshowdepartedClick
        end
      end
      object Button1: TButton
        Left = 680
        Top = 23
        Width = 75
        Height = 25
        Caption = #26597#35810
        TabOrder = 0
        OnClick = Button1Click
      end
    end
    object pnlschedule: TPanel
      Left = 0
      Top = 89
      Width = 863
      Height = 311
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      OnResize = pnlscheduleResize
      object nvdbgrdhschedule: TNvDbgridEh
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 778
        Height = 218
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSchedule
        Flat = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -15
        FooterFont.Name = #24494#36719#38597#40657
        FooterFont.Style = []
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        RowHeight = 26
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = [fsBold]
        OnDblClick = nvdbgrdhscheduleDblClick
        OnDrawColumnCell = nvdbgrdhscheduleDrawColumnCell
        OnGetCellParams = nvdbgrdhscheduleGetCellParams
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
        ParentName = 'FrmSellTicket'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'endstationname'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#31449
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24635#24231#20301
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'RESIDUESEATNUM'
            Footers = <>
            Title.Caption = #21487#21806
            Width = 35
          end
          item
            EditButtons = <>
            FieldName = 'residuecarrychildnum'
            Footers = <>
            Title.Caption = #21487#21806#20799#31461
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #37324#31243
            Width = 46
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #29677#27425#29366#24577
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            Title.Caption = #22987#21457#26102#38388
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#31080#20215
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#31080#20215
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'issaleafterreport'
            Footers = <>
            Title.Caption = #25253#21040#21806#31080
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #27969#27700#29677
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677
            Width = 34
          end
          item
            EditButtons = <>
            FieldName = 'planbrandmodel'
            Footers = <>
            Title.Caption = #36710#36742#21697#29260
            Width = 114
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'workwaysname'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'planunitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'planvehicleno'
            Footers = <>
            Title.Caption = #36710#29260
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'planvehicletypecustomname'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'startstationname'
            Footers = <>
            Title.Caption = #22987#21457#31449
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'isroundtrip'
            Footers = <>
            Title.Caption = #24448#36820#31080
            Width = 48
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'scheduleremarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'returntripvaliddays'
            Footers = <>
            Title.Caption = #22238#31243#31080#26377#25928#22825#25968
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #24050#21457#29677
            Width = 50
          end>
        object RowDetailData: TRowDetailPanelControlEh
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
        end
      end
    end
  end
  object dsSchedule: TDataSource
    Left = 48
    Top = 72
  end
  object jcdsvipinfo: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'VipHelp'
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_v!vipcardno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_v!status'
        ParamType = ptInput
        Value = '0'
      end>
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 304
  end
  object tmrrefreshschedule: TTimer
    Interval = 1000000
    OnTimer = tmrrefreshscheduleTimer
    Left = 400
    Top = 200
  end
end
