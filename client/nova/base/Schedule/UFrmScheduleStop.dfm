inherited FrmScheduleStop: TFrmScheduleStop
  Caption = 'FrmScheduleStop'
  ClientHeight = 354
  ClientWidth = 674
  OnShow = FormShow
  ExplicitWidth = 680
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 674
    Height = 309
    ExplicitWidth = 674
    ExplicitHeight = 309
    inherited Bevel1: TBevel
      Top = 291
      Width = 640
      ExplicitTop = 305
      ExplicitWidth = 401
    end
    object Label24: TLabel
      Left = 78
      Top = 206
      Width = 42
      Height = 14
      Caption = #26816#31080#21475
    end
    object Label25: TLabel
      Left = 75
      Top = 248
      Width = 42
      Height = 14
      Caption = #20056#36710#24211
    end
    object Label1: TLabel
      Left = 61
      Top = 45
      Width = 56
      Height = 14
      Caption = #20572#38752#31449#28857
    end
    object Label2: TLabel
      Left = 61
      Top = 169
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object Label9: TLabel
      Left = 64
      Top = 85
      Width = 56
      Height = 14
      Caption = #36816#34892#26102#38388
    end
    object Label14: TLabel
      Left = 195
      Top = 86
      Width = 28
      Height = 14
      Caption = #23567#26102
    end
    object Label17: TLabel
      Left = 309
      Top = 43
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
    object Label18: TLabel
      Left = 234
      Top = 83
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
    object Label4: TLabel
      Left = 201
      Top = 164
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
    object Label5: TLabel
      Left = 309
      Top = 204
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
    object Label6: TLabel
      Left = 309
      Top = 245
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
    object lbl1: TLabel
      Left = 335
      Top = 45
      Width = 42
      Height = 14
      Caption = #22791#27880#19968
    end
    object lbl2: TLabel
      Left = 335
      Top = 85
      Width = 42
      Height = 14
      Caption = #22791#27880#20108
    end
    object lbl3: TLabel
      Left = 335
      Top = 125
      Width = 42
      Height = 14
      Caption = #22791#27880#19977
    end
    object lbl4: TLabel
      Left = 335
      Top = 166
      Width = 42
      Height = 14
      Caption = #22791#27880#22235
    end
    object lbl5: TLabel
      Left = 335
      Top = 206
      Width = 42
      Height = 14
      Caption = #22791#27880#20116
    end
    object NHccbTicketEntrance: TNovaHComboBox
      Left = 126
      Top = 203
      Width = 171
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 4
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketEntranceHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_o!id'
          ParamType = ptInput
        end>
    end
    object NHccbVehiclepark: TNovaHComboBox
      Left = 126
      Top = 244
      Width = 171
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehicleparkHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_o!station.id'
          ParamType = ptInput
        end>
    end
    object ChkIsDepart: TCheckBox
      Left = 126
      Top = 122
      Width = 90
      Height = 17
      Caption = #26159#21542#21457#36710#31449
      TabOrder = 2
      OnClick = ChkIsDepartClick
    end
    object dtStartTime: TDateTimePicker
      Left = 126
      Top = 163
      Width = 64
      Height = 22
      Date = 37834.000011574100000000
      Format = 'HH:mm'
      Time = 37834.000011574100000000
      Kind = dtkTime
      TabOrder = 3
    end
    object NEdtRuntime: TNovaEdit
      Left = 126
      Top = 82
      Width = 64
      Height = 22
      MaxLength = 3
      TabOrder = 1
      ValueType = ssDouble
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
    object NovaHCbbStation: TNovaHComboBox
      Left = 126
      Top = 42
      Width = 171
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = NovaHCbbStationChange
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'RouteSHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!route.id'
          ParamType = ptInput
        end>
    end
    object chkIssellable: TCheckBox
      Left = 223
      Top = 122
      Width = 102
      Height = 17
      Caption = #26159#21542#20801#35768#21806#31080
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object nvedtremark1: TNovaEdit
      Left = 387
      Top = 42
      Width = 234
      Height = 22
      MaxLength = 100
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
    object nvedtremark2: TNovaEdit
      Left = 387
      Top = 82
      Width = 234
      Height = 22
      MaxLength = 100
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
    object nvedtremark3: TNovaEdit
      Left = 387
      Top = 123
      Width = 234
      Height = 22
      MaxLength = 100
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
    object nvedtremark4: TNovaEdit
      Left = 387
      Top = 163
      Width = 234
      Height = 22
      MaxLength = 100
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
    end
    object nvedtremark5: TNovaEdit
      Left = 387
      Top = 203
      Width = 234
      Height = 22
      MaxLength = 100
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
    end
  end
  inherited pnlOperation: TPanel
    Top = 309
    Width = 674
    ExplicitTop = 309
    ExplicitWidth = 674
    inherited bbtnSave: TBitBtn
      Left = 218
      Top = 4
      OnClick = bbtnSaveClick
      ExplicitLeft = 218
      ExplicitTop = 4
    end
    inherited bbtnClose: TBitBtn
      Left = 355
      Top = 4
      ExplicitLeft = 355
      ExplicitTop = 4
    end
  end
  object jcdsSaveSchStop: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveScheduleStop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'scheduleStop.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.schedule.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.stationid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.orderno'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.runtime'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'scheduleStop.isdepart'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleStop.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.ticketentrance.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.vehiclepark.id'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'scheduleStop.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleStop.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleStop.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleStop.issellable'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'scheduleStop.remark1'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'scheduleStop.remark2'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'scheduleStop.remark3'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'scheduleStop.remark4'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'scheduleStop.remark5'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleStop.synccode'
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
    Left = 40
    Top = 264
  end
  object jcdsLoadRouteStop: TjsonClientDataSet
    DataSourceName = 'routestoplist'
    QueryAddress = 'base/qryroutestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedule.route.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 264
  end
end
