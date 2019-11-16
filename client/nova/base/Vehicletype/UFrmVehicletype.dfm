inherited FrmVehicletype: TFrmVehicletype
  Caption = #36710#22411#31649#29702#20449#24687
  ClientHeight = 399
  ClientWidth = 822
  Font.Charset = GB2312_CHARSET
  ExplicitWidth = 838
  ExplicitHeight = 437
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 822
    ExplicitWidth = 822
    object lbl1: TLabel
      Left = 18
      Top = 24
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object lbl2: TLabel
      Left = 222
      Top = 24
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object lbl3: TLabel
      Left = 416
      Top = 24
      Width = 28
      Height = 14
      Caption = #31867#22411
    end
    object lbl4: TLabel
      Left = 624
      Top = 24
      Width = 28
      Height = 14
      Caption = #32423#21035
    end
    object edtcode: TNovaEdit
      Left = 52
      Top = 19
      Width = 121
      Height = 22
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
    object edtname: TNovaEdit
      Left = 253
      Top = 19
      Width = 121
      Height = 22
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
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
    object cbbtype: TNovaComboBox
      Left = 450
      Top = 19
      Width = 121
      Height = 22
      ImeMode = imClose
      TabOrder = 2
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
      HelpOptions.TableName = 'vehicletype'
      HelpOptions.Columnname = 'type'
    end
    object cbbgrade: TNovaComboBox
      Left = 662
      Top = 19
      Width = 121
      Height = 22
      ImeMode = imClose
      TabOrder = 3
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
      HelpOptions.TableName = 'vehicletype'
      HelpOptions.Columnname = 'grade'
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 822
    ExplicitWidth = 822
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
  end
  inherited Panel1: TPanel
    Width = 822
    Height = 296
    ExplicitWidth = 822
    ExplicitHeight = 296
    inherited GroupBox1: TGroupBox
      Width = 822
      Height = 296
      ExplicitWidth = 822
      ExplicitHeight = 296
      inherited dbgrdhResult: TNvDbgridEh
        Width = 818
        Height = 278
        FooterFont.Charset = GB2312_CHARSET
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        TitleFont.Charset = GB2312_CHARSET
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.DisplayFormat = #21512#35745
            Footer.Value = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32534#30721
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21517#31216
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #31867#22411
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'gradename'
            Footers = <>
            Title.Caption = #32423#21035
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'customname'
            Footers = <>
            Title.Caption = #33258#23450#20041#21517#31216
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'rationseatnum'
            Footers = <>
            Title.Caption = #26680#23450#24231#20301#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 100
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
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'isactive'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'islocaldelete'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'vehiclemap'
    QueryAddress = 'base/qryveh'
    SaveAddress = 'base/saveveh'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_t!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_t!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_t!type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_t!grade'
        ParamType = ptInput
      end>
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultname: TWideStringField
      FieldName = 'name'
    end
    object jcdsResulttype: TWideStringField
      FieldName = 'type'
    end
    object jcdsResultgrade: TWideStringField
      FieldName = 'grade'
    end
    object jcdsResultcustomname: TWideStringField
      FieldName = 'customname'
    end
    object jcdsResultrationseatnum: TIntegerField
      FieldName = 'rationseatnum'
    end
    object jcdsResultcreatename: TWideStringField
      FieldName = 'createname'
    end
    object jcdsResultupdatename: TWideStringField
      FieldName = 'updatename'
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
    object jcdsResulttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'typename'
      LookupDataSet = jcdstypename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'type'
      Lookup = True
    end
    object jcdsResultgradename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'gradename'
      LookupDataSet = jcdsgradename
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'grade'
      Lookup = True
    end
    object jcdsResultisactive: TBooleanField
      FieldName = 'isactive'
    end
    object jcdsResultislocaldelete: TBooleanField
      FieldName = 'islocaldelete'
    end
    object jcdsResultsynccode: TWideStringField
      FieldName = 'synccode'
      Size = 40
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
  end
  object jcdstypename: TjsonClientDataSet
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
        Value = 'vehicletype'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'type'
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 248
  end
  object jcdsgradename: TjsonClientDataSet
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
        Value = 'vehicletype'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'grade'
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 248
  end
  object jcdsResultCDSDelVehicletype: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delvehicletype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehicletype.id'
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
    Left = 120
    Top = 216
  end
end
