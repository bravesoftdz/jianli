inherited FrmGoodsReceive: TFrmGoodsReceive
  Caption = #39046#21462#23567#20214#23492#23384
  ClientHeight = 445
  ClientWidth = 710
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 716
  ExplicitHeight = 470
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 710
    Height = 400
    ExplicitWidth = 710
    ExplicitHeight = 400
    inherited Bevel1: TBevel
      Top = 392
      Width = 676
      ExplicitTop = 461
      ExplicitWidth = 676
    end
    object Label17: TLabel
      Left = 379
      Top = 18
      Width = 56
      Height = 14
      Caption = #20445#31649#29260#21495
    end
    object Label22: TLabel
      Left = 81
      Top = 61
      Width = 56
      Height = 14
      Caption = #26053#23458#22995#21517
    end
    object Label24: TLabel
      Left = 379
      Top = 61
      Width = 56
      Height = 14
      Caption = #26053#23458#30005#35805
    end
    object Label27: TLabel
      Left = 95
      Top = 106
      Width = 42
      Height = 14
      Caption = #36523#20221#35777
    end
    object Label35: TLabel
      Left = 379
      Top = 106
      Width = 56
      Height = 14
      Caption = #23567#20214#31867#21035
    end
    object Label1: TLabel
      Left = 109
      Top = 150
      Width = 28
      Height = 14
      Caption = #20214#25968
    end
    object Label26: TLabel
      Left = 379
      Top = 150
      Width = 56
      Height = 14
      Caption = #23384#25918#20301#32622
    end
    object Label6: TLabel
      Left = 53
      Top = 198
      Width = 84
      Height = 14
      Caption = #25552#21462#25130#27490#26085#26399
    end
    object Label11: TLabel
      Left = 109
      Top = 334
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object Label2: TLabel
      Left = 95
      Top = 243
      Width = 42
      Height = 14
      Caption = #20445#31649#36153
    end
    object Label5: TLabel
      Left = 81
      Top = 18
      Width = 56
      Height = 14
      Caption = #23492#23384#21333#21495
    end
    object Label7: TLabel
      Left = 270
      Top = 18
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
    object Label3: TLabel
      Left = 379
      Top = 198
      Width = 56
      Height = 14
      Caption = #25552#21462#26085#26399
    end
    object Label4: TLabel
      Left = 393
      Top = 243
      Width = 42
      Height = 14
      Caption = #28382#32435#37329
    end
    object Label8: TLabel
      Left = 81
      Top = 288
      Width = 56
      Height = 14
      Caption = #21512#35745#37329#39069
    end
    object Label9: TLabel
      Left = 393
      Top = 288
      Width = 42
      Height = 14
      Caption = #25552#39046#20154
    end
    object Label15: TLabel
      Left = 568
      Top = 288
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
    object nvedtnum: TNovaEdit
      Tag = 1
      Left = 441
      Top = 15
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 10
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
    object nvedtcustomer: TNovaEdit
      Tag = 2
      Left = 143
      Top = 58
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 10
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
    end
    object nvedtphone: TNovaEdit
      Tag = 3
      Left = 441
      Top = 58
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 11
      TabOrder = 5
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
      Left = 143
      Top = 103
      Width = 173
      Height = 22
      Enabled = False
      MaxLength = 22
      TabOrder = 6
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
      Left = 441
      Top = 103
      Width = 145
      Height = 22
      Enabled = False
      ImeMode = imClose
      TabOrder = 7
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
      Left = 441
      Top = 147
      Width = 227
      Height = 22
      Enabled = False
      MaxLength = 10
      TabOrder = 9
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
      Left = 143
      Top = 196
      Width = 121
      Height = 22
      Date = 41492.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41492.639888414350000000
      Enabled = False
      TabOrder = 10
    end
    object memremarks: TMemo
      Left = 143
      Top = 331
      Width = 303
      Height = 53
      MaxLength = 25
      TabOrder = 2
    end
    object nvedtcustodial: TNovaEdit
      Left = 143
      Top = 240
      Width = 75
      Height = 22
      Enabled = False
      MaxLength = 7
      TabOrder = 12
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
      Left = 143
      Top = 147
      Width = 52
      Height = 22
      Enabled = False
      MaxLength = 3
      TabOrder = 8
      Text = '0'
      ValueTrim = '0'
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
      Left = 16
      Top = 33
      Width = 121
      Height = 22
      MaxLength = 10
      TabOrder = 0
      Visible = False
      OnKeyPress = nvedtgoodsnoKeyPress
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
    object dtppickupdate: TDateTimePicker
      Left = 441
      Top = 196
      Width = 121
      Height = 22
      Date = 41492.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41492.639888414350000000
      Enabled = False
      TabOrder = 11
    end
    object nvedtpenalty: TNovaEdit
      Left = 441
      Top = 240
      Width = 75
      Height = 22
      Enabled = False
      MaxLength = 7
      TabOrder = 13
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
    object nvedttotalfee: TNovaEdit
      Left = 143
      Top = 285
      Width = 75
      Height = 22
      Enabled = False
      MaxLength = 7
      TabOrder = 14
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
    object nvedtpickuper: TNovaEdit
      Left = 441
      Top = 285
      Width = 121
      Height = 22
      MaxLength = 10
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
    object nvhelpgoodsno: TNovaHelp
      Left = 143
      Top = 15
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 15
      OnClick = nvhelpgoodsnoClick
      OnIdChange = nvhelpgoodsnoIdChange
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
          Title.Caption = #21333#21495
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #20445#31649#29260#21495
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'customer'
          Title.Caption = #26053#23458#22995#21517
          Width = -1
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'idcardno'
          Title.Caption = #35777#20214#21495
          Width = 130
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 330
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'goodsnomap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'pack/queryGgoodsno'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_g!orgid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_EQS_g!status'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 400
    Width = 710
    ExplicitTop = 400
    ExplicitWidth = 710
    inherited bbtnSave: TBitBtn
      Left = 259
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 259
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 396
      Top = 6
      ExplicitLeft = 396
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 624
    Top = 392
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
    Left = 508
    Top = 328
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
    Left = 628
    Top = 280
  end
  object jcdsQueryGoods: TjsonClientDataSet
    DataSourceName = 'goodslist'
    QueryAddress = 'pack/listGoods'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_g!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_g!goodsno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_g!status'
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
    Left = 48
    Top = 312
    object jcdsQueryGoodsid: TLargeintField
      FieldName = 'id'
    end
    object jcdsQueryGoodsgoodsno: TWideStringField
      FieldName = 'goodsno'
      Size = 0
    end
    object jcdsQueryGoodsnum: TWideStringField
      FieldName = 'num'
      Size = 0
    end
    object jcdsQueryGoodscustomer: TWideStringField
      FieldName = 'customer'
      Size = 0
    end
    object jcdsQueryGoodsphone: TWideStringField
      FieldName = 'phone'
      Size = 0
    end
    object jcdsQueryGoodsidcardno: TWideStringField
      FieldName = 'idcardno'
      Size = 0
    end
    object jcdsQueryGoodsGOODSTYPE: TWideStringField
      FieldName = 'GOODSTYPE'
      Size = 0
    end
    object jcdsQueryGoodspieces: TIntegerField
      FieldName = 'pieces'
    end
    object jcdsQueryGoodslocation: TWideStringField
      FieldName = 'location'
      Size = 0
    end
    object jcdsQueryGoodspickupenddate: TDateTimeField
      FieldName = 'pickupenddate'
    end
    object jcdsQueryGoodsdeposittiime: TDateTimeField
      FieldName = 'deposittiime'
    end
    object jcdsQueryGoodscustodial: TFloatField
      FieldName = 'custodial'
    end
    object jcdsQueryGoodspenalty: TFloatField
      FieldName = 'penalty'
    end
    object jcdsQueryGoodstotalfee: TFloatField
      FieldName = 'totalfee'
    end
    object jcdsQueryGoodsconsignee: TLargeintField
      FieldName = 'consignee'
    end
    object jcdsQueryGoodsconsigneename: TWideStringField
      FieldName = 'consigneename'
      Size = 0
    end
    object jcdsQueryGoodsSTATUS: TWideStringField
      FieldName = 'STATUS'
      Size = 0
    end
    object jcdsQueryGoodspickuper: TWideStringField
      FieldName = 'pickuper'
      Size = 0
    end
    object jcdsQueryGoodspickupdate: TDateTimeField
      FieldName = 'pickupdate'
    end
    object jcdsQueryGoodsoperator: TLargeintField
      FieldName = 'operator'
    end
    object jcdsQueryGoodsoperatorname: TWideStringField
      FieldName = 'operatorname'
      Size = 0
    end
    object jcdsQueryGoodsremak: TWideStringField
      FieldName = 'remak'
      Size = 0
    end
    object jcdsQueryGoodsORGID: TLargeintField
      FieldName = 'ORGID'
    end
    object jcdsQueryGoodsorgname: TWideStringField
      FieldName = 'orgname'
      Size = 0
    end
    object jcdsQueryGoodscreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsQueryGoodscreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsQueryGoodsupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsQueryGoodsupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsQueryGoodscreatebyname: TWideStringField
      FieldName = 'createbyname'
      Size = 0
    end
    object jcdsQueryGoodsupdatebyname: TWideStringField
      FieldName = 'updatebyname'
      Size = 0
    end
  end
end
