inherited FrmTicketPriceFormulaEdt: TFrmTicketPriceFormulaEdt
  Caption = 'FrmTicketPriceFormulaEdt'
  ClientHeight = 398
  ClientWidth = 549
  OnShow = FormShow
  ExplicitWidth = 555
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 549
    Height = 353
    ExplicitWidth = 549
    ExplicitHeight = 353
    inherited Bevel1: TBevel
      Top = 345
      Width = 515
      ExplicitTop = 338
      ExplicitWidth = 515
    end
    object Label1: TLabel
      Left = 80
      Top = 67
      Width = 28
      Height = 14
      Caption = #31080#31181
    end
    object Label2: TLabel
      Left = 52
      Top = 111
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object Label3: TLabel
      Left = 52
      Top = 156
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object Label4: TLabel
      Left = 80
      Top = 232
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object Label5: TLabel
      Left = 80
      Top = 194
      Width = 28
      Height = 14
      Caption = #20844#24335
    end
    object Label11: TLabel
      Left = 272
      Top = 64
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 272
      Top = 109
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 272
      Top = 154
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 478
      Top = 192
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object labIsFullType: TLabel
      Left = 304
      Top = 66
      Width = 119
      Height = 14
      Caption = #20840#31080#31080#31181#65288'Q'#34920#31034#65289
    end
    object Label9: TLabel
      Left = 84
      Top = 31
      Width = 28
      Height = 14
      Caption = #26426#26500
    end
    object Label10: TLabel
      Left = 301
      Top = 25
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object NovaHCbbTicketType: TNovaHComboBox
      Left = 121
      Top = 63
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = NovaHCbbTicketTypeChange
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketTypeSHelp'
        end>
    end
    object DateTpFromDate: TDateTimePicker
      Left = 121
      Top = 107
      Width = 145
      Height = 22
      Date = 40614.716442233800000000
      Time = 40614.716442233800000000
      TabOrder = 1
    end
    object DateTpEndDate: TDateTimePicker
      Left = 121
      Top = 152
      Width = 145
      Height = 22
      Date = 40614.716442233800000000
      Time = 40614.716442233800000000
      TabOrder = 2
    end
    object MeRemark: TMemo
      Left = 121
      Top = 229
      Width = 351
      Height = 76
      MaxLength = 100
      TabOrder = 3
    end
    object NovaEdtFormula: TNovaEdit
      Left = 121
      Top = 191
      Width = 351
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 4
      OnKeyPress = NovaEdtFormulaKeyPress
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
    object NovaHCbbOrg: TNovaHComboBox
      Left = 121
      Top = 24
      Width = 170
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 5
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
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 353
    Width = 549
    ExplicitTop = 353
    ExplicitWidth = 549
    inherited bbtnSave: TBitBtn
      Left = 167
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 167
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 304
      Top = 6
      ExplicitLeft = 304
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 440
  end
  object jcdsSaveFormula: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveformula'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketpriceformula.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformula.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformula.tickettypeid'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ticketpriceformula.isdefault'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'ticketpriceformula.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'ticketpriceformula.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformula.formula'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformula.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformula.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketpriceformula.createtime'
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
    Left = 352
    Top = 88
  end
end
