inherited FrmPackStock: TFrmPackStock
  ActiveControl = nvedtpackno
  Caption = #34892#21253#31614#21457
  ClientHeight = 437
  ClientWidth = 1179
  KeyPreview = True
  OnActivate = FormActivate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  ExplicitWidth = 1195
  ExplicitHeight = 475
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1179
    Height = 128
    ExplicitWidth = 1179
    ExplicitHeight = 128
    object Label2: TLabel
      Left = 24
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl3: TLabel
      Left = 491
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl4: TLabel
      Left = 250
      Top = 22
      Width = 56
      Height = 14
      Caption = #25805#20316#26102#38388
    end
    object Label1: TLabel
      Left = 229
      Top = 59
      Width = 77
      Height = 14
      Caption = #25176#36816'/'#25910#36135#20154
    end
    object Label3: TLabel
      Left = 264
      Top = 94
      Width = 42
      Height = 14
      Caption = #30446#30340#22320
    end
    object Label4: TLabel
      Left = 681
      Top = 60
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object Label5: TLabel
      Left = 445
      Top = 59
      Width = 56
      Height = 14
      Caption = #30005#35805#21495#30721
    end
    object Label7: TLabel
      Left = 653
      Top = 23
      Width = 56
      Height = 14
      Caption = #20184#27454#26041#24335
    end
    object Label8: TLabel
      Left = 667
      Top = 101
      Width = 42
      Height = 14
      Caption = #25805#20316#21592
    end
    object Label9: TLabel
      Left = 463
      Top = 99
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object lblsingbillno: TLabel
      Left = 23
      Top = 94
      Width = 56
      Height = 14
      Caption = #31614#21457#21333#21495
    end
    object lblpackno: TLabel
      Left = 23
      Top = 59
      Width = 56
      Height = 14
      Caption = #34892#21253#21333#21495
    end
    object dtpstartdate: TDateTimePicker
      Left = 312
      Top = 19
      Width = 121
      Height = 22
      Date = 41494.639888414350000000
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 511
      Top = 19
      Width = 121
      Height = 22
      Date = 41494.639888414350000000
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 2
    end
    object nvedtname: TNovaEdit
      Left = 312
      Top = 56
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 8
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
    object nvhelptostation: TNovaHelp
      Left = 312
      Top = 91
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbborg: TNovaCheckedComboBox
      Left = 86
      Top = 19
      Width = 121
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
    object nvcbbpackstatus: TNovaComboBox
      Left = 720
      Top = 56
      Width = 114
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 10
      TabOrder = 7
      Items.Strings = (
        '')
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
      HelpOptions.Columnname = 'status'
      HelpOptions.DisAll = True
    end
    object nvedtsenderphone: TNovaEdit
      Left = 511
      Top = 56
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 11
      TabOrder = 6
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
    object nvcbbpaymethod: TNovaComboBox
      Left = 720
      Top = 19
      Width = 114
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 10
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'pack'
      HelpOptions.Columnname = 'paymethod'
    end
    object nvhelpvehiclecode: TNovaHelp
      Left = 511
      Top = 96
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 10
      TabOrder = 10
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
          Title.Caption = #36710#29260#21495
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'vehicletypename'
          Title.Caption = #36710#22411
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedtsingbillno: TNovaEdit
      Left = 86
      Top = 90
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 8
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
    object nvedtpackno: TNovaEdit
      Left = 86
      Top = 56
      Width = 121
      Height = 22
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
    end
    object nvhlpseller: TNovaHelp
      Left = 719
      Top = 96
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 11
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
      HDBGColumns = <>
      HelpOptions.HelpHeight = 200
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
    Width = 1179
    ButtonWidth = 84
    ExplicitWidth = 1179
    inherited tbtnFilter: TToolButton
      Caption = '&F1.'#26597#35810
      OnClick = tbtnFilterClick
      ExplicitWidth = 84
    end
    inherited tbtn1: TToolButton
      Left = 84
      ExplicitLeft = 84
    end
    inherited tbtnInsert: TToolButton
      Left = 92
      Caption = '&F2.'#31614#21457
      OnClick = tbtnInsertClick
      ExplicitLeft = 92
      ExplicitWidth = 84
    end
    inherited tbtnEdit: TToolButton
      Left = 176
      Caption = '&F3.'#20986#24211
      ImageIndex = 12
      Visible = False
      ExplicitLeft = 176
      ExplicitWidth = 84
    end
    inherited tbtnDelete: TToolButton
      Left = 260
      Caption = '&F4.'#34917#25171
      ImageIndex = 8
      OnClick = tbtnDeleteClick
      ExplicitLeft = 260
      ExplicitWidth = 84
    end
    inherited ToolButton50: TToolButton
      Left = 344
      AutoSize = False
      Caption = '&F5.'#33829#25910
      ImageIndex = 14
      OnClick = ToolButton50Click
      ExplicitLeft = 344
      ExplicitWidth = 84
    end
    inherited ToolButton51: TToolButton
      Left = 428
      ImageIndex = 9
      OnClick = ToolButton51Click
      ExplicitLeft = 428
      ExplicitWidth = 31
    end
    inherited tbtn3: TToolButton
      Left = 459
      Width = 9
      ExplicitLeft = 459
      ExplicitWidth = 9
    end
    inherited tbtnSave: TToolButton
      Left = 468
      Caption = '&F6.'#21462#28040#31614#21457
      ImageIndex = 51
      OnClick = tbtnSaveClick
      ExplicitLeft = 468
      ExplicitWidth = 84
    end
    inherited tbtnCancel: TToolButton
      Left = 552
      Caption = '&F7.'#21462#28040#25552#39046
      Visible = False
      ExplicitLeft = 552
      ExplicitWidth = 84
    end
    inherited ToolButton52: TToolButton
      Left = 636
      ExplicitLeft = 636
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 654
      ExplicitLeft = 654
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 672
      Visible = False
      ExplicitLeft = 672
    end
    inherited tbtnInfo: TToolButton
      Left = 680
      ExplicitLeft = 680
      ExplicitWidth = 84
    end
    inherited tbtn5: TToolButton
      Left = 764
      ExplicitLeft = 764
    end
    inherited tbtnExcel: TToolButton
      Left = 772
      ExplicitLeft = 772
      ExplicitWidth = 84
    end
    inherited tbtnPrinter: TToolButton
      Left = 856
      ExplicitLeft = 856
      ExplicitWidth = 84
    end
    inherited tbtn6: TToolButton
      Left = 940
      ExplicitLeft = 940
    end
    inherited tbtnClose: TToolButton
      Left = 948
      ExplicitLeft = 948
      ExplicitWidth = 84
    end
    object tbtnpackbill: TToolButton
      Left = 1032
      Top = 0
      Caption = #37325#25171
      ImageIndex = 8
      Visible = False
      OnClick = tbtnpackbillClick
    end
  end
  inherited Panel1: TPanel
    Top = 173
    Width = 1179
    Height = 264
    ExplicitTop = 173
    ExplicitWidth = 1179
    ExplicitHeight = 264
    object splmid: TSplitter [0]
      Left = 1176
      Top = 0
      Height = 264
      Align = alRight
      ExplicitLeft = 514
      ExplicitTop = 6
      ExplicitHeight = 308
    end
    inherited GroupBox1: TGroupBox
      Width = 1176
      Height = 264
      ExplicitWidth = 1176
      ExplicitHeight = 264
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1172
        Height = 246
        FooterRowCount = 1
        ImeMode = imDisable
        ParentShowHint = False
        ReadOnly = False
        ShowHint = True
        SumList.Active = True
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ischoose'
            Footers = <>
            Title.Caption = ' '#36873#25321' '
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            ImeMode = imClose
            Title.Caption = #34892#21253#21333#21495
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'sendstationname'
            Footer.ValueType = fvtCount
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#31449
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'tostationname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #30446#30340#22320
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36135#29289#21517#31216
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
            FieldName = 'pieces'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20214#25968
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'sender'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'senderphone'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#20154#30005#35805
            Width = 90
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
            FieldName = 'paymethodvalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20184#27454#26041#24335
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehiclecode'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36710#29260#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #39550#39542#21592#30005#35805
            Width = 106
          end
          item
            EditButtons = <>
            FieldName = 'packtypevalue'
            Footers = <>
            Title.Caption = #34892#21253#31867#22411
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'signbyname'
            Footers = <>
            Title.Caption = #31614#21457#21592
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'signtime'
            Footers = <>
            Title.Caption = #31614#21457#26085#26399
            Width = 142
          end
          item
            EditButtons = <>
            FieldName = 'statusvalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #31614#21457#29366#24577
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21019#24314#26102#38388
            Width = 137
          end
          item
            EditButtons = <>
            FieldName = 'singbillno'
            Footers = <>
            Title.Caption = #31614#21457#21333#21495
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'invoiceno'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#31080#21495
            Visible = False
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'sellbyname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25805#20316#20154
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'weight'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #37325#37327'(kg)'
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'volume'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20307#31215
            Width = 70
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
            FieldName = 'shipprice'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'packfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #32508#21512#26381#21153#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'handfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#35013#21368#36153
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'unloadfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21040#36135#35013#21368#36153
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'insurance'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#38505#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'custodial'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#31649#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'transitfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20013#36716#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insuredamount'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#20215#37329#39069
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'insurancefee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#20215#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'deliveryfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36865#36135#36153
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20854#20182#36153#29992
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21512#35745#37329#39069
          end
          item
            EditButtons = <>
            FieldName = 'location'
            Footers = <>
            Title.Caption = #23384#25918#20301#32622
            Width = 70
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
            FieldName = 'senderaddress'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#20154#22320#22336
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25910#36135#20154#35777#20214#21495#30721
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'consigneeaddress'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25910#36135#20154#22320#22336
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypevalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #35777#20214#31867#22411
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'shiptypevalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#26041#24335
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'valuables'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #26159#21542#36149#37325#29289#21697
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'remak'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36135#29289#25551#36848
            Visible = False
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'updatebyname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20462#25913#20154
            Visible = False
            Width = 70
          end
          item
            Alignment = taRightJustify
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'balancestatusname'
            Footers = <>
            Title.Caption = #32467#31639#29366#24577
            Width = 80
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
    DataSourceName = 'packlist'
    QueryAddress = 'pack/listPack'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_p!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!packtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_p!createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_p!tostationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!sender_OR_p!consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!senderphone_OR_p!consigneephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_p!sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_p!vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!shiptype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!paymethod'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_p!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!singbillno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_p!packno'
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
    AfterScroll = jcdsResultAfterScroll
    Top = 216
    object jcdsResultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsResultPACKTYPE: TWideStringField
      FieldName = 'PACKTYPE'
      Size = 0
    end
    object jcdsResultpacktypevalue: TWideStringField
      FieldKind = fkLookup
      FieldName = 'packtypevalue'
      LookupDataSet = jcdspacktypevalue
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'PACKTYPE'
      Lookup = True
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
    object jcdsResultunloadfee: TFloatField
      FieldName = 'unloadfee'
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
      FieldName = 'sellbyname'
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
    object jcdsResultcustodial: TFloatField
      FieldName = 'custodial'
    end
    object jcdsResulttransitfee: TFloatField
      FieldName = 'transitfee'
    end
    object jcdsResultinsuredamount: TFloatField
      FieldName = 'insuredamount'
    end
    object jcdsResultinsurancefee: TFloatField
      FieldName = 'insurancefee'
    end
    object jcdsResultinsurance: TFloatField
      FieldName = 'insurance'
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
    object jcdsResultischoose: TBooleanField
      FieldName = 'ischoose'
    end
    object jcdsResultsignby: TLargeintField
      FieldName = 'signby'
    end
    object jcdsResultsignbyname: TWideStringField
      FieldName = 'signbyname'
      Size = 0
    end
    object jcdsResultsigntime: TDateTimeField
      FieldName = 'signtime'
    end
    object jcdsResultsingbillno: TWideStringField
      FieldName = 'singbillno'
    end
    object jcdsResultbalancestatus: TWideStringField
      FieldName = 'balancestatus'
    end
    object jcdsResultbalancestatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'balancestatusname'
      LookupDataSet = jcdsbalancestatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'balancestatus'
      Lookup = True
    end
  end
  inherited dsResult: TDataSource
    Left = 768
    Top = 328
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 352
    Top = 240
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
    Left = 616
    Top = 232
  end
  object ilsmalltools: TImageList
    DrawingStyle = dsSelected
    Left = 64
    Top = 320
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
    Left = 176
    Top = 296
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
    Left = 280
    Top = 296
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
    Left = 384
    Top = 296
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
    Left = 496
    Top = 296
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
    Left = 600
    Top = 296
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
    Left = 696
    Top = 296
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
    Left = 816
    Top = 296
  end
  object jcdsrevenue: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'pack/queryrevenue'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
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
    Left = 532
    Top = 232
    object jcdsrevenueacceptpieces: TLargeintField
      FieldName = 'acceptpieces'
    end
    object jcdsrevenueaccepttotalfee: TFloatField
      FieldName = 'accepttotalfee'
    end
    object jcdsrevenuegoodspieces: TLargeintField
      FieldName = 'goodspieces'
    end
    object jcdsrevenuegoodstotalfee: TFloatField
      FieldName = 'goodstotalfee'
    end
    object jcdsrevenuepkuppieces: TLargeintField
      FieldName = 'pkuppieces'
    end
    object jcdsrevenuepkuptotalfee: TFloatField
      FieldName = 'pkuptotalfee'
    end
  end
  object jcdscancelPack: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/cancelPack'
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
        Name = 'pack.packtype'
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
    Left = 736
    Top = 232
  end
  object jcdsbalancestatus: TjsonClientDataSet
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
        Value = 'balancestatus'
      end>
    RemoteServer = DMPublic.jcon
    Left = 880
    Top = 240
  end
  object jcdsQryPackItems: TjsonClientDataSet
    DataSourceName = 'packlist'
    QueryAddress = 'pack/listTotalPack'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_ss!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_ss!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ss!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_sd!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isbukai'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isreprint'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packStockVo.code'
        ParamType = ptOutput
      end
      item
        DataType = ftDate
        Name = 'packStockVo.departdate'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.departtime'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.vehicleno'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.drivername'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packStockVo.unitname'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 984
    Top = 280
  end
  object jcdsUpdatepack: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/updatPackBy'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
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
        Name = 'filter_EQS_p!status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_p!scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'singbillno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 944
    Top = 336
  end
  object jcdsPackIsdepart: TjsonClientDataSet
    DataSourceName = 'havaPackdepartmap'
    QueryAddress = 'pack/havaPackdepart'
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
    Left = 448
    Top = 240
  end
end
