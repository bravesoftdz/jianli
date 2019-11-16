inherited FrmParameter: TFrmParameter
  Caption = #31995#32479#21442#25968#31649#29702
  ClientHeight = 514
  ClientWidth = 1284
  OnShow = FormShow
  ExplicitWidth = 1300
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1284
    Height = 85
    ExplicitWidth = 1284
    ExplicitHeight = 85
    object lblOrg: TLabel
      Left = 16
      Top = 20
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lblcode: TLabel
      Left = 253
      Top = 62
      Width = 56
      Height = 14
      Caption = #21442#25968#32534#30721
    end
    object lblType: TLabel
      Left = 253
      Top = 20
      Width = 56
      Height = 14
      Caption = #21442#25968#31867#22411
    end
    object lblParamvalue: TLabel
      Left = 710
      Top = 62
      Width = 42
      Height = 14
      Caption = #21442#25968#20540
      Visible = False
    end
    object lbl1: TLabel
      Left = 44
      Top = 62
      Width = 28
      Height = 14
      Caption = #21333#20301
    end
    object lbl2: TLabel
      Left = 506
      Top = 20
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object nvcbbtype: TNovaComboBox
      Left = 315
      Top = 17
      Width = 137
      Height = 22
      ImeMode = imClose
      TabOrder = 1
      Text = #35831#36873#25321'...'
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
      HelpOptions.TableName = 'parameter'
      HelpOptions.Columnname = 'type'
      HelpOptions.DisAll = True
    end
    object nvedtVlaue: TNovaEdit
      Left = 758
      Top = 57
      Width = 134
      Height = 22
      MaxLength = 50
      TabOrder = 5
      Visible = False
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
    object nvedtCode: TNovaEdit
      Left = 315
      Top = 57
      Width = 137
      Height = 22
      MaxLength = 50
      TabOrder = 4
      OnKeyPress = nvedtCodeKeyPress
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
    object nvckbOrg: TNovaCheckedComboBox
      Left = 78
      Top = 17
      Width = 137
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
    object nvedtRemark: TNovaEdit
      Left = 540
      Top = 17
      Width = 272
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
    object nvedtUnit: TNovaEdit
      Left = 78
      Top = 57
      Width = 137
      Height = 22
      MaxLength = 50
      TabOrder = 3
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
    object chkYes: TCheckBox
      Left = 547
      Top = 62
      Width = 58
      Height = 17
      Caption = #21487#32534#36753
      TabOrder = 6
    end
    object chkNo: TCheckBox
      Left = 617
      Top = 62
      Width = 87
      Height = 17
      Caption = #19981#21487#32534#36753
      TabOrder = 7
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1284
    ExplicitWidth = 1284
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
    end
    inherited tbtnEdit: TToolButton
      OnClick = tbtnEditClick
    end
    inherited tbtnDelete: TToolButton
      Visible = False
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
  end
  inherited Panel1: TPanel
    Top = 130
    Width = 1284
    Height = 384
    ExplicitTop = 130
    ExplicitWidth = 1284
    ExplicitHeight = 384
    inherited GroupBox1: TGroupBox
      Width = 1284
      Height = 384
      ExplicitWidth = 1284
      ExplicitHeight = 384
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1280
        Height = 366
        ImeMode = imDisable
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 131
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #21442#25968#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #21442#25968#32534#30721
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'showvalue'
            Footers = <>
            Title.Caption = #21442#25968#20540
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'type'
            Footers = <>
            Visible = False
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'unit'
            Footers = <>
            Title.Caption = #21333#20301
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'orgids'
            Footers = <>
            Visible = False
            Width = 25
          end
          item
            EditButtons = <>
            FieldName = 'did'
            Footers = <>
            Visible = False
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'remark'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 439
          end
          item
            EditButtons = <>
            FieldName = 'iseditable'
            Footers = <>
            Title.Caption = #26159#21542#21487#32534#36753
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 147
          end
          item
            EditButtons = <>
            FieldName = 'pid'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 176
    Top = 168
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'paramlistmap'
    QueryAddress = 'system/findParameter'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQS_p!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_p!iseditable'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_oa!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!unit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!remark'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end>
    Left = 256
    Top = 160
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object wdstrngfldResulttype: TWideStringField
      FieldName = 'type'
    end
    object wdstrngfldResultunit: TWideStringField
      FieldName = 'unit'
    end
    object lrgntfldResultdid: TLargeintField
      FieldName = 'did'
    end
    object lrgntfldResultorgids: TLargeintField
      FieldName = 'orgids'
    end
    object wdstrngfldResultremark: TWideStringField
      FieldName = 'remark'
      Size = 100
    end
    object wdstrngfldResultiseditable: TBooleanField
      FieldName = 'iseditable'
    end
    object lrgntfldResultpid: TLargeintField
      FieldName = 'pid'
    end
    object wdstrngfldResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdsTypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Lookup = True
    end
    object wdstrngfldResultupdatename: TWideStringField
      FieldName = 'updatename'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object wdstrngfldResultshowvalue: TWideStringField
      FieldName = 'showvalue'
      Size = 100
    end
    object wdstrngfldResultcode: TWideStringField
      FieldName = 'code'
    end
  end
  inherited dsResult: TDataSource
    Left = 104
    Top = 184
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 24
    Top = 200
  end
  object jcdsTypename: TjsonClientDataSet
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
        Value = 'parameter'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 248
    Top = 216
  end
end
