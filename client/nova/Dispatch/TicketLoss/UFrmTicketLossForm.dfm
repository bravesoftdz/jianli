inherited FrmTicketLoss: TFrmTicketLoss
  Caption = #36710#31080#25346#22833
  ClientHeight = 469
  ClientWidth = 922
  ExplicitWidth = 938
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 922
    ExplicitWidth = 922
    object Label1: TLabel
      Left = 38
      Top = 22
      Width = 70
      Height = 14
      Caption = #25346#22833#25805#20316#20154
    end
    object lbl4: TLabel
      Left = 266
      Top = 22
      Width = 56
      Height = 14
      Caption = #25346#22833#26085#26399
    end
    object Label2: TLabel
      Left = 471
      Top = 22
      Width = 56
      Height = 14
      Caption = #25346#22833#29366#24577
    end
    object nvhlpLossReporter: TNovaHelp
      Left = 115
      Top = 18
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
    object lossdate: TDateTimePicker
      Left = 330
      Top = 18
      Width = 111
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy/MM/dd'
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 1
    end
    object lossstatus: TNovaComboBox
      Left = 536
      Top = 19
      Width = 114
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 10
      TabOrder = 2
      Items.Strings = (
        '')
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
      HelpOptions.TableName = 'ticketloss'
      HelpOptions.Columnname = 'status'
      HelpOptions.DisAll = True
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 922
    ExplicitWidth = 922
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Caption = #25346#22833
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      Caption = #21462#28040#25346#22833
      OnClick = tbtnEditClick
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
  end
  inherited Panel1: TPanel
    Width = 922
    Height = 366
    ExplicitWidth = 922
    ExplicitHeight = 366
    inherited GroupBox1: TGroupBox
      Width = 922
      Height = 366
      ExplicitWidth = 922
      ExplicitHeight = 366
      inherited dbgrdhResult: TNvDbgridEh
        Width = 918
        Height = 348
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'lossreportername'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25346#22833#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'losstime'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25346#22833#26102#38388
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'status'
            Footers = <>
            Title.Caption = #25346#22833#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#31449
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#31080#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'sellby'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'sellstationname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 144
          end
          item
            EditButtons = <>
            FieldName = 'sellip'
            Footers = <>
            Title.Caption = #21806#31080#30005#33041'IP'
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 184
  end
  inherited ilToolBarDisable: TImageList
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketlosslist'
    QueryAddress = 'dispatch/qryticketloss'
    Params = <
      item
        DataType = ftString
        Name = 'tl.lossby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tl.losstime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tl.status'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 208
  end
  inherited dsResult: TDataSource
    Left = 16
    Top = 176
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 320
    Top = 200
  end
  object jcdsCancelLoss: TjsonClientDataSet
    DataSourceName = 'ticketlosslist'
    QueryAddress = 'dispatch/ticketlosscancel'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tl.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 288
  end
end
