inherited FrmGenExecutePrice: TFrmGenExecutePrice
  Caption = 'FrmGenExecutePrice'
  ClientHeight = 482
  ClientWidth = 596
  OnShow = FormShow
  ExplicitWidth = 602
  ExplicitHeight = 510
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 596
    Height = 437
    ExplicitWidth = 596
    ExplicitHeight = 437
    inherited Bevel1: TBevel
      Top = 429
      Width = 562
      ExplicitTop = 429
      ExplicitWidth = 562
    end
    object Label1: TLabel
      Left = 39
      Top = 32
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label2: TLabel
      Left = 39
      Top = 77
      Width = 56
      Height = 14
      Caption = #24403#21069#29677#27425
    end
    object Label3: TLabel
      Left = 40
      Top = 292
      Width = 56
      Height = 14
      Caption = #21046#20316#26085#26399
    end
    object Label4: TLabel
      Left = 82
      Top = 334
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label5: TLabel
      Left = 39
      Top = 119
      Width = 56
      Height = 14
      Caption = #36873#25321#25805#20316
    end
    object Label6: TLabel
      Left = 167
      Top = 372
      Width = 14
      Height = 14
      Caption = #22825
    end
    object Label7: TLabel
      Left = 67
      Top = 372
      Width = 28
      Height = 14
      Caption = #25110#32773
    end
    object Label8: TLabel
      Left = 40
      Top = 244
      Width = 56
      Height = 14
      Caption = #25805#20316#31867#22411
    end
    object LabInfo: TLabel
      Left = 40
      Top = 406
      Width = 8
      Height = 16
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object GroupBox1: TGroupBox
      Left = 321
      Top = 22
      Width = 257
      Height = 387
      Caption = #21516#32447#36335#20854#20182#29677#27425
      TabOrder = 9
      object NovaListSchedule: TNovaListView
        Left = 2
        Top = 16
        Width = 253
        Height = 369
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
        HelpOptions.HQueryAddress = 'ticketprice/qrySameRouteSchedules'
        HelpOptions.FieldNames.Strings = (
          'id'
          'name'
          'starttime'
          'code')
        HelpOptions.HSkinData = DMPublic.SkinData1
        Params = <
          item
            DataType = ftString
            Name = 'routeid'
            ParamType = ptInput
          end>
      end
    end
    object NovaHelpRoute: TNovaHelp
      Left = 102
      Top = 29
      Width = 170
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 0
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
    object DTPBuildStartDay: TDateTimePicker
      Left = 102
      Top = 284
      Width = 122
      Height = 22
      Date = 40645.466286168980000000
      Time = 40645.466286168980000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 6
      OnChange = DTPBuildStartDayChange
    end
    object DTPBuildEndDay: TDateTimePicker
      Left = 102
      Top = 326
      Width = 122
      Height = 22
      Date = 40645.466286168980000000
      Time = 40645.466286168980000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
      OnChange = DTPBuildEndDayChange
    end
    object NovaHelpSchedule: TNovaHelp
      Left = 102
      Top = 71
      Width = 171
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object RbtnCurSchedule: TRadioButton
      Left = 101
      Top = 119
      Width = 145
      Height = 17
      Caption = #24403#21069#36873#20013#30340#29677#27425
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RbtnCurScheduleClick
    end
    object RbtnCurRoute: TRadioButton
      Left = 102
      Top = 156
      Width = 122
      Height = 17
      Caption = #26412#32447#36335#25152#26377#29677#27425
      TabOrder = 3
      OnClick = RbtnCurRouteClick
    end
    object RbtnCurOrg: TRadioButton
      Left = 102
      Top = 199
      Width = 131
      Height = 17
      Caption = #26412#26426#26500#25152#26377#29677#27425
      TabOrder = 4
      OnClick = RbtnCurOrgClick
    end
    object NovaEdtSEDays: TNovaEdit
      Left = 102
      Top = 368
      Width = 55
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object CbbOperType: TComboBox
      Left = 102
      Top = 241
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemIndex = 0
      TabOrder = 5
      Text = #29983#25104#33829#36816#35745#21010
      OnChange = CbbOperTypeChange
      Items.Strings = (
        #29983#25104#33829#36816#35745#21010
        #21024#38500#33829#36816#35745#21010)
    end
  end
  inherited pnlOperation: TPanel
    Top = 437
    Width = 596
    ExplicitTop = 437
    ExplicitWidth = 596
    inherited bbtnSave: TBitBtn
      Left = 151
      Top = 6
      Width = 106
      Caption = '&S '#24320#22987#29983#25104
      OnClick = bbtnSaveClick
      ExplicitLeft = 151
      ExplicitTop = 6
      ExplicitWidth = 106
    end
    inherited bbtnClose: TBitBtn
      Left = 331
      Top = 6
      ExplicitLeft = 331
      ExplicitTop = 6
    end
  end
  object jcdsGenScheduleplan: TjsonClientDataSet
    DataSourceName = 'scheduleplanloglist'
    QueryAddress = 'ticketprice/genScheduleplan'
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
        Name = 'scheduleplanlog.operationtype'
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
        Name = 'scheduleplanlog.ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.userid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 288
  end
end
