inherited FrmDelTicketoutletsPrice: TFrmDelTicketoutletsPrice
  Caption = 'FrmDelHandPrice'
  ClientHeight = 482
  ClientWidth = 596
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
      Top = 86
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label2: TLabel
      Left = 40
      Top = 135
      Width = 56
      Height = 14
      Caption = #24403#21069#29677#27425
    end
    object Label5: TLabel
      Left = 40
      Top = 194
      Width = 56
      Height = 14
      Caption = #36873#25321#25805#20316
    end
    object LabelTickeoutlets: TLabel
      Left = 54
      Top = 38
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object GroupBox1: TGroupBox
      Left = 321
      Top = 22
      Width = 257
      Height = 387
      Caption = #21516#32447#36335#20854#20182#29677#27425
      TabOrder = 5
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
      Left = 103
      Top = 85
      Width = 170
      Height = 22
      CharCase = ecUpperCase
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
    object NovaHelpSchedule: TNovaHelp
      Left = 103
      Top = 133
      Width = 170
      Height = 22
      CharCase = ecUpperCase
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
      Left = 103
      Top = 194
      Width = 145
      Height = 17
      Caption = #24403#21069#36873#20013#30340#29677#27425
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RbtnCurScheduleClick
    end
    object RbtnCurRoute: TRadioButton
      Left = 103
      Top = 238
      Width = 122
      Height = 17
      Caption = #26412#32447#36335#25152#26377#29677#27425
      TabOrder = 3
      OnClick = RbtnCurRouteClick
    end
    object RbtnCurOrg: TRadioButton
      Left = 103
      Top = 318
      Width = 131
      Height = 17
      Caption = #26412#26426#26500#25152#26377#29677#27425
      TabOrder = 4
      OnClick = RbtnCurOrgClick
    end
    object RbtnTickeoutlets: TRadioButton
      Left = 103
      Top = 281
      Width = 122
      Height = 17
      Caption = #21806#31080#28857#25152#26377#29677#27425
      TabOrder = 6
      OnClick = RbtnCurRouteClick
    end
    object NvHelpTickeoutlets: TNovaHelp
      Left = 103
      Top = 35
      Width = 170
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 7
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
      Caption = '&S '#21024#38500
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
  inherited ImageList: TImageList
    Left = 40
    Top = 312
  end
  object jcdsDelhandprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/delTicketoutletsprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_h!vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_s!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_h!ticketoutletsid'
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
    Left = 120
    Top = 320
  end
end
