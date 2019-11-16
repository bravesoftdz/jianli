inherited FrmRoute: TFrmRoute
  Caption = #32447#36335#31649#29702
  ClientHeight = 439
  ClientWidth = 885
  OnShow = FormShow
  ExplicitWidth = 901
  ExplicitHeight = 479
  PixelsPerInch = 106
  TextHeight = 15
  inherited pnlQuery: TPanel
    Top = 100
    Width = 885
    Height = 51
    ExplicitTop = 100
    ExplicitWidth = 885
    ExplicitHeight = 51
    object Label1: TLabel
      Left = 220
      Top = 24
      Width = 30
      Height = 15
      Caption = #32447#36335
    end
    object lbldistricttype: TLabel
      Left = 402
      Top = 24
      Width = 60
      Height = 15
      Caption = #21306#22495#31867#21035
    end
    object lblendstation: TLabel
      Left = 640
      Top = 24
      Width = 45
      Height = 15
      Caption = #32456#28857#31449
    end
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 60
      Height = 15
      Caption = #25152#23646#26426#26500
    end
    object edtname: TEdit
      Left = 252
      Top = 19
      Width = 129
      Height = 23
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
      OnKeyPress = edtnameKeyPress
    end
    object NvCbbdistricttype: TNovaComboBox
      Left = 465
      Top = 19
      Width = 155
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'districttype'
      HelpOptions.DisAll = True
    end
    object NvHpendstation: TNovaHelp
      Left = 688
      Top = 19
      Width = 130
      Height = 23
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 2
      OnKeyPress = NvHpendstationKeyPress
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
      HelpOptions.HelpHeight = 300
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
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 73
      Top = 19
      Width = 128
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 885
    Height = 100
    ButtonHeight = 46
    ButtonWidth = 77
    ExplicitWidth = 885
    ExplicitHeight = 100
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Left = 77
      ExplicitLeft = 77
    end
    inherited tbtnInsert: TToolButton
      Left = 85
      OnClick = tbtnInsertClick
      ExplicitLeft = 85
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited tbtnEdit: TToolButton
      Left = 162
      OnClick = tbtnEditClick
      ExplicitLeft = 162
    end
    inherited tbtnDelete: TToolButton
      Left = 239
      OnClick = tbtnDeleteClick
      ExplicitLeft = 239
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited ToolButton50: TToolButton
      Left = 324
      ExplicitLeft = 324
      ExplicitWidth = 19
      ExplicitHeight = 46
    end
    inherited ToolButton51: TToolButton
      Left = 343
      ExplicitLeft = 343
      ExplicitWidth = 19
      ExplicitHeight = 46
    end
    inherited tbtn3: TToolButton
      Left = 0
      Wrap = True
      ExplicitLeft = 0
      ExplicitHeight = 54
    end
    inherited tbtnSave: TToolButton
      Left = 0
      Top = 54
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 54
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited tbtnCancel: TToolButton
      Left = 77
      Top = 54
      Visible = False
      ExplicitLeft = 77
      ExplicitTop = 54
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited ToolButton52: TToolButton
      Left = 154
      Top = 54
      ExplicitLeft = 154
      ExplicitTop = 54
      ExplicitWidth = 19
      ExplicitHeight = 46
    end
    inherited ToolButton53: TToolButton
      Left = 173
      Top = 54
      ExplicitLeft = 173
      ExplicitTop = 54
      ExplicitWidth = 19
      ExplicitHeight = 46
    end
    inherited tbtn4: TToolButton
      Left = 192
      Top = 54
      Visible = False
      ExplicitLeft = 192
      ExplicitTop = 54
      ExplicitHeight = 46
    end
    inherited tbtnInfo: TToolButton
      Left = 200
      Top = 54
      ExplicitLeft = 200
      ExplicitTop = 54
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited tbtn5: TToolButton
      Left = 316
      ExplicitLeft = 316
      ExplicitHeight = 46
    end
    inherited tbtnExcel: TToolButton
      Left = 277
      Top = 54
      ExplicitLeft = 277
      ExplicitTop = 54
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited tbtnPrinter: TToolButton
      Left = 354
      Top = 54
      ExplicitLeft = 354
      ExplicitTop = 54
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
    inherited tbtn6: TToolButton
      Left = 431
      Top = 54
      ExplicitLeft = 431
      ExplicitTop = 54
      ExplicitHeight = 46
    end
    inherited tbtnClose: TToolButton
      Left = 439
      Top = 54
      ExplicitLeft = 439
      ExplicitTop = 54
      ExplicitWidth = 77
      ExplicitHeight = 46
    end
  end
  inherited Panel1: TPanel
    Top = 151
    Width = 885
    Height = 288
    ExplicitTop = 151
    ExplicitWidth = 885
    ExplicitHeight = 288
    object splmid: TSplitter [0]
      Left = 518
      Top = 0
      Height = 288
      Align = alRight
      ExplicitHeight = 340
    end
    inherited GroupBox1: TGroupBox
      Width = 518
      Height = 288
      ExplicitWidth = 518
      ExplicitHeight = 288
      inherited dbgrdhResult: TNvDbgridEh
        Width = 514
        Height = 269
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25152#23646#36710#31449
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #32447#36335#32534#30721
            Visible = False
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'NAME'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32447#36335#21517#31216
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'startstationname'
            Footers = <>
            Title.Caption = #36215#28857#31449
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'ENDSTATIONNAME'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'DISTANCE'
            Footers = <>
            Title.Caption = #37324#31243
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'highdistance'
            Footers = <>
            Title.Caption = #39640#36895#37324#31243
          end
          item
            EditButtons = <>
            FieldName = 'districttypename'
            Footers = <>
            Title.Caption = #21306#22495#31867#21035
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #32447#36335#31867#22411
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'gradename'
            Footers = <>
            Title.Caption = #32447#36335#31561#32423
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'directionname'
            Footers = <>
            Title.Caption = #32447#36335#26041#21521
            Width = 63
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISAUDITED'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#24050#23457#26680
            Width = 77
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'ISAUDITPASS'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#23457#26680#36890#36807
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'returntripvaliddays'
            Footers = <>
            Title.Caption = #22238#31243#31080#26377#25928#22825#25968
          end
          item
            EditButtons = <>
            FieldName = 'reportinterval'
            Footers = <>
            Title.Caption = #25253#29677#26102#38388#38388#38548
          end
          item
            EditButtons = <>
            FieldName = 'createbyname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'updatebyname'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 154
          end
          item
            EditButtons = <>
            FieldName = 'isrealnameticket'
            Footers = <>
            Visible = False
          end>
      end
    end
    object pnlright: TPanel
      Left = 521
      Top = 0
      Width = 364
      Height = 288
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object gbroutestop: TGroupBox
        Left = 0
        Top = 0
        Width = 364
        Height = 121
        Align = alClient
        Caption = #32447#36335#20572#38752#28857
        TabOrder = 0
        object dbgrdhroutestop: TNvDbgridEh
          Left = 2
          Top = 46
          Width = 360
          Height = 73
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsroutestop
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -15
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          ImeMode = imClose
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
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
          PrintOptions = [pghFitGridToPageWidth, pghColored, pghFitingByColWidths, pghOptimalColWidths]
          PrintAutoNewLine = False
          ParentName = 'FrmRoute'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'STATIONNAME'
              Footers = <>
              Title.Caption = #31449#28857#21517#31216
              Title.TitleButton = False
              Width = 66
            end
            item
              EditButtons = <>
              FieldName = 'DISTANCE'
              Footers = <>
              Title.Caption = #37324#31243
              Title.TitleButton = False
              Width = 40
            end
            item
              EditButtons = <>
              EndEllipsis = True
              FieldName = 'BALANCEDISTANCE'
              Footers = <>
              Title.Caption = #32467#31639#37324#31243
              Title.TitleButton = False
              Width = 68
            end
            item
              EditButtons = <>
              FieldName = 'isdepart'
              Footers = <>
              Title.Caption = #19978#36710#31449
              Width = 62
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object tlbstop: TToolBar
          Left = 2
          Top = 17
          Width = 360
          Height = 29
          Images = ilsmalltools
          TabOrder = 1
          object tbtn2: TToolButton
            Left = 0
            Top = 0
            Width = 8
            Caption = 'ToolButton6'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtnaddstop: TToolButton
            Left = 8
            Top = 0
            Hint = #28155#21152
            Caption = #28155#21152
            ImageIndex = 9
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnaddstopClick
          end
          object tbtn7: TToolButton
            Left = 31
            Top = 0
            Width = 8
            Caption = 'ToolButton4'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtnUpdatestop: TToolButton
            Left = 39
            Top = 0
            Hint = #20462#25913
            Caption = 'ToolButton2'
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnUpdatestopClick
          end
          object tbtn8: TToolButton
            Left = 62
            Top = 0
            Width = 8
            Caption = 'tbtn8'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtndelstop: TToolButton
            Left = 70
            Top = 0
            Hint = #21024#38500
            Caption = 'ToolButton8'
            ImageIndex = 7
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtndelstopClick
          end
          object tbtn14: TToolButton
            Left = 93
            Top = 0
            Width = 8
            Caption = 'tbtn14'
            ImageIndex = 6
            Style = tbsSeparator
          end
          object tbtndownstop: TToolButton
            Left = 101
            Top = 0
            Caption = 'tbtndownstop'
            ImageIndex = 2
            OnClick = tbtndownstopClick
          end
          object tbtn15: TToolButton
            Left = 124
            Top = 0
            Width = 8
            Caption = 'tbtn15'
            ImageIndex = 6
            Style = tbsSeparator
          end
          object tbtnupstop: TToolButton
            Left = 132
            Top = 0
            Caption = 'tbtnupstop'
            ImageIndex = 5
            OnClick = tbtnupstopClick
          end
        end
      end
      object gbrouteroad: TGroupBox
        Left = 0
        Top = 121
        Width = 364
        Height = 167
        Align = alBottom
        Caption = #32447#36335#36335#27573
        TabOrder = 1
        Visible = False
        object dbgrdhrouteroad: TNvDbgridEh
          Left = 2
          Top = 46
          Width = 360
          Height = 119
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsrouteroad
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -15
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          ImeMode = imClose
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
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
          PrintOptions = [pghFitGridToPageWidth, pghColored, pghFitingByColWidths, pghOptimalColWidths]
          PrintAutoNewLine = False
          ParentName = 'FrmRoute'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #20844#36335#21517#31216
              Title.TitleButton = False
              Width = 88
            end
            item
              EditButtons = <>
              FieldName = 'roadgradename'
              Footers = <>
              Title.Caption = #20844#36335#31561#32423
              Title.TitleButton = False
              Width = 67
            end
            item
              EditButtons = <>
              FieldName = 'DISTANCE'
              Footers = <>
              Title.Caption = #37324#31243
              Title.TitleButton = False
              Width = 38
            end
            item
              EditButtons = <>
              FieldName = 'ENTRANCENAME'
              Footers = <>
              Title.Caption = #20837#21475#21517#31216
              Title.TitleButton = False
              Width = 79
            end
            item
              EditButtons = <>
              FieldName = 'EXITNAME'
              Footers = <>
              Title.Caption = #20986#21475#21517#31216
              Title.TitleButton = False
              Width = 78
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object tlbroad: TToolBar
          Left = 2
          Top = 17
          Width = 360
          Height = 29
          Images = ilsmalltools
          TabOrder = 1
          object tbtn9: TToolButton
            Left = 0
            Top = 0
            Width = 8
            Caption = 'ToolButton6'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtnaddroad: TToolButton
            Left = 8
            Top = 0
            Hint = #28155#21152
            Caption = #28155#21152
            ImageIndex = 9
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnaddroadClick
          end
          object tbtn11: TToolButton
            Left = 31
            Top = 0
            Width = 8
            Caption = 'ToolButton4'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtnupdateroad: TToolButton
            Left = 39
            Top = 0
            Hint = #20462#25913
            Caption = 'ToolButton2'
            ImageIndex = 0
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtnupdateroadClick
          end
          object tbtn13: TToolButton
            Left = 62
            Top = 0
            Width = 8
            Caption = 'tbtn8'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtndelroad: TToolButton
            Left = 70
            Top = 0
            Hint = #21024#38500
            Caption = 'ToolButton8'
            ImageIndex = 7
            ParentShowHint = False
            ShowHint = True
            OnClick = tbtndelroadClick
          end
          object tbtn10: TToolButton
            Left = 93
            Top = 0
            Width = 8
            Caption = 'tbtn10'
            ImageIndex = 8
            Style = tbsSeparator
          end
          object tbtndownroad: TToolButton
            Left = 101
            Top = 0
            Caption = 'tbtndownroad'
            ImageIndex = 2
            OnClick = tbtndownroadClick
          end
          object tbtn12: TToolButton
            Left = 124
            Top = 0
            Width = 8
            Caption = 'tbtn12'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbtnuproad: TToolButton
            Left = 132
            Top = 0
            Caption = 'tbtnuproad'
            ImageIndex = 5
            OnClick = tbtnuproadClick
          end
        end
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'routeList'
    QueryAddress = 'base/listRoute'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_r!name_OR_r!code_OR_r!jianpin'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_r!districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ste!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end>
    AfterOpen = jcdsResultAfterOpen
    AfterClose = jcdsResultAfterClose
    AfterScroll = jcdsResultAfterScroll
    Left = 198
    Top = 80
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultORGID: TLargeintField
      FieldName = 'ORGID'
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultNAME: TWideStringField
      FieldName = 'NAME'
    end
    object jcdsResultSTARTSTATIONNAME: TWideStringField
      FieldName = 'startstationname'
    end
    object jcdsResultENDSTATIONNAME: TWideStringField
      FieldName = 'ENDSTATIONNAME'
    end
    object jcdsResultDISTANCE: TIntegerField
      FieldName = 'DISTANCE'
    end
    object jcdsResulthighdistance: TIntegerField
      FieldName = 'highdistance'
    end
    object jcdsResultdistricttype: TWideStringField
      FieldName = 'districttype'
    end
    object jcdsResultdistricttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'districttypename'
      LookupDataSet = jcdsdistricttype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'districttype'
      Lookup = True
    end
    object jcdsResultTYPE: TWideStringField
      FieldName = 'TYPE'
    end
    object jcdsResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdsroutetype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'TYPE'
      Lookup = True
    end
    object jcdsResultGRADE: TWideStringField
      FieldName = 'GRADE'
    end
    object jcdsResultgradename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'gradename'
      LookupDataSet = jcdsroutegrade
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'GRADE'
      Lookup = True
    end
    object jcdsResultDIRECTION: TWideStringField
      FieldName = 'DIRECTION'
    end
    object jcdsResultdirectionname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'directionname'
      LookupDataSet = jcdsroutedirection
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'DIRECTION'
      Lookup = True
    end
    object jcdsResultISAUDITED: TBooleanField
      FieldName = 'ISAUDITED'
    end
    object jcdsResultISAUDITPASS: TBooleanField
      FieldName = 'ISAUDITPASS'
    end
    object jcdsResultISACTIVE: TBooleanField
      FieldName = 'ISACTIVE'
    end
    object jcdsResultjianpin: TWideStringField
      FieldName = 'jianpin'
    end
    object jcdsResultstartstationid: TLargeintField
      FieldName = 'startstationid'
    end
    object jcdsResultendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsResultremarks: TWideStringField
      FieldName = 'remarks'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object wdstrngfldResultcreatebyname: TWideStringField
      FieldName = 'createbyname'
    end
    object wdstrngfldResultupdatebyname: TWideStringField
      FieldName = 'updatebyname'
    end
    object jcdsResultsynccode: TWideStringField
      FieldName = 'synccode'
      Size = 40
    end
    object jcdsResultreturntripvaliddays: TIntegerField
      FieldName = 'returntripvaliddays'
    end
    object jcdsResultreportinterval: TIntegerField
      FieldName = 'reportinterval'
    end
    object jcdsResultisrealnameticket: TBooleanField
      FieldName = 'isrealnameticket'
    end
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 368
  end
  object jcdsdistricttype: TjsonClientDataSet
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
        Value = 'route'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'districttype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 136
    Top = 192
  end
  object jcdsroutetype: TjsonClientDataSet
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
        Value = 'route'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 152
    Top = 264
  end
  object jcdsroutegrade: TjsonClientDataSet
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
        Value = 'route'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'grade'
      end>
    RemoteServer = DMPublic.jcon
    Left = 248
    Top = 184
  end
  object jcdsroutedirection: TjsonClientDataSet
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
        Value = 'route'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'direction'
      end>
    RemoteServer = DMPublic.jcon
    Left = 264
    Top = 264
  end
  object jcdsroutestop: TjsonClientDataSet
    DataSourceName = 'routestopList'
    QueryAddress = 'base/listRoutestop'
    SaveAddress = 'base/saveRoutestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 80
  end
  object dsroutestop: TDataSource
    DataSet = jcdsroutestop
    Left = 688
    Top = 192
  end
  object dsrouteroad: TDataSource
    DataSet = jcdsrouteroad
    Left = 648
    Top = 328
  end
  object jcdsrouteroad: TjsonClientDataSet
    DataSourceName = 'routeroadList'
    UpdateDataSet = 'updaterouteroads'
    QueryAddress = 'base/listRouteroad'
    SaveAddress = 'base/saveRouteroad'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 688
    Top = 328
    object jcdsrouteroadid: TLargeintField
      FieldName = 'id'
    end
    object jcdsrouteroadrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsrouteroadORDERNO: TIntegerField
      FieldName = 'ORDERNO'
    end
    object jcdsrouteroadNAME: TWideStringField
      FieldName = 'NAME'
    end
    object jcdsrouteroadENTRANCENAME: TWideStringField
      FieldName = 'ENTRANCENAME'
    end
    object jcdsrouteroadEXITNAME: TWideStringField
      FieldName = 'EXITNAME'
    end
    object jcdsrouteroadDISTANCE: TIntegerField
      FieldName = 'DISTANCE'
    end
    object jcdsrouteroadroadgrade: TWideStringField
      FieldName = 'roadgrade'
    end
    object jcdsrouteroadroadgradename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'roadgradename'
      LookupDataSet = jcdsroadgrade
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'roadgrade'
      Lookup = True
    end
    object jcdsrouteroadroadupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsrouteroadroadcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsrouteroadcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsrouteroadupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
  end
  object jcdsroadgrade: TjsonClientDataSet
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
        Value = 'routeroad'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'roadgrade'
      end>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 312
  end
  object jcdsroutedelete: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/deleteRoute'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'route.id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 272
    Top = 128
  end
  object ilsmalltools: TImageList
    DrawingStyle = dsSelected
    Left = 48
    Top = 336
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
  object jcdsroutestopdel: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/deleteRoutestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routestop.id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 616
    Top = 184
  end
  object jcdsrouteroaddel: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/deleteRouteroad'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routeroad.id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 552
    Top = 344
  end
  object jcdsswapstoporderno: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/swapRoutestopOrderno'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'swapid1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'swapid2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 536
    Top = 184
  end
  object jcdsswaproadorderno: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/swapRouteroadOrderno'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'swapid1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'swapid2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 680
    Top = 272
  end
  object jscdRouteUsed: TjsonClientDataSet
    DataSourceName = 'diclist'
    SaveAddress = 'base/qryRouteuse'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'used'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 56
    Top = 240
  end
end
