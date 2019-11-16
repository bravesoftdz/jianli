inherited frmbookticketend: Tfrmbookticketend
  Width = 567
  Height = 397
  Font.Charset = DEFAULT_CHARSET
  Font.Name = #23435#20307
  ExplicitWidth = 567
  ExplicitHeight = 397
  inherited pnlticketreceipt: TPanel
    Top = 177
    Width = 567
    TabOrder = 1
    ExplicitTop = 177
    ExplicitWidth = 567
    inherited lblticketnum_: TLabel
      Left = 56
      Height = 15
      ExplicitLeft = 56
      ExplicitHeight = 15
    end
    inherited lblticketnum: TLabel
      Left = 108
      ExplicitLeft = 108
    end
    inherited lblticketreceivablenum_: TLabel
      Height = 15
      ExplicitHeight = 15
    end
    inherited bvlticketreceipt: TBevel
      Width = 567
      ExplicitWidth = 564
    end
  end
  inherited pnlrr: TPanel
    Top = 271
    Width = 567
    Height = 90
    TabOrder = 2
    ExplicitTop = 271
    ExplicitWidth = 567
    ExplicitHeight = 90
    inherited bvlrr: TBevel
      Width = 567
      ExplicitWidth = 564
    end
    inherited lblreceivablenum_: TLabel
      Left = 334
      Top = 20
      Height = 15
      ExplicitLeft = 334
      ExplicitTop = 20
      ExplicitHeight = 15
    end
    inherited lblreceivablenum: TLabel
      Left = 398
      Top = 21
      ExplicitLeft = 398
      ExplicitTop = 21
    end
    object lblpassword: TLabel
      Left = 54
      Top = 63
      Width = 60
      Height = 15
      Caption = #21462#31080#23494#30721
      Visible = False
    end
    object nvedtpassword: TNovaEdit
      Left = 120
      Top = 59
      Width = 177
      Height = 23
      MaxLength = 50
      TabOrder = 0
      Text = '123456'
      Visible = False
      ValueTrim = '123456'
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
    object chkautocancel: TCheckBox
      Left = 3
      Top = 23
      Width = 111
      Height = 17
      Caption = #33258#21160#21462#28040#30041#20301
      TabOrder = 1
      OnClick = chkautocancelClick
    end
    object dtpautocanceldate: TDateTimePicker
      Left = 120
      Top = 20
      Width = 102
      Height = 23
      Date = 40701.439687500000000000
      Time = 40701.439687500000000000
      DateMode = dmUpDown
      TabOrder = 2
    end
    object dtpautocanceltime: TDateTimePicker
      Left = 223
      Top = 20
      Width = 74
      Height = 23
      Date = 40701.439687500000000000
      Format = 'HH:mm'
      Time = 40701.439687500000000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 3
    end
  end
  object gbadvanced: TGroupBox
    Left = 0
    Top = 0
    Width = 567
    Height = 177
    Align = alTop
    Caption = #23458#25143#20449#24687
    TabOrder = 0
    DesignSize = (
      567
      177)
    object lbl6: TLabel
      Left = 412
      Top = 68
      Width = 30
      Height = 15
      Caption = #23398#21382
    end
    object lbl12: TLabel
      Left = 223
      Top = 100
      Width = 60
      Height = 15
      Caption = #23478#24237#30005#35805
    end
    object lbl13: TLabel
      Left = 25
      Top = 124
      Width = 60
      Height = 15
      Caption = #23478#24237#20303#22336
    end
    object lbl5: TLabel
      Left = 25
      Top = 152
      Width = 135
      Height = 15
      Caption = #22312#25105#21496#20174#20107#21830#19994#27963#21160
      Visible = False
    end
    object lbl10: TLabel
      Left = 25
      Top = 99
      Width = 60
      Height = 15
      Caption = #31227#21160#30005#35805
    end
    object Label1: TLabel
      Left = 398
      Top = 29
      Width = 30
      Height = 15
      Caption = #22995#21517
    end
    object Label2: TLabel
      Left = 25
      Top = 28
      Width = 60
      Height = 15
      Caption = #35777#20214#21495#30721
    end
    object Label3: TLabel
      Left = 225
      Top = 28
      Width = 60
      Height = 15
      Caption = #35777#20214#31867#22411
    end
    object lbl7: TLabel
      Left = 55
      Top = 70
      Width = 30
      Height = 15
      Caption = #24615#21035
    end
    object lbl4: TLabel
      Left = 223
      Top = 71
      Width = 60
      Height = 15
      Caption = #20986#29983#26085#26399
    end
    object bvl1: TBevel
      Left = 13
      Top = 56
      Width = 541
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      Style = bsRaised
      ExplicitWidth = 647
    end
    object dbedtMOBILEPHONE: TDBEdit
      Left = 87
      Top = 95
      Width = 121
      Height = 23
      DataField = 'MOBILEPHONE'
      DataSource = dscustom
      TabOrder = 7
    end
    object dbedtFamilyPhone: TDBEdit
      Left = 292
      Top = 93
      Width = 121
      Height = 23
      DataField = 'FAMILYPHONE'
      DataSource = dscustom
      TabOrder = 8
    end
    object dbedtAdress: TDBEdit
      Left = 87
      Top = 124
      Width = 453
      Height = 23
      DataField = 'FAMILYADDRESS'
      DataSource = dscustom
      TabOrder = 9
    end
    object dbmmoRemark: TDBMemo
      Left = 25
      Top = 174
      Width = 515
      Height = 19
      DataField = 'remarks'
      DataSource = dscustom
      ScrollBars = ssVertical
      TabOrder = 10
      Visible = False
    end
    object dblkcbbEDUCATION: TDBLookupComboBox
      Left = 448
      Top = 64
      Width = 92
      Height = 23
      DataField = 'EDUCATION'
      DataSource = dscustom
      KeyField = 'code'
      ListField = 'value'
      ListSource = dsEducation
      TabOrder = 6
    end
    object dbedtNAME: TDBEdit
      Left = 432
      Top = 24
      Width = 108
      Height = 23
      DataField = 'NAME'
      DataSource = dscustom
      TabOrder = 2
    end
    object dbedtCERTIFICATENO: TDBEdit
      Left = 87
      Top = 24
      Width = 121
      Height = 23
      DataField = 'CERTIFICATENO'
      DataSource = dscustom
      TabOrder = 0
    end
    object dblkcbbCERTIFICATETYPE: TDBLookupComboBox
      Left = 289
      Top = 24
      Width = 91
      Height = 23
      DataField = 'CERTIFICATETYPE'
      DataSource = dscustom
      KeyField = 'code'
      ListField = 'value'
      ListSource = dsCERTIFICATETYPE
      TabOrder = 1
    end
    object rbMan: TRadioButton
      Left = 87
      Top = 67
      Width = 35
      Height = 18
      Caption = #30007
      Checked = True
      TabOrder = 3
      TabStop = True
    end
    object rbGrile: TRadioButton
      Left = 128
      Top = 67
      Width = 33
      Height = 17
      Caption = #22899
      TabOrder = 4
      TabStop = True
    end
    object dbehdtedtbirthday: TDBDateTimeEditEh
      Left = 292
      Top = 64
      Width = 109
      Height = 23
      DataField = 'birthday'
      DataSource = dscustom
      EditButtons = <>
      TabOrder = 5
      Visible = True
      EditFormat = 'YYYY-MM-DD'
    end
  end
  object pnlservicefee: TPanel
    Left = 0
    Top = 229
    Width = 567
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblservicefee_: TLabel
      Left = 184
      Top = 5
      Width = 75
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #26381#21153#36153#24212#25910
    end
    object lblservicefee: TLabel
      Left = 263
      Top = -4
      Width = 18
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '0'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblserviceprice: TLabel
      Left = 26
      Top = 6
      Width = 75
      Height = 15
      Caption = #35746#31080#26381#21153#36153
    end
    object lblpropotion: TLabel
      Left = 152
      Top = 6
      Width = 8
      Height = 15
      Caption = '%'
    end
    object nvedtservicefee: TNovaEdit
      Left = 107
      Top = 3
      Width = 39
      Height = 23
      Color = clBtnFace
      MaxLength = 50
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 0
      Text = '1'
      ValueTrim = '1'
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
  object dsEducation: TDataSource
    DataSet = jsoncdsEducation
    Left = 184
    Top = 168
  end
  object jsoncdsEducation: TjsonClientDataSet
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
        Value = 'employee'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'education'
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 168
  end
  object jsoncdsCustom: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQL_c!id'
        ParamType = ptInput
        Value = '0'
      end
      item
        DataType = ftInteger
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
    Top = 248
  end
  object dsCERTIFICATETYPE: TDataSource
    DataSet = jsoncdsCERTIFICATETYPE
    Left = 376
    Top = 152
  end
  object jsoncdsCERTIFICATETYPE: TjsonClientDataSet
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
    Left = 416
    Top = 152
  end
  object dscustom: TDataSource
    DataSet = jsoncdsCustom
    OnDataChange = dscustomDataChange
    Left = 424
    Top = 224
  end
  object jsoncdsseatreserve: TjsonClientDataSet
    DataSourceName = 'seatreservemap'
    UpdateDataSet = 'seatreserves'
    QueryAddress = 'dispatch/qryempty'
    SaveAddress = 'dispatch/reservelist'
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
    Left = 432
    Top = 288
  end
  object jsoncdsquerycustomer: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 8
  end
  object jcdsquerybookunsellcount: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/querybookunsellcount'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'customerid'
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
        Name = 'bookunsellcount'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 296
    Top = 304
  end
  object jcdsVipBooktime: TjsonClientDataSet
    DataSourceName = 'booktimemap'
    QueryAddress = 'base/queryvipbooktime'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_vb!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_vb!vipgrade'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 72
    Top = 304
  end
end
