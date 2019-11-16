inherited FrmPrintTemplate: TFrmPrintTemplate
  Caption = #25171#21360#27169#26495
  ClientHeight = 451
  ClientWidth = 885
  ExplicitWidth = 901
  ExplicitHeight = 489
  PixelsPerInch = 96
  TextHeight = 14
  object spl1: TSplitter [0]
    Left = 0
    Top = 283
    Width = 885
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 24
    ExplicitTop = 412
  end
  inherited pnlQuery: TPanel
    Width = 885
    ExplicitWidth = 885
    object lbltemplatetype: TLabel
      Left = 6
      Top = 26
      Width = 56
      Height = 14
      Caption = #27169#26495#31867#22411
    end
    object lblname: TLabel
      Left = 262
      Top = 26
      Width = 56
      Height = 14
      Caption = #27169#26495#21517#31216
    end
    object Nvhcbbtemplatetype: TNovaHComboBox
      Left = 68
      Top = 22
      Width = 170
      Height = 22
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
      HelpOptions.HDataSourceName = 'printtemplatetypelist'
      HelpOptions.HQueryAddress = 'system/queryPrinttemplatetype'
      HelpOptions.displayFieldname = 'name'
      Params = <>
    end
    object nvedtname: TNovaEdit
      Left = 327
      Top = 22
      Width = 170
      Height = 22
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
  end
  inherited tlbShortCut: TToolBar
    Width = 885
    ExplicitWidth = 885
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
    inherited tbtnSave: TToolButton
      Caption = #22797#21046
      ImageIndex = 45
      OnClick = tbtnSaveClick
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited ToolButton52: TToolButton
      Caption = #35774#32622
      ImageIndex = 52
      Visible = True
      OnClick = ToolButton52Click
      ExplicitWidth = 39
    end
    inherited ToolButton53: TToolButton
      Left = 511
      Caption = #27979#35797#25171#21360
      ImageIndex = 8
      Visible = True
      OnClick = ToolButton53Click
      ExplicitLeft = 511
      ExplicitWidth = 67
    end
    inherited tbtn4: TToolButton
      Left = 578
      ImageIndex = -1
      ExplicitLeft = 578
    end
    inherited tbtnInfo: TToolButton
      Left = 586
      ExplicitLeft = 586
    end
    inherited tbtn5: TToolButton
      Left = 656
      ExplicitLeft = 656
    end
    inherited tbtnExcel: TToolButton
      Left = 664
      Visible = False
      ExplicitLeft = 664
    end
    inherited tbtnPrinter: TToolButton
      Left = 734
      Visible = False
      ExplicitLeft = 734
    end
    inherited tbtn6: TToolButton
      Left = 804
      Visible = False
      ExplicitLeft = 804
    end
    inherited tbtnClose: TToolButton
      Left = 812
      ExplicitLeft = 812
    end
  end
  inherited Panel1: TPanel
    Width = 885
    Height = 180
    Align = alTop
    ExplicitWidth = 885
    ExplicitHeight = 180
    inherited GroupBox1: TGroupBox
      Width = 395
      Height = 180
      ExplicitWidth = 395
      ExplicitHeight = 180
      inherited dbgrdhResult: TNvDbgridEh
        Width = 391
        Height = 162
        Columns = <
          item
            EditButtons = <>
            FieldName = 'printtemplatetypename'
            Footers = <>
            Title.Caption = #27169#26495#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Caption = #27169#26495#21517#31216
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'width'
            Footers = <>
            Title.Caption = #39029#23485
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'height'
            Footers = <>
            Title.Caption = #39029#39640
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'heightcorrection'
            Footers = <>
            Title.Caption = #39029#39640#20462#27491
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'top'
            Footers = <>
            Title.Caption = #36317#39030
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'left'
            Footers = <>
            Title.Caption = #36317#24038
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'rowperpage'
            Footers = <>
            Title.Caption = #34892'/'#39029
            Width = 43
          end
          item
            EditButtons = <>
            FieldName = 'rowspace'
            Footers = <>
            Title.Caption = #34892#38388#36317
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'columnsperpage'
            Footers = <>
            Title.Caption = #21015'/'#39029
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'autopages'
            Footers = <>
            Title.Caption = #25968#25454#38598#33258#21160#36208#32440
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'printername'
            Footers = <>
            Title.Caption = #25171#21360#26426
            Width = 161
          end
          item
            EditButtons = <>
            FieldName = 'backgroundimage'
            Footers = <>
            Title.Caption = #32972#26223#22270#36335#24452
            Width = 159
          end
          item
            EditButtons = <>
            FieldName = 'createbyname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
          end
          item
            EditButtons = <>
            FieldName = 'updatebyname'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
          end>
      end
    end
    object gbitems: TGroupBox
      Left = 395
      Top = 0
      Width = 490
      Height = 180
      Align = alRight
      Caption = #25171#21360#39033#30446#26126#32454
      TabOrder = 1
      object nvdbgrdhitems: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 486
        Height = 162
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = ds1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
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
        ParentName = 'FrmPrintTemplatePlan'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'title'
            Footers = <>
            Title.Caption = #26174#31034#26631#31614
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'valueTypename'
            Footers = <>
            Title.Caption = #25171#21360#31867#22411
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'parameter'
            Footers = <>
            Title.Caption = #21442#25968
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'islist'
            Footers = <>
            Title.Caption = #25968#25454#38598
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'fontname'
            Footers = <>
            Title.Caption = #23383#20307
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'fontsize'
            Footers = <>
            Title.Caption = #23383#20307#22823#23567
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'left'
            Footers = <>
            Title.Caption = #36317#24038
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'top'
            Footers = <>
            Title.Caption = #36317#39030
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'width'
            Footers = <>
            Title.Caption = #23485
            Width = 33
          end
          item
            EditButtons = <>
            FieldName = 'height'
            Footers = <>
            Title.Caption = #39640
            Width = 34
          end
          item
            EditButtons = <>
            FieldName = 'isprint'
            Footers = <>
            Title.Caption = #26159#21542#25171#21360
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'itemname'
            Footers = <>
            Title.Caption = #25968#25454#28304#21517#31216
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'itemcode'
            Footers = <>
            Title.Caption = #25968#25454#28304#32534#30721
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'itemtype'
            Footers = <>
            Title.Caption = #25968#25454#28304#31867#22411
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'createbyname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 102
          end
          item
            EditButtons = <>
            FieldName = 'updatebyname'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 109
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object scrlbxplan: TScrollBox [4]
    Left = 0
    Top = 288
    Width = 885
    Height = 163
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 3
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 168
  end
  inherited ilToolBarDisable: TImageList
    Left = 152
    Top = 168
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'printtemplatelist'
    QueryAddress = 'system/queryPrinttemplate'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_pt!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ptt!id'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 232
    Top = 168
  end
  inherited dsResult: TDataSource
    Left = 16
    Top = 168
  end
  object jcdsDeletePrinttemplate: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/deletePrinttemplate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'printtemplate.id'
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
    Left = 136
    Top = 232
  end
  object ds1: TDataSource
    DataSet = jcdsqueryitem
    Left = 744
    Top = 184
  end
  object jcdsqueryitem: TjsonClientDataSet
    DataSourceName = 'printtemplateitemlist'
    QueryAddress = 'system/queryPrinttemplateitem'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_pti!printtemplate.id'
        ParamType = ptInput
        Value = '5028850'
      end>
    RemoteServer = DMPublic.jcon
    Left = 784
    Top = 184
  end
  object jcdsprintValueType: TjsonClientDataSet
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
        Value = 'printtemplateitem'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'valuetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 632
    Top = 184
  end
  object jcdsCopyPrintTemplate: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/copyPrinttemplate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'printtemplate.id'
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
      end
      item
        DataType = ftLargeint
        Name = 'printtemplateId'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterScroll = jcdsResultAfterScroll
    Left = 560
    Top = 64
  end
end
