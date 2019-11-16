inherited FrmVehicle: TFrmVehicle
  Caption = #36710#36742#31649#29702
  ClientHeight = 498
  ClientWidth = 1003
  OldCreateOrder = False
  ExplicitWidth = 1019
  ExplicitHeight = 536
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1003
    Height = 116
    ExplicitWidth = 1003
    ExplicitHeight = 116
    object lbl3: TLabel
      Left = 244
      Top = 23
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object lblunitid: TLabel
      Left = 446
      Top = 23
      Width = 56
      Height = 14
      Caption = #25152#23646#21333#20301
    end
    object lblcardno: TLabel
      Left = 30
      Top = 56
      Width = 42
      Height = 14
      Caption = 'IC'#21345#21495
    end
    object lblvehicletypeid: TLabel
      Left = 44
      Top = 23
      Width = 28
      Height = 14
      Caption = #36710#22411
    end
    object lbltype: TLabel
      Left = 16
      Top = 91
      Width = 56
      Height = 14
      Caption = #33829#36816#31867#22411
    end
    object lblcontractno: TLabel
      Left = 232
      Top = 56
      Width = 56
      Height = 14
      Caption = #21512#21516#32534#21495
    end
    object Label1: TLabel
      Left = 656
      Top = 23
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object Label4: TLabel
      Left = 446
      Top = 58
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl1: TLabel
      Left = 684
      Top = 56
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object lbl2: TLabel
      Left = 232
      Top = 91
      Width = 56
      Height = 14
      Caption = #36710#29260#31616#30721
    end
    object edt_vehicleno: TNovaEdit
      Left = 293
      Top = 18
      Width = 142
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = edt_vehiclenoKeyPress
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
    object edtcardno: TNovaEdit
      Left = 78
      Top = 53
      Width = 130
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
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
    end
    object NovaHVehicleTypes: TNovaHelp
      Left = 78
      Top = 18
      Width = 130
      Height = 22
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
    object edtcontractno: TNovaEdit
      Left = 293
      Top = 53
      Width = 142
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 30
      TabOrder = 4
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
    object NovaHelpUnits: TNovaHelp
      Left = 508
      Top = 18
      Width = 142
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
    object NovaHBalnaceUnit: TNovaHelp
      Left = 718
      Top = 18
      Width = 128
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object NHelpRoute: TNovaHelp
      Left = 508
      Top = 53
      Width = 142
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 6
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
    object cbbstatus: TNovaComboBox
      Left = 716
      Top = 53
      Width = 130
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
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
      HelpOptions.TableName = 'vehicle'
      HelpOptions.Columnname = 'status'
      HelpOptions.DisAll = True
    end
    object cbbChecktype: TNovaCheckedComboBox
      Left = 78
      Top = 88
      Width = 130
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'vehicle'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'type'
        end>
    end
    object nvhlpvehiclecode: TNovaHelp
      Left = 293
      Top = 88
      Width = 142
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 9
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
          FieldName = 'code'
          Title.Caption = #31616#30721
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fullname'
          Title.Caption = #24402#23646#22320
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'vehiclecodeHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object chkIstemp1: TCheckBox
      Left = 469
      Top = 91
      Width = 97
      Height = 17
      Caption = #20020#26102#36710#36742
      TabOrder = 10
    end
    object chkIstemp2: TCheckBox
      Left = 604
      Top = 91
      Width = 97
      Height = 17
      Caption = #36827#31449#36710#36742
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1003
    ExplicitWidth = 1003
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
      AutoSize = False
      Caption = #22797#21046
      ImageIndex = 21
      Visible = True
      OnClick = ToolButton51Click
    end
    inherited tbtn3: TToolButton
      Left = 376
      ExplicitLeft = 376
    end
    inherited tbtnSave: TToolButton
      Left = 384
      Caption = #21457#25918#34920
      ImageIndex = 8
      OnClick = tbtnSaveClick
      ExplicitLeft = 384
    end
    inherited tbtnCancel: TToolButton
      Left = 454
      Caption = #24180#23457#34920
      ImageIndex = 8
      OnClick = tbtnCancelClick
      ExplicitLeft = 454
    end
    inherited ToolButton52: TToolButton
      Left = 524
      ExplicitLeft = 524
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 542
      ExplicitLeft = 542
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 560
      Visible = False
      ExplicitLeft = 560
    end
    inherited tbtnInfo: TToolButton
      Left = 568
      ExplicitLeft = 568
    end
    inherited tbtn5: TToolButton
      Left = 638
      ExplicitLeft = 638
    end
    inherited tbtnExcel: TToolButton
      Left = 646
      ExplicitLeft = 646
    end
    inherited tbtnPrinter: TToolButton
      Left = 716
      ExplicitLeft = 716
    end
    inherited tbtn6: TToolButton
      Left = 786
      ExplicitLeft = 786
    end
    inherited tbtnClose: TToolButton
      Left = 794
      ExplicitLeft = 794
    end
  end
  inherited Panel1: TPanel
    Top = 161
    Width = 1003
    Height = 337
    ExplicitTop = 161
    ExplicitWidth = 1003
    ExplicitHeight = 337
    inherited GroupBox1: TGroupBox
      Width = 1003
      Height = 337
      ExplicitWidth = 1003
      ExplicitHeight = 337
      inherited dbgrdhResult: TNvDbgridEh
        Width = 999
        Height = 319
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            MinWidth = 30
            Title.Caption = #36710#23646#21333#20301
            Width = 87
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
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36710#29260#21495#30721
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicletypename'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'brandname'
            Footers = <>
            Title.Caption = #36710#36742#21697#29260
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #20056#23458#24231#20301#25968
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'rationseatnum'
            Footers = <>
            Title.Caption = #26680#23450#24231#20301#25968
            Width = 80
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
            FieldName = 'cardno'
            Footers = <>
            Title.Caption = 'IC'#21345#21495
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'validdate'
            Footers = <>
            Title.Caption = 'IC'#21345#26377#25928#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #33829#36816#31867#22411
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'colorname'
            Footers = <>
            Title.Caption = #36710#36742#39068#33394
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'modelcode'
            Footers = <>
            Title.Caption = #22411#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'istempvehicle'
            Footers = <>
            Title.Caption = #20020#26102#36710#36742
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'entercardno'
            Footers = <>
            Title.Caption = #36827#31449#21345#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'cardnoprintdate'
            Footers = <>
            Title.Caption = #25171#34920#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'makedate'
            Footers = <>
            Title.Caption = #20986#21378#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'grantdate'
            Footers = <>
            Title.Caption = #21457#21345#26085#26399
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'loadamout'
            Footers = <>
            Title.Caption = #36733#37325
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'checkfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20363#26816#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'margin'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#35777#37329
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'stopfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20572#36710#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182#36153#29992
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'vehiclenodate'
            Footers = <>
            Title.Caption = #19978#29260#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'contactperson'
            Footers = <>
            Title.Caption = #32852#31995#20154#22995#21517
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'contactphone'
            Footers = <>
            Title.Caption = #32852#31995#20154#30005#35805
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'auditroute'
            Footers = <>
            Title.Caption = #26680#20934#32447#36335
            Width = 80
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isaudited'
            Footers = <>
            Title.Caption = #26159#21542#24050#23457#26680
            Width = 80
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isauditpass'
            Footers = <>
            Title.Caption = #26159#21542#23457#26680#36890#36807
            Width = 103
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isneedfinger'
            Footers = <>
            Title.Caption = #38656#35201#39550#39542#21592
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'contractno'
            Footers = <>
            Title.Caption = #31532#19977#32773#36131#20219#38505#32534#21495
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'contractstartdate'
            Footers = <>
            Title.Caption = #21512#21516#36215#22987#26085#26399
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'contractenddate'
            Footers = <>
            Title.Caption = #21512#21516#25130#33267#26085#26399
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'liabilityinsureno'
            Footers = <>
            Title.Caption = #25215#36816#38505#32534#21495
            Width = 129
          end
          item
            EditButtons = <>
            FieldName = 'liabilityinsurestartdate'
            Footers = <>
            Title.Caption = #25215#36816#20154#36131#20219#38505#36215#22987#26085#26399
            Width = 155
          end
          item
            EditButtons = <>
            FieldName = 'liabilityinsureenddate'
            Footers = <>
            Title.Caption = #25215#36816#20154#36131#20219#38505#25130#27490#26085#26399
            Width = 126
          end
          item
            EditButtons = <>
            FieldName = 'compulsoryinsureno'
            Footers = <>
            Title.Caption = #20132#24378#38505#32534#21495
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'compulsoryinsurestartdate'
            Footers = <>
            Title.Caption = #20132#24378#38505#36215#22987#26085#26399
            Width = 111
          end
          item
            EditButtons = <>
            FieldName = 'compulsoryinsureenddate'
            Footers = <>
            Title.Caption = #20132#24378#38505#25130#27490#26085#26399
            Width = 116
          end
          item
            EditButtons = <>
            FieldName = 'driverlicense'
            Footers = <>
            Title.Caption = #34892#39542#35777#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'roadno'
            Footers = <>
            Title.Caption = #26631#24535#29260#21495#30721
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'twodimensionno'
            Footers = <>
            Title.Caption = #20108#32500#35777#20214#21495
            Width = 109
          end
          item
            EditButtons = <>
            FieldName = 'maintainvaliddate'
            Footers = <>
            Title.Caption = #20108#32500#26377#25928#26399
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'nextmaintaindistance'
            Footers = <>
            Title.Caption = #19979#27425#20108#32423#32500#25252#37324#31243
            Width = 135
          end
          item
            EditButtons = <>
            FieldName = 'licensestartdate'
            Footers = <>
            Title.Caption = #34892#39542#35777#25130#27490#26085#26399
            Visible = False
            Width = 123
          end
          item
            EditButtons = <>
            FieldName = 'licensestartdate'
            Footers = <>
            Title.Caption = #34892#39542#35777#36215#22987#26085#26399
            Width = 122
          end
          item
            EditButtons = <>
            FieldName = 'licenseenddate'
            Footers = <>
            Title.Caption = #34892#39542#35777#25130#27490#26085#26399
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'workno'
            Footers = <>
            Title.Caption = #33829#36816#35777#32534#21495
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'workstartdate'
            Footers = <>
            Title.Caption = #33829#36816#35777#36215#22987#26085#26399
            Width = 112
          end
          item
            EditButtons = <>
            FieldName = 'workenddate'
            Footers = <>
            Title.Caption = #33829#36816#35777#25130#27490#26085#26399
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'gprs'
            Footers = <>
            Title.Caption = 'GPRS'#30721
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'createbyname'
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
            FieldName = 'updatebyname'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 74
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
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Width = 77
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isneedcheck'
            Footers = <>
            Title.Caption = #38656#35777#20214#26680#26597#25165#33021#25253#29677
            Width = 120
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 312
    Top = 200
  end
  inherited ilToolBarDisable: TImageList
    Left = 392
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'vehiclemap'
    QueryAddress = 'base/qryVehicles'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_v!vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_v!cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_v!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_v!contractno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_v!balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_v!istempvehicle'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_v!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKELS_v!vehicleno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 497
    Top = 192
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResulttype: TWideStringField
      FieldName = 'type'
      Size = 10
    end
    object jcdsResultvehicletypeid: TLargeintField
      FieldName = 'vehicletypeid'
    end
    object jcdsResultvehiclebrandmodelid: TLargeintField
      FieldName = 'vehiclebrandmodelid'
    end
    object jcdsResultunitid: TLargeintField
      FieldName = 'unitid'
    end
    object jcdsResultrationseatnum: TIntegerField
      FieldName = 'rationseatnum'
    end
    object jcdsResultseatnum: TIntegerField
      FieldName = 'seatnum'
    end
    object jcdsResultloadamout: TFloatField
      FieldName = 'loadamout'
    end
    object jcdsResultcolor: TWideStringField
      FieldName = 'color'
      Size = 10
    end
    object jcdsResultcontactperson: TWideStringField
      FieldName = 'contactperson'
      Size = 100
    end
    object jcdsResultcontactphone: TWideStringField
      FieldName = 'contactphone'
    end
    object jcdsResultremarks: TWideStringField
      FieldName = 'remarks'
      Size = 200
    end
    object jcdsResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jcdsResultcardno: TWideStringField
      FieldName = 'cardno'
      Size = 30
    end
    object jcdsResultgrantdate: TDateField
      FieldName = 'grantdate'
    end
    object jcdsResultcontractno: TWideStringField
      FieldName = 'contractno'
      Size = 30
    end
    object jcdsResultcontractstartdate: TDateField
      FieldName = 'contractstartdate'
    end
    object jcdsResultcontractenddate: TDateField
      FieldName = 'contractenddate'
    end
    object jcdsResultliabilityinsureno: TWideStringField
      FieldName = 'liabilityinsureno'
      Size = 30
    end
    object jcdsResultliabilityinsurestartdate: TDateField
      FieldName = 'liabilityinsurestartdate'
    end
    object jcdsResultliabilityinsureenddate: TDateField
      FieldName = 'liabilityinsureenddate'
    end
    object jcdsResultcompulsoryinsureno: TWideStringField
      FieldName = 'compulsoryinsureno'
      Size = 30
    end
    object jcdsResultcompulsoryinsurestartdate: TDateField
      FieldName = 'compulsoryinsurestartdate'
    end
    object jcdsResultcompulsoryinsureenddate: TDateField
      FieldName = 'compulsoryinsureenddate'
    end
    object jcdsResultlicensestartdate: TDateField
      FieldName = 'licensestartdate'
    end
    object jcdsResultlicenseenddate: TDateField
      FieldName = 'licenseenddate'
    end
    object jcdsResultworkno: TWideStringField
      FieldName = 'workno'
      Size = 30
    end
    object jcdsResultworkstartdate: TDateField
      FieldName = 'workstartdate'
    end
    object jcdsResultworkenddate: TDateField
      FieldName = 'workenddate'
    end
    object jcdsResultisaudited: TBooleanField
      FieldName = 'isaudited'
    end
    object jcdsResultisauditpass: TBooleanField
      FieldName = 'isauditpass'
    end
    object jcdsResultgprs: TWideStringField
      FieldName = 'gprs'
      Size = 100
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsResultcreatebyname: TWideStringField
      FieldName = 'createbyname'
      Size = 30
    end
    object jcdsResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 50
    end
    object jcdsResultbrandname: TWideStringField
      FieldName = 'brandname'
      Size = 50
    end
    object jcdsResultmodelcode: TWideStringField
      FieldName = 'modelcode'
      Size = 30
    end
    object jcdsResultvehicletypename: TWideStringField
      FieldName = 'vehicletypename'
      Size = 50
    end
    object jcdsResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdsQryVehicletype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Size = 30
      Lookup = True
    end
    object jcdsResultcolorname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'colorname'
      LookupDataSet = jscdQryVehicleColor
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'color'
      Lookup = True
    end
    object jcdsResultsynccode: TWideStringField
      FieldName = 'synccode'
      Size = 40
    end
    object jcdsResultvaliddate: TDateField
      FieldName = 'validdate'
    end
    object jcdsResultbalanceunitid: TLargeintField
      FieldName = 'balanceunitid'
    end
    object jcdsResultmargin: TFloatField
      FieldName = 'margin'
    end
    object jcdsResultstopfee: TFloatField
      FieldName = 'stopfee'
    end
    object jcdsResultcheckfee: TFloatField
      FieldName = 'checkfee'
    end
    object jcdsResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsResultvehiclenodate: TDateField
      FieldName = 'vehiclenodate'
    end
    object jcdsResultbalanceunitname: TWideStringField
      FieldName = 'balanceunitname'
      Size = 50
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 50
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultentercardno: TWideStringField
      FieldName = 'entercardno'
      Size = 30
    end
    object jcdsResultmakedate: TDateField
      FieldName = 'makedate'
    end
    object jcdsResultcardnoprintdate: TDateField
      FieldName = 'cardnoprintdate'
    end
    object jcdsResultistempvehicle: TBooleanField
      FieldName = 'istempvehicle'
    end
    object jcdsResultfullname: TWideStringField
      FieldName = 'fullname'
      Size = 50
    end
    object jcdsResultauditroute: TWideStringField
      FieldName = 'auditroute'
      Size = 50
    end
    object wdstrngfldResultstatus: TWideStringField
      FieldName = 'status'
    end
    object wdstrngfldResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsVehiclestatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object wdstrngfldResultupdatebyname: TWideStringField
      FieldName = 'updatebyname'
      Size = 50
    end
    object jcdsResultdriverlicense: TWideStringField
      FieldName = 'driverlicense'
      Size = 30
    end
    object jcdsResultroadno: TWideStringField
      FieldName = 'roadno'
      Size = 30
    end
    object jcdsResultmaintainvaliddate: TDateField
      FieldName = 'maintainvaliddate'
    end
    object jcdsResultnextmaintaindistance: TLargeintField
      FieldName = 'nextmaintaindistance'
    end
    object jcdsResultisneedfinger: TBooleanField
      FieldName = 'isneedfinger'
    end
    object jcdsResultseattype: TWideStringField
      FieldName = 'seattype'
    end
    object jcdsResultseattypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'seattypename'
      LookupDataSet = jcdsVehicleSeattype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'seattype'
      Lookup = True
    end
    object blnfldResultisneedcheck: TBooleanField
      FieldName = 'isneedcheck'
    end
    object jcdsResulttwodimensionno: TWideStringField
      FieldName = 'twodimensionno'
    end
  end
  inherited dsResult: TDataSource
    Left = 232
    Top = 200
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 152
    Top = 208
  end
  object jsonCDSDelVehicle: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'base/delvehicle'
    SaveAddress = 'base/delvehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'vehicle.id'
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
    Left = 544
    Top = 352
  end
  object jcdsQryVehicletype: TjsonClientDataSet
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
        Value = 'vehicle'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 320
    Top = 352
  end
  object jscdQryVehicleColor: TjsonClientDataSet
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
        Value = 'vehicle'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'color'
      end>
    RemoteServer = DMPublic.jcon
    Left = 432
    Top = 352
  end
  object jscdUpdatePrintDate: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/updatePrintdate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicle.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 608
    Top = 208
  end
  object jcdsVehiclestatus: TjsonClientDataSet
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
        Value = 'vehicle'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 648
    Top = 352
  end
  object jcdsVehicleSeattype: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'vehicle'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'seattype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 664
    Top = 272
  end
end
