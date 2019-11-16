inherited FrmScheduleplanPlus: TFrmScheduleplanPlus
  Caption = #29677#27425#21152#29677
  ClientHeight = 343
  ClientWidth = 612
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 618
  ExplicitHeight = 375
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 612
    Height = 298
    ExplicitWidth = 612
    ExplicitHeight = 298
    inherited Bevel1: TBevel
      Top = 290
      Width = 578
      ExplicitTop = 236
      ExplicitWidth = 447
    end
    object Label2: TLabel
      Left = 58
      Top = 37
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object Label17: TLabel
      Left = 59
      Top = 77
      Width = 56
      Height = 14
      Caption = #21152#29677#26085#26399
    end
    object Label19: TLabel
      Left = 348
      Top = 77
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label3: TLabel
      Left = 73
      Top = 118
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label1: TLabel
      Left = 307
      Top = 119
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object Label15: TLabel
      Left = 270
      Top = 114
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
      Left = 455
      Top = 116
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
      Left = 523
      Top = 75
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
    object lbl3: TLabel
      Left = 303
      Top = 152
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
    object Label5: TLabel
      Left = 16
      Top = 231
      Width = 98
      Height = 14
      Caption = #23458#20195#36153#25187#36153#20844#24335
    end
    object Label12: TLabel
      Left = 273
      Top = 193
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
    object Label10: TLabel
      Left = 57
      Top = 194
      Width = 56
      Height = 14
      Caption = #21378#29260#22411#21495
    end
    object Label11: TLabel
      Left = 272
      Top = 154
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
    object Label30: TLabel
      Left = 86
      Top = 158
      Width = 28
      Height = 14
      Caption = #36710#22411
    end
    object Label31: TLabel
      Left = 243
      Top = 159
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
    object Label8: TLabel
      Left = 320
      Top = 192
      Width = 42
      Height = 14
      Caption = #24231#20301#25968
    end
    object Label16: TLabel
      Left = 438
      Top = 190
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
      Left = 121
      Top = 32
      Width = 168
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 20
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
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object dtpStartdate_p: TDateTimePicker
      Left = 121
      Top = 71
      Width = 140
      Height = 22
      Date = 40333.738843125000000000
      Time = 40333.738843125000000000
      TabOrder = 1
    end
    object dtpEnddate_p: TDateTimePicker
      Left = 370
      Top = 71
      Width = 145
      Height = 22
      Date = 40333.738843125000000000
      Time = 40333.738843125000000000
      TabOrder = 2
    end
    object NEdtHelpCode: TNovaEdit
      Left = 121
      Top = 113
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
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
    object dtpStartTime: TDateTimePicker
      Left = 370
      Top = 113
      Width = 71
      Height = 22
      Date = 37834.000011574100000000
      Format = 'HH:mm'
      Time = 37834.000011574100000000
      Kind = dtkTime
      TabOrder = 4
    end
    object NovaHelpVehicleno: TNovaHelp
      Left = 370
      Top = 149
      Width = 140
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 7
      OnIdChange = NovaHelpVehiclenoIdChange
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
    object Nhcbformula: TNovaHComboBox
      Left = 120
      Top = 227
      Width = 145
      Height = 22
      ImeMode = imClose
      TabOrder = 8
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
          Value = 'BalanceformulaHelp'
        end>
    end
    object NvHcbbVehiclebrandmodel: TNovaHComboBox
      Left = 120
      Top = 189
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 6
      OnChange = NvHcbbVehiclebrandmodelChange
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
          Value = 'VehiclebrandmodelHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!vehicletypeid'
          ParamType = ptInput
        end>
    end
    object NovaVehicletype: TNovaHComboBox
      Left = 120
      Top = 151
      Width = 140
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 5
      OnChange = NovaVehicletypeChange
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
          Value = 'VehicletypeHelp'
        end>
    end
    object NEdtPLANSEATNUM: TNovaEdit
      Left = 370
      Top = 187
      Width = 62
      Height = 22
      Enabled = False
      MaxLength = 3
      TabOrder = 9
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
    Top = 298
    Width = 612
    ExplicitTop = 298
    ExplicitWidth = 612
    inherited bbtnSave: TBitBtn
      Left = 198
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 198
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 334
      Top = 6
      ExplicitLeft = 334
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 416
    Top = 8
  end
  object jscdscheduleplanplus: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/scheduleplanplus'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.starttime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceformulaid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'newscheduleplanid'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 504
    Top = 24
  end
end
