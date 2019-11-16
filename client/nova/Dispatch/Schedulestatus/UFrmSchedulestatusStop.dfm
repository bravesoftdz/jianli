inherited FrmSchedulestatusStop: TFrmSchedulestatusStop
  Caption = 'FrmSchedulestatusStop'
  ClientHeight = 457
  ClientWidth = 630
  OnShow = FormShow
  ExplicitWidth = 636
  ExplicitHeight = 485
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 630
    Height = 412
    ExplicitWidth = 630
    ExplicitHeight = 412
    inherited Bevel1: TBevel
      Top = 404
      Width = 596
      ExplicitTop = 430
      ExplicitWidth = 596
    end
    object lbl1: TLabel
      Left = 39
      Top = 66
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object lbl2: TLabel
      Left = 40
      Top = 105
      Width = 56
      Height = 14
      Caption = #24403#21069#29677#27425
    end
    object lbl3: TLabel
      Left = 39
      Top = 138
      Width = 56
      Height = 14
      Caption = #36873#25321#25805#20316
    end
    object lbl4: TLabel
      Left = 81
      Top = 271
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl5: TLabel
      Left = 40
      Top = 239
      Width = 56
      Height = 14
      Caption = #20572#29677#26085#26399
    end
    object lbl6: TLabel
      Left = 230
      Top = 271
      Width = 28
      Height = 14
      Caption = #25110#32773
    end
    object lbl7: TLabel
      Left = 303
      Top = 271
      Width = 14
      Height = 14
      Caption = #22825
    end
    object Label1: TLabel
      Left = 40
      Top = 31
      Width = 56
      Height = 14
      Caption = #25805#20316#31867#22411
    end
    object Label2: TLabel
      Left = 281
      Top = 26
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
    object lblstation: TLabel
      Left = 39
      Top = 304
      Width = 56
      Height = 14
      Caption = #35745#21010#36710#36742
    end
    object Label3: TLabel
      Left = 230
      Top = 233
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
      Left = 39
      Top = 369
      Width = 56
      Height = 14
      Caption = #20572#29677#21407#22240
    end
    object Label4: TLabel
      Left = 53
      Top = 336
      Width = 42
      Height = 14
      Caption = #30003#25253#20154
    end
    object Label6: TLabel
      Left = 237
      Top = 334
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
    object NovaHelpRoute: TNovaHelp
      Left = 102
      Top = 63
      Width = 170
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      OnIdChange = NovaHelpRouteIdChange
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
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #25805#20316#30721
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 102
      Top = 102
      Width = 171
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
      OnIdChange = NovaHelpScheduleIdChange
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
          Title.Caption = #29677#27425#21495
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object rbRbtnCurSchedule: TRadioButton
      Left = 101
      Top = 137
      Width = 145
      Height = 17
      Caption = #24403#21069#36873#20013#30340#29677#27425
      Checked = True
      TabOrder = 3
      TabStop = True
      OnClick = rbRbtnCurScheduleClick
    end
    object rbCurRoute: TRadioButton
      Left = 101
      Top = 167
      Width = 122
      Height = 17
      Caption = #26412#32447#36335#25152#26377#29677#27425
      TabOrder = 4
      OnClick = rbCurRouteClick
    end
    object rbCurOrg: TRadioButton
      Left = 102
      Top = 199
      Width = 131
      Height = 17
      Caption = #26412#26426#26500#25152#26377#29677#27425
      TabOrder = 5
      OnClick = rbCurOrgClick
    end
    object dtpStartDay: TDateTimePicker
      Left = 102
      Top = 231
      Width = 122
      Height = 22
      Date = 40645.466286168980000000
      Time = 40645.466286168980000000
      TabOrder = 6
      OnChange = dtpStartDayChange
    end
    object dtpEndDay: TDateTimePicker
      Left = 102
      Top = 266
      Width = 122
      Height = 22
      Date = 40645.466286168980000000
      Time = 40645.466286168980000000
      TabOrder = 7
      OnChange = dtpEndDayChange
    end
    object NovaEdtSEDays: TNovaEdit
      Left = 260
      Top = 266
      Width = 36
      Height = 22
      MaxLength = 2
      TabOrder = 8
      Text = '1'
      OnChange = NovaEdtSEDaysChange
      ValueTrim = '1'
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
    object grp1: TGroupBox
      Left = 330
      Top = 19
      Width = 257
      Height = 367
      Caption = #21516#32447#36335#20854#20182#29677#27425
      TabOrder = 9
      object NovaListSchedule: TNovaListView
        Left = 2
        Top = 16
        Width = 253
        Height = 349
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            MaxWidth = 20
            MinWidth = 20
            Width = 20
          end
          item
            Caption = #29677#27425#21495
            Width = 100
          end
          item
            Caption = #21457#36710#26102#38388
            Width = 100
          end>
        TabOrder = 0
        ViewStyle = vsReport
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HQueryAddress = 'system/help'
        HelpOptions.FieldNames.Strings = (
          'id'
          'name'
          'starttime'
          'code')
        HelpOptions.HSkinData = DMPublic.SkinData1
        Params = <
          item
            DataType = ftWideString
            Name = 'helpType'
            ParamType = ptInput
            Value = 'ScheduleRHelp'
          end
          item
            DataType = ftWideString
            Name = 'filter_EQL_r!id'
            ParamType = ptInput
          end>
      end
    end
    object cbbOpertype: TComboBox
      Left = 102
      Top = 25
      Width = 171
      Height = 22
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbbOpertypeChange
      Items.Strings = (
        #29677#27425#20572#29677#22788#29702
        #24674#22797#29677#27425#21806#31080)
    end
    object nvhlpendstation: TNovaHelp
      Left = 102
      Top = 299
      Width = 110
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
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
          Title.Caption = #21517#31216
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'unitname'
          Title.Caption = #36710#23646#21333#20301
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 123
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaEdtRemark: TNovaEdit
      Left = 100
      Top = 365
      Width = 194
      Height = 22
      MaxLength = 20
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
    end
    object cbbReportName: TComboBox
      Left = 101
      Top = 333
      Width = 130
      Height = 22
      TabOrder = 11
      Items.Strings = (
        #21496#20056#20154#21592
        #32463#33829#32773
        #36710#23646#21333#20301
        #29677#32447#35843#24230
        #20540#29677#31449#38271
        #33829#36816#22788)
    end
  end
  inherited pnlOperation: TPanel
    Top = 412
    Width = 630
    ExplicitTop = 412
    ExplicitWidth = 630
    inherited bbtnSave: TBitBtn
      Left = 207
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 207
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 344
      Top = 6
      ExplicitLeft = 344
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 528
    Top = 240
  end
  object jcsdStopScheduleplan: TjsonClientDataSet
    DataSourceName = 'statusmap'
    QueryAddress = 'dispatch/schedulestatusStop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanlog.typeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.scheduleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.operationtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclelost.reason'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclelost.vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclelost.reportname'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 376
    Top = 200
  end
end
