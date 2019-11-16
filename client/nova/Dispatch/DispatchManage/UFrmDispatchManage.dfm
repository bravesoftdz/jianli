inherited FrmDispatchManage: TFrmDispatchManage
  Caption = 'IC'#21345#25253#29677
  ClientHeight = 555
  ClientWidth = 1122
  KeyPreview = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitWidth = 1138
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 98
    Width = 1122
    Height = 119
    ExplicitTop = 98
    ExplicitWidth = 1122
    ExplicitHeight = 119
    object lbl1: TLabel
      Left = 8
      Top = 20
      Width = 70
      Height = 14
      Caption = #24403#21069#35843#24230#31449
    end
    object Label2: TLabel
      Left = 213
      Top = 21
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label12: TLabel
      Left = 408
      Top = 21
      Width = 84
      Height = 14
      Caption = #21457#36710#26102#38388#22823#20110
    end
    object Label3: TLabel
      Left = 626
      Top = 55
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label4: TLabel
      Left = 20
      Top = 55
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label5: TLabel
      Left = 436
      Top = 55
      Width = 56
      Height = 14
      Caption = #35745#21010#36710#36742
    end
    object Label7: TLabel
      Left = 213
      Top = 55
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object Label1: TLabel
      Left = 22
      Top = 88
      Width = 56
      Height = 14
      Caption = #29677#27425#29366#24577
    end
    object Label8: TLabel
      Left = 213
      Top = 88
      Width = 56
      Height = 14
      Caption = #26816#31080#29366#24577
    end
    object Label9: TLabel
      Left = 436
      Top = 88
      Width = 56
      Height = 14
      Caption = #25253#29677#29366#24577
    end
    object Label6: TLabel
      Left = 612
      Top = 88
      Width = 56
      Height = 14
      Caption = #21806#31080#29366#24577
    end
    object Label10: TLabel
      Left = 768
      Top = 20
      Width = 28
      Height = 14
      Caption = #20998#38047
    end
    object DpDepartdate: TDateTimePicker
      Left = 277
      Top = 16
      Width = 121
      Height = 22
      Date = 40333.738843125000000000
      Time = 40333.738843125000000000
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object dtfromdatetime: TDateTimePicker
      Left = 499
      Top = 16
      Width = 96
      Height = 22
      Date = 37571.000162037000000000
      Format = 'HH:mm'
      Time = 37571.000162037000000000
      ShowCheckbox = True
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      Kind = dtkTime
      TabOrder = 2
    end
    object NovaCobbScheduleStatus: TNovaComboBox
      Left = 84
      Top = 85
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 9
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
      HelpOptions.TableName = 'schedulestatus'
      HelpOptions.Columnname = 'schedulestatus'
      HelpOptions.DisAll = True
    end
    object NovaCbbIsChecked: TNovaComboBox
      Left = 277
      Top = 85
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 10
      Items.Strings = (
        ''
        #24320#26816
        #26410#26816)
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
      HelpOptions.TableName = 'schedulestatus'
      HelpOptions.Columnname = 'schedulestatus'
      HelpOptions.DisAll = True
    end
    object NovaCbbIsReported: TNovaComboBox
      Left = 499
      Top = 85
      Width = 96
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 11
      Items.Strings = (
        ''
        #24050#25253#21040
        #26410#25253#21040)
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
      HelpOptions.TableName = 'schedulestatus'
      HelpOptions.Columnname = 'schedulestatus'
      HelpOptions.DisAll = True
    end
    object NovaCbbissellable: TNovaComboBox
      Left = 674
      Top = 85
      Width = 82
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 12
      Items.Strings = (
        ''
        #21457#21806
        #20572#21806)
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
      HelpOptions.TableName = 'schedulestatus'
      HelpOptions.Columnname = 'schedulestatus'
      HelpOptions.DisAll = True
    end
    object NHelpRoute: TNovaHelp
      Left = 84
      Top = 51
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 5
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
    object NovaHelpUnit: TNovaHelp
      Left = 277
      Top = 51
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 20
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
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 674
      Top = 51
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
    object NovaHCbbOrg: TNovaHComboBox
      Left = 84
      Top = 16
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
      HelpOptions.HDataSourceName = 'list'
      HelpOptions.HQueryAddress = 'dispatch/qryCurOrg'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object NovaHelpVehiclenoHelp: TNovaHelp
      Left = 499
      Top = 51
      Width = 96
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
          Title.Caption = #24231#20301#25968
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'brandname'
          Title.Caption = #21378#29260
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
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
    object chkDepatetimePre: TCheckBox
      Left = 612
      Top = 19
      Width = 97
      Height = 17
      Caption = #21457#36710#21069
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object NovaEditMinute: TNovaEdit
      Left = 674
      Top = 16
      Width = 82
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 3
      TabOrder = 4
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
    object ChkNotIsworkline: TCheckBox
      Left = 768
      Top = 55
      Width = 97
      Height = 17
      Caption = #38750#27969#27700#29677
      TabOrder = 13
    end
    object ChkIsworkline: TCheckBox
      Left = 768
      Top = 87
      Width = 97
      Height = 17
      Caption = #27969#27700#29677
      TabOrder = 14
    end
    object edtDriver1: TNovaHelp
      Left = 865
      Top = 27
      Width = 96
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 15
      Visible = False
      OnIdChange = edtDriver1IdChange
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
          Title.Caption = #22995#21517
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #24037#21495
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'DriverHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1122
    Height = 98
    ButtonWidth = 84
    ExplicitWidth = 1122
    ExplicitHeight = 98
    inherited tbtnFilter: TToolButton
      AutoSize = True
      Caption = ' &F.'#26597#35810' '
      OnClick = tbtnFilterClick
      ExplicitWidth = 67
    end
    inherited tbtn1: TToolButton
      Left = 67
      ExplicitLeft = 67
    end
    inherited tbtnInsert: TToolButton
      Left = 75
      AutoSize = True
      Caption = '  '#25253#21040'  '
      ImageIndex = 48
      OnClick = tbtnInsertClick
      ExplicitLeft = 75
      ExplicitWidth = 67
    end
    inherited tbtnEdit: TToolButton
      Left = 142
      AutoSize = True
      Caption = #21462#28040#25253#21040
      ImageIndex = 51
      OnClick = tbtnEditClick
      ExplicitLeft = 142
      ExplicitWidth = 67
    end
    inherited tbtnDelete: TToolButton
      Left = 209
      AutoSize = True
      Caption = #26202#28857#22788#29702
      ImageIndex = 25
      OnClick = tbtnDeleteClick
      ExplicitLeft = 209
      ExplicitWidth = 67
    end
    inherited ToolButton50: TToolButton
      Left = 276
      Caption = '&F3.'#25171#21333
      ImageIndex = 8
      OnClick = ToolButton50Click
      ExplicitLeft = 276
      ExplicitWidth = 60
    end
    inherited ToolButton51: TToolButton
      Left = 336
      Caption = '&F2.'#21457#29677#25171#21333
      ImageIndex = 17
      OnClick = ToolButton51Click
      ExplicitLeft = 336
      ExplicitWidth = 88
    end
    inherited tbtn3: TToolButton
      Left = 0
      Wrap = True
      Visible = False
      ExplicitLeft = 0
      ExplicitHeight = 53
    end
    inherited tbtnSave: TToolButton
      Left = 0
      Top = 53
      AutoSize = True
      Caption = #25442#36710#25253#21040
      ImageIndex = 35
      OnClick = tbtnSaveClick
      ExplicitLeft = 0
      ExplicitTop = 53
      ExplicitWidth = 67
    end
    inherited tbtnCancel: TToolButton
      Left = 67
      Top = 53
      AutoSize = True
      Caption = #20572#29677
      Enabled = False
      ImageIndex = 44
      Visible = False
      OnClick = tbtnCancelClick
      ExplicitLeft = 67
      ExplicitTop = 53
      ExplicitWidth = 39
    end
    inherited ToolButton52: TToolButton
      Left = 106
      Top = 53
      AutoSize = False
      Caption = #25918#31354
      ImageIndex = 38
      OnClick = ToolButton52Click
      ExplicitLeft = 106
      ExplicitTop = 53
      ExplicitWidth = 84
    end
    inherited ToolButton53: TToolButton
      Left = 190
      Top = 53
      Caption = #37325#32622#21333#21495
      ImageIndex = 45
      OnClick = ToolButton53Click
      ExplicitLeft = 190
      ExplicitTop = 53
      ExplicitWidth = 67
    end
    inherited tbtn4: TToolButton
      Left = 257
      Top = 53
      ExplicitLeft = 257
      ExplicitTop = 53
    end
    inherited tbtnInfo: TToolButton
      Left = 265
      Top = 53
      AutoSize = True
      Caption = #36816#34892#35745#21010
      ExplicitLeft = 265
      ExplicitTop = 53
      ExplicitWidth = 67
    end
    inherited tbtn5: TToolButton
      Left = 332
      Top = 53
      ExplicitLeft = 332
      ExplicitTop = 53
    end
    inherited tbtnExcel: TToolButton
      Left = 340
      Top = 53
      ExplicitLeft = 340
      ExplicitTop = 53
      ExplicitWidth = 84
    end
    inherited tbtnPrinter: TToolButton
      Left = 424
      Top = 53
      Caption = #25171#21360#36335#21333
      ExplicitLeft = 424
      ExplicitTop = 53
      ExplicitWidth = 84
    end
    inherited tbtn6: TToolButton
      Left = 508
      Top = 53
      Caption = #37325#25171#36335#21333
      ImageIndex = 5
      Style = tbsButton
      OnClick = tbtn6Click
      ExplicitLeft = 508
      ExplicitTop = 53
      ExplicitWidth = 84
    end
    inherited tbtnClose: TToolButton
      Left = 592
      Top = 53
      ExplicitLeft = 592
      ExplicitTop = 53
      ExplicitWidth = 84
    end
    object GroupBox2: TGroupBox
      Left = 676
      Top = 53
      Width = 294
      Height = 45
      Align = alRight
      Caption = #24403#21069#32467#31639#21333#21495
      TabOrder = 0
      Visible = False
      object lblBillnum: TLabel
        Left = 234
        Top = 16
        Width = 58
        Height = 27
        Align = alClient
        Caption = '100'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 33
        ExplicitHeight = 19
      end
      object lblBillno: TLabel
        Left = 2
        Top = 16
        Width = 132
        Height = 27
        Align = alLeft
        Caption = '888888888888'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 19
      end
      object Label11: TLabel
        Left = 134
        Top = 16
        Width = 100
        Height = 27
        Align = alLeft
        Caption = #21097#20313#24352#25968#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 19
      end
    end
  end
  inherited Panel1: TPanel
    Top = 217
    Width = 1122
    Height = 338
    ExplicitTop = 217
    ExplicitWidth = 1122
    ExplicitHeight = 338
    object Splitter2: TSplitter [0]
      Left = 169
      Top = 0
      Height = 338
      ExplicitLeft = 210
      ExplicitTop = 6
      ExplicitHeight = 331
    end
    inherited GroupBox1: TGroupBox
      Left = 172
      Width = 950
      Height = 338
      Caption = #29677#27425#33829#36816#20449#24687
      ExplicitLeft = 172
      ExplicitWidth = 950
      ExplicitHeight = 338
      inherited dbgrdhResult: TNvDbgridEh
        Width = 946
        Height = 320
        FooterRowCount = 1
        ImeMode = imDisable
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        RowHeight = 30
        SumList.Active = True
        OnDblClick = dbgrdhResultDblClick
        OnGetCellParams = dbgrdhResultGetCellParams
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
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
            FieldName = 'code'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'schedulestatus'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25253#21040#36710#31449
            Width = 100
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
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #32447#36335#21517#31216
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'isreported'
            Footers = <>
            Title.Caption = #25253#21040#21542
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'isreplace'
            Footers = <>
            Title.Caption = #39030#29677#21542
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'reporttime'
            Footers = <>
            Title.Caption = #25253#21040#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #25253#21040#36710#36742
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'planvehicle'
            Footers = <>
            Title.Caption = #35745#21010#36710#36742
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'reporddriver1'
            Footers = <>
            Title.Caption = #20027#39550#39542#21592
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'reporddriver2'
            Footers = <>
            Title.Caption = #21103#39550#39542#21592'1'
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'reporddriver3'
            Footers = <>
            Title.Caption = #21103#39550#39542#21592'2'
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'reporddriver4'
            Footers = <>
            Title.Caption = #21103#39550#39542#21592'3'
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #21457#29677
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24231#20301#25968
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #24050#21806
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'leaveseat'
            Footers = <>
            Title.Caption = #20313#24231
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'fixedreserveseatnum'
            Footers = <>
            Title.Caption = #22266#23450#30041#20301
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'autocancelreserveseatnum'
            Footers = <>
            Title.Caption = #33258#21160#21462#28040#30041#20301
          end
          item
            EditButtons = <>
            FieldName = 'unautocancelreserveseatnum'
            Footers = <>
            Title.Caption = #19981#33258#21160#21462#28040#30041#20301
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reportname'
            Footers = <>
            Title.Caption = #25805#20316#21592
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reportunit'
            Footers = <>
            Title.Caption = #25253#21040#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'buspark'
            Footers = <>
            Title.Caption = #20572#36710#21345#20301
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #32447#36335#20844#37324
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'highdistance'
            Footers = <>
            Title.Caption = #39640#36895#37324#31243
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Footers = <>
            Title.Caption = #21487#21806#21542
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'isbegincheck'
            Footers = <>
            Title.Caption = #24320#26816
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isemptyvehicle'
            Footers = <>
            Title.Caption = #25918#31354
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'scheduletypename'
            Footers = <>
            Title.Caption = #29677#27425#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'worktypename'
            Footers = <>
            Title.Caption = #33829#36816#31867#21035
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'workwaysname'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'districttypename'
            Footers = <>
            Title.Caption = #36816#34892#21306#22495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'iscanmixcheck'
            Footers = <>
            Title.Caption = #21487#21542#28151#26816
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #27969#27700#29677
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'spacinginterval'
            Footers = <>
            Title.Caption = #38388#38548#21457#36710#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'endtime'
            Footers = <>
            Title.Caption = #26411#29677#26102#38388
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'isproprietary'
            Footers = <>
            Title.Caption = #26412#31449#19987#33829
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'isoriginator'
            Footers = <>
            Title.Caption = #36807#36335#29677#27425
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'issaleafterreport'
            Footers = <>
            Title.Caption = #25253#21040#21518#21487#21806
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'issellreturnticket'
            Footers = <>
            Title.Caption = #26159#21542#21806#22238#31243#31080
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Title.Caption = #29677#27425'ID'
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'rationseatnum'
            Footers = <>
            Visible = False
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 0
            object Splitter1: TSplitter
              Left = 0
              Top = -151
              Width = 0
              Height = 3
              Cursor = crVSplit
              Align = alBottom
              ExplicitTop = 0
              ExplicitWidth = 243
            end
            object GroupBox4: TGroupBox
              Left = 0
              Top = 0
              Width = 0
              Height = 139
              Align = alClient
              Caption = #29677#27425#33829#36816#20449#24687
              TabOrder = 0
              object NvDbgridEh1: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 984
                Height = 121
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsResult
                Flat = False
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -14
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                ImeMode = imClose
                ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
                    Title.Caption = #26426#26500
                    Width = 120
                  end
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
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'schedulestatus'
                    Footers = <>
                    Title.Caption = #29366#24577
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departstation'
                    Footers = <>
                    Title.Caption = #21457#36710#31449
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departdate'
                    Footers = <>
                    Title.Caption = #21457#36710#26085#26399
                    Width = 80
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
                    FieldName = 'reachstation'
                    Footers = <>
                    Title.Caption = #32456#28857#31449
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicletypename'
                    Footers = <>
                    Title.Caption = #36710#22411
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seatnum'
                    Footers = <>
                    Title.Caption = #24635#24231#25968
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'soldeatnum'
                    Footers = <>
                    Title.Caption = #24050#21806
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'fixedreserveseatnum'
                    Footers = <>
                    Title.Caption = #22266#23450#30041#20301#25968
                    Width = 81
                  end
                  item
                    EditButtons = <>
                    FieldName = 'autocancelreserveseatnum'
                    Footers = <>
                    Title.Caption = #33258#21160#21462#28040#30041#20301#25968
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'unautocancelreserveseatnum'
                    Footers = <>
                    Title.Caption = #19981#33258#21160#21462#28040#30041#20301#25968
                    Width = 128
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
                    FieldName = 'buspark'
                    Footers = <>
                    Title.Caption = #19978#36710#21345#20301
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'runtime'
                    Footers = <>
                    Title.Caption = #36816#34892#26102#38388
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehicleno'
                    Footers = <>
                    Title.Caption = #35745#21010#36710#36742
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'brandname'
                    Footers = <>
                    Title.Caption = #36710#36742#21378#29260
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'distance'
                    Footers = <>
                    Title.Caption = #20844#37324#25968
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'driver1'
                    Footers = <>
                    Title.Caption = #35745#21010#39550#39542#21592'1'
                    Width = 91
                  end
                  item
                    EditButtons = <>
                    FieldName = 'driver2'
                    Footers = <>
                    Title.Caption = #35745#21010#39550#39542#21592'2'
                    Width = 87
                  end
                  item
                    EditButtons = <>
                    FieldName = 'driver3'
                    Footers = <>
                    Title.Caption = #35745#21010#39550#39542#21592'3'
                    Width = 88
                  end
                  item
                    EditButtons = <>
                    FieldName = 'steward1'
                    Footers = <>
                    Title.Caption = #35745#21010#20056#21153#21592
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isreported'
                    Footers = <>
                    Title.Caption = #25253#21040
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isbegincheck'
                    Footers = <>
                    Title.Caption = #24320#26816
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isdeparted'
                    Footers = <>
                    Title.Caption = #21457#29677
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'districttypename'
                    Footers = <>
                    Title.Caption = #36816#34892#21306#22495
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'worktypename'
                    Footers = <>
                    Title.Caption = #33829#36816#31867#21035
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'scheduletypename'
                    Footers = <>
                    Title.Caption = #29677#27425#31867#22411
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'worktypename'
                    Footers = <>
                    Title.Caption = #33829#36816#31867#21035
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'workwaysname'
                    Footers = <>
                    Title.Caption = #33829#36816#26041#24335
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'highdistance'
                    Footers = <>
                    Title.Caption = #39640#36895#37324#31243
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'iscanmixcheck'
                    Footers = <>
                    Title.Caption = #28151#26816
                    Width = 44
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isoriginator'
                    Footers = <>
                    Title.Caption = #36807#36335#29677#27425
                    Width = 63
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isovertime'
                    Footers = <>
                    Title.Caption = #21152#29677#29677#27425
                    Width = 67
                  end
                  item
                    EditButtons = <>
                    FieldName = 'isproprietary'
                    Footers = <>
                    Title.Caption = #26412#31449#19987#33829
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issaleafterreport'
                    Footers = <>
                    Title.Caption = #25253#21040#21518#21806#31080
                    Width = 83
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issellable'
                    Footers = <>
                    Title.Caption = #20801#35768#21806#31080
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issellreturnticket'
                    Footers = <>
                    Title.Caption = #21452#31243#29677#27425
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'islinework'
                    Footers = <>
                    Title.Caption = #27969#27700#29677#27425
                    Width = 67
                  end
                  item
                    EditButtons = <>
                    FieldName = 'starttime'
                    Footers = <>
                    Title.Caption = #39318#29677#26102#38388
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'spacinginterval'
                    Footers = <>
                    Title.Caption = #21457#29677#38388#38548
                    Width = 66
                  end
                  item
                    EditButtons = <>
                    FieldName = 'endtime'
                    Footers = <>
                    Title.Caption = #26411#29677#26102#38388
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'createtime'
                    Footers = <>
                    Title.Caption = #21019#24314#26102#38388
                    Width = 150
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
            object GroupBox5: TGroupBox
              Left = 0
              Top = -148
              Width = 0
              Height = 148
              Align = alBottom
              Caption = #25191#34892#31080#20215#20449#24687
              TabOrder = 1
              object NvDbgridEh2: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 984
                Height = 130
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                Flat = False
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -14
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                ImeMode = imClose
                ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
                ParentName = 'FrmExecutePrice'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'departstation'
                    Footers = <>
                    Title.Caption = #19978#36710#31449
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'reachstation'
                    Footers = <>
                    Title.Caption = #21040#36798#31449
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seattypename'
                    Footers = <>
                    Title.Caption = #24231#20301#31867#22411
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'seatnum'
                    Footers = <>
                    Title.Caption = #24231#20301#25968
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'soldeatnum'
                    Footers = <>
                    Title.Caption = #24050#21806
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'residueseatnum'
                    Footers = <>
                    Title.Caption = #20313#24231
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'fullprice'
                    Footers = <>
                    Title.Caption = #20840#31080#20215
                    Width = 51
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
                    Title.Caption = #23398#29983#31080#20215
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'toplimitprice'
                    Footers = <>
                    Title.Caption = #19978#38480#20215
                    Width = 56
                  end
                  item
                    EditButtons = <>
                    FieldName = 'lowerlimitprice'
                    Footers = <>
                    Title.Caption = #19979#38480#20215
                    Width = 54
                  end
                  item
                    EditButtons = <>
                    FieldName = 'issellable'
                    Footers = <>
                    Title.Caption = #20801#35768#21806#31080
                    Width = 68
                  end
                  item
                    EditButtons = <>
                    FieldName = 'runtime'
                    Footers = <>
                    Title.Caption = #36816#34892#26102#38388
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'distance'
                    Footers = <>
                    Title.Caption = #20844#37324#25968
                    Width = 50
                  end
                  item
                    EditButtons = <>
                    FieldName = 'balancedistance'
                    Footers = <>
                    Title.Caption = #32467#31639#37324#31243
                    Width = 70
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
          end
        end
      end
    end
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 169
      Height = 338
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object grp1: TGroupBox
        Left = 0
        Top = 129
        Width = 169
        Height = 209
        Align = alClient
        Caption = #25552#31034#20449#24687
        TabOrder = 2
        object mmoReportInfo: TMemo
          Left = 2
          Top = 16
          Width = 165
          Height = 191
          Align = alClient
          Color = clInfoBk
          Ctl3D = False
          ImeName = #20013#25991' ('#31616#20307') - '#29579#30721#20116#31508#22411'86'#29256
          ParentCtl3D = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object grp3: TGroupBox
        Left = 0
        Top = 52
        Width = 169
        Height = 52
        Align = alTop
        Caption = #36710#29260#21495#30721
        TabOrder = 1
        object NovaHelpVehicleNo: TNovaHelp
          Left = 12
          Top = 24
          Width = 140
          Height = 22
          CharCase = ecUpperCase
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
          MaxLength = 50
          TabOrder = 0
          OnKeyUp = NovaHelpVehicleNoKeyUp
          OnIdChange = NovaHelpVehicleNoIdChange
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
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'brandname'
              Title.Caption = #21378#29260
              Width = 60
              Visible = True
            end>
          HelpOptions.HelpHeight = 150
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
      end
      object grp2: TGroupBox
        Left = 0
        Top = 0
        Width = 169
        Height = 52
        Align = alTop
        Caption = 'IC'#21345#21495
        TabOrder = 0
        object NovaEdtCardNo: TNovaEdit
          Left = 12
          Top = 24
          Width = 140
          Height = 22
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
          MaxLength = 50
          TabOrder = 0
          OnChange = NovaEdtCardNoChange
          OnKeyDown = NovaEdtCardNoKeyDown
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
      object pnlAutoReport: TPanel
        Left = 0
        Top = 104
        Width = 169
        Height = 25
        Align = alTop
        TabOrder = 3
        object chkAutoReport: TCheckBox
          Left = 52
          Top = 4
          Width = 97
          Height = 17
          Caption = #33258#21160#25253#29677
          TabOrder = 0
          OnClick = chkAutoReportClick
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 40
    Top = 368
  end
  inherited ilToolBarDisable: TImageList
    Left = 104
    Top = 368
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'scheduleplanlist'
    QueryAddress = 'dispatch/qryDisScheduleplan'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQD_sp!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GES_ss!departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LES_ss!departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isbegincheck'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_ss!isreported'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!issellable'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_r!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_u1!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sv!planvehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_sp!islinework'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'qrycurstationid'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 304
    Top = 312
    object jcdsResultreportorgid: TLargeintField
      FieldName = 'reportorgid'
    end
    object jcdsResultreportid: TLargeintField
      FieldName = 'reportid'
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object departdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultscheduleid: TLargeintField
      FieldName = 'scheduleid'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsResultautocancelreserveseatnum: TIntegerField
      FieldName = 'autocancelreserveseatnum'
    end
    object jcdsResultunautocancelreserveseatnum: TIntegerField
      FieldName = 'unautocancelreserveseatnum'
    end
    object jcdsResultfixedreserveseatnum: TIntegerField
      FieldName = 'fixedreserveseatnum'
    end
    object jcdsResultsoldeatnum: TIntegerField
      FieldName = 'soldeatnum'
    end
    object jcdsResultissellable: TBooleanField
      FieldName = 'issellable'
    end
    object jcdsResultstartstationid: TLargeintField
      FieldName = 'startstationid'
    end
    object jcdsResultendstationid: TLargeintField
      FieldName = 'endstationid'
    end
    object jcdsResultruntime: TFloatField
      FieldName = 'runtime'
    end
    object jcdsResultdistance: TIntegerField
      FieldName = 'distance'
    end
    object jcdsResulthighdistance: TIntegerField
      FieldName = 'highdistance'
    end
    object jcdsResultworktype: TWideStringField
      FieldName = 'worktype'
      Size = 10
    end
    object jcdsResultworkways: TWideStringField
      FieldName = 'workways'
      Size = 10
    end
    object jcdsResultdistricttype: TWideStringField
      FieldName = 'districttype'
      Size = 10
    end
    object jcdsResultscheduletype: TWideStringField
      FieldName = 'scheduletype'
      Size = 10
    end
    object jcdsResultisproprietary: TBooleanField
      FieldName = 'isproprietary'
    end
    object jcdsResultisovertime: TBooleanField
      FieldName = 'isovertime'
    end
    object jcdsResultissellreturnticket: TBooleanField
      FieldName = 'issellreturnticket'
    end
    object jcdsResultislinework: TBooleanField
      FieldName = 'islinework'
    end
    object jcdsResultendtime: TWideStringField
      FieldName = 'endtime'
      Size = 10
    end
    object jcdsResultspacinginterval: TIntegerField
      FieldName = 'spacinginterval'
    end
    object jcdsResultisoriginator: TBooleanField
      FieldName = 'isoriginator'
    end
    object jcdsResultissaleafterreport: TBooleanField
      FieldName = 'issaleafterreport'
    end
    object jcdsResultiscanmixcheck: TBooleanField
      FieldName = 'iscanmixcheck'
    end
    object jcdsResultdepartstationid: TLargeintField
      FieldName = 'departstationid'
    end
    object jcdsResultdepartstation: TWideStringField
      FieldName = 'departstation'
      Size = 30
    end
    object jcdsResultendstation: TWideStringField
      FieldName = 'endstation'
      Size = 30
    end
    object jcdsResultdeparttime: TWideStringField
      FieldName = 'departtime'
      Size = 10
    end
    object jcdsResultticketentrance: TWideStringField
      FieldName = 'ticketentrance'
      Size = 30
    end
    object jcdsResultbuspark: TWideStringField
      FieldName = 'buspark'
    end
    object jcdsResultisreported: TBooleanField
      FieldName = 'isreported'
    end
    object jcdsResultisbegincheck: TBooleanField
      FieldName = 'isbegincheck'
    end
    object jcdsResultisdeparted: TBooleanField
      FieldName = 'isdeparted'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 10
    end
    object jcdsResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResultplanvehicleid: TLargeintField
      FieldName = 'planvehicleid'
    end
    object jcdsResultplanvehicle: TWideStringField
      FieldName = 'planvehicle'
    end
    object jcdsResultplanvehicletypeid: TLargeintField
      FieldName = 'planvehicletypeid'
    end
    object jcdsResultplanvehicletype: TWideStringField
      FieldName = 'planvehicletype'
    end
    object jcdsResultplanvehiclebrandmodelid: TLargeintField
      FieldName = 'planvehiclebrandmodelid'
    end
    object jcdsResultplanunitid: TLargeintField
      FieldName = 'planunitid'
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
    end
    object jcdsResultleaveseat: TIntegerField
      FieldName = 'leaveseat'
    end
    object jcdsResultisemptyvehicle: TBooleanField
      FieldName = 'isemptyvehicle'
    end
    object jcdsResultreportunit: TWideStringField
      FieldName = 'reportunit'
      Size = 50
    end
    object jcdsResultreportname: TWideStringField
      FieldName = 'reportname'
      Size = 50
    end
    object jcdsResultschedulestatus: TWideStringField
      FieldKind = fkLookup
      FieldName = 'schedulestatus'
      LookupDataSet = jcdsScheduleStatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object jcdsResultworktypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'worktypename'
      LookupDataSet = jcsdWorkType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'worktype'
      Lookup = True
    end
    object jcdsResultworkwaysname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'workwaysname'
      LookupDataSet = jcdsworkways
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'workways'
      Lookup = True
    end
    object jcdsResultdistricttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'districttypename'
      LookupDataSet = jcdsDISTRICTTYPE
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'districttype'
      Lookup = True
    end
    object jcdsResultscheduletypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'scheduletypename'
      LookupDataSet = jcdstype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'scheduletype'
      Lookup = True
    end
    object jcdsResultreporttime: TDateTimeField
      FieldName = 'reporttime'
    end
    object jcdsResultplanunit: TWideStringField
      FieldName = 'planunit'
      Size = 50
    end
    object jcdsResultplandriver1id: TLargeintField
      FieldName = 'plandriver1id'
    end
    object jcdsResultplandriver1: TWideStringField
      FieldName = 'plandriver1'
      Size = 50
    end
    object jcdsResultplandriver2id: TLargeintField
      FieldName = 'plandriver2id'
    end
    object jcdsResultplandriver2: TWideStringField
      FieldName = 'plandriver2'
      Size = 50
    end
    object jcdsResultplandriver3id: TLargeintField
      FieldName = 'plandriver3id'
    end
    object jcdsResultplandriver3: TWideStringField
      FieldName = 'plandriver3'
      Size = 50
    end
    object jcdsResultplansteward1id: TLargeintField
      FieldName = 'plansteward1id'
    end
    object jcdsResultplansteward2id: TLargeintField
      FieldName = 'plansteward2id'
    end
    object jcdsResultplansteward1: TWideStringField
      FieldName = 'plansteward1'
      Size = 50
    end
    object jcdsResultplansteward2: TWideStringField
      FieldName = 'plansteward2'
      Size = 50
    end
    object jcdsResultremarks: TWideStringField
      FieldName = 'remarks'
      Size = 300
    end
    object jcdsResultschedulestatusid: TLargeintField
      FieldName = 'schedulestatusid'
    end
    object jcdsResultreporddriver1: TWideStringField
      FieldName = 'reporddriver1'
    end
    object jcdsResultreporddriver2: TWideStringField
      FieldName = 'reporddriver2'
    end
    object jcdsResultisreplace: TBooleanField
      FieldName = 'isreplace'
    end
    object jcdsResultdriverfingernum: TIntegerField
      FieldName = 'driverfingernum'
    end
    object jcdsResultreportddriver3: TWideStringField
      FieldName = 'reporddriver3'
      Size = 100
    end
    object jcdsResultreporddriver4: TWideStringField
      FieldName = 'reporddriver4'
      Size = 100
    end
    object jcdsResultrationseatnum: TWideStringField
      FieldName = 'rationseatnum'
    end
    object jcdsResultplandriver4id: TLargeintField
      FieldName = 'plandriver4id'
    end
    object jcdsResultplandriver4: TWideStringField
      FieldName = 'plandriver4'
      Size = 100
    end
    object jcdsResultbalanceunitid: TLargeintField
      FieldName = 'balanceunitid'
    end
    object jcdsResultbalanceunitname: TWideStringField
      FieldName = 'balanceunitname'
    end
    object jcdsResultliabilityinsureenddate: TDateField
      FieldName = 'liabilityinsureenddate'
    end
    object jcdsResultroadno: TWideStringField
      FieldName = 'roadno'
      Size = 100
    end
    object jcdsResultlicenseenddate: TDateField
      FieldName = 'licenseenddate'
    end
    object jcdsResultworkenddate: TDateField
      FieldName = 'workenddate'
    end
    object jcdsResultcompulsoryinsureenddate: TDateField
      FieldName = 'compulsoryinsureenddate'
    end
    object jcdsResultstewardname: TWideStringField
      FieldName = 'stewardname'
    end
  end
  inherited dsResult: TDataSource
    Left = 176
    Top = 248
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 384
    Top = 288
  end
  object jcdsQryRouteTree: TjsonClientDataSet
    DataSourceName = 'routetreelist'
    QueryAddress = 'dispatch/qryRouteTree'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'orgid'
        ParamType = ptInput
        Value = '310'
      end>
    RemoteServer = DMPublic.jcon
    Left = 472
    Top = 288
  end
  object ImageList1: TImageList
    Left = 142
    Top = 315
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      000000000000000000000000000000000000000000000000000000000000CECD
      CF00C4C5C300C4C4C400C5C5C500C3C3C300C5C5C500C3C3C300C5C5C500C4C4
      C400C4C4C400C6C4C400D0CECD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D0D2D200CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CCCDCB00D4D2D10000000000000000000000000000000000189BC7000C73
      A4001073A5000C73A4000C73A4000D74A5000B72A3000A71A200076E9F00066D
      9E00036A9B0002699A00B9B7B700CBCDCD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001F82B6001C82B300187E
      AF00167CAD00147AAB001177A8000E74A5000B71A200086E9F00066C9D00046A
      9B0000669700C1C2C000D1D3D300000000000000000000000000189AC50098FF
      FF0076DDFE0075DAFF0073DBFF0075DCFC0074DCFF0075DAFF0073DBFE0073DB
      FE007CE5F0001B99C90000679800C7C5C5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000278ABE009AFFFF0077DBFE0074DC
      FF0075DBFE0075DBFE0076DCFF0075DBFE0075DBFE0075DBFE0075DBFE0075DB
      FE0099FFFE0002679B00CDCACC000000000000000000199AC50099FDFE0089EE
      FD0087EEFD0086EFFC0089EEFD008AEEFE0087EDFE0088EFFE0086EDFC00A6FD
      FE001F9EC70043B3DE00036A9A00C3C2C4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002A8DBF0099FEFF0080E5FE007FE4
      FD007FE3FF007CE6FE007EE5FF0080E3FF007EE5FF0080E5FE007EE5FF0080E4
      FF0099FFFE00036B9A00CDCBCB00000000001698C40099FEFC009AFEFD0094F7
      FE0094F8FD0091F6FE008FF9FE0090F5FD0092F8FD0091F6FE009CFEFE0085EE
      F7001B9AC50070D2FE00056C9C00C5C3C3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000298DC30099FFFE0088EEFF0088F0
      FF008CEFFD0087EFFE008AEEFF0088EEFF0087F0FD0088EFFE0088EEFF008AEF
      FE009AFFFF00066B9F00CBCBCB00000000001899C30098FDFD0099FDFD009BFB
      FD009AFDFD009CFDFD009DFCFC009AFDFD009CFDFC009CFDFD009AFDFC006CBF
      D9001897C70083D6FC00076DA000C3C4C2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002D92C6009AFFFF0095F9FD0095F8
      FF0090F7FF0096FAFF0094F8FD0094FBFE0092F7FF0093F9FE0095F9FE0092F7
      FF0099FFFE00086E9F00D0CCCB00000000001B99C5001998C2001C98C400189A
      C5001B99C5001A98C4001B9AC4001A9AC6001897C6001999C5001799C3001898
      C4004DC1DE0084E9FC000A6FA300C2C3C1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003196CA009BFFFF009BFFFF009AFF
      FD009BFFFE009AFEFE009BFFFE009CFEFE009AFEFF009DFFFE00A0FFFF009BFF
      FE009AFFFE001073A700CDCECC0000000000000000003296C900FBFBFB009DFB
      FB009DFBFA0099FBFA0099FBFB009DFBFB009BFAFB0099FBFB00FBFBFB00FBFA
      FB00FBFBFB00FCFCFC00157AAA00CECDCF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003599C900FEFEFE00FFFEFF00FFFE
      FF00FEFEFE0000000000FDFFFF00FFFFFE00FFFEFF00FFFEFF00FFFFFE000000
      0000FFFEFE00157BAC00D5D6D40000000000000000003296C900FAF9FA0098FA
      FA0097F9F9009AFAFA0096F9FA009AFAFA00FAF9FA002487BA002084B7001E81
      B4001C80B0001A7EB1001A7BAC00FBFBFB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003399CA0070B7DC0051B7DA0053B7
      DA0052B8DB0053B5DD004FB7DA0073B7DA002489BD002187BB001E84B8001982
      B5001A80B5001880AF00000000000000000000000000000000003594C900F9F9
      F900F9F9F900F9F8F800F5F6F400F6F5F1002A8CBB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000369ACA00FBFFFF000000
      0000FFFFFE00B9FFFE00BEFEFF00298FC0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003194
      C7003396C6003192C7002E91C1002F91C3000000000000000000000000000000
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
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFE00100000000C003C000000000008001C00000000000
      0001800000000000000100000000000000010000000000000001000000000000
      000180000000000004118000000000000003C07F0000000090FFE0FF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
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
    Left = 624
    Top = 360
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
    Left = 536
    Top = 360
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
    Left = 448
    Top = 360
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
    Top = 360
  end
  object jcdsScheduleStatus: TjsonClientDataSet
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
        Value = 'schedulestatus'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'schedulestatus'
      end>
    ReadOnly = True
    RemoteServer = DMPublic.jcon
    Left = 264
    Top = 360
  end
  object jcdsStopScheduleplan: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/stopScheduleplan'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.scheduleplan.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.createby'
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
    Left = 536
    Top = 184
  end
  object jcdsallowScheduleplan: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/allowScheduleplan'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.scheduleplan.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
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
    Left = 640
    Top = 256
  end
  object jcsdSaveRoadbill: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'dispatch/saveroadbill'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'roadbillprint.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'roadbillprint.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'roadbillprint.roadbillno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'roadbillprint.vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'roadbillprint.validateday'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'roadbillprint.remark'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
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
    Left = 704
    Top = 304
  end
  object jcdsDepartScheduleNoPrint: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/departScheduleNoPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereport.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.reportorgid'
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
    Left = 888
    Top = 344
  end
  object jcsdundodepartScheduleNoPrint: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/undodepartScheduleNoPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereport.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.reportorgid'
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
    Left = 808
    Top = 288
  end
  object jscdVehicleLater: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/schVehicleLater'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'schedulestatusid'
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
    Left = 984
    Top = 112
  end
  object jcdsDepartinvoice: TjsonClientDataSet
    DataSourceName = 'invoiceslist'
    QueryAddress = 'checkticket/vehicleDepartinvoice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'iscomputeno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isreprint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
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
    Left = 576
    Top = 8
  end
  object jcdsQryDetail: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryInvoicesDetailPrintInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 672
  end
  object jcdsOthersells: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'checkticket/qryOthersellmessage'
    SaveAddress = 'checkticket/qryOthersellmessage'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'othersells'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 752
    Top = 8
  end
  object jcdsResultSave: TjsonClientDataSet
    DataSourceName = 'departinvoicesMap'
    QueryAddress = 'checkticket/qryprintinvoices'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
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
    Left = 934
    Top = 179
  end
  object jscdQryDeductfees: TjsonClientDataSet
    DataSourceName = 'invoicesdetaillist'
    QueryAddress = 'checkticket/qryDeductfees'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 488
    Top = 96
  end
  object jsonSpcQry: TjsonClientDataSet
    DataSourceName = 'pictureResult'
    QueryAddress = 'archive/queryDriverFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 344
    Top = 176
  end
  object jsonQryStwed: TjsonClientDataSet
    DataSourceName = 'stewardpicture'
    QueryAddress = 'archive/queryStewardFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 432
    Top = 184
  end
  object qryvehisecuresult: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/qryvehisecuresult'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereportid'
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
    Left = 512
  end
  object jcdsVehicleDriver: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'dispatch/qryVehicleDriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 824
    Top = 186
  end
  object jcsdqryvehiclebydriverid: TjsonClientDataSet
    DataSourceName = 'vehiclemap'
    QueryAddress = 'archive/findVehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'driverid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 712
    Top = 368
  end
end
