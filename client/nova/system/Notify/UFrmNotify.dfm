inherited FrmNotify: TFrmNotify
  AlphaBlend = True
  Caption = #21335#20940#31449#21153#31995#32479
  ClientHeight = 150
  ClientWidth = 257
  TransparentColor = True
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 263
  ExplicitHeight = 179
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 257
    Height = 149
    OnMouseEnter = pnlEditBoxMouseEnter
    OnMouseLeave = pnlEditBoxMouseLeave
    ExplicitWidth = 257
    ExplicitHeight = 149
    inherited Bevel1: TBevel
      Left = 19
      Top = 118
      Width = 221
      Height = 1
      Anchors = [akTop]
      Style = bsRaised
      ExplicitLeft = 19
      ExplicitTop = 118
      ExplicitWidth = 221
      ExplicitHeight = 1
    end
    object Label1: TLabel
      Left = 70
      Top = 126
      Width = 70
      Height = 14
      Caption = #19978#27425#30331#24405#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clOlive
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabUserName: TLabel
      Left = 54
      Top = 30
      Width = 42
      Height = 20
      Caption = #38472#23567#26126
      Font.Charset = GB2312_CHARSET
      Font.Color = clOlive
      Font.Height = -14
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 19
      Top = 34
      Width = 28
      Height = 14
      Caption = #20320#22909
      Font.Charset = GB2312_CHARSET
      Font.Color = clOlive
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabLoginTime: TLabel
      Left = 140
      Top = 126
      Width = 98
      Height = 14
      Caption = '12'#26376'12'#26085' 18:30'
      Font.Charset = GB2312_CHARSET
      Font.Color = clOlive
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabInfo: TLabel
      Left = 32
      Top = 62
      Width = 189
      Height = 48
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = #31995#32479#20013#26377'100'#36742#36710#35777#20214#24050#32463#36807#26399
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clOlive
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
      OnMouseEnter = LabInfoMouseEnter
      OnMouseLeave = LabInfoMouseLeave
    end
    object Label3: TLabel
      Left = 88
      Top = 11
      Width = 90
      Height = 14
      Caption = #31995#32479#20449#24687#25552#31034
      Font.Charset = GB2312_CHARSET
      Font.Color = clOlive
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mp1: TMediaPlayer
      Left = 4
      Top = 31
      Width = 253
      Height = 30
      FileName = 'E:\svn\branches\NvBus\5.04\client\nova\BIN\abc.mp3'
      Visible = False
      TabOrder = 0
    end
  end
  inherited pnlOperation: TPanel
    Top = 149
    Width = 257
    Height = 1
    ExplicitTop = 149
    ExplicitWidth = 257
    ExplicitHeight = 1
    inherited bbtnSave: TBitBtn
      Visible = False
    end
    inherited bbtnClose: TBitBtn
      Top = 6
      Visible = False
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 200
    Top = 224
  end
  object Timer1: TTimer
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 224
    Top = 88
  end
  object jscdupdateNotifyByid: TjsonClientDataSet
    DataSourceName = 'datalist'
    SaveAddress = 'system/updateNotifyByid'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'notifyid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 152
    Top = 80
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 88
    Top = 80
  end
end
