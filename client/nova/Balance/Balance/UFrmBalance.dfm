inherited FrmBalance: TFrmBalance
  Caption = #32467#31639#21333#32467#31639
  ClientHeight = 556
  ClientWidth = 1185
  KeyPreview = True
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitWidth = 1201
  ExplicitHeight = 594
  PixelsPerInch = 96
  TextHeight = 14
  object spl1: TSplitter [0]
    Left = 607
    Top = 153
    Height = 403
    Align = alRight
    ExplicitLeft = 832
    ExplicitTop = 312
    ExplicitHeight = 100
  end
  inherited pnlQuery: TPanel
    Width = 1185
    Height = 108
    ExplicitWidth = 1185
    ExplicitHeight = 108
    object Label1: TLabel
      Left = 17
      Top = 18
      Width = 56
      Height = 14
      Caption = #25171#21333#26426#26500
    end
    object Label2: TLabel
      Left = 261
      Top = 18
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label3: TLabel
      Left = 519
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label5: TLabel
      Left = 477
      Top = 49
      Width = 56
      Height = 14
      Caption = #32467#31639#21345#21495
    end
    object Label7: TLabel
      Left = 17
      Top = 82
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object Label8: TLabel
      Left = 261
      Top = 82
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label6: TLabel
      Left = 477
      Top = 82
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object Label9: TLabel
      Left = 17
      Top = 50
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label10: TLabel
      Left = 275
      Top = 50
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label4: TLabel
      Left = 689
      Top = 51
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object Label11: TLabel
      Left = 827
      Top = 18
      Width = 70
      Height = 14
      Caption = #32467#31639#21333#31867#22411
    end
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 82
      Top = 14
      Width = 143
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
    object DpFromDepart: TDateTimePicker
      Left = 326
      Top = 14
      Width = 120
      Height = 22
      Date = 40716.620322083330000000
      Time = 40716.620322083330000000
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object DptoDepart: TDateTimePicker
      Left = 543
      Top = 14
      Width = 120
      Height = 22
      Date = 40716.620350289360000000
      Time = 40716.620350289360000000
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 2
      OnChange = DptoDepartChange
    end
    object NovaHelpUnit: TNovaHelp
      Left = 82
      Top = 78
      Width = 143
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 6
      OnKeyPress = NovaHelpUnitKeyPress
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
          FieldName = 'fullname'
          Title.Caption = #20840#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 80
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
    object NovaHelpVehicle: TNovaHelp
      Left = 326
      Top = 78
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 7
      OnChange = NovaHelpVehicleChange
      OnKeyPress = NovaHelpVehicleKeyPress
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
          Width = 80
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
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!unitid'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object NovaEdtInvoicesno: TNovaEdit
      Left = 543
      Top = 78
      Width = 120
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 8
      OnKeyPress = NovaEdtInvoicesnoKeyPress
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
    object NovaHelpCard: TNovaHelp
      Left = 543
      Top = 46
      Width = 120
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
      HDBGColumns = <>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NHelpRoute: TNovaHelp
      Left = 82
      Top = 46
      Width = 143
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 3
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
    object NovaHelpSchedule: TNovaHelp
      Left = 326
      Top = 46
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 4
      OnKeyPress = NovaHelpScheduleKeyPress
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
    object chkAutoAdd: TCheckBox
      Left = 689
      Top = 81
      Width = 115
      Height = 17
      Caption = #21152#20837#32467#31639#21015#34920
      TabOrder = 9
    end
    object chkscheduleTypeN: TCheckBox
      Left = 689
      Top = 16
      Width = 87
      Height = 17
      Caption = #27491#29677
      TabOrder = 10
    end
    object chkscheduleTypeY: TCheckBox
      Left = 755
      Top = 15
      Width = 55
      Height = 17
      Caption = #21152#29677
      TabOrder = 11
    end
    object NovachkStatus: TNovaCheckedComboBox
      Left = 723
      Top = 47
      Width = 81
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'departinvoices'
        end
        item
          DataType = ftString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'status'
        end>
    end
    object nhcbbdepartinvoicestype: TNovaHComboBox
      Left = 905
      Top = 14
      Width = 120
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 13
      Items.Strings = (
        #20840#37096
        #24494#26426#36816#37327
        #25163#24037#36816#37327)
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1185
    ButtonWidth = 77
    ExplicitWidth = 1185
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 77
    end
    inherited tbtn1: TToolButton
      Left = 77
      ExplicitLeft = 77
    end
    inherited tbtnInsert: TToolButton
      Left = 85
      Caption = #21333#20301#32467#31639
      ImageIndex = 33
      OnClick = tbtnInsertClick
      ExplicitLeft = 85
      ExplicitWidth = 77
    end
    inherited tbtnEdit: TToolButton
      Left = 162
      Caption = #21333#36710#32467#31639
      ImageIndex = 33
      OnClick = tbtnEditClick
      ExplicitLeft = 162
      ExplicitWidth = 77
    end
    inherited tbtnDelete: TToolButton
      Left = 239
      AutoSize = True
      Caption = ''
      ImageIndex = -1
      Visible = False
      ExplicitLeft = 239
      ExplicitWidth = 18
    end
    inherited ToolButton50: TToolButton
      Left = 257
      ExplicitLeft = 257
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 275
      ExplicitLeft = 275
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 293
      ExplicitLeft = 293
    end
    inherited tbtnSave: TToolButton
      Left = 301
      AutoSize = True
      Caption = #37325#26032#35745#31639
      ImageIndex = 45
      OnClick = tbtnSaveClick
      ExplicitLeft = 301
      ExplicitWidth = 67
    end
    inherited tbtnCancel: TToolButton
      Left = 368
      Caption = ' '#29983#25104#25187#36153' '
      ImageIndex = 34
      OnClick = tbtnCancelClick
      ExplicitLeft = 368
      ExplicitWidth = 77
    end
    inherited ToolButton52: TToolButton
      Left = 445
      Caption = #21024#38500#25187#36153
      ImageIndex = 3
      Visible = True
      OnClick = ToolButton52Click
      ExplicitLeft = 445
      ExplicitWidth = 67
    end
    inherited ToolButton53: TToolButton
      Left = 512
      Caption = #36710#31080#26126#32454
      ImageIndex = 42
      OnClick = ToolButton53Click
      ExplicitLeft = 512
      ExplicitWidth = 67
    end
    inherited tbtn4: TToolButton
      Left = 579
      ExplicitLeft = 579
    end
    inherited tbtnInfo: TToolButton
      Left = 587
      ExplicitLeft = 587
      ExplicitWidth = 77
    end
    inherited tbtn5: TToolButton
      Left = 664
      ExplicitLeft = 664
    end
    inherited tbtnExcel: TToolButton
      Left = 672
      ExplicitLeft = 672
      ExplicitWidth = 77
    end
    inherited tbtnPrinter: TToolButton
      Left = 749
      Visible = False
      ExplicitLeft = 749
      ExplicitWidth = 77
    end
    inherited tbtn6: TToolButton
      Left = 826
      ExplicitLeft = 826
    end
    inherited tbtnClose: TToolButton
      Left = 834
      ExplicitLeft = 834
      ExplicitWidth = 77
    end
    object ToolButton1: TToolButton
      Left = 911
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object tbtnModifyBalance: TToolButton
      Left = 919
      Top = 0
      Caption = #20462#25913
      ImageIndex = 2
      OnClick = tbtnModifyBalanceClick
    end
  end
  inherited Panel1: TPanel
    Left = 25
    Top = 153
    Width = 582
    Height = 403
    ExplicitLeft = 25
    ExplicitTop = 153
    ExplicitWidth = 582
    ExplicitHeight = 403
    object Splitter1: TSplitter [0]
      Left = 0
      Top = 245
      Width = 582
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 284
    end
    inherited GroupBox1: TGroupBox
      Width = 582
      Height = 245
      ExplicitWidth = 582
      ExplicitHeight = 245
      inherited dbgrdhResult: TNvDbgridEh
        Tag = -99
        Width = 578
        Height = 227
        FooterRowCount = 1
        ImeMode = imDisable
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete]
        PopupMenu = PopupMenu1
        ReadOnly = False
        SumList.Active = True
        OnDblClick = dbgrdhResultDblClick
        OnDrawColumnCell = dbgrdhResultDrawColumnCell
        OnMouseDown = dbgrdhResultMouseDown
        OnMouseUp = dbgrdhResultMouseUp
        Columns = <
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Visible = False
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicetypename'
            Footers = <>
            Title.Caption = #32467#31639#21333#31867#22411
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footers = <>
            Title.Caption = #32467#31639#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#20154#25968
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#32467#31639#37329#39069
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'agentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#20195#29702#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'othterfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#25187#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'fueladditionfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29123#27833#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'balanceunitname'
            Footers = <>
            Title.Caption = #32467#31639#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #33829#36816#36710#36742
            Width = 70
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
            FieldName = 'printname'
            Footers = <>
            Title.Caption = #25171#21333#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'printtime'
            Footers = <>
            Title.Caption = #25171#21333#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'routeid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'iscomputerno'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'isaudit'
            Footers = <>
            Visible = False
          end>
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 248
      Width = 582
      Height = 155
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 1
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 582
        Height = 155
        Align = alClient
        Caption = #25187#36153#26126#32454
        TabOrder = 0
        object NvDbgridEh1: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 578
          Height = 137
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = dsDeduct
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FooterRowCount = 1
          ImeMode = imClose
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          SumList.Active = True
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
          ParentName = 'FrmBalance'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'deducttypename'
              Footer.Value = #21512#35745
              Footer.ValueType = fvtStaticText
              Footers = <>
              Title.Caption = #25187#36153#31867#22411
              Width = 88
            end
            item
              EditButtons = <>
              FieldName = 'name'
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #25187#36153#21517#31216
              Width = 115
            end
            item
              EditButtons = <>
              FieldName = 'deductmoney'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #25187#36153#37329#39069
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'isdeductbeforebalance'
              Footers = <>
              Title.Caption = #25171#21333#26102#25187
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'target'
              Footers = <>
              Title.Caption = #25187#36153#23545#35937
              Width = 104
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
    Width = 25
    Height = 403
    Align = alLeft
    Caption = #33829#36816#21333#20301
    TabOrder = 3
    object TreeVItem: TTreeView
      Left = 2
      Top = 16
      Width = 21
      Height = 385
      Cursor = crHandPoint
      Align = alClient
      AutoExpand = True
      BevelInner = bvNone
      BevelOuter = bvRaised
      Ctl3D = False
      Images = ImageList
      Indent = 19
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      OnClick = TreeVItemClick
      Items.NodeData = {
        0302000000220000000000000000000000FFFFFFFFFFFFFFFF00000000000000
        0002000000010261006100220000000000000000000000FFFFFFFFFFFFFFFF00
        0000000000000000000000010261003100220000000000000000000000FFFFFF
        FFFFFFFFFF000000000000000000000000010261003200220000000000000000
        000000FFFFFFFFFFFFFFFF000000000000000000000000010262006200}
    end
  end
  object pnl1: TPanel [5]
    Left = 610
    Top = 153
    Width = 575
    Height = 403
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object pnl3: TPanel
      Left = 0
      Top = 0
      Width = 575
      Height = 403
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object grp1: TGroupBox
        Left = 0
        Top = 0
        Width = 575
        Height = 403
        Align = alClient
        Caption = #24453#32467#31639#30340#36816#37327#21333#21015#34920
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object nvdbgrdh1: TNvDbgridEh
          Tag = -99
          Left = 2
          Top = 18
          Width = 571
          Height = 383
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = ds1
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
          ImeMode = imDisable
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          ParentFont = False
          PopupMenu = pm1
          ReadOnly = True
          RowDetailPanel.Color = clBtnFace
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = #23435#20307
          TitleFont.Style = [fsBold]
          OnDblClick = nvdbgrdh1DblClick
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
              FieldName = 'endstation'
              Footer.Value = #21512#35745
              Footer.ValueType = fvtStaticText
              Footers = <>
              Title.Caption = #32456#28857#31449
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'departdate'
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #21457#36710#26085#26399
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'departinvoicetypename'
              Footers = <>
              Title.Caption = #32467#31639#21333#31867#22411
              Width = 85
            end
            item
              EditButtons = <>
              FieldName = 'departinvoicesno'
              Footers = <>
              Title.Caption = #32467#31639#21333#21495
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'ticketnum'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #24635#20154#25968
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'totalamount'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #24635#37329#39069
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'balanceamount'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #24635#32467#31639#37329#39069
              Width = 86
            end
            item
              EditButtons = <>
              FieldName = 'agentfee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #23458#36816#20195#29702#36153
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'stationservicefee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #31449#21153#36153
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'fueladditionfee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #29123#27833#36153
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'othterfee'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #20854#20182#25187#36153
              Width = 80
            end
            item
              EditButtons = <>
              FieldName = 'code'
              Footers = <>
              Title.Caption = #29677#27425#21495
              Width = 50
            end
            item
              EditButtons = <>
              FieldName = 'balanceunitname'
              Footers = <>
              Title.Caption = #32467#31639#21333#20301
              Width = 100
            end
            item
              EditButtons = <>
              FieldName = 'departtime'
              Footers = <>
              Title.Caption = #21457#36710#26102#38388
              Width = 66
            end
            item
              EditButtons = <>
              FieldName = 'vehicleno'
              Footers = <>
              Title.Caption = #33829#36816#36710#36742
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'statusname'
              Footers = <>
              Title.Caption = #29366#24577
              Width = 45
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
              FieldName = 'routeid'
              Footers = <>
              Visible = False
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 120
    Top = 376
  end
  inherited ilToolBarDisable: TImageList
    Left = 40
    Top = 304
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'departinvoinceslist'
    QueryAddress = 'balance/qryDepartinvoices'
    Params = <
      item
        DataType = ftString
        Name = 'invoicesids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ds!printorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_ds!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ds!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u2!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_u!cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ds!departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ds!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ds!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_s!isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicestype'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 384
    Top = 264
    object jcdsResultendstation: TWideStringField
      FieldName = 'endstation'
      Size = 30
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultdepartinvoicetypename: TWideStringField
      FieldName = 'departinvoicetypename'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
    end
    object jcdsResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsQryStatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 5
    end
    object jcdsResultticketnum: TIntegerField
      FieldName = 'ticketnum'
    end
    object jcdsResulttotalamount: TFloatField
      FieldName = 'totalamount'
    end
    object jcdsResultbalanceamount: TFloatField
      FieldName = 'balanceamount'
    end
    object jcdsResultstationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object jcdsResultfueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object jcdsResultagentfee: TFloatField
      FieldName = 'agentfee'
    end
    object jcdsResultothterfee: TFloatField
      FieldName = 'othterfee'
    end
    object jcdsResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 40
    end
    object jcdsResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultprintname: TWideStringField
      FieldName = 'printname'
      Size = 30
    end
    object jcdsResultprinttime: TDateTimeField
      FieldName = 'printtime'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultbalanceunitid: TLargeintField
      FieldName = 'balanceunitid'
    end
    object jcdsResultbalanceunitname: TWideStringField
      FieldName = 'balanceunitname'
      Size = 50
    end
    object jcdsResultiscomputerno: TIntegerField
      FieldName = 'iscomputerno'
    end
    object jcdsResultisaudit: TIntegerField
      FieldName = 'isaudit'
    end
    object jcdsResultdatafrom: TWideStringField
      FieldName = 'datafrom'
    end
  end
  inherited dsResult: TDataSource
    Left = 312
    Top = 264
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 224
    Top = 248
  end
  object ImageList: TImageList
    Left = 136
    Top = 328
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B007B7B7B00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B007B7B7B007B7B7B007B7B7B00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B007B7B7B00000000007B7B7B007B7B7B007B7B7B007B7B7B00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000007B7B7B000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B000000
      00000000000000000000000000007B7B7B007B7B7B007B7B7B00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B007B7B7B007B7B7B007B7B7B00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B007B7B7B007B7B
      7B00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B007B7B
      7B007B7B7B00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B007B7B7B007B7B7B000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF000000000000FFFF00C6C6C60000FFFF00C6C6C60000FFFF00C6C6C60000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFCFF0000
      FFFFF9FFF87F0000FFFFF0FFF07F0000FC7FF0FFF03F0000FC7FE07FE03F0000
      FC7FC07FC01F0000E00F843F841F0000E00F1E3F1E0F0000E00FFE1FFE0F0000
      FC7FFF1FFF070000FC7FFF8FFF830000FC7FFFC7FFC10000FFFFFFE3FFE00000
      FFFFFFF8FFF80000FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFC00FC03FE00FFFFF800F801FE00FFFFF800F800FE00FFFFF
      800F8007E00FFFFF800F8007E00FE007800F800FE00FE007800F800FE00FE007
      801F801FE00FFFFFC0FFC0FFE00FFFFFC0FFC0FFE01FFFFFFFFFFFFFE03FFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupMenu
    Left = 104
    Top = 248
    object N1: TMenuItem
      Caption = #21152#20837#32467#31639#21015#34920
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20840#37096#21152#20837#32467#31639#21015#34920
      OnClick = N2Click
    end
  end
  object jscdCreatetree: TjsonClientDataSet
    DataSourceName = 'unitvehicletree'
    QueryAddress = 'balance/createBalanceUnitTree'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 208
    Top = 192
  end
  object jcdsGenData: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/genBalanceData'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'invoicesids'
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
    Left = 168
    Top = 136
  end
  object jscdDelData: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/delBalanceData'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'invoicesids'
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
    Top = 88
  end
  object jcdsQryStatus: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'departinvoices'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 544
    Top = 304
  end
  object jcdsQryDeductDetail: TjsonClientDataSet
    DataSourceName = 'invoincesdeductlist'
    QueryAddress = 'balance/qryInvoicesdeductdetail'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoincesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 440
    object jcdsQryDeductDetaildeducttype: TWideStringField
      FieldName = 'deducttype'
      Size = 10
    end
    object jcdsQryDeductDetailname: TWideStringField
      FieldName = 'name'
    end
    object jcdsQryDeductDetailisdeductbeforebalance: TBooleanField
      FieldName = 'isdeductbeforebalance'
    end
    object jcdsQryDeductDetaildeductmoney: TFloatField
      FieldName = 'deductmoney'
    end
    object jcdsQryDeductDetailtarget: TWideStringField
      FieldName = 'target'
    end
    object jcdsQryDeductDetailstartdate: TDateField
      FieldName = 'startdate'
    end
    object jcdsQryDeductDetailenddate: TDateField
      FieldName = 'enddate'
    end
    object jcdsQryDeductDetaildeducttypename: TStringField
      FieldKind = fkLookup
      FieldName = 'deducttypename'
      LookupDataSet = jcdsQryDeducttype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'deducttype'
      Size = 40
      Lookup = True
    end
  end
  object dsDeduct: TDataSource
    DataSet = jcdsQryDeductDetail
    Left = 520
    Top = 480
  end
  object jcdsQryDeducttype: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'balancedeductitem'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'deducttype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 312
    Top = 480
  end
  object jscdQryBalance: TjsonClientDataSet
    DataSourceName = 'departinvoinceslist'
    SaveAddress = 'balance/qryBalanceByNo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 120
    Top = 200
  end
  object ds1: TDataSource
    DataSet = jscd1
    Left = 800
    Top = 216
  end
  object jscd1: TjsonClientDataSet
    DataSourceName = 'dataSet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 688
    Top = 208
    object jscd1endstation: TWideStringField
      FieldName = 'endstation'
      Size = 50
    end
    object jscd1departdate: TDateField
      FieldName = 'departdate'
    end
    object jscd1departinvoicetypename: TWideStringField
      FieldName = 'departinvoicetypename'
    end
    object jscd1vehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jscd1departinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
    end
    object jscd1statusname: TWideStringField
      FieldName = 'statusname'
      Size = 10
    end
    object jscd1code: TWideStringField
      FieldName = 'code'
    end
    object jscd1departtime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object jscd1ticketnum: TIntegerField
      FieldName = 'ticketnum'
    end
    object jscd1totalamount: TFloatField
      FieldName = 'totalamount'
    end
    object jscd1balanceamount: TFloatField
      FieldName = 'balanceamount'
    end
    object jscd1stationservicefee: TFloatField
      FieldName = 'stationservicefee'
    end
    object jscd1fueladditionfee: TFloatField
      FieldName = 'fueladditionfee'
    end
    object jscd1agentfee: TFloatField
      FieldName = 'agentfee'
    end
    object jscd1othterfee: TFloatField
      FieldName = 'othterfee'
    end
    object jscd1unitname: TWideStringField
      FieldName = 'unitname'
      Size = 50
    end
    object jscd1vehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jscd1id: TLargeintField
      FieldName = 'id'
    end
    object jscd1printname: TWideStringField
      FieldName = 'printname'
    end
    object jscd1printtime: TDateTimeField
      FieldName = 'printtime'
    end
    object jscd1status: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jscd1routename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jscd1routeid: TLargeintField
      FieldName = 'routeid'
    end
    object jscd1balanceunitid: TLargeintField
      FieldName = 'balanceunitid'
    end
    object jscd1balanceunitname: TWideStringField
      FieldName = 'balanceunitname'
      Size = 100
    end
    object jscd1datafrom: TWideStringField
      FieldName = 'datafrom'
    end
  end
  object pm1: TPopupMenu
    Left = 584
    Top = 224
    object N3: TMenuItem
      Caption = #21024#38500#24403#21069#36873#20013#36816#37327#21333
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #21024#38500#21015#34920#20013#25152#26377#36816#37327#21333
      OnClick = N4Click
    end
  end
  object jscdReCal: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/recalDepartinvoices'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fromdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'todepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'invoicesids'
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
    Left = 240
    Top = 88
  end
end
