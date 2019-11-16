inherited FrmPlusScheduleStaion: TFrmPlusScheduleStaion
  Caption = 'FrmPlusScheduleStaion'
  ClientHeight = 429
  ClientWidth = 420
  OnShow = FormShow
  ExplicitWidth = 426
  ExplicitHeight = 460
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 420
    Height = 384
    ExplicitWidth = 420
    ExplicitHeight = 384
    inherited Bevel1: TBevel
      Top = 376
      Width = 386
      ExplicitTop = 380
      ExplicitWidth = 693
    end
    object grp4: TGroupBox
      Left = 30
      Top = 18
      Width = 349
      Height = 343
      Caption = #24403#21069#29677#27425#20572#38752#31449#28857#20449#24687
      TabOrder = 0
      object nvdbgrdh3: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 345
        Height = 325
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
            FieldName = 'stationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20572#38752#31449
            Width = 180
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
  inherited pnlOperation: TPanel
    Top = 384
    Width = 420
    ExplicitTop = 384
    ExplicitWidth = 420
    inherited bbtnSave: TBitBtn
      Left = 87
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 87
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 224
      Top = 6
      ExplicitLeft = 224
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 616
    Top = 304
  end
  object jscdQryStation: TjsonClientDataSet
    DataSourceName = 'schedulestoplist'
    QueryAddress = 'dispatch/QryStationstop'
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
  object ds3: TDataSource
    DataSet = jscdQryStation
    Left = 120
    Top = 304
  end
  object jscdUpdateSchedulestop: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/updateSchedulestop'
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
        Name = 'stationids'
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
    Left = 152
    Top = 184
  end
end
