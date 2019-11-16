inherited FrmHolidayEdt: TFrmHolidayEdt
  Caption = 'FrmHolidayEdt'
  ClientHeight = 293
  ClientWidth = 487
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 493
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 487
    Height = 248
    ExplicitWidth = 487
    ExplicitHeight = 248
    inherited Bevel1: TBevel
      Top = 240
      Width = 453
      ExplicitTop = 240
      ExplicitWidth = 453
    end
    object Label1: TLabel
      Left = 94
      Top = 41
      Width = 28
      Height = 14
      Caption = #33410#26085
    end
    object Label2: TLabel
      Left = 66
      Top = 86
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object Label3: TLabel
      Left = 66
      Top = 131
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object Label5: TLabel
      Left = 52
      Top = 176
      Width = 70
      Height = 14
      Caption = #33258#23450#20041#21517#31216
    end
    object Label11: TLabel
      Left = 281
      Top = 37
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
      Left = 281
      Top = 80
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
    object Label7: TLabel
      Left = 281
      Top = 125
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
      Left = 408
      Top = 178
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
    object DateTpFromDate: TDateTimePicker
      Left = 130
      Top = 81
      Width = 145
      Height = 22
      Date = 40614.716442233800000000
      Time = 40614.716442233800000000
      TabOrder = 0
      OnChange = DateTpFromDateChange
    end
    object DateTpEndDate: TDateTimePicker
      Left = 130
      Top = 126
      Width = 145
      Height = 22
      Date = 40614.716442233800000000
      Time = 40614.716442233800000000
      TabOrder = 1
    end
    object NovaEdtHoliday: TNovaEdit
      Left = 130
      Top = 172
      Width = 272
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 100
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
    end
    object NovaCbbHolidayType: TNovaComboBox
      Left = 130
      Top = 36
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
      OnChange = NovaCbbHolidayTypeChange
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'holiday'
      HelpOptions.Columnname = 'type'
    end
  end
  inherited pnlOperation: TPanel
    Top = 248
    Width = 487
    ExplicitTop = 248
    ExplicitWidth = 487
    inherited bbtnSave: TBitBtn
      Left = 128
      OnClick = bbtnSaveClick
      ExplicitLeft = 128
    end
    inherited bbtnClose: TBitBtn
      Left = 265
      ExplicitLeft = 265
    end
  end
  object jcdsSaveHoliday: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'ticketprice/saveholiday'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'holiday.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.type'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'holiday.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'holiday.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'holiday.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.fullname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.islocaldelete'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'holiday.orgid'
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
        DataType = ftBCD
        Name = 'holidayid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 88
  end
end
