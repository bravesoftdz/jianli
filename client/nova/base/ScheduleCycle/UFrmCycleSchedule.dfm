inherited FrmCycleSchedule: TFrmCycleSchedule
  Caption = 'FrmCycleSchedule'
  ClientHeight = 371
  ClientWidth = 621
  ExplicitWidth = 627
  ExplicitHeight = 399
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 621
    Height = 326
    ExplicitWidth = 621
    ExplicitHeight = 326
    inherited Bevel1: TBevel
      Top = 318
      Width = 587
      ExplicitTop = 243
      ExplicitWidth = 531
    end
    object Label1: TLabel
      Left = 49
      Top = 45
      Width = 70
      Height = 14
      Caption = #24490#29615#32452#21517#31216
    end
    object Label3: TLabel
      Left = 36
      Top = 99
      Width = 84
      Height = 14
      Caption = #24490#29615#24320#22987#26085#26399
    end
    object Label4: TLabel
      Left = 64
      Top = 157
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object NovaEdtName: TNovaEdit
      Left = 126
      Top = 42
      Width = 187
      Height = 22
      MaxLength = 50
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
    object DateTpFromDate: TDateTimePicker
      Left = 127
      Top = 96
      Width = 120
      Height = 22
      Date = 40621.664476805560000000
      Time = 40621.664476805560000000
      TabOrder = 1
    end
    object DateTpEndDate: TDateTimePicker
      Left = 126
      Top = 152
      Width = 120
      Height = 22
      Date = 40621.664558368060000000
      Time = 40621.664558368060000000
      TabOrder = 2
    end
    object grp1: TGroupBox
      Left = 335
      Top = 12
      Width = 257
      Height = 296
      Caption = #26412#32447#36335#30340#25152#26377#29677#27425
      TabOrder = 3
      object NovaListSchedule: TNovaListView
        Left = 2
        Top = 16
        Width = 253
        Height = 278
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
          end
          item
            DataType = ftString
            Name = 'filter_EQB_t!isovertime'
            ParamType = ptInput
          end>
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 326
    Width = 621
    ExplicitTop = 326
    ExplicitWidth = 621
    inherited bbtnSave: TBitBtn
      Left = 159
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 159
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 296
      Top = 6
      ExplicitLeft = 296
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 64
    Top = 248
  end
  object jcdsSaveCycleschemesschedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveCycleschemesschedule'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'cycleschemesschedule.scheduleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesschedule.cyclescheme.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'cycleschemesschedule.createby'
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
      end
      item
        DataType = ftString
        Name = 'types'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 432
    Top = 192
    object N1: TMenuItem
      Caption = #20840#36873
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #21453#36873
    end
    object N3: TMenuItem
      Caption = #20840#19981#36873
    end
  end
end
