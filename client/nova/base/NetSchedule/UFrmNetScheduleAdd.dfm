inherited FrmNetScheduleAdd: TFrmNetScheduleAdd
  Caption = 'FrmNetScheduleAdd'
  ClientHeight = 299
  ClientWidth = 485
  ExplicitWidth = 491
  ExplicitHeight = 331
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 485
    Height = 254
    ExplicitWidth = 438
    ExplicitHeight = 194
    inherited Bevel1: TBevel
      Top = 246
      Width = 451
      ExplicitTop = 267
      ExplicitWidth = 373
    end
    object Label3: TLabel
      Left = 64
      Top = 136
      Width = 84
      Height = 14
      Caption = #37197#23458#29677#27425#26426#26500
    end
    object Label4: TLabel
      Left = 78
      Top = 187
      Width = 70
      Height = 14
      Caption = #37197#23458#29677#27425#21495
    end
    object Label1: TLabel
      Left = 68
      Top = 40
      Width = 84
      Height = 14
      Caption = #22987#21457#29677#27425#26426#26500
    end
    object Label2: TLabel
      Left = 78
      Top = 91
      Width = 70
      Height = 14
      Caption = #22987#21457#29677#27425#21495
    end
    object NovaHOverOrg: TNovaHelp
      Left = 158
      Top = 133
      Width = 200
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      OnIdChange = NovaHOverOrgIdChange
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
          Title.Caption = #26426#26500#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'OrgManagerHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaHOverSch: TNovaHelp
      Left = 158
      Top = 184
      Width = 200
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
          FieldName = 'endstationname'
          Title.Caption = #21040#31449
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #29677#27425#21495
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 260
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object NovaHStartOrg: TNovaHelp
      Left = 158
      Top = 37
      Width = 200
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
      OnIdChange = NovaHOverOrgIdChange
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
          Title.Caption = #26426#26500#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'OrgManagerHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpschedule: TNovaHelp
      Left = 158
      Top = 88
      Width = 200
      Height = 22
      CharCase = ecUpperCase
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
          FieldName = 'endstationname'
          Title.Caption = #21040#31449
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #29677#27425#21495
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 260
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 254
    Width = 485
    ExplicitTop = 194
    ExplicitWidth = 438
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Top = 6
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 600
    Top = 400
  end
  object jscdSaveNetSchedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveNetSchedulebydelphi'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'netschedule.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedule.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedule.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedule.orderno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedule.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedule.startscheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedule.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'actionResultStr'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'actionResult'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'netscheduleid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 432
    Top = 200
  end
end
