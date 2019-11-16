inherited FrmCancelCheckticket: TFrmCancelCheckticket
  Caption = 'FrmCancelCheckticket'
  ClientHeight = 348
  ClientWidth = 714
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 720
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 714
    Height = 303
    ExplicitWidth = 714
    ExplicitHeight = 303
    inherited Bevel1: TBevel
      Top = 295
      Width = 680
      ExplicitTop = 275
      ExplicitWidth = 678
    end
    object lbl1: TLabel
      Left = 493
      Top = 27
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object Label3: TLabel
      Left = 203
      Top = 28
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object Label4: TLabel
      Left = 362
      Top = 28
      Width = 42
      Height = 14
      Caption = #24231#20301#21495
    end
    object Label10: TLabel
      Left = 21
      Top = 28
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 479
      Top = 55
      Width = 42
      Height = 14
      Caption = #35777#20214#21495
      Visible = False
    end
    object grp1: TGroupBox
      Tag = 99
      Left = 21
      Top = 87
      Width = 667
      Height = 183
      Caption = #36710#31080#20449#24687
      Color = clBtnHighlight
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object LabcurFromStation: TLabel
        Left = 42
        Top = 34
        Width = 70
        Height = 14
        Caption = #31119#30000#23458#36816#31449
        Transparent = True
      end
      object lbl2: TLabel
        Left = 149
        Top = 36
        Width = 14
        Height = 14
        Caption = #33267
        Transparent = True
      end
      object LabcurTostation: TLabel
        Left = 180
        Top = 32
        Width = 68
        Height = 16
        Caption = #24191#24030#30465#31449
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object bvl1: TBevel
        Left = 32
        Top = 49
        Width = 104
        Height = 5
        Shape = bsBottomLine
      end
      object bvl2: TBevel
        Left = 174
        Top = 48
        Width = 114
        Height = 5
        Shape = bsBottomLine
      end
      object bvl3: TBevel
        Left = 552
        Top = 48
        Width = 60
        Height = 5
        Shape = bsBottomLine
      end
      object LabcurSeatnum: TLabel
        Left = 567
        Top = 30
        Width = 22
        Height = 19
        Caption = '45'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #26032#23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lbl3: TLabel
        Left = 310
        Top = 34
        Width = 28
        Height = 14
        Caption = #31080#20215
        Transparent = True
      end
      object LabcurPrice: TLabel
        Left = 344
        Top = 30
        Width = 102
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = '120.00'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #26032#23435#20307
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object bvl4: TBevel
        Left = 344
        Top = 48
        Width = 102
        Height = 5
        Shape = bsBottomLine
      end
      object shp1: TShape
        Left = 25
        Top = 71
        Width = 576
        Height = 62
      end
      object lbl4: TLabel
        Left = 67
        Top = 80
        Width = 56
        Height = 14
        Caption = #20056#36710#26085#26399
      end
      object LabcurDepartdate: TLabel
        Left = 31
        Top = 110
        Width = 123
        Height = 16
        Alignment = taCenter
        Caption = '2010'#24180'12'#26376'12'#26085
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl5: TBevel
        Left = 25
        Top = 100
        Width = 576
        Height = 3
        Shape = bsBottomLine
      end
      object bvl6: TBevel
        Left = 164
        Top = 72
        Width = 2
        Height = 60
      end
      object bvl7: TBevel
        Left = 257
        Top = 72
        Width = 2
        Height = 60
      end
      object lbl5: TLabel
        Left = 371
        Top = 82
        Width = 42
        Height = 14
        Caption = #39564#31080#21475
      end
      object LabcurEntrance: TLabel
        Left = 353
        Top = 109
        Width = 75
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = '12'#21495#21345#20301
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl6: TLabel
        Left = 456
        Top = 80
        Width = 42
        Height = 14
        Caption = #20056#36710#24211
      end
      object LabcurBuspark: TLabel
        Left = 440
        Top = 109
        Width = 83
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = '12'#21495#21345#20301
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl8: TBevel
        Left = 434
        Top = 71
        Width = 2
        Height = 60
      end
      object lbl8: TLabel
        Left = 198
        Top = 80
        Width = 28
        Height = 14
        Caption = #29677#27425
      end
      object LabcurCode: TLabel
        Left = 187
        Top = 109
        Width = 45
        Height = 16
        Caption = '89877'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl9: TLabel
        Left = 269
        Top = 80
        Width = 56
        Height = 14
        Caption = #21457#36710#26102#38388
      end
      object LabcurDeparttime: TLabel
        Left = 273
        Top = 109
        Width = 45
        Height = 16
        Caption = '12:45'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bvl10: TBevel
        Left = 344
        Top = 72
        Width = 2
        Height = 60
      end
      object LabcurTickettype: TLabel
        Left = 452
        Top = 33
        Width = 42
        Height = 14
        Caption = #65288#20840#65289
      end
      object lbllabremark: TLabel
        Left = 44
        Top = 148
        Width = 42
        Height = 14
        Caption = #22791#27880#65306
      end
      object LabcurRemark: TLabel
        Left = 87
        Top = 148
        Width = 84
        Height = 14
        Caption = 'LabcurRemark'
      end
      object lbl10: TLabel
        Left = 518
        Top = 35
        Width = 28
        Height = 14
        Caption = #24231#21495
      end
      object bvl11: TBevel
        Left = 529
        Top = 72
        Width = 2
        Height = 60
      end
      object LabcurTicketStatus: TLabel
        Left = 542
        Top = 109
        Width = 47
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = #27491#24120
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 552
        Top = 80
        Width = 28
        Height = 14
        Caption = #29366#24577
      end
    end
    object NovaEdtTicketNo: TNovaEdit
      Left = 527
      Top = 24
      Width = 156
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 4
      OnKeyPress = NovaEdtTicketNoKeyPress
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
    object dtpDepartdate: TDateTimePicker
      Left = 84
      Top = 24
      Width = 110
      Height = 22
      Date = 40829.815839120370000000
      Time = 40829.815839120370000000
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnChange = dtpDepartdateChange
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 237
      Top = 24
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          FieldName = 'endstationname'
          Title.Caption = #32456#28857#31449
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'departtime'
          Title.Caption = #21457#36710#26102#38388
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #29677#27425#21495
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 250
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleplanHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQD_t!departdate'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object NovaEdtSeatno: TNovaEdit
      Left = 410
      Top = 24
      Width = 75
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 3
      TabOrder = 3
      OnExit = NovaEdtSeatnoExit
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
    object edtcertificateno: TNovaEdit
      Left = 527
      Top = 52
      Width = 156
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 5
      Visible = False
      OnKeyPress = NovaEdtTicketNoKeyPress
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
  end
  inherited pnlOperation: TPanel
    Top = 303
    Width = 714
    ExplicitTop = 303
    ExplicitWidth = 714
    inherited bbtnSave: TBitBtn
      Left = 226
      Top = 6
      Caption = '&S '#36864#26816
      OnClick = bbtnSaveClick
      ExplicitLeft = 226
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 363
      Top = 6
      OnClick = bbtnCloseClick
      ExplicitLeft = 363
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 384
    Top = 208
  end
  object jscdcancelCheckticket: TjsonClientDataSet
    DataSourceName = 'ticketselllist'
    SaveAddress = 'checkticket/cancelCheckticket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleplanid'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'mixcheck'
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
    Left = 488
    Top = 216
  end
  object jscdQryTicket: TjsonClientDataSet
    DataSourceName = 'ticketlist'
    QueryAddress = 'checkticket/qryTicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'certificateno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 208
  end
  object jscdQryIsMix: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/queryisMix'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'mixcheck'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 584
    Top = 200
  end
  object jscdverifystation: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/verifystation'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'verifystation'
        ParamType = ptOutput
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
        DataType = ftString
        Name = 'filter_INS_t!departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 328
    Top = 224
  end
end
