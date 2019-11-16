inherited frmDriver: TfrmDriver
  Caption = #39550#39542#21592#26723#26696#31649#29702
  ClientHeight = 539
  ClientWidth = 1217
  ExplicitWidth = 1233
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1217
    Height = 100
    ExplicitWidth = 1217
    ExplicitHeight = 100
    object lbl3: TLabel
      Left = 16
      Top = 16
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object lbl2: TLabel
      Left = 216
      Top = 49
      Width = 28
      Height = 14
      Caption = #24037#21495
    end
    object lbl1: TLabel
      Left = 216
      Top = 16
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object lbl4: TLabel
      Left = 405
      Top = 49
      Width = 56
      Height = 14
      Caption = #39550#39542#35777#21495
    end
    object lbl5: TLabel
      Left = 377
      Top = 16
      Width = 84
      Height = 14
      Caption = #20174#19994#36164#26684#35777#21495
    end
    object lbl6: TLabel
      Left = 188
      Top = 77
      Width = 56
      Height = 14
      Caption = #20934#39550#31867#22411
    end
    object lbl7: TLabel
      Left = 44
      Top = 77
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object lbl8: TLabel
      Left = 30
      Top = 49
      Width = 42
      Height = 14
      Caption = #26723#26696#21495
    end
    object Label1: TLabel
      Left = 397
      Top = 80
      Width = 98
      Height = 14
      Caption = #39550#39542#35777#26159#21542#36807#26399
    end
    object Label2: TLabel
      Left = 586
      Top = 80
      Width = 98
      Height = 14
      Caption = #20174#19994#35777#26159#21542#36807#26399
    end
    object nvedtCode: TNovaEdit
      Left = 247
      Top = 41
      Width = 119
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
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
    object nvedtName: TNovaEdit
      Left = 247
      Top = 8
      Width = 120
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object nvedtDrivinglicense: TNovaEdit
      Left = 466
      Top = 41
      Width = 112
      Height = 22
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
    end
    object nvedtQualification: TNovaEdit
      Left = 466
      Top = 8
      Width = 113
      Height = 22
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
    end
    object nvcbbtypeDrivertype: TNovaComboBox
      Left = 247
      Top = 71
      Width = 120
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
      HelpOptions.TableName = 'driver'
      HelpOptions.Columnname = 'qualificationtype'
      HelpOptions.DisAll = True
    end
    object nvcbbtypeState: TNovaComboBox
      Left = 75
      Top = 71
      Width = 102
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.TableName = 'driver'
      HelpOptions.Columnname = 'workstatus'
      HelpOptions.DisAll = True
    end
    object chkOver: TCheckBox
      Left = 501
      Top = 77
      Width = 29
      Height = 17
      Caption = #26159
      TabOrder = 8
    end
    object nvedtArchiceNo: TNovaEdit
      Left = 75
      Top = 41
      Width = 102
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    end
    object chkNotOver: TCheckBox
      Left = 542
      Top = 77
      Width = 29
      Height = 17
      Caption = #21542
      TabOrder = 9
    end
    object nvhelpUnit: TNovaHelp
      Left = 75
      Top = 8
      Width = 102
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
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
          Title.Caption = #21517#31216
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
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
    object chktemp: TCheckBox
      Left = 594
      Top = 13
      Width = 62
      Height = 17
      Caption = #20020#26102#24037
      TabOrder = 10
    end
    object chkNtemp: TCheckBox
      Left = 594
      Top = 46
      Width = 59
      Height = 17
      Caption = #27491#24335#24037
      TabOrder = 11
    end
    object chkYes: TCheckBox
      Left = 692
      Top = 77
      Width = 29
      Height = 17
      Caption = #26159
      TabOrder = 12
    end
    object chkNo: TCheckBox
      Left = 735
      Top = 77
      Width = 29
      Height = 17
      Caption = #21542
      TabOrder = 13
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1217
    ExplicitWidth = 1217
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
      Caption = #25351#32441#37319#38598
      ImageIndex = 1
      OnClick = tbtnSaveClick
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
    inherited tbtnInfo: TToolButton
      Visible = False
    end
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 145
    Width = 1217
    Height = 271
    ExplicitTop = 145
    ExplicitWidth = 1217
    ExplicitHeight = 271
    inherited GroupBox1: TGroupBox
      Width = 1217
      Height = 271
      ExplicitWidth = 1217
      ExplicitHeight = 271
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1213
        Height = 253
        FooterRowCount = 1
        SumList.Active = True
        OnGetCellParams = dbgrdhResultGetCellParams
        Columns = <
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'subunit'
            Footers = <>
            Title.Caption = #25152#23646#20998#38431
            Width = 114
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #24037#21495
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'archiveno'
            Footers = <>
            Title.Caption = #26723#26696#21495
            Width = 112
          end
          item
            EditButtons = <>
            FieldName = 'cardno'
            Footers = <>
            Title.Caption = 'IC'#21345#21495
            Width = 119
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
            Title.Caption = #24615#21035
            Width = 32
          end
          item
            EditButtons = <>
            FieldName = 'idcard'
            Footers = <>
            Title.Caption = #36523#20221#35777
            Width = 134
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #31227#21160#30005#35805
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'familyphone'
            Footers = <>
            Title.Caption = #23478#24237#30005#35805
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'birthday'
            Footers = <>
            Title.Caption = #29983#26085
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'nativeplace'
            Footers = <>
            Title.Caption = #31821#36143
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'routename'
            Footers = <>
            Title.Caption = #33829#36816#32447#36335
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'educationname'
            Footers = <>
            Title.Caption = #25991#21270#31243#24230
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'poilticsstatusname'
            Footers = <>
            Title.Caption = #25919#27835#38754#35980
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'vehiclename'
            Footers = <>
            Title.Caption = #24314#21046#36710#21495
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'istemporary'
            Footers = <>
            Title.Caption = #26159#21542#20020#26102#24037
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'issignedresponsibility'
            Footers = <>
            Title.Caption = #26159#21542#31614#35746#36131#20219#35777#20070
            Width = 123
          end
          item
            EditButtons = <>
            FieldName = 'familyaddress'
            Footers = <>
            Title.Caption = #23478#24237#22320#22336
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'workstatusname'
            Footers = <>
            Title.Caption = #24037#20316#29366#24577
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'salary'
            Footers = <>
            Title.Caption = #24037#36164
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicense'
            Footers = <>
            Title.Caption = #39550#39542#35777#21495
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicensefirstdate'
            Footers = <>
            Title.Caption = #39550#39542#35777#21021#27425#39046#35777#26085#26399
            Width = 141
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicensestartdate'
            Footers = <>
            Title.Caption = #39550#39542#35777#26377#25928#36215#22987#26085#26399
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicenseenddate'
            Footers = <>
            Title.Caption = #39550#39542#35777#26377#25928#25130#27490#26085#26399
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'education'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'politicsstatus'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'recruitmentdate'
            Footers = <>
            Title.Caption = #25307#32771#26085#26399
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'qualification'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'workstatus'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'qualificationstartdate'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#21457#35777#26085#26399
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'qualificationtype'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'unitid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'qualificationenddate'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#26377#25928#26085#26399
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'workno'
            Footers = <>
            Title.Caption = #20934#39550#35777#21495
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'qualifyvehicletype'
            Footers = <>
            Title.Caption = #20934#39550#36710#22411
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'qualfacationtypename'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#20934#39550#31867#22411
            Width = 146
          end
          item
            EditButtons = <>
            FieldName = 'workenddate'
            Footers = <>
            Title.Caption = #20934#39550#35777#26377#25928#26085#26399
            Width = 138
          end
          item
            EditButtons = <>
            FieldName = 'workstartdate'
            Footers = <>
            Title.Caption = #20934#39550#35777#21457#35777#26085#26399
            Width = 117
          end
          item
            EditButtons = <>
            FieldName = 'initialkm'
            Footers = <>
            Title.Caption = #36215#22987#20844#37324#25968
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 139
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 151
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  object grp3: TGroupBox [3]
    Left = 0
    Top = 416
    Width = 1217
    Height = 123
    Align = alBottom
    TabOrder = 3
    Visible = False
    object grp8: TGroupBox
      Left = 2
      Top = 16
      Width = 565
      Height = 105
      Align = alLeft
      Caption = #24037#20316#32463#21382#20449#24687
      TabOrder = 0
      object tlb1: TToolBar
        Left = 2
        Top = 16
        Width = 561
        Height = 29
        Caption = 'ToolBar1'
        Images = imgLi
        TabOrder = 0
        object btn1: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btn2: TToolButton
          Left = 8
          Top = 0
          Hint = #28155#21152
          Caption = 'ToolButton1'
          ImageIndex = 9
          ParentShowHint = False
          ShowHint = True
          OnClick = btn2Click
        end
        object btn3: TToolButton
          Left = 31
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btnUpdWork: TToolButton
          Left = 39
          Top = 0
          Hint = #20462#25913
          Caption = 'ToolButton2'
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUpdWorkClick
        end
        object btn5: TToolButton
          Left = 62
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btnDelWork: TToolButton
          Left = 70
          Top = 0
          Hint = #27880#38144
          Caption = 'ToolButton8'
          ImageIndex = 7
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDelWorkClick
        end
      end
      object nvdbgrdhWork: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 561
        Height = 58
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsWorkResult
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imDisable
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 1
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
        ParentName = 'frmDriver'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'workunit'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #24037#20316#21333#20301
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'position'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32844#20301
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'startdate'
            Footers = <>
            Title.Caption = #24037#20316#24320#22987#26085#26399
            Width = 106
          end
          item
            EditButtons = <>
            FieldName = 'enddate'
            Footers = <>
            Title.Caption = #24037#20316#32467#26463#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 103
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 118
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #26356#26032#20154
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #26356#26032#26102#38388
            Width = 123
          end
          item
            EditButtons = <>
            FieldName = 'driverid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object grp1: TGroupBox
      Left = 567
      Top = 16
      Width = 648
      Height = 105
      Align = alClient
      Caption = #23478#24237#25104#21592#20449#24687
      TabOrder = 1
      object tlb2: TToolBar
        Left = 2
        Top = 16
        Width = 644
        Height = 29
        Caption = 'tlb2'
        Images = imgLi
        TabOrder = 0
        object btn7: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btn8: TToolButton
          Left = 8
          Top = 0
          Hint = #28155#21152
          Caption = 'ToolButton1'
          ImageIndex = 9
          ParentShowHint = False
          ShowHint = True
          OnClick = btn8Click
        end
        object btn9: TToolButton
          Left = 31
          Top = 0
          Width = 8
          Caption = 'ToolButton4'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btnUpdFamily: TToolButton
          Left = 39
          Top = 0
          Hint = #20462#25913
          Caption = 'ToolButton2'
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          OnClick = btnUpdFamilyClick
        end
        object btn11: TToolButton
          Left = 62
          Top = 0
          Width = 8
          Caption = 'btn11'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btnDelFamily: TToolButton
          Left = 70
          Top = 0
          Hint = #27880#38144
          Caption = 'ToolButton8'
          ImageIndex = 7
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDelFamilyClick
        end
      end
      object dbgrdhroutestop: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 644
        Height = 58
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsFamliy
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imDisable
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 1
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
        ParentName = 'frmDriver'
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
            FieldName = 'name'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'relation'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #19982#39550#39542#21592#20851#31995
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'birthday'
            Footers = <>
            Title.Caption = #29983#26085
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'politicsstatus'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
            Title.Caption = #24615#21035
            Width = 33
          end
          item
            EditButtons = <>
            FieldName = 'workunit'
            Footers = <>
            Title.Caption = #24037#20316#21333#20301
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'position'
            Footers = <>
            Title.Caption = #32844#20301
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'politicsstatusname'
            Footers = <>
            Title.Caption = #25919#27835#38754#35980
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 152
          end
          item
            EditButtons = <>
            FieldName = 'driverid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 256
  end
  inherited ilToolBarDisable: TImageList
    Left = 136
    Top = 264
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'drivermap'
    QueryAddress = 'archive/findDriver'
    SaveAddress = 'archive/findDriver'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_d!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_d!code'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_LIKES_d!qualification'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'filter_EQS_d!workstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_d!drivinglicense'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_d!archiveno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_d!qualificationtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LTD_d!drivinglicenseenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_d!drivinglicenseenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_d!istemporary'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LTD_d!qualificationenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_d!qualificationenddate'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    AfterScroll = jcdsResultAfterScroll
    Left = 632
    Top = 216
    object lrgntfldResultid: TLargeintField
      FieldName = 'id'
    end
    object wdstrngfldResultarchiveno: TWideStringField
      FieldName = 'archiveno'
    end
    object wdstrngfldResultcardno: TWideStringField
      FieldName = 'cardno'
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
      Size = 10
    end
    object lrgntfldResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object wdstrngfldResultdrivinglicense: TWideStringField
      FieldName = 'drivinglicense'
      Size = 50
    end
    object wdstrngfldResulteducation: TWideStringField
      FieldName = 'education'
      Size = 50
    end
    object wdstrngfldResultfamilyaddress: TWideStringField
      FieldName = 'familyaddress'
      Size = 200
    end
    object wdstrngfldResultfamilyphone: TWideStringField
      FieldName = 'familyphone'
      Size = 30
    end
    object wdstrngfldResultidcard: TWideStringField
      FieldName = 'idcard'
    end
    object lrgntfldResultinitialkm: TLargeintField
      FieldName = 'initialkm'
    end
    object blnfldResultissignedresponsibility: TBooleanField
      FieldName = 'issignedresponsibility'
    end
    object blnfldResultistemporary: TBooleanField
      FieldName = 'istemporary'
    end
    object wdstrngfldResultmobilephone: TWideStringField
      FieldName = 'mobilephone'
      Size = 30
    end
    object wdstrngfldResultname: TWideStringField
      FieldName = 'name'
      Size = 30
    end
    object wdstrngfldResultnativeplace: TWideStringField
      FieldName = 'nativeplace'
      Size = 50
    end
    object lrgntfldResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object wdstrngfldResultpoliticsstatus: TWideStringField
      FieldName = 'politicsstatus'
    end
    object wdstrngfldResultqualification: TWideStringField
      FieldName = 'qualification'
      Size = 30
    end
    object wdstrngfldResultqualificationtype: TWideStringField
      FieldName = 'qualificationtype'
    end
    object fltfldResultsalary: TFloatField
      FieldName = 'salary'
    end
    object wdstrngfldResultsex: TWideStringField
      FieldName = 'sex'
    end
    object wdstrngfldResultsubunit: TWideStringField
      FieldName = 'subunit'
      Size = 50
    end
    object lrgntfldResultunitid: TLargeintField
      FieldName = 'unitid'
    end
    object lrgntfldResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object wdstrngfldResultworkno: TWideStringField
      FieldName = 'workno'
      Size = 50
    end
    object wdstrngfldResultworkstatus: TWideStringField
      FieldName = 'workstatus'
    end
    object wdstrngfldResultvehiclename: TWideStringField
      FieldName = 'vehiclename'
      Size = 30
    end
    object wdstrngfldResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 30
    end
    object wdstrngfldResulteducationname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'educationname'
      LookupDataSet = jcdsEducation
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'education'
      Lookup = True
    end
    object wdstrngfldResultworkstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'workstatusname'
      LookupDataSet = jcdsWorkstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'workstatus'
      Lookup = True
    end
    object wdstrngfldResultpoilticsstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'poilticsstatusname'
      LookupDataSet = jcdsPoliticsstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'politicsstatus'
      Lookup = True
    end
    object wdstrngfldResultqualfacationtypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'qualfacationtypename'
      LookupDataSet = jcdsQualificationtype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'qualificationtype'
      Lookup = True
    end
    object wdstrngfldResultcreatename: TWideStringField
      FieldName = 'createname'
    end
    object wdstrngfldResultupdatename: TWideStringField
      FieldName = 'updatename'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultdrivinglicenseenddate: TDateField
      FieldName = 'drivinglicenseenddate'
    end
    object jcdsResultdrivinglicensefirstdate: TDateField
      FieldName = 'drivinglicensefirstdate'
    end
    object jcdsResultdrivinglicensestartdate: TDateField
      FieldName = 'drivinglicensestartdate'
    end
    object jcdsResultqualificationenddate: TDateField
      FieldName = 'qualificationenddate'
    end
    object jcdsResultqualificationstartdate: TDateField
      FieldName = 'qualificationstartdate'
    end
    object jcdsResultrecruitmentdate: TDateField
      FieldName = 'recruitmentdate'
    end
    object jcdsResultworkenddate: TDateField
      FieldName = 'workenddate'
    end
    object jcdsResultworkstartdate: TDateField
      FieldName = 'workstartdate'
    end
    object jcdsResultbirthday: TDateField
      FieldName = 'birthday'
    end
    object lrgntfldResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
    object wdstrngfldResultqualifyvehicletype: TWideStringField
      FieldName = 'qualifyvehicletype'
    end
    object jcdsResultroutename: TWideStringField
      FieldName = 'routename'
    end
    object jcdsResultrouteid: TLargeintField
      FieldName = 'routeid'
    end
    object jcdsResultjianpin: TWideStringField
      FieldName = 'jianpin'
      Size = 100
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 264
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 536
    Top = 216
  end
  object jcdsWork: TjsonClientDataSet
    DataSourceName = 'workmap'
    QueryAddress = 'archive/findWork'
    SaveAddress = 'archive/findWork'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_w!driverid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 168
    Top = 448
  end
  object dsWorkResult: TDataSource
    DataSet = jcdsWork
    Left = 72
    Top = 456
  end
  object dsFamliy: TDataSource
    DataSet = jcdsFamily
    Left = 744
    Top = 432
  end
  object jcdsPoliticsstatus: TjsonClientDataSet
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
        Value = 'driver'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'politicsstatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 224
  end
  object jcdsWorkstatus: TjsonClientDataSet
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
        Value = 'driver'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'workstatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 280
    Top = 248
  end
  object jcdsQualificationtype: TjsonClientDataSet
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
        Value = 'driver'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'qualificationtype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 432
    Top = 256
  end
  object jcdsDriverdelete: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'archive/deleteDriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'driverid'
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
    Left = 432
    Top = 216
  end
  object jcdsEducation: TjsonClientDataSet
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
        Value = 'employee'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'education'
      end>
    RemoteServer = DMPublic.jcon
    Left = 736
    Top = 208
  end
  object jcdsDelWork: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/delWork'
    SaveAddress = 'archive/delWork'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'delid'
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
    Top = 456
  end
  object jcdsDelFamily: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/delFamily'
    SaveAddress = 'archive/delFamily'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'delid'
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
    Left = 600
    Top = 416
  end
  object jcdsFamily: TjsonClientDataSet
    DataSourceName = 'familymap'
    QueryAddress = 'archive/findFamliy'
    SaveAddress = 'archive/findFamliy'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_f!driverid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 680
    Top = 440
    object lrgntfldFamilyid: TLargeintField
      FieldName = 'id'
    end
    object wdstrngfldFamilyname: TWideStringField
      FieldName = 'name'
    end
    object wdstrngfldFamilypoliticsstatus: TWideStringField
      FieldName = 'politicsstatus'
    end
    object wdstrngfldFamilyposition: TWideStringField
      FieldName = 'position'
      Size = 50
    end
    object wdstrngfldFamilyrelation: TWideStringField
      FieldName = 'relation'
    end
    object wdstrngfldFamilysex: TWideStringField
      FieldName = 'sex'
      Size = 10
    end
    object lrgntfldFamilyupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object wdstrngfldFamilyworkunit: TWideStringField
      FieldName = 'workunit'
      Size = 50
    end
    object lrgntfldFamilydriverid: TLargeintField
      FieldName = 'driverid'
    end
    object lrgntfldFamilycreateby: TLargeintField
      FieldName = 'createby'
    end
    object wdstrngfldFamilycreatename: TWideStringField
      FieldName = 'createname'
    end
    object wdstrngfldFamilyupdatename: TWideStringField
      FieldName = 'updatename'
    end
    object wdstrngfldFamilypoliticsstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'politicsstatusname'
      LookupDataSet = jcdsPoliticsstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'politicsstatus'
      Lookup = True
    end
    object jcdsFamilycreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsFamilyupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsFamilybirthday: TDateField
      FieldName = 'birthday'
    end
  end
  object imgLi: TImageList
    DrawingStyle = dsSelected
    Left = 312
    Top = 344
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
  object jcdsFindPicture: TjsonClientDataSet
    DataSourceName = 'pictureResult'
    QueryAddress = 'archive/finddriverPicture'
    SaveAddress = 'archive/finddriverPicture'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_d!id'
        ParamType = ptInput
        Value = 'employee'
      end>
    RemoteServer = DMPublic.jcon
    Left = 192
    Top = 208
  end
end
