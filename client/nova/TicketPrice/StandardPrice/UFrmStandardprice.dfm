inherited FrmStandardprice: TFrmStandardprice
  Caption = #20844#24335#31080#20215
  ClientHeight = 488
  ClientWidth = 768
  OnShow = FormShow
  ExplicitWidth = 776
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 98
    Width = 768
    Height = 108
    ExplicitTop = 98
    ExplicitWidth = 768
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
      Top = 50
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
      Top = 53
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
      TabOrder = 0
    end
    object Chkislinework: TCheckBox
      Left = 296
      Top = 82
      Width = 81
      Height = 17
      Caption = #27969#27700#29677#27425
      TabOrder = 1
    end
    object Chkissellreturnticket: TCheckBox
      Left = 479
      Top = 82
      Width = 81
      Height = 17
      Caption = #21452#31243#29677#27425
      TabOrder = 2
    end
    object CobDISTRICTTYPE: TNovaComboBox
      Left = 299
      Top = 49
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
      TabOrder = 7
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
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
    end
    object NCbbWorkType: TNovaComboBox
      Left = 520
      Top = 49
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
  end
  inherited tlbShortCut: TToolBar
    Width = 768
    Height = 98
    ExplicitWidth = 768
    ExplicitHeight = 98
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
    end
    inherited tbtnInsert: TToolButton
      Caption = #29983#25104#31080#20215
      ImageIndex = 42
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Visible = False
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
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
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 53
    end
    inherited tbtnCancel: TToolButton
      Left = 70
      Top = 53
      Visible = False
      ExplicitLeft = 70
      ExplicitTop = 53
    end
    inherited ToolButton52: TToolButton
      Left = 140
      Top = 53
      ExplicitLeft = 140
      ExplicitTop = 53
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 158
      Top = 53
      ExplicitLeft = 158
      ExplicitTop = 53
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 176
      Top = 53
      ExplicitLeft = 176
      ExplicitTop = 53
    end
    inherited tbtnInfo: TToolButton
      Left = 184
      Top = 53
      ExplicitLeft = 184
      ExplicitTop = 53
    end
    inherited tbtn5: TToolButton
      Left = 254
      Top = 53
      ExplicitLeft = 254
      ExplicitTop = 53
    end
    inherited tbtnExcel: TToolButton
      Left = 262
      Top = 53
      ExplicitLeft = 262
      ExplicitTop = 53
    end
    inherited tbtnPrinter: TToolButton
      Left = 332
      Top = 53
      ExplicitLeft = 332
      ExplicitTop = 53
    end
    inherited tbtn6: TToolButton
      Left = 402
      Top = 53
      ExplicitLeft = 402
      ExplicitTop = 53
    end
    inherited tbtnClose: TToolButton
      Left = 410
      Top = 53
      ExplicitLeft = 410
      ExplicitTop = 53
    end
  end
  inherited Panel1: TPanel
    Top = 206
    Width = 768
    Height = 282
    ExplicitTop = 206
    ExplicitWidth = 768
    ExplicitHeight = 282
    object Splitter1: TSplitter [0]
      Left = 0
      Top = 104
      Width = 768
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 193
      ExplicitWidth = 69
    end
    inherited GroupBox1: TGroupBox
      Width = 768
      Height = 104
      ExplicitWidth = 768
      ExplicitHeight = 104
      inherited dbgrdhResult: TNvDbgridEh
        Width = 764
        Height = 86
        FooterRowCount = 1
        SortLocal = True
        SumList.Active = True
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
            Width = 78
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
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'username'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'UPDATETIME'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 107
      Width = 768
      Height = 175
      Align = alBottom
      Caption = #31080#20215#20449#24687
      TabOrder = 1
      object NvDbgridEhStandardPrice: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 764
        Height = 157
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DsStandardPrice
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnCellClick = NvDbgridEhStandardPriceCellClick
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
        ParentName = 'FrmStandardprice'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departstation'
            Footers = <>
            Title.Caption = #19978#36710#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'reachstation'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'vehicletype'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'toplimitprice'
            Footers = <>
            Title.Caption = #19978#38480#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'lowerlimitprice'
            Footers = <>
            Title.Caption = #19979#38480#20215
            Width = 60
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 136
    Top = 192
  end
  inherited ilToolBarDisable: TImageList
    Left = 200
    Top = 192
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
        DataType = ftBCD
        Name = 'filter_LIKES_r!name'
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
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 152
    Top = 240
    object jcdsResultroutename: TWideStringField
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
    object jcdsResultCREATETIME: TDateTimeField
      FieldName = 'CREATETIME'
    end
    object jcdsResultUPDATETIME: TDateTimeField
      FieldName = 'UPDATETIME'
    end
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 192
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Top = 192
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
    Left = 392
    Top = 192
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
    Left = 472
    Top = 192
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
    Left = 552
    Top = 192
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
    Top = 192
  end
  object jcdsQryStandardprice: TjsonClientDataSet
    DataSourceName = 'standardpricemlist'
    QueryAddress = 'ticketprice/querystandardprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_s!id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 368
  end
  object DsStandardPrice: TDataSource
    DataSet = jcdsQryStandardprice
    Left = 360
    Top = 368
  end
  object jcsdGenPrice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/genScheduleStandardPrice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'createby'
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
    Left = 312
    Top = 264
  end
end
