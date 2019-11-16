inherited FrmSellerTaskReport: TFrmSellerTaskReport
  Caption = #21806#31080#21592#20219#21153#34920
  ClientHeight = 417
  ClientWidth = 818
  ExplicitWidth = 834
  ExplicitHeight = 455
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 818
    ExplicitWidth = 818
    object lbl6: TLabel
      Left = 19
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbldate: TLabel
      Left = 234
      Top = 22
      Width = 56
      Height = 14
      Caption = #21806#31080#26085#26399
    end
    object lbl1: TLabel
      Left = 432
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 583
      Top = 22
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object NovaHCbbOrg: TNovaHComboBox
      Left = 81
      Top = 19
      Width = 137
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
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
      HelpOptions.HDataSourceName = 'list'
      HelpOptions.HQueryAddress = 'dispatch/qryCurOrg'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object dtpstartdate: TDateTimePicker
      Left = 298
      Top = 20
      Width = 123
      Height = 22
      Date = 40640.000000000000000000
      Time = 40640.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 460
      Top = 20
      Width = 110
      Height = 22
      Date = 40640.999988425930000000
      Time = 40640.999988425930000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object nvhelpUserid: TNovaHelp
      Left = 633
      Top = 19
      Width = 127
      Height = 22
      CharCase = ecUpperCase
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
  end
  inherited tlbShortCut: TToolBar
    Width = 818
    ExplicitWidth = 818
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
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
  end
  inherited Panel1: TPanel
    Width = 818
    Height = 314
    ExplicitWidth = 818
    ExplicitHeight = 314
    inherited GroupBox1: TGroupBox
      Width = 818
      Height = 314
      ExplicitWidth = 818
      ExplicitHeight = 314
      inherited dbgrdhResult: TNvDbgridEh
        Width = 814
        Height = 296
        FooterRowCount = 1
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'seller'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #21806#31080#21592
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'soldnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #21806#31080#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'soldmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #21806#31080#37329#39069
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'returnnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36864#31080#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'returnmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36864#31080#37329#39069
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'cancelnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #24223#31080#25968
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'canclemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #24223#31080#37329#39069
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'totalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20154#25968#21512#35745
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'totalmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #37329#39069#21512#35745
            Width = 90
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 112
    Top = 200
  end
  inherited ilToolBarDisable: TImageList
    Left = 184
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'query/sellerTaskReport'
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_ts!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ts!sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GTD_ts!selltime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LTD_ts!selltime'
        ParamType = ptInput
      end>
    Left = 264
    Top = 200
  end
  inherited dsResult: TDataSource
    Top = 152
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 368
    Top = 200
  end
end
