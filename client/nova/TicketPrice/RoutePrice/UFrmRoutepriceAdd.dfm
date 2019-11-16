inherited FrmRoutepriceAdd: TFrmRoutepriceAdd
  Caption = 'FrmRoutepriceAdd'
  ClientHeight = 366
  ClientWidth = 422
  Position = poScreenCenter
  OnShow = FormShow
  ExplicitWidth = 428
  ExplicitHeight = 394
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 422
    Height = 321
    ExplicitWidth = 422
    ExplicitHeight = 321
    inherited Bevel1: TBevel
      Top = 313
      Width = 388
      ExplicitTop = 239
      ExplicitWidth = 370
    end
    object lbl1: TLabel
      Left = 75
      Top = 69
      Width = 42
      Height = 14
      Caption = #20572#38752#31449
    end
    object lbl2: TLabel
      Left = 89
      Top = 111
      Width = 28
      Height = 14
      Caption = #31080#20215
    end
    object lbl3: TLabel
      Left = 282
      Top = 69
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 228
      Top = 111
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 75
      Top = 27
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object lbl6: TLabel
      Left = 282
      Top = 25
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 61
      Top = 151
      Width = 56
      Height = 14
      Caption = #32467#31639#31080#20215
    end
    object lbl8: TLabel
      Left = 228
      Top = 151
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 58
      Top = 228
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object Label4: TLabel
      Left = 58
      Top = 268
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object NovaEdtFullprice: TNovaEdit
      Left = 122
      Top = 108
      Width = 100
      Height = 22
      MaxLength = 50
      TabOrder = 0
      Text = '0'
      OnChange = NovaEdtFullpriceChange
      ValueTrim = '0'
      ValueType = ssDouble
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
    object NovaEdtBalancePrice: TNovaEdit
      Left = 122
      Top = 148
      Width = 100
      Height = 22
      MaxLength = 50
      TabOrder = 1
      Text = '0'
      ValueTrim = '0'
      ValueType = ssDouble
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
    object NovaChOrgStation: TNovaHComboBox
      Left = 123
      Top = 22
      Width = 145
      Height = 22
      ImeMode = imClose
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
      HelpOptions.HDataSourceName = 'results'
      HelpOptions.HQueryAddress = 'ticketprice/qryRoutestops'
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
    object NcbbReach: TNovaHComboBox
      Left = 123
      Top = 66
      Width = 145
      Height = 22
      ImeMode = imClose
      TabOrder = 3
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
      HelpOptions.HDataSourceName = 'results'
      HelpOptions.HQueryAddress = 'ticketprice/qryRoutestops'
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
    object ChkISbase: TCheckBox
      Left = 122
      Top = 189
      Width = 97
      Height = 17
      Caption = #22522#30784#31080#20215
      TabOrder = 4
      OnClick = ChkISbaseClick
    end
    object DpFromDate: TDateTimePicker
      Left = 123
      Top = 224
      Width = 106
      Height = 22
      Date = 41993.634841932870000000
      Time = 41993.634841932870000000
      TabOrder = 5
    end
    object DpEndDate: TDateTimePicker
      Left = 123
      Top = 264
      Width = 106
      Height = 22
      Date = 41993.634841932870000000
      Time = 41993.634841932870000000
      TabOrder = 6
    end
  end
  inherited pnlOperation: TPanel
    Top = 321
    Width = 422
    ExplicitTop = 321
    ExplicitWidth = 422
    inherited bbtnSave: TBitBtn
      Left = 103
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 103
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 456
    Top = 256
  end
  object jscdSavesRouteprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/addRoutePrice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'routeprice.price'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.balanceprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.routeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.fromstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.isbaseprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.fromdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'routeprice.todate'
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
        DataType = ftBCD
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 128
  end
end
