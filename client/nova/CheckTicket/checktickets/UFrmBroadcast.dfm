inherited FrmBroadcast: TFrmBroadcast
  Caption = 'FrmBroadcast'
  ClientHeight = 299
  ClientWidth = 504
  ExplicitWidth = 510
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 504
    Height = 254
    ExplicitWidth = 504
    ExplicitHeight = 254
    inherited Bevel1: TBevel
      Top = 246
      Width = 470
      Visible = False
      ExplicitTop = 246
      ExplicitWidth = 470
    end
    object Label1: TLabel
      Left = 54
      Top = 44
      Width = 56
      Height = 14
      Caption = #25773#38899#29677#27425
    end
    object Label2: TLabel
      Left = 54
      Top = 100
      Width = 56
      Height = 14
      Caption = #25773#38899#20869#23481
    end
    object MeContent: TMemo
      Left = 120
      Top = 97
      Width = 275
      Height = 100
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 259
      Top = 38
      Width = 75
      Height = 29
      Caption = #25773#38899
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 364
      Top = 38
      Width = 74
      Height = 29
      Caption = '&Q '#36864#20986
      Kind = bkClose
      TabOrder = 2
    end
    object NovaHelpSchedule: TNovaEdit
      Left = 120
      Top = 42
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
    end
  end
  inherited pnlOperation: TPanel
    Top = 254
    Width = 504
    Visible = False
    ExplicitTop = 254
    ExplicitWidth = 504
    inherited bbtnSave: TBitBtn
      Left = 103
      Top = 6
      ExplicitLeft = 103
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 272
      Top = 6
      ExplicitLeft = 272
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 224
    Top = 184
  end
  object jscdaddMusicContent: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'checkticket/addMusicContent'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'lc.content'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.ticketentrance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.departtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.orgname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.mccontent'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.routename'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'lc.jianpin'
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
    Left = 280
    Top = 104
  end
end
