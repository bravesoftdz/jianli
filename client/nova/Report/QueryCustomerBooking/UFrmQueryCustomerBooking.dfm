inherited frmQueryCustomerBooking: TfrmQueryCustomerBooking
  Caption = #35746#31080#32479#35745#26597#35810
  ClientHeight = 480
  ClientWidth = 1362
  OnShow = FormShow
  ExplicitWidth = 1378
  ExplicitHeight = 518
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1362
    Height = 44
    ExplicitWidth = 1362
    ExplicitHeight = 44
    object lbl1: TLabel
      Left = 28
      Top = 19
      Width = 28
      Height = 14
      Caption = #26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldate: TLabel
      Left = 213
      Top = 19
      Width = 56
      Height = 14
      Caption = #35746#31080#26085#26399
    end
    object Label1: TLabel
      Left = 403
      Top = 21
      Width = 14
      Height = 14
      Caption = #33267
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 63
      Top = 16
      Width = 138
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object dtpstartdate: TDateTimePicker
      Left = 277
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 428
      Top = 16
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      TabOrder = 2
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1362
    ExplicitWidth = 1362
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
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
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
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
    inherited tbtn4: TToolButton
      Visible = False
    end
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 89
    Width = 1362
    Height = 391
    ExplicitTop = 89
    ExplicitWidth = 1362
    ExplicitHeight = 391
    inherited GroupBox1: TGroupBox
      Width = 1362
      Height = 391
      ExplicitWidth = 1362
      ExplicitHeight = 391
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1358
        Height = 373
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        UseMultiTitle = True
        AutoGridAdject = True
        AutoGridSave = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #26426#26500
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'cusname'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #39038#23458
            Width = 130
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #24615#21035
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #30005#35805
            Width = 126
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypevalue'
            Footers = <>
            Title.Caption = #35777#20214#31867#22411
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #35777#20214#21495#30721
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'email'
            Footers = <>
            Title.Caption = 'Email'
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'bookingnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #35746#31080#25968
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'S'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24050#21462#25968
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'R'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #26410#21462#25968
            Width = 105
          end
          item
            EditButtons = <>
            FieldName = 'C'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#35746#25968
            Width = 118
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
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
              object nvdbgrdh1: TNvDbgridEh
                Left = 2
                Top = 16
                Width = 1295
                Height = 229
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
                ImeMode = imDisable
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
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 96
    Top = 360
  end
  inherited ilToolBarDisable: TImageList
    Left = 184
    Top = 360
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'cbklist'
    QueryAddress = 'report/queryCustomerBooking'
    DisableStringTrim = True
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end>
    Left = 296
    Top = 216
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 0
    end
    object jcdsResultcusname: TWideStringField
      FieldName = 'cusname'
      Size = 0
    end
    object jcdsResultsex: TWideStringField
      FieldName = 'sex'
      Size = 0
    end
    object jcdsResultmobilephone: TWideStringField
      FieldName = 'mobilephone'
      Size = 0
    end
    object jcdsResultbookingnum: TLargeintField
      FieldName = 'bookingnum'
    end
    object jcdsResultR: TLargeintField
      FieldName = 'R'
    end
    object jcdsResultS: TLargeintField
      FieldName = 'S'
    end
    object jcdsResultC: TLargeintField
      FieldName = 'C'
    end
    object jcdsResultcertificatetype: TWideStringField
      FieldName = 'certificatetype'
      Size = 0
    end
    object jcdsResultcertificatetypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certificatetypevalue'
      LookupDataSet = jcdsCertificatetype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Size = 80
      Lookup = True
    end
    object jcdsResultcertificateno: TWideStringField
      FieldName = 'certificateno'
      Size = 0
    end
    object jcdsResultemail: TWideStringField
      FieldName = 'email'
      Size = 0
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 368
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
    Top = 360
  end
  object jcdsCertificatetype: TjsonClientDataSet
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
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'certificatetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 624
    Top = 280
  end
end
