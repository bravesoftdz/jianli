inherited FrmHoliday: TFrmHoliday
  Caption = #33410#26085#20449#24687
  ClientHeight = 447
  ClientWidth = 967
  OnShow = FormShow
  ExplicitLeft = 0
  ExplicitWidth = 975
  ExplicitHeight = 481
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 967
    ExplicitTop = 98
    ExplicitWidth = 752
    object Label1: TLabel
      Left = 22
      Top = 25
      Width = 28
      Height = 14
      Caption = #33410#26085
    end
    object Label5: TLabel
      Left = 218
      Top = 25
      Width = 70
      Height = 14
      Caption = #33258#23450#20041#21517#31216
    end
    object NovaCbbHolidayType: TNovaComboBox
      Left = 58
      Top = 20
      Width = 145
      Height = 22
      Style = csDropDownList
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'holiday'
      HelpOptions.Columnname = 'type'
      HelpOptions.DisAll = True
    end
    object NovaEdtHoliday: TNovaEdit
      Left = 296
      Top = 20
      Width = 201
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 100
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
    Width = 967
    ExplicitWidth = 752
    ExplicitHeight = 98
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
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
      OnClick = tbtnCancelClick
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
  end
  inherited Panel1: TPanel
    Width = 967
    Height = 344
    ExplicitTop = 156
    ExplicitWidth = 752
    ExplicitHeight = 291
    inherited GroupBox1: TGroupBox
      Width = 967
      Height = 344
      ExplicitWidth = 752
      ExplicitHeight = 291
      inherited dbgrdhResult: TNvDbgridEh
        Width = 963
        Height = 326
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'typename'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #33410#26085
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'fullname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #33258#23450#20041#21517#31216
            Width = 200
          end
          item
            EditButtons = <>
            FieldName = 'startdate'
            Footers = <>
            Title.Caption = #24320#22987#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'enddate'
            Footers = <>
            Title.Caption = #32467#26463#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'username'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 140
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 88
    Top = 208
  end
  inherited ilToolBarDisable: TImageList
    Left = 176
    Top = 208
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'holidaylist'
    QueryAddress = 'ticketprice/queryholiday'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_h!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_h!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_h!fullname'
        ParamType = ptInput
      end>
    Left = 240
    Top = 248
    object jcdsResulttype: TWideStringField
      FieldName = 'type'
      Size = 10
    end
    object jcdsResultfullname: TWideStringField
      FieldName = 'fullname'
      Size = 100
    end
    object jcdsResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdsQryHolidayType
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Size = 30
      Lookup = True
    end
    object jcdsResultusername: TWideStringField
      FieldName = 'username'
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object jcdsResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultenddate: TDateField
      FieldName = 'enddate'
    end
    object jcdsResultstartdate: TDateField
      FieldName = 'startdate'
    end
    object jcdsResultsynccode: TWideStringField
      FieldName = 'synccode'
      Size = 40
    end
  end
  inherited dsResult: TDataSource
    Top = 200
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 40
    Top = 304
  end
  object jcdsQryHolidayType: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'holiday'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 384
    Top = 280
  end
  object jcdsDelHoliday: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delholiday'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'holiday.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.createby'
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
    Left = 416
    Top = 208
  end
end
