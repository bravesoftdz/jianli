inherited FrmScheduel: TFrmScheduel
  Caption = #29677#27425#31649#29702
  ClientHeight = 500
  ClientWidth = 931
  Font.Charset = GB2312_CHARSET
  OnShow = FormShow
  ExplicitWidth = 947
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 17
    Top = 153
    Height = 347
    ExplicitLeft = 184
    ExplicitTop = 216
    ExplicitHeight = 100
  end
  inherited pnlQuery: TPanel
    Width = 931
    Height = 108
    ExplicitWidth = 931
    ExplicitHeight = 108
    object Label1: TLabel
      Left = 14
      Top = 23
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label8: TLabel
      Left = 236
      Top = 23
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object Label4: TLabel
      Left = 457
      Top = 54
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#21035
    end
    object Label2: TLabel
      Left = 471
      Top = 23
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label6: TLabel
      Left = 14
      Top = 82
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object Label7: TLabel
      Left = 14
      Top = 54
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object Label9: TLabel
      Left = 235
      Top = 54
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object Chkisoriginator: TCheckBox
      Left = 392
      Top = 82
      Width = 81
      Height = 17
      Caption = #36807#36335#29677#27425
      TabOrder = 8
    end
    object Chkislinework: TCheckBox
      Left = 296
      Top = 82
      Width = 81
      Height = 17
      Caption = #27969#27700#29677#27425
      TabOrder = 7
    end
    object Chkissellreturnticket: TCheckBox
      Left = 479
      Top = 82
      Width = 81
      Height = 17
      Caption = #21452#31243#29677#27425
      TabOrder = 9
    end
    object CobDISTRICTTYPE: TNovaComboBox
      Left = 299
      Top = 50
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 4
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
    object CobWORKWAYS: TNovaComboBox
      Left = 75
      Top = 50
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'workways'
      HelpOptions.DisAll = True
    end
    object NcbbScheduleType: TNovaComboBox
      Left = 75
      Top = 78
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 6
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'scheduletype'
      HelpOptions.DisAll = True
    end
    object NHelpRoute: TNovaHelp
      Left = 298
      Top = 21
      Width = 122
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = NHelpRouteKeyPress
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
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 75
      Top = 18
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
    object NEdtScheduleHelpCode: TNovaEdit
      Left = 520
      Top = 20
      Width = 120
      Height = 22
      CharCase = ecUpperCase
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
    end
    object NCbbWorkType: TNovaComboBox
      Left = 520
      Top = 50
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 5
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'worktype'
      HelpOptions.DisAll = True
    end
    object ChkISPROPRIETARY: TCheckBox
      Left = 566
      Top = 82
      Width = 81
      Height = 17
      Caption = #26412#31449#19987#33829
      TabOrder = 10
    end
    object chkPlusSchedule: TCheckBox
      Left = 650
      Top = 23
      Width = 97
      Height = 17
      Caption = #21152#29677#29677#27425
      TabOrder = 11
    end
    object chkSchedule: TCheckBox
      Left = 650
      Top = 54
      Width = 97
      Height = 17
      Caption = #27491#29677#29677#27425
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 931
    ExplicitWidth = 931
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
      AutoSize = False
      Caption = #22797#21046
      ImageIndex = 1
      Visible = True
      OnClick = ToolButton50Click
    end
    inherited ToolButton51: TToolButton
      Left = 358
      AutoSize = False
      Caption = #25209#37327#20462#25913
      ImageIndex = 2
      Visible = True
      OnClick = ToolButton51Click
      ExplicitLeft = 358
    end
    inherited tbtn3: TToolButton
      Left = 428
      ExplicitLeft = 428
    end
    inherited tbtnSave: TToolButton
      Left = 436
      Caption = #38271#20572#20449#24687
      ImageIndex = 41
      OnClick = tbtnSaveClick
      ExplicitLeft = 436
    end
    inherited tbtnCancel: TToolButton
      Left = 506
      Caption = #22266#23450#30041#20301
      ImageIndex = 43
      OnClick = tbtnCancelClick
      ExplicitLeft = 506
    end
    inherited ToolButton52: TToolButton
      Left = 576
      ExplicitLeft = 576
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 594
      ExplicitLeft = 594
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 612
      Visible = False
      ExplicitLeft = 612
    end
    inherited tbtnInfo: TToolButton
      Left = 620
      ExplicitLeft = 620
    end
    inherited tbtn5: TToolButton
      Left = 690
      ExplicitLeft = 690
    end
    inherited tbtnExcel: TToolButton
      Left = 698
      ExplicitLeft = 698
    end
    inherited tbtnPrinter: TToolButton
      Left = 768
      ExplicitLeft = 768
    end
    inherited tbtn6: TToolButton
      Left = 838
      ExplicitLeft = 838
    end
    inherited tbtnClose: TToolButton
      Left = 846
      ExplicitLeft = 846
    end
  end
  inherited Panel1: TPanel
    Left = 20
    Top = 153
    Width = 911
    Height = 347
    Caption = ''
    ExplicitLeft = 20
    ExplicitTop = 153
    ExplicitWidth = 911
    ExplicitHeight = 347
    inherited GroupBox1: TGroupBox
      Width = 911
      Height = 168
      Caption = #29677#27425#20449#24687
      ExplicitWidth = 911
      ExplicitHeight = 168
      inherited dbgrdhResult: TNvDbgridEh
        Width = 907
        Height = 150
        FooterFont.Charset = GB2312_CHARSET
        FooterRowCount = 1
        SortLocal = True
        SumList.Active = True
        TitleFont.Charset = GB2312_CHARSET
        OnGetCellParams = dbgrdhResultGetCellParams
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25152#23646#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footer.ValueType = fvtCount
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
            FieldName = 'islongstop'
            Footers = <>
            Title.Caption = #38271#20572
            Width = 40
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
            EditButtons = <>
            FieldName = 'PLANSEATNUM'
            Footers = <>
            Title.Caption = #35745#21010#24231#20301#25968
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'isfixseat'
            Footers = <>
            Title.Caption = #22266#23450#24231#20301#25968
            Width = 84
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isneedfinger'
            Footers = <>
            Title.Caption = #38656#35201#39550#39542#21592
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'driverfingernum'
            Footers = <>
            Title.Caption = #39550#39542#21592#25968#37327
            Width = 82
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
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'endtime'
            Footers = <>
            Title.Caption = #26411#29677#21457#36710#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footers = <>
            Title.Caption = #32456#21040#36710#31449
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'startstationprice'
            Footers = <>
            Title.Caption = #22987#21457#31449#31080#20215
            Width = 90
          end>
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 168
      Width = 911
      Height = 179
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 911
        Height = 179
        Align = alClient
        Caption = #29677#27425#20572#38752#28857#20449#24687
        TabOrder = 0
        object ToolBar3: TToolBar
          Left = 2
          Top = 16
          Width = 907
          Height = 29
          ButtonHeight = 30
          ButtonWidth = 31
          Caption = 'ToolBar1'
          Images = ilToolBar
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
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButton21Click
          end
          object ToolButton25: TToolButton
            Left = 39
            Top = 0
            Width = 8
            Caption = 'ToolButton5'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object ToolButton23: TToolButton
            Left = 47
            Top = 0
            Hint = #20462#25913
            Caption = 'ToolButton2'
            ImageIndex = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButton23Click
          end
          object ToolButton22: TToolButton
            Left = 78
            Top = 0
            Width = 8
            Caption = 'ToolButton4'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object ToolButton26: TToolButton
            Left = 86
            Top = 0
            Hint = #27880#38144
            Caption = 'ToolButton8'
            ImageIndex = 3
            ParentShowHint = False
            ShowHint = True
            OnClick = ToolButton26Click
          end
        end
        object DBGridEh2: TNvDbgridEh
          Left = 2
          Top = 45
          Width = 907
          Height = 132
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsScheduleStop
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
              EditButtons = <>
              FieldName = 'orderno'
              Footers = <>
              Title.Caption = #24207#21495
              Width = 41
            end
            item
              Checkboxes = True
              EditButtons = <>
              FieldName = 'isdepart'
              Footers = <>
              KeyList.Strings = (
                'true'
                'false')
              Title.Caption = #26159#21542#21457#36710#31449
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
              FieldName = 'issellable'
              Footers = <>
              Title.Caption = #26159#21542#20801#35768#21806#31080
              Width = 99
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
              Title.Caption = #20056#36710#24211
              Width = 120
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
              FieldName = 'updatetime'
              Footers = <>
              Title.Caption = #20462#25913#26102#38388
              Width = 140
            end
            item
              EditButtons = <>
              FieldName = 'remark1'
              Footers = <>
              Title.Caption = #22791#27880#19968
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'remark2'
              Footers = <>
              Title.Caption = #22791#27880#20108
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'remark3'
              Footers = <>
              Title.Caption = #22791#27880#19977
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'remark4'
              Footers = <>
              Title.Caption = #22791#27880#22235
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'remark5'
              Footers = <>
              Title.Caption = #22791#27880#20116
              Width = 70
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
    end
  end
  object GroupBox2: TGroupBox [4]
    Left = 0
    Top = 153
    Width = 17
    Height = 347
    Align = alLeft
    Caption = #36816#33829#32447#36335
    TabOrder = 3
    Visible = False
    object TreeVRoute: TTreeView
      Left = 2
      Top = 16
      Width = 13
      Height = 329
      Cursor = crHandPoint
      Align = alClient
      AutoExpand = True
      BevelInner = bvNone
      BevelOuter = bvRaised
      Ctl3D = False
      Indent = 19
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      Items.NodeData = {
        0303000000240000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        000200000001037F5E1C4E0177240000000000000000000000FFFFFFFFFFFFFF
        FF00000000000000000000000001037F5EDE5D025E2400000000000000000000
        00FFFFFFFFFFFFFFFF0000000000000000000000000103E073776D025E240000
        000000000000000000FFFFFFFFFFFFFFFF00000000000000000200000001038F
        79FA5E0177240000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        000000000001038F79DE5D025E240000000000000000000000FFFFFFFFFFFFFF
        FF0000000000000000000000000103A653E895025E2400000000000000000000
        00FFFFFFFFFFFFFFFF00000000000000000100000001035F6C7F890177240000
        000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000010357
        530C66025E}
    end
  end
  inherited ilToolBar: TImageList
    Left = 336
    Top = 248
  end
  inherited ilToolBarDisable: TImageList
    Left = 96
    Top = 416
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'base/queryschedule'
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
        Name = 'filter_LIKES_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!type'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!islinework'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!isoriginator'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!issellreturnticket'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'filter_EQB_s!isproprietary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_s!isovertime'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 192
    Top = 208
    object ssss: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 50
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
      Size = 50
    end
    object jcdsResultWORKTYPE: TWideStringField
      FieldName = 'WORKTYPE'
      Size = 10
    end
    object jcdsResultWORKWAYS: TWideStringField
      FieldName = 'WORKWAYS'
      Size = 10
    end
    object jcdsResultDISTRICTTYPE: TWideStringField
      FieldName = 'DISTRICTTYPE'
      Size = 10
    end
    object jcdsResultTYPE: TWideStringField
      FieldName = 'TYPE'
      Size = 10
    end
    object jcdsResultSTARTTIME: TWideStringField
      FieldName = 'STARTTIME'
      Size = 10
    end
    object jcdsResultRUNTIME: TFloatField
      FieldName = 'RUNTIME'
    end
    object jcdsResultISPROPRIETARY: TBooleanField
      FieldName = 'ISPROPRIETARY'
    end
    object jcdsResultISOVERTIME: TBooleanField
      FieldName = 'ISOVERTIME'
    end
    object jcdsResultISSELLRETURNTICKET: TBooleanField
      FieldName = 'ISSELLRETURNTICKET'
    end
    object jcdsResultISLINEWORK: TBooleanField
      FieldName = 'ISLINEWORK'
    end
    object jcdsResultISORIGINATOR: TBooleanField
      FieldName = 'ISORIGINATOR'
    end
    object jcdsResultISSALEAFTERREPORT: TBooleanField
      FieldName = 'ISSALEAFTERREPORT'
    end
    object jcdsResultISCANMIXCHECK: TBooleanField
      FieldName = 'ISCANMIXCHECK'
    end
    object jcdsResultPLANSEATNUM: TIntegerField
      FieldName = 'PLANSEATNUM'
    end
    object jcdsResultVIASTATION: TWideStringField
      FieldName = 'VIASTATION'
      Size = 200
    end
    object jcdsResultPRINTINFO: TWideStringField
      FieldName = 'PRINTINFO'
      Size = 100
    end
    object jcdsResultREMARKS: TWideStringField
      FieldName = 'REMARKS'
      Size = 200
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
    object jcdsResultusername: TWideStringField
      FieldName = 'username'
    end
    object jcdsResultWORKTYPENAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'WORKTYPENAME'
      LookupDataSet = jcsdWorkType
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'WORKTYPE'
      Size = 10
      Lookup = True
    end
    object jcdsResultWORKWAYSNAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'WORKWAYSNAME'
      LookupDataSet = jcdsworkways
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'WORKWAYS'
      Lookup = True
    end
    object jcdsResultDISTRICTTYPENAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'DISTRICTTYPENAME'
      LookupDataSet = jcdsDISTRICTTYPE
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'DISTRICTTYPE'
      Lookup = True
    end
    object jcdsResultTYPENAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'TYPENAME'
      LookupDataSet = jcdstype
      LookupKeyFields = 'CODE'
      LookupResultField = 'VALUE'
      KeyFields = 'TYPE'
      Lookup = True
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
    end
    object jcdsResultvehcilepark: TWideStringField
      FieldName = 'vehcilepark'
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultORGID: TLargeintField
      FieldName = 'ORGID'
    end
    object jcdsResultROUTEID: TLargeintField
      FieldName = 'ROUTEID'
    end
    object jcdsResultstartstationid: TLargeintField
      FieldName = 'startstationid'
    end
    object jcdsResultendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsResultCREATEBY: TLargeintField
      FieldName = 'CREATEBY'
    end
    object jcdsResultUPDATEBY: TLargeintField
      FieldName = 'UPDATEBY'
    end
    object jcdsResultendtime: TWideStringField
      FieldName = 'endtime'
    end
    object jcdsResultspacinginterval: TIntegerField
      FieldName = 'spacinginterval'
    end
    object jcdsResultentranceid: TLargeintField
      FieldName = 'entranceid'
    end
    object jcdsResultparkid: TLargeintField
      FieldName = 'parkid'
    end
    object jcdsResultCREATETIME: TDateTimeField
      FieldName = 'CREATETIME'
    end
    object jcdsResultUPDATETIME: TDateTimeField
      FieldName = 'UPDATETIME'
    end
    object jcdsResultsynccode: TWideStringField
      FieldName = 'synccode'
      Size = 50
    end
    object jcdsResultislongstop: TBooleanField
      FieldName = 'islongstop'
    end
    object jcdsResultisfixseat: TBooleanField
      FieldName = 'isfixseat'
    end
    object jcdsResultisneedfinger: TBooleanField
      FieldName = 'isneedfinger'
    end
    object jcdsResultdriverfingernum: TLargeintField
      FieldName = 'driverfingernum'
    end
    object jcdsResultendstation: TWideStringField
      FieldName = 'endstation'
    end
    object jcdsResultstartstationprice: TFloatField
      FieldName = 'startstationprice'
    end
  end
  inherited dsResult: TDataSource
    Left = 256
    Top = 208
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 48
    Top = 232
  end
  object jcsdWorkType: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'worktype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 200
  end
  object jcdsworkways: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'workways'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 440
    Top = 200
  end
  object jcdsDISTRICTTYPE: TjsonClientDataSet
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
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 520
    Top = 200
  end
  object jcdstype: TjsonClientDataSet
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
        Value = 'schedule'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'scheduletype'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 600
    Top = 208
  end
  object jcdsDelSchedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedule.id'
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
    Left = 656
    Top = 216
  end
  object jcdsTreeRoute: TjsonClientDataSet
    DataSourceName = 'dataSet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 128
    Top = 224
  end
  object jcdsScheduleStop: TjsonClientDataSet
    DataSourceName = 'schedulestoplist'
    QueryAddress = 'base/qryschedulestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedule.id'
        ParamType = ptInput
        Value = '14852'
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 416
  end
  object dsScheduleStop: TDataSource
    DataSet = jcdsScheduleStop
    Left = 344
    Top = 440
  end
  object jcdsDelScheduleStop: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delschedulestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'scheduleStop.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 424
    Top = 440
  end
end
