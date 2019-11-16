inherited FrmDeductManage: TFrmDeductManage
  Caption = #25187#36153#31649#29702
  ClientHeight = 486
  ClientWidth = 1020
  OnShow = FormShow
  ExplicitWidth = 1028
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1020
    ExplicitWidth = 1020
    object Label2: TLabel
      Left = 459
      Top = 27
      Width = 56
      Height = 14
      Caption = #25187#36153#31867#22411
    end
    object Label6: TLabel
      Left = 235
      Top = 27
      Width = 56
      Height = 14
      Caption = #25187#36153#39033#30446
    end
    object Label1: TLabel
      Left = 11
      Top = 27
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object NovaCobType: TNovaComboBox
      Left = 521
      Top = 22
      Width = 121
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
      HelpOptions.TableName = 'balancedeductitem'
      HelpOptions.Columnname = 'deducttype'
      HelpOptions.DisAll = True
    end
    object NovaEdtName: TNovaEdit
      Left = 298
      Top = 22
      Width = 152
      Height = 22
      MaxLength = 20
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
    object NovaHCbbOrg: TNovaHComboBox
      Left = 73
      Top = 22
      Width = 147
      Height = 22
      Style = csDropDownList
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'HelpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1020
    ExplicitWidth = 1020
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
      AutoSize = True
      Caption = #21152#21040
      Visible = False
      ExplicitWidth = 39
    end
    inherited tbtnCancel: TToolButton
      Left = 371
      AutoSize = True
      Visible = False
      ExplicitLeft = 371
      ExplicitWidth = 39
    end
    inherited ToolButton52: TToolButton
      Left = 410
      ExplicitLeft = 410
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 428
      ExplicitLeft = 428
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 446
      ExplicitLeft = 446
    end
    inherited tbtnInfo: TToolButton
      Left = 454
      ExplicitLeft = 454
    end
    inherited tbtn5: TToolButton
      Left = 524
      ExplicitLeft = 524
    end
    inherited tbtnExcel: TToolButton
      Left = 532
      ExplicitLeft = 532
    end
    inherited tbtnPrinter: TToolButton
      Left = 602
      ExplicitLeft = 602
    end
    inherited tbtn6: TToolButton
      Left = 672
      ExplicitLeft = 672
    end
    inherited tbtnClose: TToolButton
      Left = 680
      ExplicitLeft = 680
    end
  end
  inherited Panel1: TPanel
    Width = 1020
    Height = 383
    ExplicitWidth = 1020
    ExplicitHeight = 383
    inherited GroupBox1: TGroupBox
      Width = 1020
      Height = 383
      ExplicitWidth = 1020
      ExplicitHeight = 383
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1016
        Height = 365
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #32534#30721
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Caption = #21517#31216
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'printname'
            Footers = <>
            Title.Caption = #25171#21360#21517#31216
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footers = <>
            Title.Caption = #24207#21495
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'deducttypename'
            Footers = <>
            Title.Caption = #25187#36153#31867#22411
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'deductmoney'
            Footers = <>
            Title.Caption = #25187#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'isexpress'
            Footers = <>
            Title.Caption = #34920#36798#24335
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'ispriceitem'
            Footers = <>
            Title.Caption = #31080#20215#20998#39033
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'issum'
            Footers = <>
            Title.Caption = #23567#35745#39033
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'description'
            Footers = <>
            Title.Caption = #22791#27880'/'#34920#36798#24335
            Width = 160
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #28155#21152#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #28155#21152#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 208
    Top = 304
  end
  inherited ilToolBarDisable: TImageList
    Left = 312
    Top = 304
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'deductitemlist'
    QueryAddress = 'balance/qrydeductitems'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_b!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_b!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_b!deducttype'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 200
    Top = 176
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultcode: TWideStringField
      FieldName = 'code'
    end
    object jcdsResultname: TWideStringField
      FieldName = 'name'
    end
    object jcdsResultprintname: TWideStringField
      FieldName = 'printname'
    end
    object jcdsResultorderno: TIntegerField
      FieldName = 'orderno'
    end
    object jcdsResultdeducttype: TWideStringField
      FieldName = 'deducttype'
      Size = 10
    end
    object jcdsResultispriceitem: TBooleanField
      FieldName = 'ispriceitem'
    end
    object jcdsResultisexpress: TBooleanField
      FieldName = 'isexpress'
    end
    object jcdsResultissum: TBooleanField
      FieldName = 'issum'
    end
    object jcdsResultdeductmoney: TFloatField
      FieldName = 'deductmoney'
    end
    object jcdsResultdescription: TWideStringField
      FieldName = 'description'
      Size = 200
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
    object jcdsResultcreatename: TWideStringField
      FieldName = 'createname'
    end
    object jcdsResultupdatename: TWideStringField
      FieldName = 'updatename'
    end
    object jcdsResultorgname: TWideStringField
      FieldName = 'orgname'
      Size = 100
    end
    object jcdsResultdeducttypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'deducttypename'
      LookupDataSet = jcdsQryDeducttype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'deducttype'
      Lookup = True
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
  end
  inherited dsResult: TDataSource
    Left = 400
    Top = 176
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 296
    Top = 176
  end
  object jcdsQryDeducttype: TjsonClientDataSet
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
        Value = 'deductitem'
      end
      item
        DataType = ftWideString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'deducttype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 200
    Top = 240
  end
  object jscdDelItem: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/deldeductitems'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'deductitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'deductitem.updateby'
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
    Left = 576
    Top = 248
  end
end
