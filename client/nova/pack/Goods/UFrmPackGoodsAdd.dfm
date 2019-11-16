inherited FrmPackGoodsAdd: TFrmPackGoodsAdd
  Caption = #23567#20214#23492#23384
  ClientHeight = 405
  ClientWidth = 629
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 635
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 629
    Height = 360
    ExplicitWidth = 629
    ExplicitHeight = 360
    inherited Bevel1: TBevel
      Top = 352
      Width = 595
      ExplicitTop = 461
      ExplicitWidth = 587
    end
    object Label17: TLabel
      Left = 69
      Top = 60
      Width = 56
      Height = 14
      Caption = #20445#31649#29260#21495
    end
    object Label20: TLabel
      Left = 258
      Top = 60
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 325
      Top = 60
      Width = 56
      Height = 14
      Caption = #26053#23458#22995#21517
    end
    object Label23: TLabel
      Left = 566
      Top = 60
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label24: TLabel
      Left = 68
      Top = 106
      Width = 56
      Height = 14
      Caption = #26053#23458#30005#35805
    end
    object Label25: TLabel
      Left = 257
      Top = 106
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 339
      Top = 105
      Width = 42
      Height = 14
      Caption = #36523#20221#35777
    end
    object Label35: TLabel
      Left = 68
      Top = 151
      Width = 56
      Height = 14
      Caption = #23567#20214#31867#21035
    end
    object Label42: TLabel
      Left = 281
      Top = 149
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 353
      Top = 149
      Width = 28
      Height = 14
      Caption = #20214#25968
    end
    object Label26: TLabel
      Left = 68
      Top = 195
      Width = 56
      Height = 14
      Caption = #23384#25918#20301#32622
    end
    object Label6: TLabel
      Left = 40
      Top = 241
      Width = 84
      Height = 14
      Caption = #25552#21462#25130#27490#26085#26399
    end
    object Label15: TLabel
      Left = 257
      Top = 241
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 93
      Top = 288
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object Label2: TLabel
      Left = 339
      Top = 241
      Width = 42
      Height = 14
      Caption = #20445#31649#36153
    end
    object Label3: TLabel
      Left = 468
      Top = 241
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 445
      Top = 149
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 69
      Top = 24
      Width = 56
      Height = 14
      Caption = #23492#23384#21333#21495
      Visible = False
    end
    object Label7: TLabel
      Left = 258
      Top = 24
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label8: TLabel
      Left = 127
      Top = 266
      Width = 336
      Height = 14
      Caption = #23567#20214#23492#23384#22522#26412#22825#25968#65292#36229#36807#25552#21462#25130#27490#26085#26399#26102#23558#25910#21462#28382#32435#37329
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object nvedtnum: TNovaEdit
      Left = 131
      Top = 57
      Width = 121
      Height = 22
      MaxLength = 10
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
    end
    object nvedtcustomer: TNovaEdit
      Left = 387
      Top = 57
      Width = 173
      Height = 22
      MaxLength = 20
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
    end
    object nvedtphone: TNovaEdit
      Left = 130
      Top = 103
      Width = 121
      Height = 22
      MaxLength = 11
      TabOrder = 2
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
    object nvedtidcardno: TNovaEdit
      Left = 387
      Top = 103
      Width = 173
      Height = 22
      MaxLength = 18
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
    end
    object nvcbbgoodstype: TNovaComboBox
      Left = 130
      Top = 147
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 4
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
      HelpOptions.TableName = 'goods'
      HelpOptions.Columnname = 'goodstype'
    end
    object nvedtlocation: TNovaEdit
      Left = 130
      Top = 192
      Width = 227
      Height = 22
      MaxLength = 20
      TabOrder = 5
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
    object dtppickupenddate: TDateTimePicker
      Left = 130
      Top = 238
      Width = 121
      Height = 22
      Date = 41492.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41492.639888414350000000
      TabOrder = 6
      OnChange = dtppickupenddateChange
    end
    object memremarks: TMemo
      Left = 127
      Top = 285
      Width = 254
      Height = 51
      MaxLength = 50
      TabOrder = 7
    end
    object nvedtcustodial: TNovaEdit
      Left = 387
      Top = 238
      Width = 75
      Height = 22
      MaxLength = 7
      TabOrder = 8
      Text = '0'
      ValueTrim = '0'
      ValueType = ssNumber
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
    object nvedtpieces: TNovaEdit
      Left = 387
      Top = 146
      Width = 52
      Height = 22
      MaxLength = 3
      TabOrder = 9
      Text = '1'
      ValueTrim = '1'
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
    object nvedtgoodsno: TNovaEdit
      Left = 131
      Top = 21
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 10
      TabOrder = 10
      Visible = False
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
  inherited pnlOperation: TPanel
    Top = 360
    Width = 629
    ExplicitTop = 360
    ExplicitWidth = 629
    inherited bbtnSave: TBitBtn
      Left = 219
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 219
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 356
      Top = 6
      ExplicitLeft = 356
      ExplicitTop = 6
    end
  end
  object jcdsgoodssave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/saveGoods'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'goods.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.goodsno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.num'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.customer'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.phone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.idcardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.goodstype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.pieces'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.location'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.pickupenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.deposittiime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.custodial'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.penalty'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.totalfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.pickuper'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.pickupdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.operator'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.remak'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'goods.createtime'
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
      end
      item
        DataType = ftInteger
        Name = 'goodsid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 68
    Top = 296
  end
  object jcdsupdateBillinuse: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/updateBillinuse'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'billinusestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinusenextno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billtypecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinusenextform'
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
    Left = 476
    Top = 280
  end
end
