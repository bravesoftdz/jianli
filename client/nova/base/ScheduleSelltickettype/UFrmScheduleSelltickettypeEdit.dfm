inherited frmScheduleSelltickettypeEdit: TfrmScheduleSelltickettypeEdit
  Caption = #32534#36753#29677#27425#39044#21806#31080#31181#25511#21046
  ClientHeight = 408
  ClientWidth = 648
  OnCreate = FormCreate
  ExplicitWidth = 654
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 648
    Height = 363
    ExplicitWidth = 648
    ExplicitHeight = 363
    inherited Bevel1: TBevel
      Top = 347
      Width = 612
      ExplicitTop = 276
      ExplicitWidth = 474
    end
    object lbltype: TLabel
      Left = 29
      Top = 107
      Width = 56
      Height = 14
      Caption = #39044#21806#31080#31181
    end
    object lblOrgid: TLabel
      Left = 57
      Top = 35
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object lblSellType: TLabel
      Left = 29
      Top = 71
      Width = 56
      Height = 14
      Caption = #29677#32447#31867#22411
    end
    object lbl28: TLabel
      Left = 243
      Top = 69
      Width = 8
      Height = 16
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl2: TLabel
      Left = 241
      Top = 105
      Width = 8
      Height = 16
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblRemark: TLabel
      Left = 57
      Top = 209
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object lbl3: TLabel
      Left = 243
      Top = 32
      Width = 8
      Height = 16
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl5: TLabel
      Left = 29
      Top = 106
      Width = 56
      Height = 14
      Caption = #32447#36335#21517#31216
      Visible = False
    end
    object labtype: TLabel
      Left = 29
      Top = 142
      Width = 56
      Height = 14
      Caption = #24352#25968#31867#22411
    end
    object labvalue: TLabel
      Left = 71
      Top = 176
      Width = 14
      Height = 14
      Caption = #20540
    end
    object lbl12: TLabel
      Left = 241
      Top = 105
      Width = 8
      Height = 16
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object nvcbbSelltype: TNovaComboBox
      Left = 91
      Top = 68
      Width = 144
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = nvcbbSelltypeChange
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'sellschedule'
      HelpOptions.Columnname = 'type'
    end
    object mmoMeRemark: TMemo
      Left = 91
      Top = 209
      Width = 162
      Height = 95
      TabOrder = 1
    end
    object nvHcbbOrg: TNovaHComboBox
      Left = 91
      Top = 30
      Width = 144
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
    object nvdbgrdhRouteSchedule: TNvDbgridEh
      Left = 273
      Top = 23
      Width = 331
      Height = 265
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsScheduleResult
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -14
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 3
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
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'id'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'checked'
          Footer.DisplayFormat = #21512#35745
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #36873#25321
          Width = 38
        end
        item
          EditButtons = <>
          FieldName = 'name'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #32447#36335
          Width = 118
        end
        item
          EditButtons = <>
          FieldName = 'code'
          Footers = <>
          Title.Caption = #29677#27425#21495
          Width = 59
        end
        item
          EditButtons = <>
          FieldName = 'starttime'
          Footers = <>
          Title.Caption = #21457#36710#26102#38388
          Width = 72
        end>
      object RowDetailData: TRowDetailPanelControlEh
        object pnl1: TPanel
          Left = 0
          Top = 0
          Width = 0
          Height = 0
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            0
            0)
          object bvl1: TBevel
            Left = 16
            Top = 432
            Width = 849
            Height = 2
            Anchors = [akLeft, akRight, akBottom]
          end
          object lblroute: TLabel
            Left = 48
            Top = 25
            Width = 28
            Height = 14
            Caption = #32447#36335
          end
          object lblschedule: TLabel
            Left = 303
            Top = 25
            Width = 28
            Height = 14
            Caption = #29677#27425
          end
          object Label1: TLabel
            Left = 20
            Top = 69
            Width = 56
            Height = 14
            Caption = #24320#22987#26085#26399
          end
          object lbl4: TLabel
            Left = 275
            Top = 69
            Width = 56
            Height = 14
            Caption = #32467#26463#26085#26399
          end
          object edtroute: TNovaEdit
            Left = 82
            Top = 22
            Width = 183
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
          end
          object edtschedule: TNovaEdit
            Left = 337
            Top = 22
            Width = 120
            Height = 22
            Enabled = False
            MaxLength = 50
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
          object dtpstartdate: TDateTimePicker
            Left = 82
            Top = 61
            Width = 121
            Height = 22
            Date = 40782.731706956030000000
            Time = 40782.731706956030000000
            TabOrder = 2
          end
          object dtpenddate: TDateTimePicker
            Left = 337
            Top = 66
            Width = 121
            Height = 22
            Date = 40782.731706956030000000
            Time = 40782.731706956030000000
            TabOrder = 3
          end
          object grp2: TGroupBox
            Left = 20
            Top = 105
            Width = 578
            Height = 307
            Caption = #20572#38752#31449#28857#31080#20215#20449#24687
            TabOrder = 4
            object nvdbgrdh1: TNvDbgridEh
              Left = 2
              Top = 16
              Width = 574
              Height = 289
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
              FooterRowCount = 1
              ImeMode = imDisable
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
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
              ParentName = 'FrmTicketpriceEdit'
              TitleAlign = taLeftJustify
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'id'
                  Footers = <>
                  Visible = False
                end
                item
                  EditButtons = <>
                  FieldName = 'issellable'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlue
                  Font.Height = -16
                  Font.Name = #23435#20307
                  Font.Style = []
                  Footer.DisplayFormat = #21512#35745
                  Footer.ValueType = fvtCount
                  Footers = <>
                  Title.Caption = #21487#21806
                  Width = 40
                end
                item
                  EditButtons = <>
                  FieldName = 'departstationname'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #21457#36710#31449
                  Width = 111
                end
                item
                  EditButtons = <>
                  FieldName = 'reachstationname'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #21040#36798#31449
                  Width = 72
                end
                item
                  EditButtons = <>
                  FieldName = 'fullprice'
                  Footers = <>
                  Title.Caption = #20840#31080#20215
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'halfprice'
                  Footers = <>
                  Title.Caption = #21322#31080#20215
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'studentprice'
                  Footers = <>
                  Title.Caption = #23398#29983#31080
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'moreprice'
                  Footers = <>
                  Title.Caption = #31080#20215#24046
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'toplimitprice'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #19978#38480#20215
                  Width = 50
                end
                item
                  EditButtons = <>
                  FieldName = 'typename'
                  Footers = <>
                  ReadOnly = True
                  Title.Caption = #24231#20301#31867#22411
                  Width = 62
                end
                item
                  EditButtons = <>
                  FieldName = 'scheduleplanid'
                  Footers = <>
                  Visible = False
                end
                item
                  EditButtons = <>
                  FieldName = 'scheduleid'
                  Footers = <>
                  Visible = False
                end
                item
                  EditButtons = <>
                  FieldName = 'reachstationid'
                  Footers = <>
                  Visible = False
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
          object grp1: TGroupBox
            Left = 616
            Top = 14
            Width = 249
            Height = 396
            Caption = #35813#32447#36335#23545#24212#29677#27425
            TabOrder = 5
            object nvdbgrdh3: TNvDbgridEh
              Left = 2
              Top = 16
              Width = 245
              Height = 378
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
              FooterRowCount = 1
              ImeMode = imDisable
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
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
              ParentName = 'FrmTicketpriceEdit'
              TitleAlign = taLeftJustify
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'id'
                  Footers = <>
                  Visible = False
                end
                item
                  EditButtons = <>
                  FieldName = 'checked'
                  Footer.DisplayFormat = #21512#35745
                  Footer.ValueType = fvtCount
                  Footers = <>
                  Title.Caption = #36873#25321
                  Width = 44
                end
                item
                  EditButtons = <>
                  FieldName = 'code'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  Title.Caption = #29677#27425#21495
                  Width = 80
                end
                item
                  EditButtons = <>
                  FieldName = 'starttime'
                  Footers = <>
                  Title.Caption = #21457#36710#26102#38388
                  Width = 72
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 0
          Height = 0
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          DesignSize = (
            0
            0)
          object Bevel2: TBevel
            Left = 16
            Top = 328
            Width = 605
            Height = 2
            Anchors = [akLeft, akRight, akBottom]
            ExplicitTop = 276
            ExplicitWidth = 474
          end
          object Label2: TLabel
            Left = 29
            Top = 130
            Width = 56
            Height = 14
            Caption = #39044#21806#22825#25968
          end
          object Label3: TLabel
            Left = 29
            Top = 41
            Width = 56
            Height = 14
            Caption = #25152#23646#26426#26500
          end
          object Label4: TLabel
            Left = 29
            Top = 85
            Width = 56
            Height = 14
            Caption = #29677#32447#31867#22411
          end
          object Label5: TLabel
            Left = 258
            Top = 81
            Width = 8
            Height = 16
            Caption = '*'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lbl1: TLabel
            Left = 258
            Top = 38
            Width = 8
            Height = 16
            Caption = '*'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label6: TLabel
            Left = 155
            Top = 129
            Width = 8
            Height = 16
            Caption = '*'
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 57
            Top = 170
            Width = 28
            Height = 14
            Caption = #22791#27880
          end
          object NovaComboBox1: TNovaComboBox
            Left = 92
            Top = 82
            Width = 160
            Height = 22
            Style = csDropDownList
            ImeMode = imClose
            TabOrder = 1
            OnChange = nvcbbSelltypeChange
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
            HelpOptions.HDataSourceName = 'diclist'
            HelpOptions.HQueryAddress = 'system/querydictionary'
            HelpOptions.TableName = 'sellschedule'
            HelpOptions.Columnname = 'type'
          end
          object nvhcbbOrgid: TNovaHComboBox
            Left = 92
            Top = 37
            Width = 160
            Height = 22
            Style = csDropDownList
            ImeMode = imClose
            TabOrder = 0
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
            HelpOptions.HQueryAddress = 'system/qryuserorgright'
            HelpOptions.displayFieldname = 'name'
            Params = <
              item
                DataType = ftString
                Name = 'helpType'
                ParamType = ptInput
                Value = 'OrgHelp'
              end>
          end
          object edtSellDays: TNovaEdit
            Left = 92
            Top = 127
            Width = 53
            Height = 22
            CharCase = ecUpperCase
            MaxLength = 2
            TabOrder = 2
            ValueType = ssTicket
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
          object Memo1: TMemo
            Left = 91
            Top = 167
            Width = 175
            Height = 130
            TabOrder = 3
          end
          object NvDbgridEh1: TNvDbgridEh
            Left = 288
            Top = 30
            Width = 331
            Height = 292
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsScheduleResult
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            ImeMode = imDisable
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            PopupMenu = pmMenu
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 4
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
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'id'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'checked'
                Footer.DisplayFormat = #21512#35745
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #36873#25321
                Width = 38
              end
              item
                EditButtons = <>
                FieldName = 'name'
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #32447#36335
                Width = 118
              end
              item
                EditButtons = <>
                FieldName = 'code'
                Footers = <>
                Title.Caption = #29677#27425#21495
                Width = 59
              end
              item
                EditButtons = <>
                FieldName = 'starttime'
                Footers = <>
                Title.Caption = #21457#36710#26102#38388
                Width = 72
              end>
            object RowDetailData: TRowDetailPanelControlEh
              object Panel2: TPanel
                Left = 0
                Top = 0
                Width = 0
                Height = 0
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                DesignSize = (
                  0
                  0)
                object Bevel3: TBevel
                  Left = 16
                  Top = 432
                  Width = 849
                  Height = 2
                  Anchors = [akLeft, akRight, akBottom]
                end
                object Label8: TLabel
                  Left = 48
                  Top = 25
                  Width = 28
                  Height = 14
                  Caption = #32447#36335
                end
                object Label9: TLabel
                  Left = 303
                  Top = 25
                  Width = 28
                  Height = 14
                  Caption = #29677#27425
                end
                object Label10: TLabel
                  Left = 20
                  Top = 69
                  Width = 56
                  Height = 14
                  Caption = #24320#22987#26085#26399
                end
                object Label11: TLabel
                  Left = 275
                  Top = 69
                  Width = 56
                  Height = 14
                  Caption = #32467#26463#26085#26399
                end
                object NovaEdit1: TNovaEdit
                  Left = 82
                  Top = 22
                  Width = 183
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
                end
                object NovaEdit2: TNovaEdit
                  Left = 337
                  Top = 22
                  Width = 120
                  Height = 22
                  Enabled = False
                  MaxLength = 50
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
                object DateTimePicker1: TDateTimePicker
                  Left = 82
                  Top = 61
                  Width = 121
                  Height = 22
                  Date = 40782.731706956030000000
                  Time = 40782.731706956030000000
                  TabOrder = 2
                end
                object DateTimePicker2: TDateTimePicker
                  Left = 337
                  Top = 66
                  Width = 121
                  Height = 22
                  Date = 40782.731706956030000000
                  Time = 40782.731706956030000000
                  TabOrder = 3
                end
                object GroupBox1: TGroupBox
                  Left = 20
                  Top = 105
                  Width = 578
                  Height = 307
                  Caption = #20572#38752#31449#28857#31080#20215#20449#24687
                  TabOrder = 4
                  object NvDbgridEh2: TNvDbgridEh
                    Left = 2
                    Top = 16
                    Width = 574
                    Height = 289
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
                    FooterRowCount = 1
                    ImeMode = imDisable
                    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
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
                    ParentName = 'FrmTicketpriceEdit'
                    TitleAlign = taLeftJustify
                    Columns = <
                      item
                        EditButtons = <>
                        FieldName = 'id'
                        Footers = <>
                        Visible = False
                      end
                      item
                        EditButtons = <>
                        FieldName = 'issellable'
                        Font.Charset = GB2312_CHARSET
                        Font.Color = clBlue
                        Font.Height = -16
                        Font.Name = #23435#20307
                        Font.Style = []
                        Footer.DisplayFormat = #21512#35745
                        Footer.ValueType = fvtCount
                        Footers = <>
                        Title.Caption = #21487#21806
                        Width = 40
                      end
                      item
                        EditButtons = <>
                        FieldName = 'departstationname'
                        Footer.ValueType = fvtCount
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #21457#36710#31449
                        Width = 111
                      end
                      item
                        EditButtons = <>
                        FieldName = 'reachstationname'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #21040#36798#31449
                        Width = 72
                      end
                      item
                        EditButtons = <>
                        FieldName = 'fullprice'
                        Footers = <>
                        Title.Caption = #20840#31080#20215
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'halfprice'
                        Footers = <>
                        Title.Caption = #21322#31080#20215
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'studentprice'
                        Footers = <>
                        Title.Caption = #23398#29983#31080
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'moreprice'
                        Footers = <>
                        Title.Caption = #31080#20215#24046
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'toplimitprice'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #19978#38480#20215
                        Width = 50
                      end
                      item
                        EditButtons = <>
                        FieldName = 'typename'
                        Footers = <>
                        ReadOnly = True
                        Title.Caption = #24231#20301#31867#22411
                        Width = 62
                      end
                      item
                        EditButtons = <>
                        FieldName = 'scheduleplanid'
                        Footers = <>
                        Visible = False
                      end
                      item
                        EditButtons = <>
                        FieldName = 'scheduleid'
                        Footers = <>
                        Visible = False
                      end
                      item
                        EditButtons = <>
                        FieldName = 'reachstationid'
                        Footers = <>
                        Visible = False
                      end>
                    object RowDetailData: TRowDetailPanelControlEh
                    end
                  end
                end
                object GroupBox2: TGroupBox
                  Left = 616
                  Top = 14
                  Width = 249
                  Height = 396
                  Caption = #35813#32447#36335#23545#24212#29677#27425
                  TabOrder = 5
                  object NvDbgridEh3: TNvDbgridEh
                    Left = 2
                    Top = 16
                    Width = 245
                    Height = 378
                    Align = alClient
                    ColumnDefValues.Title.TitleButton = True
                    DataGrouping.GroupLevels = <>
                    DataSource = dsScheduleResult
                    Flat = False
                    FooterColor = clWindow
                    FooterFont.Charset = GB2312_CHARSET
                    FooterFont.Color = clWindowText
                    FooterFont.Height = -14
                    FooterFont.Name = #23435#20307
                    FooterFont.Style = []
                    FooterRowCount = 1
                    ImeMode = imDisable
                    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                    PopupMenu = pmMenu
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
                    ParentName = 'FrmTicketpriceEdit'
                    TitleAlign = taLeftJustify
                    Columns = <
                      item
                        EditButtons = <>
                        FieldName = 'id'
                        Footers = <>
                        Visible = False
                      end
                      item
                        EditButtons = <>
                        FieldName = 'checked'
                        Footer.DisplayFormat = #21512#35745
                        Footer.ValueType = fvtCount
                        Footers = <>
                        Title.Caption = #36873#25321
                        Width = 44
                      end
                      item
                        EditButtons = <>
                        FieldName = 'code'
                        Footer.ValueType = fvtCount
                        Footers = <>
                        Title.Caption = #29677#27425#21495
                        Width = 80
                      end
                      item
                        EditButtons = <>
                        FieldName = 'starttime'
                        Footers = <>
                        Title.Caption = #21457#36710#26102#38388
                        Width = 72
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
    object nvhlpRoute: TNovaHelp
      Left = 91
      Top = 104
      Width = 144
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 4
      Visible = False
      OnChange = nvhlpRouteChange
      OnIdChange = nvhlpRouteIdChange
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
    object nvcbbTickettypes: TNovaCheckedComboBox
      Left = 91
      Top = 104
      Width = 144
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'param'
          ParamType = ptInput
        end
        item
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketTypeHelp'
        end>
    end
    object nvcbbtype: TNovaComboBox
      Left = 91
      Top = 139
      Width = 78
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 6
      OnChange = nvcbbtypeChange
      Items.Strings = (
        '')
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'scheduleselltickettype'
      HelpOptions.Columnname = 'canselltype'
    end
    object nvedtvalue: TNovaEdit
      Left = 91
      Top = 173
      Width = 78
      Height = 22
      MaxLength = 3
      TabOrder = 7
      Text = '0'
      TextHint = '0'
      OnChange = nvedtvalueChange
      ValueTrim = '0'
      ValueType = ssNumber
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
  inherited pnlOperation: TPanel
    Top = 363
    Width = 648
    ExplicitTop = 363
    ExplicitWidth = 648
    inherited bbtnSave: TBitBtn
      Left = 219
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 219
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 419
      Top = 6
      ExplicitLeft = 419
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Top = 240
    Bitmap = {
      494C0101050007008C0018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000600000003000000001002000000000000048
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000081AD8800588E
      61005A916400678D6B0093959300919591008C948C0090959100919591009094
      900090949000949492008C918C00688D6E00548B5C0055895B005A8F64005D93
      6700578F6000A4AEA50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000021B843002CCB
      610020C5500046B55600E2DDE00083D0A0005CC98300BBD5C500EAE0E600DADB
      DA00D7D8D700E1D8DD00C9CECB0056C87D0018C14A0013AC2D0020BC47002FCF
      650026D3550068956E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031B7570033C4
      6E0026BC5C0046AA5800D3D1D10042C2750013BF550099C7AB00E9D8E200D1D3
      D200CECFCE00D5CDD300BFC3C10058C185001FBC590015A2340025B4500035C8
      72002CCC62006F99790000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031B7560031C4
      6B0023BA580046A95800DAD9D90051C57F0023BF6000A3CCB300F2E1EB00DADB
      DB00D6D8D600DFD6DB00C6C9C70057C183001EBB5600159E300022AF4C0033C7
      6F002BCB6000709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031B7560031C4
      6B0021B254004AA65A00EAE5E9004AC67B0017BE5800A9D4BB00FFF1FA00EBE9
      EA00E6E5E600F0E4EC00D6D5D6005DC689001DBE5800159D300020A5470031C2
      6D002BCB6000709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000032B7560030BE
      680021AB510046A65600F0EAED0088D2A7005EC58700CCE0D700FFF9FF00FBF2
      FB00F7EEF700FFEEFE00DFDCE0005AC3830019B74D00159C2D0021A448002FBA
      69002BCA5F00709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000032B755002FB7
      650025AF59001C9F3C006AB270007DB7820072B078007CB982007EBE86007DBE
      84007BBC830081BA870063AD6E001A9F370000981C000997250023AC52002FB6
      68002AC55D00709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031B454002DB4
      620026AF57001DA04000129024001D92290020942C0016932500119523001296
      2400139624001393240010902100159225001E932C00209F3D0024AE54002DB4
      630029C15A00709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000030B0520026AF
      59003AAC5900AAC8AE00B8D6BE00B0D2B500B1D2B600B2D4B700B2D4B700B2D5
      B700B3D5B700B2D5B700B4D4B900B9D4BC00BDD7C200AFCBB30046AF620023B0
      570027BE5900709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000030AF520020AC
      53004FAF6400FFEDF900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF0FF0065B475001CAB
      500025BC57007098780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000030AF530020AC
      52004FAF6400F7F0F300FEFEFD00F7F8F700F8F8F800F8F8F800F8F9F800F8F8
      F800F8F8F800F8F8F800F8F8F800F7F8F700FEFEFD00FBF3F80063B575001DA9
      500025BC57007098780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000030B0540020AB
      53004DAF6300F5EFF100FEFDFD00F6F6F600F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F6F6F600FEFDFE00F9F1F60062B474001DA9
      4F0025BC58007098780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000031B4550020AB
      52004DAF6300F5EEF100FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00F9F1F60062B474001DA9
      4F0026BF5900709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000032B7570020AD
      53004DAE6300F5EEF300FDFCFD00F2F2F200F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400F2F2F200FDFAFC00FBF1F70062B574001DA9
      4F0027C25A00709A790000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000032B7570021B2
      56004DAE6200F5EEF200FFFEFE00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FEFEFE00F9F1F60062B374001EAB
      500028C85D00709A790000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000032B7580024BA
      5C004EB16400F4EDF100FEFEFF00F9F9F900FAFAFA00FAFAFA00FAFAFA00FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00F9F9F900FFFEFF00FAF0F70062B3740020B3
      550029CB5E00709A790000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002CB850001FB9
      52004EB36300F5EDF300FEFCFE00F4F4F400F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F500F5F5F500F4F4F400FFFCFF00FBF0F60062B8760024BF
      5D002BCF6300709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003C9D4C0069B9
      760050A95B00F8F1F700FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FFFFFF00FBF2F90064BA79001094
      2D001AAD3F00709A780000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003A88400084A6
      870051A55800FAEDFA00FFF8FF00FFF7FF00FFF7FF00FFF7FF00FFF7FF00FFF7
      FF00FFF7FF00FFF7FF00FFF7FF00FFF7FF00FFF9FF00FEEAFB0067B87E000480
      1800119B2A006A96720000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000044B4540024A1
      38003EAF4F007BBC81007CC183007BC182007BC182007BC182007BC182007BC1
      82007BC182007BC182007BC182007BC182007CC284007BBC810048B259002CB0
      4C0029BA480091AE960000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DBDBDB00D4D4D400CECE
      CE00C9C9C900C7C7C700C9C9C900CDCDCD00D2D2D200D8D8D800000000000000
      0000D0C7C600DFDDDD0000000000000000000000000000000000B7B7B700C3C3
      C300BDBDBD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00B9BAB900A2AD9F0098A693009DAB98009DA59B000000
      0000000000000000000000000000000000000000000000000000B7B7B700C0C0
      C000BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BEBEBE00C5C5C500B1B1B1000000
      00000000000000000000000000000000000000000000B6B6B600C0C0C000BDBD
      BD00BDBDBD00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBC
      BC00BABABA00B5B5B800B9B9BA00BCBCBC00C5C5C500A9A9A900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DADADA00D4D4
      D400CFCFCF00CCCCCC00CBCBCB00CECECE00D1D1D100DBDBDB0000000000B494
      9000F19A8C00D4817D00C7BFBF00000000000000000000000000CECECE00FFFF
      FF00F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800E1E8E0003E8C38001F7F1D001C7E1A0054924C00DBDD
      DB00000000000000000000000000000000000000000000000000E9E9E900FEFE
      FE00F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800FBFBFB00FFFFFF00B2B2B2000000
      00000000000000000000000000000000000000000000E0E0E000FEFEFE00F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800F3F3
      F400D7D7E3007474B100B7B7D000ECECF000FAFAFC00A8A8AE008383B900ADAD
      D100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C2A7A400FF9E
      8F00FF837C00FF918700D4998900000000000000000000000000CBCBCB00F6F6
      F600EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00EDEDED00D4DBD20017811A00007D0B00007D0A0037883400DADE
      D900000000000000000000000000000000000000000000000000E0E0E000F2F2
      F200EDEDED00EBEBEB00E9E9E900EBEBEB00EDEDED00EDEDED00EDEDED00EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EFEFEF00FAFAFA00B2B2B2000000
      00000000000000000000000000000000000000000000D9D9D900F2F2F200EDED
      ED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00DADA
      E1005757A5000404C2002525A300B0B0C700DCDCE800535394000505C0002525
      B100A6A6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DABCBA00FF9E8E00FF82
      7B00FE847C00FFD2BA00D9B8A300000000000000000000000000CDCDCD00F9F9
      F900F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
      F000F0F0F000F0F0F000DDE3DB00218D2B00008A1700008A1600419242000000
      0000000000000000000000000000000000000000000000000000E2E2E200F5F5
      F500F0F0F000E3E3E300B3BBBF00D6D6D600E8E8E800EFEFEF00F0F0F000F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F2F2F200FDFDFD00B3B3B3000000
      00000000000000000000000000000000000000000000DBDBDB00F5F5F500F0F0
      F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000D0D0
      DB002929CD000000CC000000D1002929A8005757AF000808C9000000CE000404
      D3002222AB009393BD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DFC4C100F6968600FF837B00FF86
      7E00FFD1BA00DECAB800D6C7C500000000000000000000000000CECECE00FCFC
      FC00F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300B7CA
      B20098B89000A0BC99008EB2870017962D0000962100009722002A9236008FAD
      8800A4C29E009FC09900D3DECF00000000000000000000000000E5E5E500F8F8
      F800F3F3F300D5D5D5006FA0B00079AEC900B3BEC400DADADA00EBEBEB00F2F2
      F200F3F3F300F3F3F300F3F3F300F3F3F300F5F5F500FFFFFF00B3B3B3000000
      00000000000000000000000000000000000000000000DBDBDB00F9F9F900F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300D6D6
      E0006B6BD9001615DA000000D8000101DD000303DC000000DB000000D9000303
      D9004C4CA000B7B7CD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DCC5C300EF948400FF827B00FE877F00FFD3
      BD00D7C3B300D8C8C80000000000000000000000000000000000CECECE00FFFF
      FF00F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600429B
      48000298220006992600059D280001A12C0000A12B0000A02A00019E29000297
      230004932100018F1A0074AD7400000000000000000000000000E5E5E500FBFB
      FB00F6F6F600DADADA00B0D8DE0087DFFF0063BDEC008CB5CD00BDC4C100E7E7
      E700F4F4F400F6F6F600F6F6F600F6F6F600F8F8F800FFFFFF00B4B4B4000000
      00000000000000000000000000000000000000000000DEDEDE00FCFCFC00F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600E7E7
      EC00B9B9D2006767DB001010E5000000E4000000E5000000E5000909E2005B5B
      B100D9D9E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DBD3D400E2908500FF847C00FF898200FFD3BF00D5BC
      AC00DCCDCC000000000000000000000000000000000000000000CFCFCF00FFFF
      FF00F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F90042A5
      520003AC330000A9300000AD310000AD330000AD330000AC320000A9300000A6
      2C0000A2290005A32E0072AF7600000000000000000000000000E6E6E600FEFE
      FE00F9F9F900ECECEC00B2C0C400A2E6F90084DCDB0034B0800026812D00A0B1
      9F00E7E7E700F7F7F700F9F9F900F9F9F900FBFBFB00FFFFFF00B4B4B4000000
      00000000000000000000000000000000000000000000DFDFDF00FEFEFE00F9F9
      F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F1F1
      F400CBCBDB00807FCE004242F5000D0DF0000000F0000000F4001313D400ABAB
      CA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C1B8BA00C39D9E00E87E7500FFD3BC00D2B9A800DDD0
      CF00000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB005FB4
      6F003ACB6C0030C663002BCA62001AC1530016BF4F0015BD4D001BC0520029C3
      5C0031BF5D003CC4660080B88300000000000000000000000000E6E6E600FFFF
      FF00FBFBFB00F8F8F800DADADA009ACBD8004EC4760000960300008B10001E7B
      1D00A2B3A200E9E9E900F9F9F900FBFBFB00FDFDFD00FFFFFF00B5B5B5000000
      00000000000000000000000000000000000000000000E1E1E100FFFFFF00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00EAEA
      F0008383C9006463F3005151FB004646FB001111FC000000F9000000F8002C2C
      C600BDBDD7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DAD3D500CDC3C500C6BABD00CDC2C400DAD2
      D300EDEAEA00DCD4D400B2A1A100A8999C00D4C0B900C8A89400DDD1D1000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00B4D4
      B7009CD2A800A2D5AD0094C99E005DD4870048DA81004BDA830063CA830091C4
      9C00A0D2A9009DD3A700C6DAC800000000000000000000000000E6E6E600FFFF
      FF00FEFEFE00FEFEFE00F2F2F200BAC8C60020C150000CAC2E0001A122000493
      170020801F00A5B7A400EBEBEB00FCFCFC00FFFFFF00FFFFFF00B6B6B6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00DEDE
      E9006D6DF8005D5DFF005C5CFF006B6BFC006969F5002F2FFF000202FF000000
      FF002626C8009696C70000000000000000000000000000000000000000000000
      000000000000DBD4D600D9D1CF00F5EFE300FEF5E600FEF5E400F9F0E200E7E0
      DA00C1B5B800B09D9D008D727200A6939200C7BEBF00DCD1D100000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F4EF006CD38E0064EB9D0069EDA10073BE83000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FDFDFD00E9E9E9008ABC980027C3540019B6390002AD
      2600089F1F0022882000A9BBA900EDEDED00FDFDFD00FFFFFF00B6B6B6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E0E0
      EB008181F2007575FF007D7EFE007C7CD2009A9ACD00817FE1005757FF002323
      FF002C2CC9009696C70000000000000000000000000000000000000000000000
      0000DBD4D500F0E8E000FFF7E300FEF3DF00FDEFDA00FDF4E400FEF8EA00FFF5
      DE00FDF4E100C6BBBE00A5939300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E2EBE1007DE0A00086F8BB0088FABD007BC78F00DCE0
      DC00000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E6E6E60089BB970033CD600021C2
      450004BD2D000DAC250029932800ABBCAB00EDEDED00FDFDFD00B6B6B6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEF
      F400A0A0CD009897EA008B8BD300DDDDE900E8E8F0008080A5008F8EEB007070
      D700B8B8D200000000000000000000000000000000000000000000000000EBE7
      E800E8DED700FFF4DC00FBF0DC00FAE8C800FBEED800FCF6ED00FDFBF900FDF7
      EE00FEECCE00FBF1DE00C2B6B900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E9EFE90092E1AC00B2FAD400B0FCD40085C89400DDE1
      DD00000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E6E6E60094BFA1003ED6
      6D0027CF4E0006C6310011B028002C932900A9BBA900ECECEC00B5B5B5000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFC
      FD00E3E3ED00A8A7D200CCCBE300F7F7FA00FDFDFD00ACACB100A1A0D700B1AF
      DA0000000000000000000000000000000000000000000000000000000000DBD3
      D500FDEED700FCF3E000F8E3BC00F9E7C400FBEDD600FCF2E300FCF5EA00FCF2
      E400FBECD500FFEBC200E0D9D500E5DFE0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FDFDFD00C9E3CE00BDE2C600BFE6C800B6C9BA000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E6E6E60094C1
      A30041DF73002CD2520007C4300010AA2500288D2600A7B8A700A6A6A6000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FBFBFC00F4F4F800F5F5F700F5F5F500FFFFFF00B6B6B800000000000000
      000000000000000000000000000000000000000000000000000000000000DBCE
      CC00FFEED500FAEED300F7DCAB00F9E4BC00FAEACA00FBECD400FBEDD800FBED
      D400FAEACC00FBE5B600EFE4D000CFC6C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFDFD00F7F7F700F1F1F100EDEDED00F5F5F500D6D6D6000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00E5E5
      E50096C2A40043DF75002ECD4F0005B626000B9C1C0026812600778777000000
      00000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FBFBFB00F5F5F500F0F0F000EBEBEB00FCFCFC00B7B7B700000000000000
      000000000000000000000000000000000000000000000000000000000000DCCB
      C500FFEDD400F9EACA00F7DAA400F8E0B400F9E4BC00F9E8C500FAE8C700F9E8
      C500F8E5BD00FAE1B300F4E6CC00C6BCC0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDFDFD00F4F4F400EDEDED00E7E7E700E1E1E100E7E7E700D2D2D2000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
      FB00E0E0E0008DBC9C003EDA6F0026BD3F0003A01900058611001A6A1A00ABB6
      AB000000000000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFB
      FB00F2F2F200EBEBEB00E5E5E500DEDEDE00F0F0F000B7B7B700000000000000
      000000000000000000000000000000000000000000000000000000000000DECE
      CE00FDE6C700FCF1DD00FBEDD300FBEDD500F8E3BB00F8E0B300F8E2B600F8E1
      B600F8DDAC00FAE0B100F2E4CC00D0C8CB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
      FD00F4F4F400EBEBEB00DEDEDE00D1D1D100C8C8C800DDDDDD00BDBDBD000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9
      F900ECECEC00CECECE007FAE8F0036CE63001CAB3200028F1200007707002D6F
      2E00C1C1BF0000000000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00F2F2
      F200E8E8E800DADADA00CECECE00C9C9C900E4E4E400B9B9B900000000000000
      000000000000000000000000000000000000000000000000000000000000E2D9
      DB00FADBBB00FEF9ED00FEFBFE00FDF9F800F9E9CA00F6DAA400F7DBA600F7D8
      A000F8DEAC00FAE2B700E9DFD300E1DBDD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7
      F700EDEDED00E1E1E100E0E0E000DCDCDC00E1E1E100D9D9D900CFCFCF000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00F2F2
      F200E7E7E700DCDCDC00C8C8C80080AD8E002BC056000EA2260000880200317C
      3300B5AEAE00B6BAC000000000000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00F4F4F400E9E9
      E900DFDFDF00E0E0E000DADADA00EAEAEA00C4C4C40000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECE9
      EA00EFD3C900FBE2C800FFFFFF00FDFBFA00F8E1B700F5D08C00F5D39300F8DE
      A900FBE4C100F4DEBE00D3CCCF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00F2F2
      F200E6E6E600D4D4D400F2F2F200FFFFFF00ECECEC00CFCFCF00000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700ECEC
      EC00DADADA00DEDEDE00FBFBFB00E4E4E40078A0820020AF45002F933A00BAC4
      BA00D3CAC300697EAE00A8B1C2000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9F900EFEFEF00DFDF
      DF00D8D8D800FDFDFD00FFFFFF00D3D3D300E5E5E50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E6E1E300F2CCBF00F9D8BD00FDF3DE00FCEDCD00FAE7BE00FBE9C600FAE1
      C100F2D1B200E5DEDC00E4DFDF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D0D000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F700EDED
      ED00E0E0E000CCCCCC00F9F9F900E8E8E800CCCCCC0000000000000000000000
      0000000000000000000000000000000000000000000000000000E7E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00F2F2F200E8E8
      E800D3D3D300DBDBDB00FFFFFF00BFBFBF00D6D6D600A3B6A800B9B3B800C8BC
      B600B5BFD3002859CA00496BBC000000000000000000E2E2E200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00F5F5F500EBEBEB00D8D8
      D800D2D2D200FFFFFF00CFCFCF00E4E4E4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E6E1E300EACDC500F0C3AA00F5CCB000F5CFB700F2CCB100EDD2
      BF00E0D8D900E3DDDE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D1D1D100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F8F8F800EEEE
      EE00E0E0E000DCDCDC00E2E2E200CDCDCD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8E8E800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00F3F3F300E8E8
      E800D9D9D900E9E9E900CACACA00000000000000000000000000BEBABF0087AD
      D0004188F1003369DA009EA8BE000000000000000000E4E4E400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F5F5F500EBEBEB00DBDB
      DB00E8E8E800CFCFCF00E4E4E400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EEEBEC00E4DEE000DFD1D200DACACA00DDD4D500E1DC
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CCCCCC00F5F5
      F500F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F0F0F000EAEA
      EA00E2E2E200CACACA00D1D1D100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DDDDDD00F5F5
      F500F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300EDEDED00E7E7
      E700D6D6D600C9C9C90000000000000000000000000000000000000000009EB9
      D200508EDE0093A7CB00000000000000000000000000DBDBDB00F5F5F500F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300EEEEEE00E8E8E800DBDB
      DB00C2C2C200E5E5E50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000300000000100010000000000400200000000000000000000
      000000000000000000000000FFFFFF00FFFFFF000000000000000000FFFFFF00
      0000000000000000C00003000000000000000000C00003000000000000000000
      C00003000000000000000000C00003000000000000000000C000030000000000
      00000000C00003000000000000000000C00003000000000000000000C0000300
      0000000000000000C00003000000000000000000C00003000000000000000000
      C00003000000000000000000C00003000000000000000000C000030000000000
      00000000C00003000000000000000000C00003000000000000000000C0000300
      0000000000000000C00003000000000000000000C00003000000000000000000
      C00003000000000000000000C00003000000000000000000FFFFFF0000000000
      00000000FFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF8033C0
      001FC0001F80003FFFC021C0000FC0001F80000FFFFFC1C0000FC0001F800007
      FFFF81C0001FC0001F800003FFFF01C00001C0001F800003FFFE03C00001C000
      1F800007FFFC07C00001C0001F80000FFFFC0FC00001C0001F800007FE001FC0
      0001C0001F800003F8003FC0001FC0001F800003F001FFC0000FC0001F800007
      E001FFC0000FC0001F80000FE000FFC0001FC0001F80003FE000FFC0001FC000
      1F80003FE000FFC0001FC0000F80003FE000FFC0001FC0000780003FE000FFC0
      001FC0000380007FE001FFC0003FC0000180007FF001FFC0007FC000018000FF
      F803FFC000FFC001C18001FFFC0FFFC001FFC003E38003FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object jsdcSave: TjsonClientDataSet
    DataSourceName = 'selltickettype'
    QueryAddress = 'base/saveselltickettype'
    SaveAddress = 'base/saveselltickettype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <
      item
        Visible = False
      end>
    Params = <
      item
        DataType = ftString
        Name = 'selltickettype.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.tickettypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'typeids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isupdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tickettypes'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.typeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.canselltype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'selltickettype.cansellvalue'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptInputOutput
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
    Left = 168
    Top = 248
  end
  object pmMenu: TPopupMenu
    Left = 504
    Top = 224
    object N1: TMenuItem
      Caption = #20840#36873
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21453#36873
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #21462#28040
      OnClick = N3Click
    end
  end
  object jcdsSchedule: TjsonClientDataSet
    DataSourceName = 'scheduleRouteInfo'
    QueryAddress = 'base/findscheduleRouteinfo1'
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
        Name = 'type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isupdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 224
  end
  object dsScheduleResult: TDataSource
    DataSet = jcdsSchedule
    Left = 432
    Top = 224
  end
end
