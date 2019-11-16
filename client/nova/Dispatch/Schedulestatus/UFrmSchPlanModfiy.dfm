inherited FrmSchPlanModfiy: TFrmSchPlanModfiy
  Caption = #29677#27425#35745#21010#20449#24687
  ClientHeight = 465
  ClientWidth = 607
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 613
  ExplicitHeight = 493
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 607
    Height = 420
    ExplicitWidth = 607
    ExplicitHeight = 420
    inherited Bevel1: TBevel
      Top = 412
      Width = 573
      ExplicitTop = 296
      ExplicitWidth = 519
    end
    object lblroute: TLabel
      Left = 41
      Top = 105
      Width = 56
      Height = 14
      Caption = #32447#36335#21517#31216
    end
    object lblschedule: TLabel
      Left = 55
      Top = 144
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object lbldepartdate: TLabel
      Left = 41
      Top = 27
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl2: TLabel
      Left = 40
      Top = 67
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object lbldeparttime: TLabel
      Left = 40
      Top = 257
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object Label24: TLabel
      Left = 55
      Top = 293
      Width = 42
      Height = 14
      Caption = #26816#31080#21475
    end
    object Label25: TLabel
      Left = 48
      Top = 332
      Width = 42
      Height = 14
      Caption = #20056#36710#24211
    end
    object Label7: TLabel
      Left = 40
      Top = 183
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object Label1: TLabel
      Left = 63
      Top = 374
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object Label14: TLabel
      Left = 38
      Top = 219
      Width = 56
      Height = 14
      Caption = #36816#33829#31867#21035
    end
    object Label22: TLabel
      Left = 229
      Top = 217
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object edtroute: TNovaEdit
      Left = 103
      Top = 102
      Width = 170
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
      Left = 103
      Top = 141
      Width = 170
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
    object dpstartdate: TDateTimePicker
      Left = 104
      Top = 24
      Width = 121
      Height = 22
      Date = 40784.627977233790000000
      Time = 40784.627977233790000000
      Enabled = False
      TabOrder = 2
    end
    object dpenddate: TDateTimePicker
      Left = 104
      Top = 63
      Width = 121
      Height = 22
      Date = 40784.458318101860000000
      Time = 40784.458318101860000000
      TabOrder = 3
    end
    object edtstarttime: TDateTimePicker
      Left = 103
      Top = 253
      Width = 74
      Height = 22
      Date = 40759.000011574070000000
      Format = 'HH:mm'
      Time = 40759.000011574070000000
      Kind = dtkTime
      TabOrder = 4
      OnChange = edtstarttimeChange
    end
    object NHccbTicketEntrance: TNovaHComboBox
      Left = 103
      Top = 290
      Width = 145
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
      HelpOptions.HDataSourceName = 'statusmap'
      HelpOptions.HQueryAddress = 'dispatch/qryTicketentrance'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftWideString
          Name = 'departstationid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'scheduleid'
          ParamType = ptInput
        end>
    end
    object NHccbVehiclepark: TNovaHComboBox
      Left = 103
      Top = 329
      Width = 145
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
      HelpOptions.HDataSourceName = 'schedulemap'
      HelpOptions.HQueryAddress = 'dispatch/qryVehiclepark'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'departstationid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'scheduleid'
          ParamType = ptInput
        end>
    end
    object grp1: TGroupBox
      Left = 329
      Top = 0
      Width = 252
      Height = 393
      Caption = #35813#32447#36335#23545#24212#29677#27425
      TabOrder = 7
      object nvdbgrdh2: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 248
        Height = 375
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
        PopupMenu = PopupMenu1
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
            Width = 37
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
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 72
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object CobWORKWAYS: TNovaComboBox
      Left = 103
      Top = 178
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 8
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
    end
    object EdtRemark: TEdit
      Left = 103
      Top = 370
      Width = 209
      Height = 22
      MaxLength = 50
      TabOrder = 9
    end
    object CobWORKTYPE: TNovaComboBox
      Left = 101
      Top = 215
      Width = 120
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 10
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
    end
    object chkWorkline: TCheckBox
      Left = 199
      Top = 257
      Width = 74
      Height = 17
      Caption = #27969#27700#29677
      TabOrder = 11
    end
  end
  inherited pnlOperation: TPanel
    Top = 420
    Width = 607
    ExplicitTop = 420
    ExplicitWidth = 607
    inherited bbtnSave: TBitBtn
      Left = 165
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 165
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 298
      Top = 6
      ExplicitLeft = 298
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 8
    Top = 240
  end
  object jsonUpdateScheduleplan: TjsonClientDataSet
    DataSourceName = 'planlist'
    SaveAddress = 'dispatch/updateScheduleplan'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'fromdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.buspark'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedulestatus.departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isworkline'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'remark'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleids'
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
    Left = 232
    Top = 168
  end
  object dsScheduleResult: TDataSource
    DataSet = jcdsSchedule
    Left = 392
    Top = 112
  end
  object jcdsSchedule: TjsonClientDataSet
    DataSourceName = 'datamap'
    QueryAddress = 'dispatch/qrySameRouteSch'
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
        Name = 'departdate'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 488
    Top = 128
  end
  object PopupMenu1: TPopupMenu
    Left = 400
    Top = 168
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
end
