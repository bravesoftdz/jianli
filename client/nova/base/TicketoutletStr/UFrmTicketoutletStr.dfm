inherited FrmTicketoutletStr: TFrmTicketoutletStr
  Caption = 'FrmTicketoutletStr'
  ClientHeight = 0
  ClientWidth = 116
  ExplicitWidth = 132
  ExplicitHeight = 38
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 490
    Width = 116
    Height = 52
    ExplicitTop = 490
    ExplicitWidth = 116
    ExplicitHeight = 52
    object lblticketoutlet: TLabel
      Left = 24
      Top = 21
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object nvhlpticketoutlet: TNovaHelp
      Left = 70
      Top = 17
      Width = 121
      Height = 22
      CharCase = ecUpperCase
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
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 116
    Height = 490
    ExplicitWidth = 116
    ExplicitHeight = 490
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Left = 0
      Wrap = True
      ExplicitLeft = 0
      ExplicitHeight = 53
    end
    inherited tbtnInsert: TToolButton
      Left = 0
      Top = 53
      Wrap = True
      OnClick = tbtnInsertClick
      ExplicitLeft = 0
      ExplicitTop = 53
    end
    inherited tbtnEdit: TToolButton
      Left = 0
      Top = 98
      Wrap = True
      OnClick = tbtnEditClick
      ExplicitLeft = 0
      ExplicitTop = 98
    end
    inherited tbtnDelete: TToolButton
      Left = 0
      Top = 143
      OnClick = tbtnDeleteClick
      ExplicitLeft = 0
      ExplicitTop = 143
    end
    inherited ToolButton50: TToolButton
      Left = 70
      Top = 143
      ExplicitLeft = 70
      ExplicitTop = 143
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 88
      Top = 143
      ExplicitLeft = 88
      ExplicitTop = 143
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 0
      Top = 143
      Wrap = True
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 143
      ExplicitHeight = 53
    end
    inherited tbtnSave: TToolButton
      Left = 0
      Top = 196
      Wrap = True
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 196
    end
    inherited tbtnCancel: TToolButton
      Left = 0
      Top = 241
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 241
    end
    inherited ToolButton52: TToolButton
      Left = 70
      Top = 241
      ExplicitLeft = 70
      ExplicitTop = 241
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 88
      Top = 241
      ExplicitLeft = 88
      ExplicitTop = 241
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 0
      Top = 241
      Wrap = True
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 241
      ExplicitHeight = 53
    end
    inherited tbtnInfo: TToolButton
      Left = 0
      Top = 294
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 294
    end
    inherited tbtn5: TToolButton
      Left = 0
      Top = 294
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 294
      ExplicitHeight = 53
    end
    inherited tbtnExcel: TToolButton
      Left = 0
      Top = 347
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 347
    end
    inherited tbtnPrinter: TToolButton
      Left = 0
      Top = 392
      ExplicitLeft = 0
      ExplicitTop = 392
    end
    inherited tbtn6: TToolButton
      Left = 0
      Top = 392
      Wrap = True
      ExplicitLeft = 0
      ExplicitTop = 392
      ExplicitHeight = 53
    end
    inherited tbtnClose: TToolButton
      Left = 0
      Top = 445
      ExplicitLeft = 0
      ExplicitTop = 445
    end
  end
  inherited Panel1: TPanel
    Top = 542
    Width = 116
    Height = 329
    ExplicitTop = 542
    ExplicitWidth = 116
    ExplicitHeight = 310
    inherited GroupBox1: TGroupBox
      Width = 907
      Height = 329
      ExplicitWidth = 116
      ExplicitHeight = 310
      inherited dbgrdhResult: TNvDbgridEh
        Width = 903
        Height = 311
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ticketoutletsname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 160
          end
          item
            EditButtons = <>
            FieldName = 'carrychildrate'
            Footers = <>
            Title.Caption = #20813#31080#20799#31461#27604#20363
            Width = 147
          end
          item
            EditButtons = <>
            FieldName = 'maxsellmoney'
            Footers = <>
            Title.Caption = #26368#22823#21806#31080#37329#39069
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 99
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 107
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 107
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 48
    Top = 216
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 240
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketoutletsctrmap'
    QueryAddress = 'base/queryTicketoutletsctr'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_tc!ticketoutletsid'
        ParamType = ptInput
      end>
    Left = 208
    Top = 208
  end
  inherited dsResult: TDataSource
    Left = 112
    Top = 192
  end
  object jsnclntdtstdelticketoutletsctr: TjsonClientDataSet
    DataSourceName = 'ticketoutletsctrmap'
    QueryAddress = 'base/delTicketoutletsctr'
    SaveAddress = 'base/delTicketoutletsctr'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketoutletctr.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 256
  end
end
