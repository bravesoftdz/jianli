inherited FrmComplexfee: TFrmComplexfee
  Caption = #32508#21512#25910#36153#20449#24687#31649#29702
  ClientHeight = 436
  ClientWidth = 872
  Font.Charset = GB2312_CHARSET
  OldCreateOrder = False
  OnShow = FormShow
  ExplicitWidth = 888
  ExplicitHeight = 474
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 872
    Height = 50
    ExplicitWidth = 872
    ExplicitHeight = 50
    object Label2: TLabel
      Left = 10
      Top = 18
      Width = 56
      Height = 14
      Caption = #25805#20316#26426#26500
    end
    object Label1: TLabel
      Left = 218
      Top = 18
      Width = 42
      Height = 14
      Caption = #25805#20316#20154
    end
    object lbl11: TLabel
      Left = 405
      Top = 18
      Width = 56
      Height = 14
      Caption = #24320#31080#26085#26399
    end
    object lbl5: TLabel
      Left = 589
      Top = 18
      Width = 14
      Height = 14
      Caption = #33267
    end
    object NovaCkbOrg: TNovaCheckedComboBox
      Left = 71
      Top = 14
      Width = 120
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
    object nvhlpUser: TNovaHelp
      Left = 266
      Top = 14
      Width = 107
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 69
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object dtpBdepartdate: TDateTimePicker
      Left = 465
      Top = 14
      Width = 103
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      TabOrder = 2
    end
    object dtpEdepartdate: TDateTimePicker
      Left = 609
      Top = 14
      Width = 103
      Height = 22
      Date = 40413.000000000000000000
      Time = 40413.000000000000000000
      TabOrder = 3
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 872
    ExplicitWidth = 872
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
      Caption = #37325#26032#25171#21360
      ImageIndex = 48
      Visible = True
      OnClick = ToolButton50Click
      ExplicitWidth = 67
    end
    inherited ToolButton51: TToolButton
      Left = 355
      ExplicitLeft = 355
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 373
      ExplicitLeft = 373
    end
    inherited tbtnSave: TToolButton
      Left = 381
      Visible = False
      ExplicitLeft = 381
    end
    inherited tbtnCancel: TToolButton
      Left = 451
      Visible = False
      ExplicitLeft = 451
    end
    inherited ToolButton52: TToolButton
      Left = 521
      ExplicitLeft = 521
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 539
      ExplicitLeft = 539
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 557
      Visible = False
      ExplicitLeft = 557
    end
    inherited tbtnInfo: TToolButton
      Left = 565
      ExplicitLeft = 565
    end
    inherited tbtn5: TToolButton
      Left = 635
      ExplicitLeft = 635
    end
    inherited tbtnExcel: TToolButton
      Left = 643
      ExplicitLeft = 643
    end
    inherited tbtnPrinter: TToolButton
      Left = 713
      ExplicitLeft = 713
    end
    inherited tbtn6: TToolButton
      Left = 783
      ExplicitLeft = 783
    end
    inherited tbtnClose: TToolButton
      Left = 791
      ExplicitLeft = 791
    end
  end
  inherited Panel1: TPanel
    Top = 95
    Width = 872
    Height = 341
    ExplicitTop = 95
    ExplicitWidth = 872
    ExplicitHeight = 341
    inherited GroupBox1: TGroupBox
      Width = 872
      Height = 341
      ExplicitWidth = 872
      ExplicitHeight = 341
      inherited dbgrdhResult: TNvDbgridEh
        Width = 868
        Height = 323
        FooterFont.Charset = GB2312_CHARSET
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        TitleFont.Charset = GB2312_CHARSET
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #25805#20316#36710#31449
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'operatorname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25805#20316#20154
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'customer'
            Footers = <>
            Title.Caption = #23458#25143#22995#21517
            Width = 125
          end
          item
            EditButtons = <>
            FieldName = 'feetype'
            Footers = <>
            Title.Caption = #31867#21035
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'fee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37329#39069
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'printtime'
            Footers = <>
            Title.Caption = #25171#21360#26102#38388
            Width = 132
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 158
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 149
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 154
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 176
  end
  inherited ilToolBarDisable: TImageList
    Left = 136
    Top = 176
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'complexfeemap'
    QueryAddress = 'base/queryComplexfee'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_cx!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_cx!operator'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_cx!printtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_cx!printtime'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 216
    Top = 176
  end
  inherited dsResult: TDataSource
    Left = 16
    Top = 176
  end
  object jcdsdel: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/delComplexfee'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'complexfee.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.orgid'
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
    Left = 192
    Top = 280
  end
  object jcdsComplexfeeSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveComplexfee'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'complexfee.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.feetype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.fee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.createby'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'complexfee.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'complexfee.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.customer'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.printtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'complexfee.operator'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptOutput
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
    Left = 344
    Top = 32
  end
end
