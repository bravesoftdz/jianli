inherited FrmPackreturnback: TFrmPackreturnback
  Caption = #34892#21253#36864#31080
  ExplicitWidth = 443
  ExplicitHeight = 354
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    object Label1: TLabel
      Left = 114
      Top = 225
      Width = 42
      Height = 14
      Caption = #25163#32493#36153
    end
    object Label17: TLabel
      Left = 114
      Top = 69
      Width = 42
      Height = 14
      Caption = #21463#29702#20154
    end
    object Label6: TLabel
      Left = 100
      Top = 31
      Width = 56
      Height = 14
      Caption = #21463#29702#26085#26399
    end
    object Label29: TLabel
      Left = 128
      Top = 108
      Width = 28
      Height = 14
      Caption = #21333#21495
    end
    object Label2: TLabel
      Left = 114
      Top = 147
      Width = 42
      Height = 14
      Caption = #30446#30340#22320
    end
    object Label51: TLabel
      Left = 100
      Top = 186
      Width = 56
      Height = 14
      Caption = #21512#35745#37329#39069
    end
    object nvedtfee: TNovaEdit
      Left = 184
      Top = 222
      Width = 121
      Height = 22
      MaxLength = 7
      NumbersOnly = True
      TabOrder = 0
      Text = '1'
      ValueTrim = '1'
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
    object nvedtaccepter: TNovaEdit
      Left = 184
      Top = 66
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 20
      ReadOnly = True
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
    object dtpdepartdate: TDateTimePicker
      Left = 184
      Top = 27
      Width = 121
      Height = 22
      Date = 41492.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41492.639888414350000000
      Enabled = False
      TabOrder = 2
    end
    object nvedtpackno: TNovaEdit
      Left = 184
      Top = 105
      Width = 121
      Height = 22
      Enabled = False
      MaxLength = 20
      ReadOnly = True
      TabOrder = 3
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
    object nvhelptostation: TNovaHelp
      Left = 184
      Top = 144
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 50
      ReadOnly = True
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'pack/querytostation'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedttotalfee: TNovaEdit
      Left = 184
      Top = 183
      Width = 122
      Height = 22
      Enabled = False
      MaxLength = 7
      ReadOnly = True
      TabOrder = 5
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
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      Caption = '&S '#36864#31080
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 0
    Top = 16
  end
  object jcdsreturnbackResult: TjsonClientDataSet
    DataSourceName = 'packlist'
    QueryAddress = 'pack/packreturnback'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'preturnback.packid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'preturnback.fee'
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
    Left = 224
    Top = 216
    object jcdsreturnbackResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsreturnbackResultPACKTYPE: TWideStringField
      FieldName = 'PACKTYPE'
      Size = 0
    end
    object jcdsreturnbackResultpacktypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'packtypevalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'PACKTYPE'
      Lookup = True
    end
    object jcdsreturnbackResultSENDSTATIONID: TLargeintField
      FieldName = 'SENDSTATIONID'
    end
    object jcdsreturnbackResultsendstationname: TWideStringField
      FieldName = 'sendstationname'
      Size = 0
    end
    object jcdsreturnbackResultTOSTATIONID: TLargeintField
      FieldName = 'TOSTATIONID'
    end
    object jcdsreturnbackResulttostationname: TWideStringField
      FieldName = 'tostationname'
      Size = 0
    end
    object jcdsreturnbackResultname: TWideStringField
      FieldName = 'name'
      Size = 0
    end
    object jcdsreturnbackResultGOODTYPE: TWideStringField
      FieldName = 'GOODTYPE'
      Size = 0
    end
    object jcdsreturnbackResultgoodtypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'goodtypevalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'GOODTYPE'
      Lookup = True
    end
    object jcdsreturnbackResultSCHEDULEID: TLargeintField
      FieldName = 'SCHEDULEID'
    end
    object jcdsreturnbackResultschedulename: TWideStringField
      FieldName = 'schedulecode'
    end
    object jcdsreturnbackResultunloadfee: TFloatField
      FieldName = 'unloadfee'
    end
    object jcdsreturnbackResultVEHICLEID: TLargeintField
      FieldName = 'VEHICLEID'
    end
    object jcdsreturnbackResultvehiclecode: TWideStringField
      FieldName = 'vehiclecode'
    end
    object jcdsreturnbackResultdepartdate: TDateTimeField
      FieldName = 'departdate'
    end
    object jcdsreturnbackResultpackno: TWideStringField
      FieldName = 'packno'
      Size = 0
    end
    object jcdsreturnbackResultinvoiceno: TWideStringField
      FieldName = 'invoiceno'
      Size = 0
    end
    object jcdsreturnbackResultSELLBY: TLargeintField
      FieldName = 'SELLBY'
    end
    object jcdsreturnbackResultsellbyname: TWideStringField
      FieldName = 'sellbyname'
    end
    object jcdsreturnbackResultpieces: TIntegerField
      FieldName = 'pieces'
    end
    object jcdsreturnbackResultweight: TFloatField
      FieldName = 'weight'
    end
    object jcdsreturnbackResultvolume: TWideStringField
      FieldName = 'volume'
      Size = 0
    end
    object jcdsreturnbackResultPACKED: TWideStringField
      FieldName = 'PACKED'
      Size = 0
    end
    object jcdsreturnbackResultpackedvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'packedvalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'PACKED'
      Lookup = True
    end
    object jcdsreturnbackResultshipprice: TFloatField
      FieldName = 'shipprice'
    end
    object jcdsreturnbackResultpackfee: TFloatField
      FieldName = 'packfee'
    end
    object jcdsreturnbackResulthandfee: TFloatField
      FieldName = 'handfee'
    end
    object jcdsreturnbackResultcustodial: TFloatField
      FieldName = 'custodial'
    end
    object jcdsreturnbackResulttransitfee: TFloatField
      FieldName = 'transitfee'
    end
    object jcdsreturnbackResultinsuredamount: TFloatField
      FieldName = 'insuredamount'
    end
    object jcdsreturnbackResultinsurancefee: TFloatField
      FieldName = 'insurancefee'
    end
    object jcdsreturnbackResultinsurance: TFloatField
      FieldName = 'insurance'
    end
    object jcdsreturnbackResultdeliveryfee: TFloatField
      FieldName = 'deliveryfee'
    end
    object jcdsreturnbackResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsreturnbackResulttotalfee: TFloatField
      FieldName = 'totalfee'
    end
    object jcdsreturnbackResultlocation: TWideStringField
      FieldName = 'location'
      Size = 0
    end
    object jcdsreturnbackResultpackprice: TFloatField
      FieldName = 'packprice'
    end
    object jcdsreturnbackResultsender: TWideStringField
      FieldName = 'sender'
      Size = 0
    end
    object jcdsreturnbackResultsenderphone: TWideStringField
      FieldName = 'senderphone'
      Size = 0
    end
    object jcdsreturnbackResultsenderaddress: TWideStringField
      FieldName = 'senderaddress'
      Size = 0
    end
    object jcdsreturnbackResultconsignee: TWideStringField
      FieldName = 'consignee'
      Size = 0
    end
    object jcdsreturnbackResultconsigneephone: TWideStringField
      FieldName = 'consigneephone'
      Size = 0
    end
    object jcdsreturnbackResultconsigneeaddress: TWideStringField
      FieldName = 'consigneeaddress'
      Size = 0
    end
    object jcdsreturnbackResultCERTIFICATETYPE: TWideStringField
      FieldName = 'CERTIFICATETYPE'
      Size = 0
    end
    object jcdsreturnbackResultcertificatetypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certificatetypevalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Lookup = True
    end
    object jcdsreturnbackResultcertificateno: TWideStringField
      FieldName = 'certificateno'
      Size = 0
    end
    object jcdsreturnbackResultSHIPTYPE: TWideStringField
      FieldName = 'SHIPTYPE'
      Size = 0
    end
    object jcdsreturnbackResultshiptypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'shiptypevalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'SHIPTYPE'
      Lookup = True
    end
    object jcdsreturnbackResultPAYMETHOD: TWideStringField
      FieldName = 'PAYMETHOD'
      Size = 0
    end
    object jcdsreturnbackResultpaymethodvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodvalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'PAYMETHOD'
      Lookup = True
    end
    object jcdsreturnbackResultSTATUS: TWideStringField
      FieldName = 'STATUS'
      Size = 0
    end
    object jcdsreturnbackResultstatusvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusvalue'
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'STATUS'
      Lookup = True
    end
    object jcdsreturnbackResultvaluables: TBooleanField
      FieldName = 'valuables'
    end
    object jcdsreturnbackResultPACKTTURNOVERID: TLargeintField
      FieldName = 'PACKTTURNOVERID'
    end
    object jcdsreturnbackResultremak: TWideStringField
      FieldName = 'remak'
      Size = 0
    end
    object jcdsreturnbackResultORGID: TLargeintField
      FieldName = 'ORGID'
    end
    object jcdsreturnbackResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsreturnbackResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsreturnbackResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsreturnbackResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsreturnbackResultupdatebyname: TWideStringField
      FieldName = 'updatebyname'
      Size = 0
    end
    object jcdsreturnbackResultischoose: TBooleanField
      FieldName = 'ischoose'
    end
    object jcdsreturnbackResultsignby: TLargeintField
      FieldName = 'signby'
    end
    object jcdsreturnbackResultsignbyname: TWideStringField
      FieldName = 'signbyname'
      Size = 0
    end
    object jcdsreturnbackResultsigntime: TDateTimeField
      FieldName = 'signtime'
    end
    object jcdsreturnbackResultsingbillno: TWideStringField
      FieldName = 'singbillno'
    end
  end
end
