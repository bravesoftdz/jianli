inherited FrmTicketsellIncomeRpt: TFrmTicketsellIncomeRpt
  Caption = #21806#31080#33829#25910#25253#34920
  ClientHeight = 468
  ClientWidth = 984
  OnShow = FormShow
  ExplicitWidth = 1000
  ExplicitHeight = 507
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 98
    Width = 984
    Height = 119
    ExplicitTop = 98
    ExplicitWidth = 984
    ExplicitHeight = 119
    object lbl1: TLabel
      Left = 17
      Top = 17
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object lbl6: TLabel
      Left = 276
      Top = 17
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl13: TLabel
      Left = 835
      Top = 57
      Width = 28
      Height = 14
      Caption = #29366#24577
      Visible = False
    end
    object lbl17: TLabel
      Left = 696
      Top = 17
      Width = 28
      Height = 14
      Caption = #31080#21495
      Visible = False
    end
    object lbl2: TLabel
      Left = 17
      Top = 94
      Width = 56
      Height = 14
      Caption = #32479#35745#26041#24335
    end
    object lblBegintimes: TLabel
      Left = 17
      Top = 59
      Width = 56
      Height = 14
      Caption = #21806#31080#26102#38388
    end
    object lblEndtimes: TLabel
      Left = 285
      Top = 56
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 501
      Top = 56
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label2: TLabel
      Left = 678
      Top = 56
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl3: TLabel
      Left = 451
      Top = 17
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 79
      Top = 14
      Width = 154
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      OnCheckClick = nvcbbOrgidCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryallorg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvhelpUserid: TNovaHelp
      Left = 324
      Top = 14
      Width = 102
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
    object nvcbbticketstatus: TNovaComboBox
      Left = 869
      Top = 53
      Width = 124
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
      Visible = False
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
      HelpOptions.TableName = 'ticketsell'
      HelpOptions.Columnname = 'ticketstatus'
      HelpOptions.DisAll = True
    end
    object chkIschangeticket: TCheckBox
      Left = 276
      Top = 94
      Width = 61
      Height = 17
      Caption = #25913#31614#31080
      TabOrder = 3
    end
    object nvedtTicketno: TNovaEdit
      Left = 730
      Top = 6
      Width = 102
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 4
      Visible = False
      ValueType = ssTicket
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
    object sellBegindate: TDateTimePicker
      Left = 79
      Top = 52
      Width = 96
      Height = 22
      Date = 41158.000000000000000000
      Time = 41158.000000000000000000
      TabOrder = 5
      OnChange = sellBegindateChange
    end
    object sellEnddate: TDateTimePicker
      Left = 307
      Top = 52
      Width = 93
      Height = 22
      Date = 41158.000000000000000000
      Time = 41158.000000000000000000
      TabOrder = 6
    end
    object sellEndtime: TDateTimePicker
      Left = 401
      Top = 52
      Width = 72
      Height = 22
      Date = 40553.999305555550000000
      Time = 40553.999305555550000000
      Kind = dtkTime
      TabOrder = 7
    end
    object sellBegintime: TDateTimePicker
      Left = 181
      Top = 53
      Width = 76
      Height = 22
      Date = 40553.000000000000000000
      Time = 40553.000000000000000000
      Kind = dtkTime
      TabOrder = 8
    end
    object reportnum: TNovaComboBox
      Left = 79
      Top = 89
      Width = 154
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 9
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
      HelpOptions.HDataSourceName = 'ticketsellSearchbylist'
      HelpOptions.HQueryAddress = 'report/ticketsellSearchby'
    end
    object departBegindate: TDateTimePicker
      Left = 563
      Top = 53
      Width = 109
      Height = 22
      Date = 41158.000000000000000000
      Time = 41158.000000000000000000
      ShowCheckbox = True
      TabOrder = 10
      OnChange = departBegindateChange
    end
    object departEnddate: TDateTimePicker
      Left = 698
      Top = 53
      Width = 118
      Height = 22
      Date = 41158.000000000000000000
      Time = 41158.000000000000000000
      ShowCheckbox = True
      TabOrder = 11
    end
    object nvcbbTicketoutlets: TNovaCheckedComboBox
      Left = 499
      Top = 17
      Width = 118
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.HelpType = 'TicketoutletsHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'param'
          ParamType = ptInput
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 984
    Height = 98
    ButtonWidth = 91
    ExplicitWidth = 984
    ExplicitHeight = 98
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 91
    end
    inherited tbtn1: TToolButton
      Left = 91
      Enabled = False
      ExplicitLeft = 91
    end
    inherited tbtnInsert: TToolButton
      Left = 99
      Enabled = False
      Visible = False
      ExplicitLeft = 99
      ExplicitWidth = 91
    end
    inherited tbtnEdit: TToolButton
      Left = 190
      Caption = #26597#30475#24223#36864#21333#21495
      ImageIndex = 6
      OnClick = tbtnEditClick
      ExplicitLeft = 190
      ExplicitWidth = 91
    end
    inherited tbtnDelete: TToolButton
      Left = 281
      Enabled = False
      Visible = False
      ExplicitLeft = 281
      ExplicitWidth = 91
    end
    inherited ToolButton50: TToolButton
      Left = 372
      Enabled = False
      ExplicitLeft = 372
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 390
      ExplicitLeft = 390
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 0
      Wrap = True
      Visible = False
      ExplicitLeft = 0
      ExplicitHeight = 53
    end
    inherited tbtnSave: TToolButton
      Left = 0
      Top = 53
      Enabled = False
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 53
      ExplicitWidth = 91
    end
    inherited tbtnCancel: TToolButton
      Left = 91
      Top = 53
      Enabled = False
      Visible = False
      ExplicitLeft = 91
      ExplicitTop = 53
      ExplicitWidth = 91
    end
    inherited ToolButton52: TToolButton
      Left = 182
      Top = 53
      ExplicitLeft = 182
      ExplicitTop = 53
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 200
      Top = 53
      ExplicitLeft = 200
      ExplicitTop = 53
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 218
      Top = 53
      ExplicitLeft = 218
      ExplicitTop = 53
    end
    inherited tbtnInfo: TToolButton
      Left = 226
      Top = 53
      ExplicitLeft = 226
      ExplicitTop = 53
      ExplicitWidth = 91
    end
    inherited tbtn5: TToolButton
      Left = 317
      Top = 53
      ExplicitLeft = 317
      ExplicitTop = 53
    end
    inherited tbtnExcel: TToolButton
      Left = 325
      Top = 53
      ExplicitLeft = 325
      ExplicitTop = 53
      ExplicitWidth = 91
    end
    inherited tbtnPrinter: TToolButton
      Left = 416
      Top = 53
      ExplicitLeft = 416
      ExplicitTop = 53
      ExplicitWidth = 91
    end
    inherited tbtn6: TToolButton
      Left = 507
      Top = 53
      ExplicitLeft = 507
      ExplicitTop = 53
    end
    inherited tbtnClose: TToolButton
      Left = 515
      Top = 53
      ExplicitLeft = 515
      ExplicitTop = 53
      ExplicitWidth = 91
    end
  end
  inherited Panel1: TPanel
    Top = 217
    Width = 984
    Height = 251
    ExplicitTop = 217
    ExplicitWidth = 984
    ExplicitHeight = 251
    inherited GroupBox1: TGroupBox
      Width = 984
      Height = 251
      ExplicitWidth = 984
      ExplicitHeight = 251
      inherited dbgrdhResult: TNvDbgridEh
        Width = 980
        Height = 233
        FooterRowCount = 1
        SumList.Active = True
        UseMultiTitle = True
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'column1'
            Footer.DisplayFormat = #21512#35745
            Footers = <>
            Title.Caption = #24037#21495
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'column2'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'column3'
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 112
          end
          item
            EditButtons = <>
            FieldName = 'totalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#31080#25968
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'nomalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#31080#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'fullpricenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20840#31080
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'halfpricenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21322#31080
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'studentpricenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23398#29983#31080
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'armypricenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20891#31080
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'salepricenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25171#25240#31080
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'freepricenum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20813#31080
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'changetnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25913#31614#25968
            Width = 53
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'nostationfeeamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #19981#21547#31449#21153#36153#33829#25910
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'totalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24635#33829#25910
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'nomalamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #27491#24120#33829#25910
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returnfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#33829#25910
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#25968
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'cancelamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#39069
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#25968
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'privilegereturnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29305#26435#36864#31080#25968
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'returnamount'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080#39069
            Width = 65
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 32
    Top = 280
  end
  inherited ilToolBarDisable: TImageList
    Left = 120
    Top = 272
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'report/queryTicketsellIncome'
    Params = <
      item
        DataType = ftString
        Name = 'sellorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellerid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'returnticketno'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ischangeticket'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reportnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellstartdatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellenddatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellstarttime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'sellendtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletsid'
        ParamType = ptInput
      end>
    Left = 152
    Top = 320
  end
  inherited dsResult: TDataSource
    Left = 56
    Top = 320
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 256
    Top = 288
  end
end
