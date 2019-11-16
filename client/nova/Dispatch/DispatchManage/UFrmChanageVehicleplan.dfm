inherited FrmChanageVehicleplan: TFrmChanageVehicleplan
  Caption = #39030#29677#20449#24687
  ClientHeight = 412
  ClientWidth = 715
  OnShow = FormShow
  ExplicitWidth = 721
  ExplicitHeight = 444
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 715
    Height = 367
    ExplicitWidth = 715
    ExplicitHeight = 367
    inherited Bevel1: TBevel
      Top = 359
      Width = 681
      ExplicitTop = 356
      ExplicitWidth = 520
    end
    object GroupBox1: TGroupBox
      Left = 35
      Top = 21
      Width = 296
      Height = 316
      Caption = #33829#36816#29677#27425#20449#24687
      TabOrder = 0
      object lbl13: TLabel
        Left = 33
        Top = 80
        Width = 60
        Height = 18
        Caption = #36816#33829#32447#36335
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl14: TLabel
        Left = 48
        Top = 124
        Width = 45
        Height = 18
        Caption = #29677#27425#21495
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl16: TLabel
        Left = 33
        Top = 169
        Width = 60
        Height = 18
        Caption = #21457#36710#26102#38388
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl17: TLabel
        Left = 29
        Top = 258
        Width = 64
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #24231#20301#25968
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl15: TLabel
        Left = 33
        Top = 213
        Width = 60
        Height = 18
        Caption = #21806#31080#36710#22411
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl1: TLabel
        Left = 33
        Top = 36
        Width = 60
        Height = 18
        Caption = #21457#36710#26085#26399
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object NvEdtRoute: TNovaEdit
        Left = 101
        Top = 77
        Width = 150
        Height = 22
        Enabled = False
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
      end
      object nvedtcode: TNovaEdit
        Left = 101
        Top = 122
        Width = 150
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
      object NvedtDeparttimeL: TNovaEdit
        Left = 101
        Top = 166
        Width = 150
        Height = 22
        Enabled = False
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
      end
      object nvedtSeatnum: TNovaEdit
        Left = 101
        Top = 256
        Width = 150
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
      object nvedttickettype: TNovaEdit
        Left = 101
        Top = 211
        Width = 150
        Height = 22
        Enabled = False
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
      object NovaEdtDepartDate: TNovaEdit
        Left = 101
        Top = 33
        Width = 150
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
      end
    end
    object GroupBox2: TGroupBox
      Left = 337
      Top = 21
      Width = 328
      Height = 316
      Caption = #35745#21010#33829#36816#21333#20301#20449#24687
      TabOrder = 1
      object lbl3: TLabel
        Left = 45
        Top = 75
        Width = 60
        Height = 18
        Caption = #35745#21010#36710#36742
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 49
        Top = 36
        Width = 56
        Height = 14
        Caption = #33829#36816#21333#20301
      end
      object lbl6: TLabel
        Left = 60
        Top = 114
        Width = 45
        Height = 18
        Caption = #27491#39550#39542
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl7: TLabel
        Left = 41
        Top = 153
        Width = 64
        Height = 18
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21103#39550#39542'1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl8: TLabel
        Left = 41
        Top = 192
        Width = 64
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21103#39550#39542'2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl9: TLabel
        Left = 41
        Top = 231
        Width = 64
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21103#39550#39542'3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl10: TLabel
        Left = 41
        Top = 270
        Width = 64
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = #20056#21153#21592
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 271
        Top = 35
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
      object lbl4: TLabel
        Left = 271
        Top = 74
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
      object nvhlpdriver: TNovaHelp
        Left = 111
        Top = 110
        Width = 150
        Height = 22
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
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHelpVehicleno: TNovaHelp
        Left = 111
        Top = 72
        Width = 150
        Height = 22
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
            Title.Caption = #36710#29260#21495#30721
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'rationseatnum'
            Title.Caption = #24231#20301#25968
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'brandname'
            Title.Caption = #21378#29260
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 150
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
      object nvhlpcopilot1: TNovaHelp
        Left = 111
        Top = 150
        Width = 150
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
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlpcopilot2: TNovaHelp
        Left = 111
        Top = 192
        Width = 150
        Height = 22
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
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlpcopilot3: TNovaHelp
        Left = 111
        Top = 231
        Width = 150
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
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'DriverHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object nvhlpsteward: TNovaHelp
        Left = 111
        Top = 270
        Width = 150
        Height = 22
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
            Width = 50
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'StewardHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHUnit: TNovaHelp
        Left = 111
        Top = 31
        Width = 150
        Height = 22
        CharCase = ecUpperCase
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'NAME'
            Title.Caption = #32447#36335#21517#31216
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 60
            Visible = True
          end>
        HelpOptions.HelpHeight = 300
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'UnitHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 367
    Width = 715
    ExplicitTop = 367
    ExplicitWidth = 715
    inherited bbtnSave: TBitBtn
      Left = 232
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 232
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 407
      Top = 6
      ExplicitLeft = 407
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 120
    Top = 8
  end
  object jcdsChanageVehicleplan: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/chanagePlanVehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.scheduleplan.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.planunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.planvehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.plandriver1.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.plandriver2.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.plandriver3.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.plandriver4.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclepeopleplan.plansteward1.id'
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
    Left = 304
    Top = 288
  end
end
