inherited FrmNetScheduleStation: TFrmNetScheduleStation
  Caption = 'FrmNetScheduleStation'
  ClientHeight = 269
  ClientWidth = 409
  OnShow = FormShow
  ExplicitWidth = 415
  ExplicitHeight = 301
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 409
    Height = 224
    ExplicitWidth = 409
    ExplicitHeight = 224
    inherited Bevel1: TBevel
      Top = 216
      Width = 375
    end
    object Label1: TLabel
      Left = 69
      Top = 100
      Width = 42
      Height = 14
      Caption = #20572#38752#28857
    end
    object Label2: TLabel
      Left = 55
      Top = 56
      Width = 56
      Height = 14
      Caption = #33829#36816#32447#36335
    end
    object Label3: TLabel
      Left = 83
      Top = 146
      Width = 28
      Height = 14
      Caption = #24207#21495
    end
    object EdtRoute: TEdit
      Left = 120
      Top = 51
      Width = 185
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
    object NEdtOrderno: TNovaEdit
      Left = 120
      Top = 143
      Width = 185
      Height = 22
      MaxLength = 2
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
    object NvSchedulestop: TNovaHComboBox
      Left = 120
      Top = 97
      Width = 185
      Height = 22
      ImeMode = imClose
      TabOrder = 2
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
      HelpOptions.HDataSourceName = 'netschedulelist'
      HelpOptions.HQueryAddress = 'base/qrySchedulestops'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'netscheduleid'
          ParamType = ptInput
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 224
    Width = 409
    ExplicitTop = 224
    ExplicitWidth = 409
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 432
    Top = 296
  end
  object jscdSaveSchedulestop: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveNetSchedulestop'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'netschedulestop.orderno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedulestop.stationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'netschedulestop.netscheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'netschedulestopid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'actionResultStr'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'actionResult'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 304
    Top = 168
  end
end
