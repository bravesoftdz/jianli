inherited frmEmployee: TfrmEmployee
  Caption = #21592#24037#26723#26696#31649#29702
  ClientHeight = 495
  ClientWidth = 1139
  ExplicitWidth = 1155
  ExplicitHeight = 533
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1139
    Height = 56
    ExplicitWidth = 1139
    ExplicitHeight = 56
    object lbl3: TLabel
      Left = 13
      Top = 24
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl2: TLabel
      Left = 465
      Top = 25
      Width = 28
      Height = 14
      Caption = #24037#21495
    end
    object lbl1: TLabel
      Left = 260
      Top = 24
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 75
      Top = 21
      Width = 143
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvedtCode: TNovaEdit
      Left = 498
      Top = 21
      Width = 143
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
    object nvedtName: TNovaEdit
      Left = 294
      Top = 21
      Width = 144
      Height = 22
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
  end
  inherited tlbShortCut: TToolBar
    Width = 1139
    ExplicitWidth = 1139
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
    inherited tbtnInfo: TToolButton
      Visible = False
    end
    inherited tbtn5: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 101
    Width = 1139
    Height = 394
    ExplicitTop = 101
    ExplicitWidth = 1139
    ExplicitHeight = 394
    inherited GroupBox1: TGroupBox
      Width = 1139
      Height = 394
      ExplicitWidth = 1139
      ExplicitHeight = 394
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1135
        Height = 376
        DrawGraphicData = True
        DrawMemoText = True
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #24037#21495
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
            Title.Caption = #24615#21035
            Width = 34
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
            FieldName = 'birthday'
            Footers = <>
            Title.Caption = #29983#26085
            Width = 87
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
            FieldName = 'positionname'
            Footers = <>
            Title.Caption = #32844#20301
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'salary'
            Footers = <>
            Title.Caption = #24037#36164
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #31227#21160#30005#35805
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'familyphone'
            Footers = <>
            Title.Caption = #23478#24237#30005#35805
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'familyaddress'
            Footers = <>
            Title.Caption = #23478#24237#20303#22336
            Width = 108
          end
          item
            EditButtons = <>
            FieldName = 'nativeplace'
            Footers = <>
            Title.Caption = #31821#36143
            Width = 126
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
            FieldName = 'educationame'
            Footers = <>
            Title.Caption = #23398#21382
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'position'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 68
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 132
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'employeemap'
    QueryAddress = 'archive/findEmployee'
    SaveAddress = 'archive/findEmployee'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_e!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_e!code'
        ParamType = ptInput
      end>
    object lrgntfldResultid: TLargeintField
      FieldName = 'id'
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
      Size = 30
    end
    object lrgntfldResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object wdstrngfldResulteducation: TWideStringField
      FieldName = 'education'
    end
    object wdstrngfldResultfamilyaddress: TWideStringField
      FieldName = 'familyaddress'
      Size = 100
    end
    object wdstrngfldResultfamilyphone: TWideStringField
      FieldName = 'familyphone'
      Size = 30
    end
    object wdstrngfldResultidcard: TWideStringField
      FieldName = 'idcard'
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
      Size = 50
    end
    object lrgntfldResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object wdstrngfldResultposition: TWideStringField
      FieldName = 'position'
    end
    object fltfldResultsalary: TFloatField
      FieldName = 'salary'
    end
    object wdstrngfldResultsex: TWideStringField
      FieldName = 'sex'
    end
    object lrgntfldResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object wdstrngfldResultcreatename: TWideStringField
      FieldName = 'createname'
      Size = 30
    end
    object wdstrngfldResultupdatename: TWideStringField
      FieldName = 'updatename'
      Size = 30
    end
    object wdstrngfldResultpositionname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'positionname'
      LookupDataSet = jcdsPosition
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'position'
      Size = 30
      Lookup = True
    end
    object wdstrngfldResulteducationame: TWideStringField
      FieldKind = fkLookup
      FieldName = 'educationame'
      LookupDataSet = jcdsEducation
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'education'
      Lookup = True
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultbirthday: TDateField
      FieldName = 'birthday'
    end
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
    Left = 576
    Top = 232
  end
  object jcdsPosition: TjsonClientDataSet
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
        Value = 'position'
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 224
  end
  object jcdsDelete: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/delEmployee'
    SaveAddress = 'archive/delEmployee'
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
    Left = 440
    Top = 168
  end
  object jcdsFindPicture: TjsonClientDataSet
    DataSourceName = 'employeePicture'
    QueryAddress = 'archive/findEmployeePicture'
    SaveAddress = 'archive/findEmployeePicture'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_e!id'
        ParamType = ptInput
        Value = 'employee'
      end>
    RemoteServer = DMPublic.jcon
    Left = 152
    Top = 208
  end
end
