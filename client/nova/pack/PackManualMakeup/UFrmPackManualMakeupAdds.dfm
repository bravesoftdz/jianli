inherited FrmPackManualMakeupAdds: TFrmPackManualMakeupAdds
  Caption = #32467#31639#21333#28155#21152#39029#38754
  ClientHeight = 294
  ClientWidth = 602
  OnShow = FormShow
  ExplicitWidth = 608
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 14
  object Label10: TLabel [0]
    Left = 264
    Top = 168
    Width = 7
    Height = 14
    Caption = '*'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  inherited pnlEditBox: TPanel
    Width = 602
    Height = 247
    ExplicitWidth = 602
    ExplicitHeight = 247
    inherited Bevel1: TBevel
      Top = 238
      Width = 568
      Height = 1
      ExplicitTop = 280
      ExplicitWidth = 674
      ExplicitHeight = 1
    end
    object Label2: TLabel
      Left = 36
      Top = 37
      Width = 98
      Height = 14
      Caption = #34892#21253#21463#29702#21333#21495#65306
    end
    object Label1: TLabel
      Left = 280
      Top = 37
      Width = 98
      Height = 14
      Caption = #34892#21253#32467#31639#21333#21495#65306
    end
    object Label6: TLabel
      Left = 64
      Top = 80
      Width = 70
      Height = 14
      Caption = #21457#36135#26085#26399#65306
    end
    object Label3: TLabel
      Left = 314
      Top = 80
      Width = 63
      Height = 14
      Caption = ' '#21040#36798#22320#65306
    end
    object Label33: TLabel
      Left = 320
      Top = 123
      Width = 56
      Height = 14
      Caption = #25176#36816#36153#65306
    end
    object Label4: TLabel
      Left = 264
      Top = 80
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label7: TLabel
      Left = 508
      Top = 123
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label8: TLabel
      Left = 508
      Top = 80
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label9: TLabel
      Left = 64
      Top = 169
      Width = 70
      Height = 14
      Caption = #32467#31639#37329#39069#65306
    end
    object Label11: TLabel
      Left = 75
      Top = 127
      Width = 56
      Height = 14
      Caption = #36710#29260#21495#65306
    end
    object Label12: TLabel
      Left = 264
      Top = 126
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label5: TLabel
      Left = 508
      Top = 37
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object novepackno: TNovaEdit
      Left = 140
      Top = 34
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 0
      OnExit = novepacknoExit
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
    object departpacknoname: TNovaEdit
      Left = 384
      Top = 34
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 1
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
    object dtpdepartdate: TDateTimePicker
      Left = 140
      Top = 77
      Width = 121
      Height = 22
      Date = 41492.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41492.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object nvhelptostation: TNovaHelp
      Left = 384
      Top = 77
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'pack/querytostation'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvedtshipprice: TNovaEdit
      Left = 384
      Top = 120
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 7
      TabOrder = 5
      Text = '0'
      OnChange = nvedtshippriceChange
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
    object nvedtbalanceprice: TNovaEdit
      Left = 140
      Top = 166
      Width = 121
      Height = 22
      Enabled = False
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 7
      TabOrder = 6
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
    object NovaHelpVehicleNo: TNovaHelp
      Left = 140
      Top = 123
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
          Title.Caption = #36710#29260#21495#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'seatnum'
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
  end
  inherited pnlOperation: TPanel
    Top = 247
    Width = 602
    Height = 47
    ExplicitTop = 247
    ExplicitWidth = 602
    ExplicitHeight = 47
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 327
      ExplicitLeft = 327
    end
  end
  inherited ImageList: TImageList
    Left = 504
    Top = 176
  end
  object jcdsFindpackAndDepinfo: TjsonClientDataSet
    DataSourceName = 'packManualaddquery'
    QueryAddress = 'pack/findpackAndDepinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packno'
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
    Left = 48
    Top = 192
  end
  object jcdsSavedepartdatevoice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/packManualsave'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packDeparvo.tostationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packDeparvo.departinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packDeparvo.shipprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packDeparvo.balancemount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packDeparvo.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packDeparvo.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packDeparvo.packdepartinvoicesid'
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
    Left = 368
    Top = 176
  end
  object jcdsFindpackedepartinvoiceAndDepinfo: TjsonClientDataSet
    DataSourceName = 'packManualaddquery'
    QueryAddress = 'pack/findpackedepartinvoiceAndDepinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packdepartinvoicesno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 200
  end
end
