inherited frmTicketChargeoff: TfrmTicketChargeoff
  Caption = #31080#25454#26680#38144
  ClientHeight = 351
  ClientWidth = 853
  KeyPreview = True
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitWidth = 869
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 853
    Height = 84
    ExplicitWidth = 853
    ExplicitHeight = 84
    object lbl1: TLabel
      Left = 268
      Top = 21
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object lbl7: TLabel
      Left = 11
      Top = 59
      Width = 84
      Height = 14
      Caption = #31080#35777#22238#25910#26085#26399
    end
    object lbl2: TLabel
      Left = 39
      Top = 21
      Width = 56
      Height = 14
      Caption = #21806#31080#26426#26500
    end
    object lbl3: TLabel
      Left = 447
      Top = 60
      Width = 56
      Height = 14
      Caption = #26680#38144#31080#21495
    end
    object lbl4: TLabel
      Left = 287
      Top = 59
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lblshow: TLabel
      Left = 642
      Top = 61
      Width = 7
      Height = 14
    end
    object nvhlpUserid: TNovaHelp
      Left = 315
      Top = 21
      Width = 111
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
    object dtpBselldate: TDateTimePicker
      Left = 106
      Top = 56
      Width = 136
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      TabOrder = 1
    end
    object dtpEselldate: TDateTimePicker
      Left = 315
      Top = 56
      Width = 111
      Height = 22
      Date = 40544.999988425930000000
      Time = 40544.999988425930000000
      TabOrder = 2
    end
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 106
      Top = 20
      Width = 136
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'resultmap'
      HelpOptions.HQueryAddress = 'report/queryLocalOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object edtTicketNo: TNovaEdit
      Left = 509
      Top = 51
      Width = 124
      Height = 27
      Hint = #36755#20837#31080#21495#21518#22238#36710#36827#34892#26680#38144
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      MaxLength = 20
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnKeyPress = edtTicketNoKeyPress
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
  end
  inherited tlbShortCut: TToolBar
    Width = 853
    ExplicitWidth = 853
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
      Caption = #26680#38144
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
    Top = 129
    Width = 853
    Height = 222
    ExplicitTop = 129
    ExplicitWidth = 853
    ExplicitHeight = 222
    inherited GroupBox1: TGroupBox
      Width = 853
      Height = 222
      ExplicitWidth = 853
      ExplicitHeight = 222
      inherited dbgrdhResult: TNvDbgridEh
        Width = 849
        Height = 204
        FooterRowCount = 1
        RowHeight = 24
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #21806#31080#26426#26500
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'tickettype'
            Footers = <>
            Title.Caption = #31080#35777#31867#22411
            Width = 70
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'ticketno'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #31080#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'username'
            Footers = <>
            Title.Caption = #21806#31080#21592
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footers = <>
            Title.Caption = #21040#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'actiontime'
            Footers = <>
            Title.Caption = #31080#25454#22238#25910#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'chargestatus'
            Footers = <>
            Title.Caption = #26680#38144#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'chargername'
            Footers = <>
            Title.Caption = #26680#38144#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'chargetime'
            Footers = <>
            Title.Caption = #26680#38144#26102#38388
            Width = 140
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 208
  end
  inherited ilToolBarDisable: TImageList
    Left = 136
    Top = 208
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'bill/queryChargeoff'
    Params = <
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'begindate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'userid'
        ParamType = ptInput
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 296
    Top = 232
  end
  inherited dsResult: TDataSource
    Left = 104
  end
  object jcdsChargeoff: TjsonClientDataSet
    DataSourceName = 'msg'
    QueryAddress = 'bill/saveticketchargeoff'
    SaveAddress = 'bill/saveticketchargeoff'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketchargeoff.sellerid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketchargeoff.ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketchargeoff.retrievetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketchargeoff.tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketchargeoff.chargerby'
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
      end
      item
        DataType = ftString
        Name = 'ticketchargeoff.chargetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketchargeoff.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 528
    Top = 264
  end
end
