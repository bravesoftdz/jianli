inherited FrmPackpick: TFrmPackpick
  ActiveControl = nvedtpackno
  Caption = #34892#21253#25552#39046
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
      Left = 17
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl3: TLabel
      Left = 462
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl4: TLabel
      Left = 243
      Top = 22
      Width = 56
      Height = 14
      Caption = #25805#20316#26102#38388
    end
    object Label1: TLabel
      Left = 222
      Top = 59
      Width = 77
      Height = 14
      Caption = #25176#36816'/'#25910#36135#20154
    end
    object Label3: TLabel
      Left = 257
      Top = 98
      Width = 42
      Height = 14
      Caption = #30446#30340#22320
    end
    object Label4: TLabel
      Left = 674
      Top = 60
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object Label5: TLabel
      Left = 438
      Top = 59
      Width = 56
      Height = 14
      Caption = #30005#35805#21495#30721
    end
    object Label7: TLabel
      Left = 646
      Top = 23
      Width = 56
      Height = 14
      Caption = #20184#27454#26041#24335
    end
    object Label8: TLabel
      Left = 660
      Top = 98
      Width = 42
      Height = 14
      Caption = #25805#20316#21592
    end
    object Label9: TLabel
      Left = 452
      Top = 98
      Width = 42
      Height = 14
      Caption = #36710#29260#21495
    end
    object lblpackno: TLabel
      Left = 16
      Top = 59
      Width = 56
      Height = 14
      Caption = #21463#29702#21333#21495
    end
    object Label6: TLabel
      Left = 30
      Top = 98
      Width = 42
      Height = 14
      Caption = #21457#36135#31449
    end
    object dtpstartdate: TDateTimePicker
      Left = 305
      Top = 19
      Width = 121
      Height = 22
      Date = 41494.639888414350000000
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 1
    end
    object dtpenddate: TDateTimePicker
      Left = 504
      Top = 19
      Width = 121
      Height = 22
      Date = 41494.639888414350000000
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 2
    end
    object nvedtname: TNovaEdit
      Left = 305
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
    object nvhelptostation1: TNovaHelp
      Left = 305
      Top = 95
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 10
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
      Left = 79
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
      Left = 713
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
      Left = 504
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
      Left = 713
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
      Left = 504
      Top = 95
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
    object nvedtpackno: TNovaEdit
      Left = 79
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
    object GroupBox2: TGroupBox
      Left = 918
      Top = 19
      Width = 245
      Height = 48
      Anchors = [akTop, akRight]
      Caption = #24403#21069#25552#39046#21333#21495
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Visible = False
      object lbpackrebill: TLabel
        Left = 3
        Top = 23
        Width = 96
        Height = 16
        Caption = '000000000000'
      end
      object Label10: TLabel
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
    object GroupBox3: TGroupBox
      Left = 918
      Top = 74
      Width = 245
      Height = 48
      Anchors = [akTop, akRight]
      Caption = #24403#21069#25176#36816#21333#21495
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      Visible = False
      object lbpackbill: TLabel
        Left = 3
        Top = 23
        Width = 96
        Height = 16
        Caption = '000000000000'
      end
      object Label11: TLabel
        Left = 120
        Top = 23
        Width = 64
        Height = 16
        Caption = #21097#20313#24352#25968
      end
      object lbpackbillnum: TLabel
        Left = 191
        Top = 23
        Width = 8
        Height = 16
        Caption = '0'
      end
    end
    object Nvhelpsendstation: TNovaHelp
      Left = 78
      Top = 96
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 10
      TabOrder = 12
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
    object nvhlpseller: TNovaHelp
      Left = 719
      Top = 95
      Width = 108
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 13
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
      AutoSize = True
      Caption = '&F2.'#36716#33267#23427#31449
      OnClick = tbtnInsertClick
      ExplicitLeft = 92
      ExplicitWidth = 88
    end
    inherited tbtnEdit: TToolButton
      Left = 180
      Caption = '&F3.'#25552#39046
      ImageIndex = 12
      OnClick = tbtnEditClick
      ExplicitLeft = 180
      ExplicitWidth = 84
    end
    inherited tbtnDelete: TToolButton
      Left = 264
      Caption = '&F4.'#20316#24223
      Visible = False
      OnClick = tbtnDeleteClick
      ExplicitLeft = 264
      ExplicitWidth = 84
    end
    inherited ToolButton50: TToolButton
      Left = 348
      Caption = '&F5.'#20013#36716#36816#36755
      ImageIndex = 16
      Visible = True
      OnClick = ToolButton50Click
      ExplicitLeft = 348
      ExplicitWidth = 88
    end
    inherited ToolButton51: TToolButton
      Left = 436
      ImageIndex = 9
      ExplicitLeft = 436
      ExplicitWidth = 31
    end
    inherited tbtn3: TToolButton
      Left = 467
      Width = 9
      ExplicitLeft = 467
      ExplicitWidth = 9
    end
    inherited tbtnSave: TToolButton
      Left = 476
      AutoSize = True
      Caption = ''
      ImageIndex = 51
      Visible = False
      ExplicitLeft = 476
      ExplicitWidth = 31
    end
    inherited tbtnCancel: TToolButton
      Left = 507
      Caption = '&F7.'#21462#28040#25552#39046
      OnClick = tbtnCancelClick
      ExplicitLeft = 507
      ExplicitWidth = 84
    end
    inherited ToolButton52: TToolButton
      Left = 591
      ExplicitLeft = 591
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 609
      ExplicitLeft = 609
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 627
      Visible = False
      ExplicitLeft = 627
    end
    inherited tbtnInfo: TToolButton
      Left = 635
      ExplicitLeft = 635
      ExplicitWidth = 84
    end
    inherited tbtn5: TToolButton
      Left = 719
      ExplicitLeft = 719
    end
    inherited tbtnExcel: TToolButton
      Left = 727
      ExplicitLeft = 727
      ExplicitWidth = 84
    end
    inherited tbtnPrinter: TToolButton
      Left = 811
      OnClick = nil
      ExplicitLeft = 811
      ExplicitWidth = 84
    end
    inherited tbtn6: TToolButton
      Left = 895
      ExplicitLeft = 895
    end
    inherited tbtnClose: TToolButton
      Left = 903
      ExplicitLeft = 903
      ExplicitWidth = 84
    end
    object tbtnpackbill: TToolButton
      Left = 987
      Top = 0
      Caption = #34917#24320
      ImageIndex = 45
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
        OnGetCellParams = dbgrdhResultGetCellParams
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        Columns = <
          item
            AutoDropDown = True
            EditButtons = <>
            FieldName = 'ischoose'
            Footers = <>
            Title.Caption = #36873#25321
            Visible = False
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'sendstationname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#31449
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'tostationname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #30446#30340#22320
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'zhuanyuntostationname'
            Footers = <>
            Title.Caption = #36716#36816#33267
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21463#29702#21333#21495
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36135#29289#21517#31216
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'vehiclecode'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36710#29260#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vcstatus'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36135#29289#29366#24577
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #20837#24211#26085#26399
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'packedname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21253#35013
            Width = 50
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
            FieldName = 'pieces'
            Footer.ValueType = fvtSum
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
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'senderphone'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#20154#30005#35805
            Visible = False
            Width = 90
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
            Title.Caption = #21253#35013#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'handfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21457#36135#35013#21368#36153
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'unloadfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21040#36135#35013#21368#36153
            Visible = False
            Width = 80
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
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#20215#37329#39069
            ToolTips = True
            Visible = False
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'packprice'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20195#25910#36135#27454
            Width = 70
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
            FieldName = 'deliveryfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #36865#36135#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'locationname'
            Footers = <>
            Title.Caption = #23384#25918#20301#32622
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'sellbyname'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25805#20316#20154
            Width = 100
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
            FieldName = 'takename'
            Footers = <>
            Title.Caption = #25552#39046#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'takecertificateno'
            Footers = <>
            Title.Caption = #25552#39046#20154#35777#20214
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'signtime'
            Footers = <>
            Title.Caption = #25552#39046#26102#38388
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #21019#24314#26085#26399
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'remak'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #22791#27880
            Width = 80
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
            ImeMode = imClose
            Title.Caption = #29677#27425
            Visible = False
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
            FieldName = 'weight'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #37325#37327'(kg)'
            Visible = False
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'volume'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20307#31215
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'insurance'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#38505#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'insurancefee'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20445#20215#36153
            Visible = False
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20854#20182#36153#29992
            Visible = False
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'senderaddress'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#20154#22320#22336
            Visible = False
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25910#36135#20154#35777#20214#21495#30721
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'consigneeaddress'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25910#36135#20154#22320#22336
            Visible = False
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypevalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #35777#20214#31867#22411
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'shiptypevalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #25176#36816#26041#24335
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'paymethodvalue'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #20184#27454#26041#24335
            Visible = False
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'signbyname'
            Footers = <>
            Title.Caption = #25805#20316#21592
            Visible = False
            Width = 70
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
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'valuables'
            Footers = <>
            ImeMode = imClose
            Title.Caption = #26159#21542#36149#37325#29289#21697
            Visible = False
            Width = 101
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
        Name = 'filter_EQL_p!sendstationid'
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
  object jcdspacksave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savePack'
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
        Name = 'pack.goodtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sendstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.tostationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.invoiceno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sellby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.pieces'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.weight'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.volume'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packed'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.shipprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.unloadfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.handfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.custodial'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.transitfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insuredamount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insurancefee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.insurance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.deliveryfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.otherfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.totalfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.location'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.sender'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.senderphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.senderaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consignee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consigneephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.consigneeaddress'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.shiptype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.paymethod'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.valuables'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.packtturnoverid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.remak'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.signby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.signtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.onlycode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.clientid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.integraterprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.servicefee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.usertype'
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
        Name = 'packid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.clientid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.price'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packIntegraterPay.integrater'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.collectstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.recyclestatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.collectby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pack.collectdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 436
    Top = 352
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
    Left = 280
    Top = 352
  end
end
