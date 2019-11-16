inherited FrmCustomerAdd: TFrmCustomerAdd
  BorderIcons = [biSystemMenu]
  Caption = #20056#23458#20449#24687#24405#20837
  ClientHeight = 310
  ClientWidth = 530
  Font.Height = -19
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 536
  ExplicitHeight = 338
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlEditBox: TPanel
    Width = 530
    Height = 265
    ExplicitWidth = 530
    ExplicitHeight = 265
    inherited Bevel1: TBevel
      Top = 396
      Width = 604
      ExplicitTop = 376
      ExplicitWidth = 827
    end
    object gbadvanced: TGroupBox
      Left = 528
      Top = 0
      Width = 2
      Height = 265
      Align = alRight
      Caption = #35814#32454#20449#24687
      TabOrder = 1
      Visible = False
      object lbl6: TLabel
        Left = 45
        Top = 78
        Width = 38
        Height = 19
        Caption = #23398#21382
      end
      object lbl12: TLabel
        Left = 17
        Top = 49
        Width = 76
        Height = 19
        Caption = #23478#24237#30005#35805
      end
      object lbl13: TLabel
        Left = 17
        Top = 107
        Width = 76
        Height = 19
        Caption = #23478#24237#20303#22336
      end
      object lbl5: TLabel
        Left = 17
        Top = 135
        Width = 171
        Height = 19
        Caption = #22312#25105#21496#20174#20107#21830#19994#27963#21160
      end
      object lbl10: TLabel
        Left = 17
        Top = 21
        Width = 76
        Height = 19
        Caption = #31227#21160#30005#35805
      end
      object dbedtMOBILEPHONE: TDBEdit
        Left = 79
        Top = 17
        Width = 121
        Height = 27
        DataField = 'MOBILEPHONE'
        DataSource = dsInsuranceBuffer
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
      end
      object dbedtFamilyPhone: TDBEdit
        Left = 79
        Top = 45
        Width = 121
        Height = 27
        DataField = 'FAMILYPHONE'
        DataSource = dsInsuranceBuffer
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 1
      end
      object dbedtAdress: TDBEdit
        Left = 79
        Top = 103
        Width = 121
        Height = 27
        DataField = 'FAMILYADDRESS'
        DataSource = dsInsuranceBuffer
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 3
      end
      object dbmmoRemark: TDBMemo
        Left = 17
        Top = 157
        Width = 179
        Height = 72
        DataField = 'customerremarks'
        DataSource = dsInsuranceBuffer
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object dblkcbbEDUCATION: TDBLookupComboBox
        Left = 79
        Top = 75
        Width = 122
        Height = 27
        DataField = 'EDUCATION'
        DataSource = dsInsuranceBuffer
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        KeyField = 'code'
        ListField = 'value'
        ListSource = dsEducation
        TabOrder = 2
      end
    end
    object gbstandard: TGroupBox
      Left = 0
      Top = 0
      Width = 528
      Height = 265
      Align = alClient
      Caption = #20056#23458#20449#24687
      TabOrder = 0
      object nvdbgrdhCustomer: TNvDbgridEh
        Left = 2
        Top = 21
        Width = 524
        Height = 242
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsInsuranceBuffer
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -19
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imDisable
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -19
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnKeyUp = nvdbgrdhCustomerKeyUp
        ExpOpenType = AutoOpen
        SetIndicatorWidth = 24
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
        ParentName = 'FrmCustomerAdd'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            ReadOnly = True
            Title.Caption = #29677#27425#21495
            Visible = False
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#21495
            Title.TitleButton = False
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'tickettypeprintname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#31080#31867#22411
            Visible = False
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'issell'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#20445#38505
            Title.TitleButton = False
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'insuretypename'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#38505#31867#22411
            Visible = False
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            Title.Caption = #22995#21517
            Title.TitleButton = False
            Width = 83
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypename'
            Footers = <>
            Title.Caption = #35777#20214
            Title.TitleButton = False
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #35777#20214#21495
            Title.TitleButton = False
            Width = 169
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 265
    Width = 530
    ExplicitTop = 265
    ExplicitWidth = 530
    inherited bbtnSave: TBitBtn
      Left = 104
      Top = 11
      OnClick = bbtnSaveClick
      ExplicitLeft = 104
      ExplicitTop = 11
    end
    inherited bbtnClose: TBitBtn
      Left = 225
      Top = 11
      ExplicitLeft = 225
      ExplicitTop = 11
    end
  end
  object jsoncdsEducation: TjsonClientDataSet
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
    Left = 264
    Top = 120
  end
  object jsoncdsCustom: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQL_c!id'
        ParamType = ptInput
        Value = '0'
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
    Left = 320
    Top = 64
  end
  object dsInsuranceBuffer: TDataSource
    OnDataChange = dsInsuranceBufferDataChange
    Left = 32
    Top = 96
  end
  object dsEducation: TDataSource
    DataSet = jsoncdsEducation
    Left = 176
    Top = 104
  end
  object jsoncdsquerycustomer: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 480
    Top = 56
  end
  object jcdsquerycustomerbyid: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQL_c!id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 456
    Top = 136
  end
end
