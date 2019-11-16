inherited FrmPackWarehousing: TFrmPackWarehousing
  ActiveControl = nvedtpackno
  Caption = #21040#36135#20837#20179
  ClientHeight = 410
  ClientWidth = 1366
  KeyPreview = True
  Position = poDesigned
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitLeft = -433
  ExplicitWidth = 1382
  ExplicitHeight = 448
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1366
    Height = 92
    ExplicitWidth = 1366
    ExplicitHeight = 92
    DesignSize = (
      1366
      92)
    object Label2: TLabel
      Left = 7
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl3: TLabel
      Left = 517
      Top = 21
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl4: TLabel
      Left = 272
      Top = 22
      Width = 56
      Height = 14
      Caption = #20837#20179#26102#38388
    end
    object Label1: TLabel
      Left = 284
      Top = 59
      Width = 42
      Height = 14
      Caption = #20837#20179#21592
    end
    object Label3: TLabel
      Left = 7
      Top = 59
      Width = 56
      Height = 14
      Caption = #21463#29702#21333#21495
    end
    object inwarehousemsg: TLabel
      Left = 957
      Top = 22
      Width = 8
      Height = 14
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 500
      Top = 59
      Width = 56
      Height = 14
      Caption = #36135#29289#29366#24577
    end
    object dtpstartdate: TDateTimePicker
      Left = 334
      Top = 18
      Width = 147
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 565
      Top = 17
      Width = 147
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      TabOrder = 2
    end
    object nvcbborg: TNovaCheckedComboBox
      Left = 68
      Top = 18
      Width = 173
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvedtpackno: TNovaEdit
      Left = 68
      Top = 55
      Width = 173
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 3
      OnKeyPress = nvedtpacknoKeyPress
      OnKeyUp = nvedtpacknoKeyUp
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
    object GroupBox2: TGroupBox
      Left = 1116
      Top = 22
      Width = 245
      Height = 48
      Anchors = [akTop, akRight]
      Caption = #24403#21069#34892#21253#21040#36135#25910#35755#21333#21495
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Visible = False
      object lbpackbill: TLabel
        Left = 3
        Top = 23
        Width = 96
        Height = 16
        Caption = '000000000000'
      end
      object Label5: TLabel
        Left = 120
        Top = 23
        Width = 64
        Height = 16
        Caption = #21097#20313#24352#25968
      end
      object lbbillnum: TLabel
        Left = 191
        Top = 23
        Width = 8
        Height = 16
        Caption = '0'
      end
    end
    object nvcbbgoodsstatus: TNovaComboBox
      Left = 565
      Top = 55
      Width = 147
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'goodsstatus'
      HelpOptions.DisAll = True
    end
    object nvcbbsellby: TNovaCheckedComboBox
      Left = 332
      Top = 55
      Width = 149
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'usermap'
      HelpOptions.HQueryAddress = 'system/listEntrypacker'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'filter_INS_u!orgid'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_INS_r!id'
          ParamType = ptInput
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1366
    ButtonWidth = 77
    ExplicitWidth = 1366
    inherited tbtnFilter: TToolButton
      Caption = '&F1.'#26597#35810
      OnClick = tbtnFilterClick
      ExplicitWidth = 77
    end
    inherited tbtn1: TToolButton
      Left = 77
      ExplicitLeft = 77
    end
    inherited tbtnInsert: TToolButton
      Left = 85
      Caption = '&F2.'#20837#20179
      OnClick = tbtnInsertClick
      ExplicitLeft = 85
      ExplicitWidth = 77
    end
    inherited tbtnEdit: TToolButton
      Left = 162
      Caption = '&F3.'#20462#25913
      OnClick = tbtnEditClick
      ExplicitLeft = 162
      ExplicitWidth = 77
    end
    inherited tbtnDelete: TToolButton
      Left = 239
      Caption = '&F4.'#20316#24223
      OnClick = tbtnDeleteClick
      ExplicitLeft = 239
      ExplicitWidth = 77
    end
    inherited ToolButton50: TToolButton
      Left = 316
      Caption = #23545#20184#27454#22238#25910
      ImageIndex = 14
      OnClick = ToolButton50Click
      ExplicitLeft = 316
      ExplicitWidth = 81
    end
    inherited ToolButton51: TToolButton
      Left = 397
      Caption = #21407#21333#21495#37325#25171
      ImageIndex = 5
      Visible = True
      OnClick = ToolButton51Click
      ExplicitLeft = 397
      ExplicitWidth = 81
    end
    inherited tbtn3: TToolButton
      Left = 478
      ExplicitLeft = 478
    end
    inherited tbtnSave: TToolButton
      Left = 486
      Caption = #26032#21333#21495#37325#25171
      ImageIndex = 50
      OnClick = tbtnSaveClick
      ExplicitLeft = 486
      ExplicitWidth = 77
    end
    inherited tbtnCancel: TToolButton
      Left = 563
      Visible = False
      ExplicitLeft = 563
      ExplicitWidth = 77
    end
    inherited ToolButton52: TToolButton
      Left = 640
      ExplicitLeft = 640
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 658
      ExplicitLeft = 658
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 676
      Visible = False
      ExplicitLeft = 676
    end
    inherited tbtnInfo: TToolButton
      Left = 684
      ExplicitLeft = 684
      ExplicitWidth = 77
    end
    inherited tbtn5: TToolButton
      Left = 761
      ExplicitLeft = 761
    end
    inherited tbtnExcel: TToolButton
      Left = 769
      ExplicitLeft = 769
      ExplicitWidth = 77
    end
    inherited tbtnPrinter: TToolButton
      Left = 846
      ExplicitLeft = 846
      ExplicitWidth = 77
    end
    inherited tbtn6: TToolButton
      Left = 923
      ExplicitLeft = 923
    end
    inherited tbtnClose: TToolButton
      Left = 931
      ExplicitLeft = 931
      ExplicitWidth = 77
    end
  end
  inherited Panel1: TPanel
    Top = 137
    Width = 1366
    Height = 273
    ExplicitTop = 137
    ExplicitWidth = 1366
    ExplicitHeight = 273
    object splmid: TSplitter [0]
      Left = 1363
      Top = 0
      Height = 273
      Align = alRight
      ExplicitLeft = 514
      ExplicitTop = 6
      ExplicitHeight = 308
    end
    inherited GroupBox1: TGroupBox
      Width = 1363
      Height = 273
      ExplicitWidth = 1363
      ExplicitHeight = 273
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1359
        Height = 255
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21463#29702#21333#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'packarriverno'
            Footers = <>
            Title.Caption = #25910#35755#21333#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'sendstationname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#31449
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'vehiclecode'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36710#29260#21495#30721
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20837#20179#26102#38388
            Width = 135
          end
          item
            EditButtons = <>
            FieldName = 'packedvalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21253#35013
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20214#25968
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'consignee'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25910#36135#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'consigneephone'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25910#36135#20154#30005#35805
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'shipprice'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20195#25910#36816#36153
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'transitfee'
            Footers = <>
            Title.Caption = #20013#36716#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'deliveryfee'
            Footers = <>
            Title.Caption = #36865#36135#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footers = <>
            Title.Caption = #20854#20182#36153#29992
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21512#35745#37329#39069
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20195#25910#36135#27454
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'locationvalue'
            Footers = <>
            Title.Caption = #23384#25918#20301#32622
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'zhuanyuntostationname'
            Footers = <>
            Title.Caption = #36716#36816#33267
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'goodsstatusname'
            Footers = <>
            Title.Caption = #36135#29289#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'packarriverstatusname'
            Footers = <>
            Title.Caption = #25910#35755#21333#29366#24577
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'entrypacker'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20837#20179#21592
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'sender'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#20154
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36135#29289#21517#31216
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'consigneeaddress'
            Footers = <>
            Title.Caption = #36135#20027#22320#22336
            Visible = False
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'statusvalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #29366#24577
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25552#39046#20973#35777
            Visible = False
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'paymethodvalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20184#27454#26041#24335
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'shiptypevalue'
            Footers = <>
            Title.Caption = #25552#36135#26041#24335
            Visible = False
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'weight'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #37325#37327'(kg)'
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'handfee'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#35013#21368#36153
            Visible = False
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'unloadfee'
            Footers = <>
            Title.Caption = #21040#36135#35013#21368#36153
            Visible = False
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #25910#36135#20154#35777#20214#21495#30721
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'tostationname'
            Footers = <>
            Title.Caption = #30446#30340#22320
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'goodtypevalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36135#29289#31867#21035
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36135#26085#26399
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'invoiceno'
            Footers = <>
            Title.Caption = #21457#31080#21495
            Visible = False
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'sellbyname'
            Footers = <>
            Title.Caption = #21150#29702#21592
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'volume'
            Footers = <>
            Title.Caption = #20307#31215
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'packfee'
            Footers = <>
            Title.Caption = #21253#35013#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'custodial'
            Footers = <>
            Title.Caption = #20445#31649#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insuredamount'
            Footers = <>
            Title.Caption = #20445#20215#37329#39069
            Visible = False
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'insurancefee'
            Footers = <>
            Title.Caption = #20445#20215#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insurance'
            Footers = <>
            Title.Caption = #20445#38505#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'senderphone'
            Footers = <>
            Title.Caption = #25176#36816#20154#30005#35805
            Visible = False
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'senderaddress'
            Footers = <>
            Title.Caption = #25176#36816#20154#22320#22336
            Visible = False
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'valuables'
            Footers = <>
            Title.Caption = #26159#21542#36149#37325#29289#21697
            Visible = False
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'remak'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #22791#27880
            Visible = False
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'packtypevalue'
            Footers = <>
            Title.Caption = #25968#25454#31867#22411
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packarriverdate'
            Footers = <>
            Title.Caption = #25910#35755#26085#26399
            Visible = False
            Width = 120
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 56
    Top = 240
  end
  inherited ilToolBarDisable: TImageList
    Left = 128
    Top = 336
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'packnomap'
    QueryAddress = 'pack/queryPackWarehousing'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_p!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!entrypacker'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!packtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!goodsstatus'
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
    Left = 80
    Top = 184
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultpacktypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'packtypevalue'
      LookupDataSet = jcdspacktypevalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'packtype'
      Size = 0
      Lookup = True
    end
    object jcdsResultischoose: TBooleanField
      FieldName = 'ischoose'
    end
    object jcdsResultpacktype: TWideStringField
      FieldName = 'packtype'
      Size = 0
    end
    object jcdsResultSENDSTATIONID: TLargeintField
      FieldName = 'SENDSTATIONID'
    end
    object jcdsResultsendstationname: TWideStringField
      FieldName = 'sendstationname'
      Size = 0
    end
    object jcdsResultTOSTATIONID: TLargeintField
      FieldName = 'TOSTATIONID'
    end
    object jcdsResulttostationname: TWideStringField
      FieldName = 'tostationname'
      Size = 0
    end
    object jcdsResultname: TWideStringField
      FieldName = 'name'
      Size = 0
    end
    object jcdsResultGOODTYPE: TWideStringField
      FieldName = 'GOODTYPE'
      Size = 0
    end
    object jcdsResultgoodtypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'goodtypevalue'
      LookupDataSet = jcdsgoodtypevalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'GOODTYPE'
      Lookup = True
    end
    object jcdsResultSCHEDULEID: TLargeintField
      FieldName = 'SCHEDULEID'
    end
    object jcdsResultschedulename: TWideStringField
      FieldName = 'schedulecode'
    end
    object jcdsResultVEHICLEID: TLargeintField
      FieldName = 'VEHICLEID'
    end
    object jcdsResultvehiclecode: TWideStringField
      FieldName = 'vehiclecode'
    end
    object jcdsResultdepartdate: TDateTimeField
      FieldName = 'departdate'
    end
    object jcdsResultpackno: TWideStringField
      FieldName = 'packno'
      Size = 0
    end
    object jcdsResultinvoiceno: TWideStringField
      FieldName = 'invoiceno'
      Size = 0
    end
    object jcdsResultSELLBY: TLargeintField
      FieldName = 'SELLBY'
    end
    object jcdsResultsellbyname: TWideStringField
      FieldName = 'entrypacker'
    end
    object jcdsResultpieces: TIntegerField
      FieldName = 'pieces'
    end
    object jcdsResultweight: TFloatField
      FieldName = 'weight'
    end
    object jcdsResultvolume: TWideStringField
      FieldName = 'volume'
      Size = 0
    end
    object jcdsResultPACKED: TWideStringField
      FieldName = 'PACKED'
      Size = 0
    end
    object jcdsResultpackedvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'packedvalue'
      LookupDataSet = jcdspackedvalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'PACKED'
      Lookup = True
    end
    object jcdsResultshipprice: TFloatField
      FieldName = 'shipprice'
    end
    object jcdsResultpackfee: TFloatField
      FieldName = 'packfee'
    end
    object jcdsResulthandfee: TFloatField
      FieldName = 'handfee'
    end
    object jcdsResultunloadfee: TFloatField
      FieldName = 'unloadfee'
    end
    object jcdsResultcustodial: TFloatField
      FieldName = 'custodial'
    end
    object jcdsResulttransitfee: TFloatField
      FieldName = 'transitfee'
    end
    object jcdsResultinsurancefee: TFloatField
      FieldName = 'insurancefee'
    end
    object jcdsResultinsurance: TFloatField
      FieldName = 'insurance'
    end
    object jcdsResultinsuredamount: TFloatField
      FieldName = 'insuredamount'
    end
    object jcdsResultdeliveryfee: TFloatField
      FieldName = 'deliveryfee'
    end
    object jcdsResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsResulttotalfee: TFloatField
      FieldName = 'totalfee'
    end
    object jcdsResultlocation: TWideStringField
      FieldName = 'location'
      Size = 0
    end
    object jcdsResultpackprice: TFloatField
      FieldName = 'packprice'
    end
    object jcdsResultsender: TWideStringField
      FieldName = 'sender'
      Size = 0
    end
    object jcdsResultsenderphone: TWideStringField
      FieldName = 'senderphone'
      Size = 0
    end
    object jcdsResultsenderaddress: TWideStringField
      FieldName = 'senderaddress'
      Size = 0
    end
    object jcdsResultconsignee: TWideStringField
      FieldName = 'consignee'
      Size = 0
    end
    object jcdsResultconsigneephone: TWideStringField
      FieldName = 'consigneephone'
      Size = 0
    end
    object jcdsResultconsigneeaddress: TWideStringField
      FieldName = 'consigneeaddress'
      Size = 0
    end
    object jcdsResultCERTIFICATETYPE: TWideStringField
      FieldName = 'CERTIFICATETYPE'
      Size = 0
    end
    object jcdsResultcertificatetypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certificatetypevalue'
      LookupDataSet = jcdcertificatetypevalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Lookup = True
    end
    object jcdsResultcertificateno: TWideStringField
      FieldName = 'certificateno'
      Size = 0
    end
    object jcdsResultSHIPTYPE: TWideStringField
      FieldName = 'SHIPTYPE'
      Size = 0
    end
    object jcdsResultshiptypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'shiptypevalue'
      LookupDataSet = jcdshiptypevalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'SHIPTYPE'
      Lookup = True
    end
    object jcdsResultPAYMETHOD: TWideStringField
      FieldName = 'PAYMETHOD'
      Size = 0
    end
    object jcdsResultpaymethodvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'paymethodvalue'
      LookupDataSet = jcdspaymethodvalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'PAYMETHOD'
      Lookup = True
    end
    object jcdsResultSTATUS: TWideStringField
      FieldName = 'STATUS'
      Size = 0
    end
    object jcdsResultstatusvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusvalue'
      LookupDataSet = jcdsstatusvalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'STATUS'
      Lookup = True
    end
    object jcdsResultvaluables: TBooleanField
      FieldName = 'valuables'
    end
    object jcdsResultPACKTTURNOVERID: TLargeintField
      FieldName = 'PACKTTURNOVERID'
    end
    object jcdsResultremak: TWideStringField
      FieldName = 'remak'
      Size = 0
    end
    object jcdsResultORGID: TLargeintField
      FieldName = 'ORGID'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object jcdsResultupdatebyname: TWideStringField
      FieldName = 'updatebyname'
      Size = 0
    end
    object jcdsResultzhuanyuntostationid: TLargeintField
      FieldName = 'zhuanyuntostationid'
    end
    object jcdsResultzhuanyuntostationname: TWideStringField
      FieldName = 'zhuanyuntostationname'
    end
    object jcdsResultlocationvalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'locationvalue'
      LookupDataSet = jcdslocationvalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'location'
      Lookup = True
    end
    object jcdsResultpackarriverno: TWideStringField
      FieldName = 'packarriverno'
    end
    object jcdsResultpackarriverdate: TDateTimeField
      FieldName = 'packarriverdate'
    end
    object jcdsResultpackarriverstatus: TWideStringField
      FieldName = 'packarriverstatus'
    end
    object jcdsResultpackarriverstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'packarriverstatusname'
      LookupDataSet = jcdspackarriverstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'packarriverstatus'
      Lookup = True
    end
    object jcdsResultgoodsstatus: TWideStringField
      FieldName = 'goodsstatus'
    end
    object jcdsResultservicefee: TFloatField
      FieldName = 'servicefee'
    end
    object jcdsResultrecyclestatus: TWideStringField
      FieldName = 'recyclestatus'
    end
    object jcdsResultpackarriverid: TLargeintField
      FieldName = 'packarriverid'
    end
    object jcdsResultgoodsstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'goodsstatusname'
      LookupDataSet = jcdsgoodsstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'goodsstatus'
      Lookup = True
    end
    object jcdsResultpackarrivercreatby: TLargeintField
      FieldName = 'packarrivercreatby'
    end
    object jcdsResultpackarrivercreatetime: TDateTimeField
      FieldName = 'packarrivercreatetime'
    end
  end
  inherited dsResult: TDataSource
    Left = 704
    Top = 304
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 344
  end
  object ilsmalltools: TImageList
    DrawingStyle = dsSelected
    Left = 48
    Top = 336
    Bitmap = {
      494C01010B000D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF0000000000000000007F7F7F000000
      000000000000000000007F7F7F000000000000000000000000007F7F7F000000
      000000000000000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF007F7F7F007F7F7F007F7F
      7F007F7F7F0000FFFF0000FFFF000000000000000000000000007F7F7F000000
      00007F7F7F00000000007F7F7F00000000007F7F7F00000000007F7F7F000000
      00007F7F7F00000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600FFFFFF00FFFFFF008484
      840000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600FFFFFF00840000000000FF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600FFFFFF0084000000FF00FF00FF0000000000FF00FFFFFF00FFFF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F000000000000000000000000007F7F7F00000000000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600FFFF
      FF00FFFFFF00C6C6C600FFFFFF00C6C6C600FF000000FFFFFF000000FF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60084848400C6C6
      C600FFFFFF00C6C6C600000000000000000000000000C6C6C600C6C6C600FFFF
      FF00FFFFFF008484840000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000007F7F7F007F7F7F00000000007F7F
      7F007F7F7F007F7F7F000000FF007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F000000FF007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFF000084848400848484008484
      84008484840084840000FFFF0000FFFFFF00C6C6C600FFFFFF00FFFFFF00C6C6
      C600FFFFFF0000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000848400008484
      000084840000FFFF0000FFFFFF0000000000FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00FFFFFF0000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF00000000007F7F7F00000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00008484
      0000FFFF0000FFFFFF000000000000000000FFFFFF00C6C6C600FFFFFF00FFFF
      FF00C6C6C600FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084840000FFFF
      0000FFFFFF0084848400FFFFFF00C6C6C600FFFFFF00FFFFFF00C6C6C600FFFF
      FF0084848400C6C6C600C6C6C600848484000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000007F7F7F007F7F7F00000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000FFFF0000FFFF
      FF00FFFF00008484000084848400FFFFFF00C6C6C600FFFFFF0084848400C6C6
      C600C6C6C6000000000084848400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C600FFFF0000FFFF0000FFFF000084848400C6C6C600C6C6C6000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60084848400C6C6C600C6C6C60000000000848484000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000007F7F7F007F7F7F00000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      000000000000000000007B7B7B00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000FF0000000000000000007B7B
      7B008400000084000000840000007B7B7B000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000007B7B7B00000000007B7B7B00000000000000
      00000000FF000000FF000000FF00000000000000000084000000840000008400
      000084000000840000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000FF0000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000840000008400
      0000840000008400000084000000840000007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      000084000000840000007B7B7B000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF007B7B7B00000000007B7B7B000000FF000000
      FF000000FF0000000000000000000000000000000000000000007B7B7B008400
      00008400000084000000840000008400000084000000840000007B7B7B000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      00008400000084000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF00000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000008400000084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000840000007B7B7B00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF00000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000007B7B7B00000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      00008400000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000008400000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00007B7B7B0000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000840000000000000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000000000000000000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000007B7B
      7B000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000000000000000FF000000
      FF000000FF00000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF00840000007B7B7B000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BDBD
      BD00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000007B7B7B00000000007B7B7B00000000000000
      00000000FF000000FF000000FF000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF0084000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000FF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FF0000000000FF008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B008400000084000000840000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000FF0000000000FF00840000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F0000000000000000007F7F7F00000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B008400000084000000840000008400
      00008400000084000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00007F7F7F007F7F7F0000FFFF00000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF0084000000840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0084000000840000008400000084000000840000008400
      0000840000007B7B7B00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00007F7F7F0000FFFF0000FFFF00000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00840000008400000084000000840000008400000084000000840000008400
      00008400000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000BDBDBD0000000000FF000000FF000000FF00
      00000000FF00FF000000FF0000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      00000000FF0000000000000000007F7F7F000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000007B7B
      7B0000000000000000000000000000000000000000007B7B7B00840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF0000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000007B7B7B0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000000000000000FF000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000000000000000000000000000FFFFFF0000000000BDBD
      BD00FFFFFF0000000000FFFFFF000000000000000000000000007B7B7B000000
      FF000000FF000000FF00000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF000000000000000000000000007F7F7F000000
      FF000000FF000000FF00000000000000000000000000FF000000FF000000FF00
      00000000000000000000000000000000FF0000000000000000007B7B7B008400
      000084000000840000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000FF000000FF000000FF0000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000007B7B7B0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFDFFF7EDDDD0000FF1F9001D5550000
      FC0FC00300000000F00FE003DFFF0000C007E00387FC00000007E003DBFB0000
      0003E0030000000000030001DDF70000800180009EEF0000C001E007DF1F0000
      C000E00F000000008001E00FDFFF00000007E0279FFF0000F01FC073DFFF0000
      F07F9E7900000000F9FF7EFEFFFF0000FFFFBF7CFFDFFFFF1FFF8F78FFCFFFFF
      07FFC760FFC7C63181FFC1410003E223C07FE0010001F007C01FE0030000F88F
      E007F0030001FC1FF001F0070003FE3F0000F8070007FC1FF003F80F000FF80F
      E00FFC0F001FF007E03FFC1F007FE223C0FFFE1F00FFC63183FFFE3F01FFFFFF
      8FFFFF3F03FFFFFF3FFFFF7FFFFFFFFFFF00FC00FEFFFFFFFF00FC00FE7FFFF8
      FF00FC00FC7FFFE0FF00FC00FC3FFF8100000000F83FFE0300000000F81FF803
      00000000F01FE00700000000F00F800F00230023E00F000000010001E007C00F
      00000000C007F00700230023C003FC07006300638283FF0300C300C38EC1FFC1
      010701071EF1FFF103FF03FF7EF9FFFC00000000000000000000000000000000
      000000000000}
  end
  object jcdspackedvalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'packed'
      end>
    RemoteServer = DMPublic.jcon
    Left = 168
    Top = 224
  end
  object jcdcertificatetypevalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'certificatetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 224
  end
  object jcdshiptypevalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'shiptype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 376
    Top = 224
  end
  object jcdspaymethodvalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'paymethod'
      end>
    RemoteServer = DMPublic.jcon
    Left = 488
    Top = 224
  end
  object jcdsstatusvalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 224
  end
  object jcdsgoodtypevalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'goodtype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 688
    Top = 224
  end
  object jcdspacktypevalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'packtype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 800
    Top = 224
  end
  object jcdspackwaste: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/wastePack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pack.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 312
  end
  object jcdsPackup: TjsonClientDataSet
    DataSourceName = 'packnomap'
    SaveAddress = 'pack/packnoUpStatus'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pack.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 304
  end
  object jcdslocationvalue: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'location'
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 280
  end
  object jcdspackarriverstatus: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'packarriver'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 336
    Top = 320
  end
  object jcdspaymentrecyclesave: TjsonClientDataSet
    DataSourceName = 'diclist'
    SaveAddress = 'pack/savepaymentrecycle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'pack.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 93
  end
  object jcdswhackpackarriver: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/whackPackarriver'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packarriver.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.packarriverno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packarriver.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 760
    Top = 56
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
    Left = 980
    Top = 80
  end
  object jcdsgoodsstatus: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'goodsstatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 792
    Top = 288
  end
end
