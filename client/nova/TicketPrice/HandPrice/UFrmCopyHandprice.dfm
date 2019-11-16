inherited FrmCopyHandprice: TFrmCopyHandprice
  Caption = 'FrmCopyHandprice'
  ClientHeight = 509
  ClientWidth = 738
  OnShow = FormShow
  ExplicitWidth = 744
  ExplicitHeight = 541
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 738
    Height = 464
    ExplicitWidth = 738
    ExplicitHeight = 464
    inherited Bevel1: TBevel
      Top = 456
      Width = 704
      ExplicitTop = 389
      ExplicitWidth = 653
    end
    object grp1: TGroupBox
      Left = 414
      Top = 15
      Width = 302
      Height = 430
      Caption = #21516#32447#36335#20854#20182#29677#27425
      TabOrder = 0
      object nvdbgrdh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 298
        Height = 412
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = ds1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imClose
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghRecordMoving, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
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
        ParentName = 'FrmCopyHandprice'
        TitleAlign = taLeftJustify
        Columns = <
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isselect'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36873#25321
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 67
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object chkCheckAll: TCheckBox
        Left = 112
        Top = 0
        Width = 97
        Height = 17
        Caption = #20840#36873
        TabOrder = 1
        OnClick = chkCheckAllClick
      end
    end
    object grp2: TGroupBox
      Left = 43
      Top = 15
      Width = 336
      Height = 434
      Caption = #24403#21069#29677#27425#20449#24687
      TabOrder = 1
      object Label1: TLabel
        Left = 26
        Top = 25
        Width = 56
        Height = 14
        Caption = #25152#23646#32447#36335
      end
      object Label2: TLabel
        Left = 40
        Top = 58
        Width = 42
        Height = 14
        Caption = #29677#27425#21495
      end
      object Label3: TLabel
        Left = 26
        Top = 88
        Width = 56
        Height = 14
        Caption = #21457#36710#26102#38388
      end
      object NovaEdtRoute: TNovaEdit
        Left = 88
        Top = 22
        Width = 177
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
      object NovaEditSchedule: TNovaEdit
        Left = 88
        Top = 53
        Width = 177
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
      object NovaEdtTime: TNovaEdit
        Left = 88
        Top = 85
        Width = 177
        Height = 22
        Enabled = False
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
      object grp3: TGroupBox
        Left = 2
        Top = 112
        Width = 332
        Height = 126
        Align = alBottom
        Caption = #36816#34892#36710#22411
        TabOrder = 3
        object nvdbgrdh2: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 328
          Height = 108
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = ds2
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          ImeMode = imClose
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          RowDetailPanel.Color = clBtnFace
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
          ParentName = 'FrmCopyHandprice'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'isselect'
              Footers = <>
              Title.Caption = #36873#25321
              Width = 40
            end
            item
              EditButtons = <>
              FieldName = 'name'
              Footers = <>
              ReadOnly = True
              Title.Caption = #33829#36816#36710#22411
              Width = 166
            end
            item
              EditButtons = <>
              FieldName = 'rationseatnum'
              Footers = <>
              ReadOnly = True
              Title.Caption = #24231#20301#25968
              Width = 60
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object grp4: TGroupBox
        Left = 2
        Top = 238
        Width = 332
        Height = 194
        Align = alBottom
        Caption = #20572#38752#31449#28857
        TabOrder = 4
        object nvdbgrdh3: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 328
          Height = 176
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = ds3
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          ImeMode = imClose
          OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
          RowDetailPanel.Color = clBtnFace
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
          ParentName = 'FrmCopyHandprice'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'isselect'
              Footers = <>
              Title.Caption = #36873#25321
              Width = 40
            end
            item
              EditButtons = <>
              FieldName = 'name'
              Footers = <>
              ReadOnly = True
              Title.Caption = #20572#38752#31449
              Width = 170
            end
            item
              EditButtons = <>
              FieldName = 'helpcode'
              Footers = <>
              ReadOnly = True
              Title.Caption = #25805#20316#30721
              Width = 60
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 464
    Width = 738
    ExplicitTop = 464
    ExplicitWidth = 738
    inherited bbtnSave: TBitBtn
      Left = 225
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 225
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 353
      ExplicitLeft = 353
    end
  end
  inherited ImageList: TImageList
    Left = 568
    Top = 320
  end
  object jcsdQrySchedule: TjsonClientDataSet
    DataSourceName = 'schedulelist'
    QueryAddress = 'ticketprice/qrySchedules'
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
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 480
    Top = 216
  end
  object ds1: TDataSource
    DataSet = jcsdQrySchedule
    Left = 480
    Top = 160
  end
  object ds2: TDataSource
    DataSet = jcsdQryVehicletype
    Left = 112
    Top = 192
  end
  object ds3: TDataSource
    DataSet = jscdQryStation
    Left = 120
    Top = 304
  end
  object jcsdQryVehicletype: TjsonClientDataSet
    DataSourceName = 'vehiclettypelist'
    QueryAddress = 'ticketprice/qryhandpricevehicletype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 192
  end
  object jscdQryStation: TjsonClientDataSet
    DataSourceName = 'schedulestoplist'
    QueryAddress = 'ticketprice/qryHandpricestation'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 184
    Top = 304
  end
  object jsonCopyHandprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/copyhandprice'
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
        Name = 'vehicletypeids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stationids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleids'
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
    Left = 376
    Top = 320
  end
end
