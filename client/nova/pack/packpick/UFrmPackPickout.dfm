inherited FrmPackpickout: TFrmPackpickout
  ActiveControl = NovaEditTakename
  Caption = #34892#21253#20986#24211
  ClientHeight = 480
  ClientWidth = 764
  Font.Charset = ANSI_CHARSET
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 770
  ExplicitHeight = 508
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 764
    Height = 435
    ExplicitWidth = 764
    ExplicitHeight = 435
    DesignSize = (
      764
      435)
    inherited Bevel1: TBevel
      Top = 429
      Width = 730
      ExplicitTop = 312
      ExplicitWidth = 488
    end
    object GroupBox1: TGroupBox
      Left = 29
      Top = 14
      Width = 301
      Height = 403
      Align = alCustom
      Caption = #36135#29289#20449#24687
      TabOrder = 0
      object lbl7: TLabel
        Left = 21
        Top = 159
        Width = 56
        Height = 14
        Caption = #21253#35013#21697#31867
      end
      object lbl8: TLabel
        Left = 49
        Top = 198
        Width = 28
        Height = 14
        Caption = #20214#25968
      end
      object lbl9: TLabel
        Left = 35
        Top = 269
        Width = 42
        Height = 14
        Caption = #25910#36135#20154
      end
      object lbl10: TLabel
        Left = 22
        Top = 306
        Width = 56
        Height = 14
        Caption = #30005#35805#21495#30721
      end
      object lbl11: TLabel
        Left = 20
        Top = 76
        Width = 56
        Height = 14
        Caption = #34892#21253#21333#21495
      end
      object lbl12: TLabel
        Left = 21
        Top = 36
        Width = 56
        Height = 14
        Caption = #20837#24211#26085#26399
      end
      object lbl2: TLabel
        Left = 34
        Top = 118
        Width = 42
        Height = 14
        Caption = #21457#36135#31449
      end
      object lbl3: TLabel
        Left = 35
        Top = 234
        Width = 42
        Height = 14
        Caption = #36135#31649#21592
      end
      object lbl17: TLabel
        Left = 21
        Top = 344
        Width = 56
        Height = 14
        Caption = #20195#25910#36816#36153
      end
      object Label1: TLabel
        Left = 20
        Top = 377
        Width = 56
        Height = 14
        Caption = #20195#25910#36135#27454
      end
      object nvedtname: TNovaEdit
        Left = 83
        Top = 156
        Width = 160
        Height = 22
        Enabled = False
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
      end
      object nvedtpieces: TNovaEdit
        Left = 83
        Top = 195
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 3
        TabOrder = 4
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
      object nvedtsignaturer: TNovaEdit
        Left = 83
        Top = 265
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 20
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
      object nvedtphone: TNovaEdit
        Left = 84
        Top = 302
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 18
        TabOrder = 7
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
        Left = 83
        Top = 73
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 50
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
      object dtppickupenddate: TDateTimePicker
        Left = 83
        Top = 33
        Width = 160
        Height = 22
        Date = 41492.639888414350000000
        Format = 'yyyy-MM-dd'
        Time = 41492.639888414350000000
        Enabled = False
        TabOrder = 0
      end
      object nvhelpStation: TNovaHelp
        Left = 83
        Top = 113
        Width = 160
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 2
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
        Left = 83
        Top = 230
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 50
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #22995#21517
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'code'
            Title.Caption = #24037#21495
            Width = 70
            Visible = True
          end>
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
      object nvedtgoodsprice: TNovaEdit
        Left = 84
        Top = 375
        Width = 160
        Height = 22
        MaxLength = 9
        ReadOnly = True
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
      object NovaEdtshipprice: TNovaEdit
        Left = 85
        Top = 340
        Width = 160
        Height = 22
        MaxLength = 9
        ReadOnly = True
        TabOrder = 9
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
    object grp1: TGroupBox
      Left = 367
      Top = 14
      Width = 330
      Height = 403
      Caption = #25552#39046#20449#24687
      TabOrder = 1
      object lbl13: TLabel
        Left = 44
        Top = 198
        Width = 56
        Height = 14
        Caption = #21512#35745#37329#39069
      end
      object lbl14: TLabel
        Left = 30
        Top = 74
        Width = 70
        Height = 14
        Caption = #20445#31649#26381#21153#36153
      end
      object lbl15: TLabel
        Left = 30
        Top = 118
        Width = 70
        Height = 14
        Caption = #36229#26102#20445#31649#36153
      end
      object lbl16: TLabel
        Left = 44
        Top = 35
        Width = 56
        Height = 14
        Caption = #25552#39046#26085#26399
      end
      object lbl4: TLabel
        Left = 58
        Top = 159
        Width = 42
        Height = 14
        Caption = #25910#27454#21592
      end
      object lbl5: TLabel
        Left = 58
        Top = 234
        Width = 42
        Height = 14
        Caption = #25552#39046#20154
      end
      object lbl6: TLabel
        Left = 58
        Top = 268
        Width = 42
        Height = 14
        Caption = #35777#20214#21495
      end
      object nvedttotalfee: TNovaEdit
        Left = 110
        Top = 193
        Width = 160
        Height = 22
        MaxLength = 9
        ReadOnly = True
        TabOrder = 3
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
      object nvedtpackfee: TNovaEdit
        Left = 110
        Top = 72
        Width = 160
        Height = 22
        MaxLength = 7
        TabOrder = 1
        Text = '0'
        OnChange = nvedtpackfeeChange
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
      object mmomtakecertificateno: TMemo
        Left = 110
        Top = 267
        Width = 160
        Height = 20
        MaxLength = 50
        TabOrder = 5
        WantReturns = False
      end
      object dtppickupdate: TDateTimePicker
        Left = 110
        Top = 30
        Width = 160
        Height = 22
        Date = 41492.639888414350000000
        Format = 'yyyy-MM-dd'
        Time = 41492.639888414350000000
        TabOrder = 0
      end
      object Novasellbyname: TNovaHelp
        Left = 110
        Top = 156
        Width = 160
        Height = 22
        MaxLength = 50
        TabOrder = 2
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
            Title.Caption = #22995#21517
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'code'
            Title.Caption = #24037#21495
            Width = 60
            Visible = True
          end>
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
      object NovaEditTakename: TNovaEdit
        Left = 110
        Top = 230
        Width = 160
        Height = 22
        MaxLength = 20
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
      object Nedtnvedtpenalty: TNovaEdit
        Left = 106
        Top = 113
        Width = 160
        Height = 22
        Enabled = False
        MaxLength = 18
        ReadOnly = True
        TabOrder = 6
        Text = '0'
        ValueTrim = '0'
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
  end
  inherited pnlOperation: TPanel
    Top = 435
    Width = 764
    ExplicitTop = 435
    ExplicitWidth = 764
    inherited bbtnSave: TBitBtn
      Left = 247
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 247
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 391
      Top = 6
      ExplicitLeft = 391
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 801
    Top = 400
  end
  object jcdspackpicupsave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savepackpickup'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packpickup.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.packid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.shipprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.goodsprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.handfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.packfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.penalty'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.totalfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.signaturer'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.signdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.operator'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.remak'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packpickup.takecertificateno'
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
        Name = 'packpickupid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packpickups'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 340
    Top = 208
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
        Name = 'billinusenextform'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billtypecode'
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
    Left = 340
    Top = 296
  end
end
