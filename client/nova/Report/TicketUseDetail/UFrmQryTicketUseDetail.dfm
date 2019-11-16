inherited FrmQryTicketUseDetail: TFrmQryTicketUseDetail
  Caption = 'FrmQryTicketUseDetail'
  ClientHeight = 428
  ClientWidth = 1026
  ExplicitWidth = 1042
  ExplicitHeight = 467
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1026
    Height = 94
    ExplicitWidth = 1026
    ExplicitHeight = 94
    object lbl3: TLabel
      Left = 465
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl4: TLabel
      Left = 271
      Top = 21
      Width = 56
      Height = 14
      Caption = #20351#29992#26085#26399
    end
    object lbl1: TLabel
      Left = 27
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 243
      Top = 59
      Width = 84
      Height = 14
      Caption = #31080#35777#20351#29992#31867#22411
    end
    object Label2: TLabel
      Left = 27
      Top = 59
      Width = 56
      Height = 14
      Caption = #31080#35777#31867#22411
    end
    object dtpstartdate: TDateTimePicker
      Left = 341
      Top = 18
      Width = 111
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 0
    end
    object dtpenddate: TDateTimePicker
      Left = 493
      Top = 18
      Width = 111
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 1
    end
    object nvckbOrgid: TNovaCheckedComboBox
      Left = 90
      Top = 18
      Width = 136
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbtickettype: TNovaComboBox
      Left = 90
      Top = 56
      Width = 136
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 3
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        ' 8 '#20301#36710#31080#31080#35777
        '12'#20301#36710#31080#31080#35777)
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
    end
    object nvcbticketusetype: TNovaComboBox
      Left = 341
      Top = 56
      Width = 136
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ItemIndex = 0
      TabOrder = 4
      Text = #20840#37096
      Items.Strings = (
        #20840#37096
        #21806#20986
        #36864#31080#20973#35777
        #20316#24223
        #25439#27585
        #25346#22833)
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1026
    ExplicitWidth = 1026
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
    Top = 139
    Width = 1026
    Height = 289
    ExplicitTop = 139
    ExplicitWidth = 1026
    ExplicitHeight = 289
    inherited GroupBox1: TGroupBox
      Width = 1026
      Height = 289
      ExplicitWidth = 1026
      ExplicitHeight = 289
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1022
        Height = 271
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'tickettype'
            Footer.Value = #21512#35745':'
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #31080#35777#31867#22411
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'usenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#35777#20351#29992#25968#37327
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketstartno'
            Footers = <>
            Title.Caption = #36215#22987#31080#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketendno'
            Footers = <>
            Title.Caption = #32467#26463#31080#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketusetype'
            Footers = <>
            Title.Caption = #31080#35777#20351#29992#31867#22411
            Width = 100
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 288
    Top = 336
  end
  inherited ilToolBarDisable: TImageList
    Left = 288
    Top = 336
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/qryticketusedetail'
    Params = <
      item
        DataType = ftString
        Name = 'orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketusetype'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 584
    Top = 304
  end
  inherited dsResult: TDataSource
    Left = 432
    Top = 320
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 744
    Top = 328
  end
end
