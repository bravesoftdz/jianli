inherited frmTicketTurnOverOther: TfrmTicketTurnOverOther
  Caption = 'FrmTicketTurnOverOther'
  ClientHeight = 395
  ClientWidth = 837
  ExplicitWidth = 853
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 837
    Height = 60
    ExplicitWidth = 837
    ExplicitHeight = 60
    object lbl4: TLabel
      Left = 243
      Top = 23
      Width = 56
      Height = 14
      Caption = #31080#27454#26085#26399
    end
    object lbl3: TLabel
      Left = 430
      Top = 23
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label3: TLabel
      Left = 38
      Top = 23
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object Label9: TLabel
      Left = 603
      Top = 23
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object dtpstartdate: TDateTimePicker
      Left = 306
      Top = 19
      Width = 111
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 0
    end
    object cbborg: TNovaHComboBox
      Left = 78
      Top = 19
      Width = 137
      Height = 22
      ImeMode = imClose
      TabOrder = 1
      Items.Strings = (
        #21806#31080#28857
        #33258#21161#26426
        #32852#32593)
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
      HelpOptions.HQueryAddress = 'SYSTEM/QRYALLORG'
      HelpOptions.displayFieldname = 'name'
      Params = <>
    end
    object dtpenddate: TDateTimePicker
      Left = 458
      Top = 19
      Width = 111
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 2
    end
    object nvhelpUserid: TNovaHelp
      Left = 653
      Top = 19
      Width = 133
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #20195#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 100
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
  end
  inherited tlbShortCut: TToolBar
    Width = 837
    ExplicitWidth = 837
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #32564#27454
      OnClick = tbtnInsertClick
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
  end
  inherited Panel1: TPanel
    Top = 105
    Width = 837
    Height = 290
    ExplicitTop = 105
    ExplicitWidth = 837
    ExplicitHeight = 290
    inherited GroupBox1: TGroupBox
      Width = 837
      Height = 290
      ExplicitWidth = 837
      ExplicitHeight = 290
      inherited dbgrdhResult: TNvDbgridEh
        Width = 833
        Height = 272
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'tickettime'
            Footers = <>
            Title.Caption = #31080#27454#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'money'
            Footers = <>
            Title.Caption = #32564#27454#37329#39069
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'seller'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #32564#27454#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 100
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 504
    Top = 192
  end
  inherited ilToolBarDisable: TImageList
    Left = 464
    Top = 320
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultList'
    QueryAddress = 'balance/qryTicketTurnOverOther'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_tto!tickettime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_tto!tickettime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u1!id'
        ParamType = ptInput
      end>
    Left = 544
    Top = 248
  end
  inherited dsResult: TDataSource
    Left = 376
    Top = 240
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 632
    Top = 304
  end
end
