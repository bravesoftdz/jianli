inherited FrmChecktickets: TFrmChecktickets
  Caption = #36830#26816#25805#20316
  ClientHeight = 233
  ClientWidth = 404
  ExplicitWidth = 410
  ExplicitHeight = 261
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 404
    Height = 188
    ExplicitWidth = 404
    ExplicitHeight = 188
    inherited Bevel1: TBevel
      Top = 180
      Width = 370
      ExplicitTop = 200
      ExplicitWidth = 392
    end
    object Label1: TLabel
      Left = 80
      Top = 45
      Width = 56
      Height = 14
      Caption = #24320#22987#31080#21495
    end
    object Label2: TLabel
      Left = 84
      Top = 106
      Width = 56
      Height = 14
      Caption = #32467#26463#31080#21495
    end
    object NovaEdtStartNo: TNovaEdit
      Left = 148
      Top = 41
      Width = 160
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
      TabOrder = 0
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
    object NovaEdtEndNo: TNovaEdit
      Left = 148
      Top = 101
      Width = 160
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
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
  end
  inherited pnlOperation: TPanel
    Top = 188
    Width = 404
    ExplicitTop = 188
    ExplicitWidth = 404
    inherited bbtnSave: TBitBtn
      Caption = '&S '#30830#23450
      OnClick = bbtnSaveClick
    end
  end
  object jscdChecktickets: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/checkcontinueByticketnos'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'checkstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereportid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stratticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'endticketno'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'checktickets'
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
      end
      item
        DataType = ftString
        Name = 'filter_INS_t!departstationid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 152
  end
end
