inherited FrmTicketturnoverRevenue: TFrmTicketturnoverRevenue
  Caption = 'UFrmTicketturnoverRevenue'
  ClientHeight = 515
  ClientWidth = 1004
  ExplicitWidth = 1020
  ExplicitHeight = 553
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1004
    ExplicitWidth = 1004
    object lbl4: TLabel
      Left = 19
      Top = 23
      Width = 56
      Height = 14
      Caption = #31080#27454#26085#26399
    end
    object lbl5: TLabel
      Left = 375
      Top = 22
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object Label1: TLabel
      Left = 598
      Top = 22
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object lbl3: TLabel
      Left = 211
      Top = 23
      Width = 14
      Height = 14
      Caption = #33267
    end
    object dtpstartdate: TDateTimePicker
      Left = 81
      Top = 19
      Width = 111
      Height = 22
      Date = 42021.639888414350000000
      Time = 42021.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object cbbuser: TNovaCheckedComboBox
      Left = 427
      Top = 19
      Width = 137
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'SellTicketUserHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'UserHelp'
        end>
    end
    object NovaBillType: TNovaHComboBox
      Left = 666
      Top = 19
      Width = 145
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.HDataSourceName = 'billtypemap'
      HelpOptions.HQueryAddress = 'bill/queryUsableBillType'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'routeid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'isdepart'
          ParamType = ptInput
        end>
    end
    object dtpenddate: TDateTimePicker
      Left = 238
      Top = 19
      Width = 111
      Height = 22
      Date = 42021.639888414350000000
      Time = 42021.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
    end
    object nvhlpseller: TNovaHelp
      Left = 423
      Top = 19
      Width = 135
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 4
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
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1004
    ExplicitWidth = 1004
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
    Width = 1004
    Height = 412
    ExplicitWidth = 1004
    ExplicitHeight = 412
    inherited GroupBox1: TGroupBox
      Width = 1004
      Height = 412
      ExplicitWidth = 1004
      ExplicitHeight = 412
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1000
        Height = 394
        ColumnDefValues.Layout = tlCenter
        FooterRowCount = 1
        RowHeight = 25
        SumList.Active = True
        UseMultiTitle = True
        PrintInfo.PaperSize = A4
        PrintInfo.PrinterOrientation = poLandscape
        PrintInfo.PageWidth = 210.000000000000000000
        PrintInfo.PageHeight = 297.000000000000000000
        PrintOptions = [pghFitGridToPageWidth, pghColored]
        Columns = <
          item
            Alignment = taCenter
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'code'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #24037#21495
            Width = 60
          end
          item
            AutoFitColWidth = False
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Caption = #22995#21517
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'ticketnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #29992#31080
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'sellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33829#25910'||'#20154#25968
            Width = 60
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'sellmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #33829#25910'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080'||'#20154#25968
            Width = 60
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'returnmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36864#31080'||'#37329#39069
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24223#31080#25968
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'handcharge'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25163#32493#36153
            Width = 60
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'changeservicefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #25913#31614
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'realsellnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#21806'|'#20154#25968
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'nonvouchermoneypayable'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#21806'|'#37329#39069'|'#20854#20013#38134#34892#21345
            Width = 90
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'revenuemoneypayable'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#21806'|'#37329#39069'|'#24635#37329#39069
            Width = 60
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'strike'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20914#36134
            Width = 60
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'moneypayable'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#32564#39069
            Width = 65
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'money'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23454#32564#39069
            Width = 60
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'longlost'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24046#38169'|'#38271#27454
            Width = 65
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'shortlost'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24046#38169'|'#30701#27454
            Width = 65
          end
          item
            DisplayFormat = '#0.0'
            EditButtons = <>
            FieldName = 'balance'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20313#39069
            Width = 65
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 168
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketturnoverMap'
    QueryAddress = 'sell/queryRevenueOfDay'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_tt!userid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_tt!moneydate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billtypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_tt!moneydate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
  end
  inherited dsResult: TDataSource
    Left = 152
    Top = 208
  end
end
