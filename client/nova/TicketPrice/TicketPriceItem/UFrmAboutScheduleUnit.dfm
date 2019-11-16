inherited FrmAboutScheduleUnit: TFrmAboutScheduleUnit
  Caption = 'FrmAboutScheduleUnit'
  ParentFont = False
  Font.Charset = GB2312_CHARSET
  Font.Height = -14
  Font.Name = #23435#20307
  ExplicitWidth = 443
  ExplicitHeight = 351
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 66
    Top = 43
    Width = 56
    Height = 14
    Caption = #39033#30446#21517#31216
  end
  object Label2: TLabel [1]
    Left = 80
    Top = 168
    Width = 42
    Height = 14
    Caption = #35745#31639#20540
  end
  object Label1: TLabel [2]
    Left = 94
    Top = 101
    Width = 28
    Height = 14
    Caption = #29677#27425
  end
  inherited pnlEditBox: TPanel
    ExplicitTop = 3
    object Label4: TLabel
      Left = 79
      Top = 46
      Width = 56
      Height = 14
      Caption = #39033#30446#21517#31216
    end
    object Label5: TLabel
      Left = 93
      Top = 201
      Width = 42
      Height = 14
      Caption = #35745#31639#20540
    end
    object Label6: TLabel
      Left = 107
      Top = 151
      Width = 28
      Height = 14
      Caption = #29677#27425
    end
    object Label7: TLabel
      Left = 79
      Top = 99
      Width = 56
      Height = 14
      Caption = #36710#23646#21333#20301
    end
    object NovaEdtName: TNovaEdit
      Left = 144
      Top = 42
      Width = 180
      Height = 18
      MaxLength = 50
      ReadOnly = True
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
    object NovaHelpUnit: TNovaHelp
      Left = 144
      Top = 96
      Width = 180
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
          Title.Caption = #21333#20301#21517#31216
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
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
    end
    object NovaHSchdule: TNovaHelp
      Left = 144
      Top = 148
      Width = 180
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
          FieldName = 'endstationname'
          Title.Caption = #21040#31449
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #29677#27425#21495
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'starttime'
          Title.Caption = #21457#36710#26102#38388
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'ScheduleRHelp'
      HelpOptions.HQueryAddress = 'system/help'
    end
    object NovaEdtValue: TNovaEdit
      Left = 144
      Top = 194
      Width = 116
      Height = 22
      MaxLength = 10
      TabOrder = 3
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
  end
  inherited pnlOperation: TPanel
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  object jcdsSaveAboutScheduleUnit: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveaboutscheduleunit'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'formulaitemscheduleunit.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemscheduleunit.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemscheduleunit.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemscheduleunit.ticketpriceformulaitem.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemscheduleunit.value'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'formulaitemscheduleunit.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'formulaitemscheduleunit.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftUnknown
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 320
    Top = 208
  end
end
