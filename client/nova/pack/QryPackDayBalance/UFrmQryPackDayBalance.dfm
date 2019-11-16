inherited FrmQryPackDayBalance: TFrmQryPackDayBalance
  Caption = #34892#21253#26085#32467#31639#34920
  OnShow = FormShow
  ExplicitWidth = 1140
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    object lbl2: TLabel
      Left = 177
      Top = 16
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl1: TLabel
      Left = 30
      Top = 16
      Width = 28
      Height = 14
      Caption = #26085#26399
    end
    object Label4: TLabel
      Left = 356
      Top = 16
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object sendBdepartdate: TDateTimePicker
      Left = 76
      Top = 13
      Width = 95
      Height = 22
      Date = 42075.737283831020000000
      Format = 'yyyy-MM-dd'
      Time = 42075.737283831020000000
      TabOrder = 0
    end
    object sendEdepartdate: TDateTimePicker
      Left = 210
      Top = 13
      Width = 95
      Height = 22
      Date = 42075.737283831020000000
      Format = 'yyyy-MM-dd'
      Time = 42075.737283831020000000
      TabOrder = 1
    end
    object departinvoicesno: TNovaEdit
      Left = 418
      Top = 13
      Width = 105
      Height = 22
      MaxLength = 50
      TabOrder = 2
      OnExit = departinvoicesnoExit
      OnKeyPress = departinvoicesnoKeyPress
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
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited tbtn4: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited GroupBox1: TGroupBox
      inherited dbgrdhResult: TNvDbgridEh
        Columns = <
          item
            EditButtons = <>
            FieldName = 'datatypename'
            Footers = <>
            Title.Caption = #21333#21495#31867#22411
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footers = <>
            Title.Caption = #32467#31639#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footers = <>
            Title.Caption = #32467#31639#37329#39069
            Width = 80
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'shenhejine'
            Footers = <>
            Title.Caption = #23457#26680#37329#39069
            Width = 80
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = True
            DropDownSpecRow.Value = ' '
            EditButtons = <>
            FieldName = 'isaudit'
            Footers = <>
            Title.Caption = #23457#26680#29366#24577
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 64
    Top = 304
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 296
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'qryPackDayBalance'
    QueryAddress = 'pack/qryPackDayBalance'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end>
    Left = 120
    Top = 160
    object jcdsResultdatatype: TWideStringField
      FieldName = 'datatype'
    end
    object jcdsResultdatatypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'datatypename'
      LookupDataSet = jcdsdatatypesname
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'datatype'
      Lookup = True
    end
    object jcdsResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
    end
    object jcdsResultbalanceamount: TFloatField
      FieldName = 'balanceamount'
    end
    object jcdsResultshenhejine: TFloatField
      FieldName = 'shenhejine'
    end
    object jcdsResultisaudit: TBooleanField
      FieldName = 'isaudit'
    end
  end
  inherited dsResult: TDataSource
    Left = 352
    Top = 328
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 280
    Top = 296
  end
  object jcdsdatatypesname: TjsonClientDataSet
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
        Value = 'packdepartinvoices'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'datatype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 584
    Top = 344
  end
  object jcdsauditsname: TjsonClientDataSet
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
        Value = 'packdepartinvoices'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'isaudit'
      end>
    RemoteServer = DMPublic.jcon
    Left = 464
    Top = 360
  end
  object jcdspacdepardinvoiceskaudit: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/packDayBalanceaudit'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packdepartinvoices.departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 432
    Top = 144
  end
end
