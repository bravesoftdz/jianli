inherited frmQuerySpecialOrderInfo: TfrmQuerySpecialOrderInfo
  Caption = #29305#27530#35746#21333#36864#27454#26126#32454
  ClientHeight = 404
  ClientWidth = 885
  ExplicitWidth = 901
  ExplicitHeight = 443
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 885
    Height = 68
    ExplicitWidth = 885
    ExplicitHeight = 68
    object lbl1: TLabel
      Left = 21
      Top = 15
      Width = 56
      Height = 14
      Caption = #20195#21806#26426#26500
    end
    object lbl17: TLabel
      Left = 31
      Top = 47
      Width = 42
      Height = 14
      Caption = #35746#21333#21495
    end
    object lbl2: TLabel
      Left = 253
      Top = 15
      Width = 56
      Height = 14
      Caption = #36864#31080#26085#26399
    end
    object lbl7: TLabel
      Left = 253
      Top = 47
      Width = 56
      Height = 14
      Caption = #35746#31080#26085#26399
    end
    object lbl3: TLabel
      Left = 457
      Top = 15
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl14: TLabel
      Left = 457
      Top = 47
      Width = 14
      Height = 14
      Caption = #33267
    end
    object cbbOrgid: TNovaCheckedComboBox
      Left = 85
      Top = 12
      Width = 155
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
    object edtTicketno: TNovaEdit
      Left = 85
      Top = 44
      Width = 155
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
    end
    object dtpstartdate: TDateTimePicker
      Left = 317
      Top = 12
      Width = 127
      Height = 22
      Date = 40716.000000000000000000
      Time = 40716.000000000000000000
      ShowCheckbox = True
      TabOrder = 2
      OnChange = dtpstartdateChange
    end
    object dtpBselldate: TDateTimePicker
      Left = 317
      Top = 44
      Width = 127
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      ShowCheckbox = True
      TabOrder = 3
      OnChange = dtpBselldateChange
    end
    object dtpenddate: TDateTimePicker
      Left = 484
      Top = 12
      Width = 116
      Height = 22
      Date = 40716.999988425930000000
      Time = 40716.999988425930000000
      ShowCheckbox = True
      TabOrder = 4
      OnChange = dtpenddateChange
    end
    object dtpEselldate: TDateTimePicker
      Left = 484
      Top = 44
      Width = 116
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      ShowCheckbox = True
      TabOrder = 5
      OnChange = dtpEselldateChange
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 885
    ExplicitWidth = 885
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
  end
  inherited Panel1: TPanel
    Top = 113
    Width = 885
    Height = 291
    ExplicitTop = 113
    ExplicitWidth = 885
    ExplicitHeight = 291
    inherited GroupBox1: TGroupBox
      Width = 885
      Height = 291
      ExplicitWidth = 885
      ExplicitHeight = 291
      inherited dbgrdhResult: TNvDbgridEh
        Width = 881
        Height = 273
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #20195#21806#26426#26500
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #35746#21333#21495
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'insurefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20445#38505#36153
            Width = 87
          end
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #36710#31080#29366#24577
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'returnfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#36153
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'returncause'
            Footers = <>
            Title.Caption = #36864#31080#21407#22240
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'returnperson'
            Footers = <>
            Title.Caption = #36864#31080#20154
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'returntime'
            Footers = <>
            Title.Caption = #36864#31080#26102#38388
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'remark'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 90
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 264
  end
  inherited ilToolBarDisable: TImageList
    Left = 152
    Top = 280
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/querySpecialOrderInfo'
    Params = <
      item
        DataType = ftUnknown
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_GED_so!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_GED_so!createtime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_EQS_t!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_LED_so!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_LED_so!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_LED_so!createtime'
        ParamType = ptUnknown
      end>
    Left = 280
    Top = 224
  end
  inherited dsResult: TDataSource
    DataSet = qry1
    Top = 280
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 352
    Top = 312
  end
  object qry1: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/querySpecialOrderInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_GED_so!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_LED_so!returntime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_GED_so!createtime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_LED_so!createtime'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'filter_EQS_so!orderno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 232
  end
end
