object FrmScheduledeparttime: TFrmScheduledeparttime
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #29677#27425#21457#36710#26102#21051#34920
  ClientHeight = 407
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 939
    Height = 407
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 840
    ExplicitHeight = 378
    object Panel2: TPanel
      Left = 0
      Top = 356
      Width = 939
      Height = 51
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 327
      ExplicitWidth = 840
      object bbtnClose: TBitBtn
        Left = 596
        Top = 13
        Width = 83
        Height = 25
        Caption = '&Q '#20851#38381
        DoubleBuffered = True
        Kind = bkClose
        ParentDoubleBuffered = False
        TabOrder = 0
      end
      object btn1: TBitBtn
        Left = 303
        Top = 13
        Width = 83
        Height = 25
        Caption = '&P'#25171#21360
        DoubleBuffered = True
        Kind = bkOK
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = btn1Click
      end
      object btn2: TBitBtn
        Left = 449
        Top = 13
        Width = 83
        Height = 25
        Caption = '&E'#23548#20986
        DoubleBuffered = True
        Kind = bkOK
        ParentDoubleBuffered = False
        TabOrder = 2
        OnClick = btn2Click
      end
    end
    object nvdbgrdhResult: TNvDbgridEh
      Left = 0
      Top = 0
      Width = 939
      Height = 356
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsResult
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
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = #23435#20307
      TitleFont.Style = [fsBold]
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
      ParentName = 'SimpleCRUDForm'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'routename'
          Footer.DisplayFormat = #21512#35745
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #33829#36816#32447#36335
          Width = 136
        end
        item
          EditButtons = <>
          FieldName = 'departdate'
          Footers = <>
          Visible = False
          Width = 127
        end
        item
          EditButtons = <>
          FieldName = 'endstationname'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #32456#28857#31449
          Width = 123
        end
        item
          EditButtons = <>
          FieldName = 'distance'
          Footers = <>
          Title.Caption = #37324#31243
          Width = 38
        end
        item
          EditButtons = <>
          FieldName = 'runtime'
          Footers = <>
          Title.Caption = #36816#34892#26102#38388
        end
        item
          EditButtons = <>
          FieldName = 'starttime'
          Footers = <>
          Title.Caption = #21457#29677#26102#38388
          Width = 207
        end
        item
          EditButtons = <>
          FieldName = 'reachstationname'
          Footers = <>
          Title.Caption = #21040#36798#31449
          Width = 432
        end>
      object RowDetailData: TRowDetailPanelControlEh
        object pnl1: TPanel
          Left = 0
          Top = 0
          Width = 0
          Height = 0
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Panel1'
          TabOrder = 0
          object grp1: TGroupBox
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            Caption = #26597#35810#32467#26524
            TabOrder = 0
            object nvdbgrdhResult1: TNvDbgridEh
              Left = 2
              Top = 16
              Width = 1295
              Height = 373
              Align = alClient
              ColumnDefValues.Title.TitleButton = True
              DataGrouping.GroupLevels = <>
              DataSource = dsResult
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
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
              ParentFont = False
              ReadOnly = True
              RowDetailPanel.Color = clBtnFace
              SumList.Active = True
              TabOrder = 0
              TitleFont.Charset = ANSI_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -15
              TitleFont.Name = #23435#20307
              TitleFont.Style = [fsBold]
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
              ParentName = 'SimpleCRUDForm'
              TitleAlign = taLeftJustify
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'routename'
                  Footer.DisplayFormat = #21512#35745
                  Footer.ValueType = fvtCount
                  Footers = <>
                  Title.Caption = #33829#36816#32447#36335
                  Width = 136
                end
                item
                  EditButtons = <>
                  FieldName = 'departdate'
                  Footers = <>
                  Visible = False
                  Width = 127
                end
                item
                  EditButtons = <>
                  FieldName = 'endstationname'
                  Footer.ValueType = fvtCount
                  Footers = <>
                  Title.Caption = #32456#28857#31449
                  Width = 123
                end
                item
                  EditButtons = <>
                  FieldName = 'distance'
                  Footers = <>
                  Title.Caption = #37324#31243
                  Width = 38
                end
                item
                  EditButtons = <>
                  FieldName = 'runtime'
                  Footers = <>
                  Title.Caption = #36816#34892#26102#38388
                end
                item
                  EditButtons = <>
                  FieldName = 'starttime'
                  Footers = <>
                  Title.Caption = #21457#29677#26102#38388
                  Width = 317
                end
                item
                  EditButtons = <>
                  FieldName = 'reachstationname'
                  Footers = <>
                  Title.Caption = #21040#36798#31449
                  Width = 432
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
        end
      end
    end
  end
  object dsResult: TDataSource
    DataSet = jcdsResult
    Left = 88
    Top = 56
  end
  object jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/findcheduleDepartTime'
    SaveAddress = 'query/findcheduleDepartTime'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_s!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQD_sts!departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 144
    Top = 56
    object intgrfldResultdistance: TIntegerField
      FieldName = 'distance'
    end
    object fltfldResultruntime: TFloatField
      FieldName = 'runtime'
    end
    object wdstrngfldResultendstationname: TWideStringField
      FieldName = 'endstationname'
      Size = 30
    end
    object wdstrngfldResultreachstationname: TWideStringField
      FieldName = 'reachstationname'
      Size = 4000
    end
    object wdstrngfldResultstarttime: TWideStringField
      FieldName = 'starttime'
      Size = 200
    end
    object wdstrngfldResultroutename: TWideStringField
      FieldName = 'routename'
      Size = 0
    end
  end
  object jcdsReturnwayname: TjsonClientDataSet
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
        Value = 'ticketreturn'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'returnway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 56
  end
end
