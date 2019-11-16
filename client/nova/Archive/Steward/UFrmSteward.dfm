inherited frmSteward: TfrmSteward
  Caption = #20056#21153#21592#26723#26696#31649#29702
  ClientHeight = 589
  ClientWidth = 1440
  ExplicitWidth = 1456
  ExplicitHeight = 627
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1440
    Height = 87
    ExplicitWidth = 1440
    ExplicitHeight = 87
    object lbl3: TLabel
      Left = 13
      Top = 24
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object lbl2: TLabel
      Left = 41
      Top = 62
      Width = 28
      Height = 14
      Caption = #24037#21495
    end
    object lbl1: TLabel
      Left = 224
      Top = 24
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object lbl5: TLabel
      Left = 406
      Top = 24
      Width = 84
      Height = 14
      Caption = #20174#19994#36164#26684#35777#21495
    end
    object lbl6: TLabel
      Left = 420
      Top = 62
      Width = 70
      Height = 14
      Caption = #20056#21153#21592#26143#32423
    end
    object lbl8: TLabel
      Left = 211
      Top = 62
      Width = 42
      Height = 14
      Caption = #26723#26696#21495
    end
    object nvedtCode: TNovaEdit
      Left = 74
      Top = 59
      Width = 127
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
    object nvedtName: TNovaEdit
      Left = 258
      Top = 21
      Width = 132
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
    object nvedtQualification: TNovaEdit
      Left = 496
      Top = 21
      Width = 121
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
    object nvcbbGrade: TNovaComboBox
      Left = 496
      Top = 59
      Width = 121
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 5
      Text = #35831#36873#25321'...'
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
      HelpOptions.TableName = 'steward'
      HelpOptions.Columnname = 'grade'
    end
    object chkOverDate: TCheckBox
      Left = 625
      Top = 24
      Width = 97
      Height = 17
      Caption = #35777#20214#24050#36807#26399
      TabOrder = 6
    end
    object nvedtArchiceNo: TNovaEdit
      Left = 258
      Top = 59
      Width = 132
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
    object chkNotOver: TCheckBox
      Left = 627
      Top = 61
      Width = 92
      Height = 17
      Caption = #35777#20214#26410#36807#26399
      TabOrder = 7
    end
    object nvhelpUnit: TNovaHelp
      Left = 74
      Top = 21
      Width = 127
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1440
    ExplicitWidth = 1440
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
    Top = 132
    Width = 1440
    Height = 260
    ExplicitTop = 132
    ExplicitWidth = 1440
    ExplicitHeight = 260
    inherited GroupBox1: TGroupBox
      Width = 1440
      Height = 260
      ExplicitWidth = 1440
      ExplicitHeight = 260
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1436
        Height = 242
        FooterRowCount = 1
        SumList.Active = True
        OnGetCellParams = dbgrdhResultGetCellParams
        Columns = <
          item
            EditButtons = <>
            FieldName = 'unitname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #24037#21495
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'archiveno'
            Footers = <>
            Title.Caption = #26723#26696#21495
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'cardno'
            Footers = <>
            Title.Caption = 'IC'#21345#21495
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
            Title.Caption = #24615#21035
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'idcard'
            Footers = <>
            Title.Caption = #36523#20221#35777#21495
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #25152#23646#36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'birthday'
            Footers = <>
            Title.Caption = #29983#26085
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'qualificationno'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#21495
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'qualificationstartdate'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#36215#22987#26085#26399
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'qualificationenddate'
            Footers = <>
            Title.Caption = #20174#19994#36164#26684#35777#26377#25928#26399
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #31227#21160#30005#35805
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'familyphone'
            Footers = <>
            Title.Caption = #23478#24237#30005#35805
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'familyaddress'
            Footers = <>
            Title.Caption = #23478#24237#22320#22336
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'nativeplace'
            Footers = <>
            Title.Caption = #31821#36143
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'educationname'
            Footers = <>
            Title.Caption = #23398#21382
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'politicsstatusname'
            Footers = <>
            Title.Caption = #25919#27835#38754#35980
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'education'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'gradename'
            Footers = <>
            Title.Caption = #20056#21153#21592#26143#32423
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'salary'
            Footers = <>
            Title.Caption = #24037#36164
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'istemporary'
            Footers = <>
            Title.Caption = #26159#21542#20020#26102#24037
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'grade'
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
            FieldName = 'orgid'
            Footers = <>
            Visible = False
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
            Width = 116
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 147
          end
          item
            EditButtons = <>
            FieldName = 'politicsstatus'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'vehicleid'
            Footers = <>
            Title.Caption = #36710#31080'id'
            Visible = False
            Width = 80
          end>
      end
    end
  end
  object grp3: TGroupBox [3]
    Left = 0
    Top = 392
    Width = 1440
    Height = 197
    Align = alBottom
    TabOrder = 3
    Visible = False
    object grp8: TGroupBox
      Left = 2
      Top = 16
      Width = 1436
      Height = 179
      Align = alClient
      Caption = #24037#20316#32463#21382#20449#24687
      TabOrder = 0
      object tlb1: TToolBar
        Left = 2
        Top = 16
        Width = 1432
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
        object btn4: TToolButton
          Left = 39
          Top = 0
          Hint = #20462#25913
          Caption = 'ToolButton2'
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          OnClick = btn4Click
        end
        object btn5: TToolButton
          Left = 62
          Top = 0
          Width = 8
          Caption = 'ToolButton5'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object btn6: TToolButton
          Left = 70
          Top = 0
          Hint = #27880#38144
          Caption = 'ToolButton8'
          ImageIndex = 7
          ParentShowHint = False
          ShowHint = True
          OnClick = btn6Click
        end
      end
      object nvdbgrdhWork: TNvDbgridEh
        Left = 2
        Top = 45
        Width = 1432
        Height = 132
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
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'position'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32844#20301
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'startdate'
            Footers = <>
            Title.Caption = #24037#20316#24320#22987#26085#26399
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'enddate'
            Footers = <>
            Title.Caption = #24037#20316#32467#26463#26085#26399
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'resume'
            Footers = <>
            Title.Caption = #31616#21382
            Width = 235
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 142
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Title.Caption = 'upadateby'
            Visible = False
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #26356#26032#20154
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #26356#26032#26102#38388
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'driverid'
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
    DataSourceName = 'stewardmap'
    QueryAddress = 'archive/findSteward'
    SaveAddress = 'archive/findSteward'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ut!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!qualificationno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!grade'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!archiveno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LTD_s!qualificationenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_s!qualificationenddate'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    AfterScroll = jcdsResultAfterScroll
    Left = 184
    Top = 208
    object lrgntfldResultid: TLargeintField
      FieldName = 'id'
    end
    object wdstrngfldResultarchiveno: TWideStringField
      FieldName = 'archiveno'
      Size = 40
    end
    object wdstrngfldResultcardno: TWideStringField
      FieldName = 'cardno'
      Size = 40
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
      Size = 40
    end
    object lrgntfldResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object wdstrngfldResulteducation: TWideStringField
      FieldName = 'education'
    end
    object wdstrngfldResultfamilyaddress: TWideStringField
      FieldName = 'familyaddress'
      Size = 300
    end
    object wdstrngfldResultfamilyphone: TWideStringField
      FieldName = 'familyphone'
      Size = 30
    end
    object wdstrngfldResultgrade: TWideStringField
      FieldName = 'grade'
    end
    object wdstrngfldResultidcard: TWideStringField
      FieldName = 'idcard'
      Size = 30
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
      Size = 40
    end
    object lrgntfldResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object wdstrngfldResultpoliticsstatus: TWideStringField
      FieldName = 'politicsstatus'
    end
    object wdstrngfldResultqualificationno: TWideStringField
      FieldName = 'qualificationno'
      Size = 40
    end
    object fltfldResultsalary: TFloatField
      FieldName = 'salary'
    end
    object wdstrngfldResultsex: TWideStringField
      FieldName = 'sex'
      Size = 10
    end
    object lrgntfldResultunitid: TLargeintField
      FieldName = 'unitid'
    end
    object lrgntfldResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object wdstrngfldResultunitname: TWideStringField
      FieldName = 'unitname'
      Size = 50
    end
    object wdstrngfldResultcreatename: TWideStringField
      FieldName = 'createname'
      Size = 50
    end
    object wdstrngfldResultpoliticsstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'politicsstatusname'
      LookupDataSet = jcdsPoliticsstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'politicsstatus'
      Lookup = True
    end
    object wdstrngfldResultgradename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'gradename'
      LookupDataSet = jcdsGradename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'grade'
      Size = 30
      Lookup = True
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
    object wdstrngfldResultupdatename: TWideStringField
      FieldName = 'updatename'
      Size = 50
    end
    object jcdsResultbirthday: TDateField
      FieldName = 'birthday'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultqualificationenddate: TDateField
      FieldName = 'qualificationenddate'
    end
    object jcdsResultqualificationstartdate: TDateField
      FieldName = 'qualificationstartdate'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultjianpin: TWideStringField
      FieldName = 'jianpin'
      Size = 100
    end
    object jcdsResultvehicleno: TWideStringField
      FieldName = 'vehicleno'
    end
    object jcdsResultvehicleid: TLargeintField
      FieldName = 'vehicleid'
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 264
  end
  object jcdsStewardWork: TjsonClientDataSet
    DataSourceName = 'workmap'
    QueryAddress = 'archive/findStewardworkexperience'
    SaveAddress = 'archive/findStewardworkexperience'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'filter_EQL_w!stewardid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 472
  end
  object dsWorkResult: TDataSource
    DataSet = jcdsStewardWork
    Left = 88
    Top = 472
  end
  object jcdsGradename: TjsonClientDataSet
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
        Value = 'steward'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'grade'
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 224
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
    Left = 440
    Top = 240
  end
  object jcdsDelete: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/delSteward'
    SaveAddress = 'archive/delSteward'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'stewardid'
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
    Left = 448
    Top = 176
  end
  object imgLi: TImageList
    DrawingStyle = dsSelected
    Left = 336
    Top = 376
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
  object jcdsDelWork: TjsonClientDataSet
    DataSourceName = 'workmap'
    QueryAddress = 'archive/delStewardwork'
    SaveAddress = 'archive/delStewardwork'
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
    Left = 288
    Top = 472
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
    Left = 272
    Top = 264
  end
  object jcdsFindPicture: TjsonClientDataSet
    DataSourceName = 'stewardpicture'
    QueryAddress = 'archive/findStewardPicture'
    SaveAddress = 'archive/findStewardPicture'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
        Value = 'employee'
      end>
    RemoteServer = DMPublic.jcon
    Left = 496
    Top = 304
  end
end
