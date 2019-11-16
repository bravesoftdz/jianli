inherited FrmPackManualMakeup: TFrmPackManualMakeup
  Caption = #34892#21253#32467#31639#21333#34917#24405
  ClientHeight = 450
  ClientWidth = 951
  OnShow = FormShow
  ExplicitWidth = 967
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 951
    Height = 47
    ExplicitWidth = 951
    ExplicitHeight = 47
    object lbl2: TLabel
      Left = 180
      Top = 16
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl1: TLabel
      Left = 14
      Top = 16
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label4: TLabel
      Left = 328
      Top = 16
      Width = 84
      Height = 14
      Caption = #34892#21253#32467#31639#21333#21495
    end
    object Label1: TLabel
      Left = 544
      Top = 16
      Width = 84
      Height = 14
      Caption = #34892#21253#21463#29702#21333#21495
    end
    object departinvoicesno: TNovaEdit
      Left = 418
      Top = 13
      Width = 105
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object sendBdepartdate: TDateTimePicker
      Left = 76
      Top = 13
      Width = 95
      Height = 22
      Date = 42075.737283831020000000
      Format = 'yyyy-MM-dd'
      Time = 42075.737283831020000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object sendEdepartdate: TDateTimePicker
      Left = 210
      Top = 13
      Width = 95
      Height = 22
      Date = 42075.737283831020000000
      Format = 'yyyy-MM-dd'
      Time = 42075.737283831020000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object novepackeno: TNovaEdit
      Left = 659
      Top = 13
      Width = 105
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
  end
  inherited tlbShortCut: TToolBar
    Width = 951
    ExplicitWidth = 951
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
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
      Width = 15
      ExplicitWidth = 15
    end
    inherited tbtnSave: TToolButton
      Left = 339
      Visible = False
      ExplicitLeft = 339
    end
    inherited tbtnCancel: TToolButton
      Left = 409
      Visible = False
      ExplicitLeft = 409
    end
    inherited ToolButton52: TToolButton
      Left = 479
      ExplicitLeft = 479
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 497
      ExplicitLeft = 497
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 515
      Visible = False
      ExplicitLeft = 515
    end
    inherited tbtnInfo: TToolButton
      Left = 523
      ExplicitLeft = 523
    end
    inherited tbtn5: TToolButton
      Left = 593
      ExplicitLeft = 593
    end
    inherited tbtnExcel: TToolButton
      Left = 601
      ExplicitLeft = 601
    end
    inherited tbtnPrinter: TToolButton
      Left = 671
      ExplicitLeft = 671
    end
    inherited tbtn6: TToolButton
      Left = 741
      ExplicitLeft = 741
    end
    inherited tbtnClose: TToolButton
      Left = 749
      ExplicitLeft = 749
    end
  end
  inherited Panel1: TPanel
    Top = 92
    Width = 951
    Height = 358
    ExplicitTop = 92
    ExplicitWidth = 951
    ExplicitHeight = 358
    inherited GroupBox1: TGroupBox
      Width = 951
      Height = 358
      ExplicitWidth = 951
      ExplicitHeight = 358
      inherited dbgrdhResult: TNvDbgridEh
        Width = 947
        Height = 340
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36135#26085#26399
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesno'
            Footers = <>
            Title.Caption = #36135#29289#32467#31639#21333
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
            Title.Caption = #34892#21253#21463#29702#21333
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'tostationname'
            Footers = <>
            Title.Caption = ' '#21040' '#36798' '#22320
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'shipprice'
            Footers = <>
            Title.Caption = '  '#36816' '#36153' '
          end
          item
            EditButtons = <>
            FieldName = 'balanceamount'
            Footers = <>
            Title.Caption = ' '#32467#31639#37329#39069
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #36816#37327#21333#29366#24577
            Width = 85
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 288
  end
  inherited ilToolBarDisable: TImageList
    Left = 168
    Top = 280
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'packManualMakeuplist'
    QueryAddress = 'pack/packManualMakeup'
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
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_pk!packno'
        ParamType = ptInput
      end>
    Left = 232
    Top = 288
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultdepartinvoicesno: TWideStringField
      FieldName = 'departinvoicesno'
    end
    object jcdsResultpackno: TWideStringField
      FieldName = 'packno'
    end
    object jcdsResulttostationname: TWideStringField
      FieldName = 'tostationname'
    end
    object jcdsResultshipprice: TFloatField
      FieldName = 'shipprice'
    end
    object jcdsResultbalanceamount: TFloatField
      FieldName = 'balanceamount'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
    end
    object jcdsResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsstatusname
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
  end
  inherited dsResult: TDataSource
    Top = 272
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 312
    Top = 304
  end
  object jcdsstatusname: TjsonClientDataSet
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
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 312
  end
  object jsonpackmanualrDel: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/packManualdel'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packdepartinvoices.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 184
  end
end
