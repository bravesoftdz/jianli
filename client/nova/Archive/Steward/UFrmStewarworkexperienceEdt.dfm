inherited frmStewadworkexperience: TfrmStewadworkexperience
  Caption = #20056#21153#21592#21592#24037#20316#32463#39564
  ClientHeight = 257
  ClientWidth = 513
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  ExplicitWidth = 519
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 513
    Height = 212
    ExplicitWidth = 513
    ExplicitHeight = 212
    inherited Bevel1: TBevel
      Left = 0
      Top = 186
      Width = 513
      ExplicitLeft = 0
      ExplicitTop = 186
    end
    object lbl11: TLabel
      Left = 65
      Top = 74
      Width = 28
      Height = 14
      Caption = #32844#20301
    end
    object lbl15: TLabel
      Left = 37
      Top = 35
      Width = 56
      Height = 14
      Caption = #24037#20316#21333#20301
    end
    object lbl16: TLabel
      Left = 288
      Top = 35
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object lbl17: TLabel
      Left = 288
      Top = 74
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object lbl1: TLabel
      Left = 65
      Top = 113
      Width = 28
      Height = 14
      Caption = #31616#21382
    end
    object lbl2: TLabel
      Left = 248
      Top = 35
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbl3: TLabel
      Left = 248
      Top = 74
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object nvedtPosition: TNovaEdit
      Left = 99
      Top = 71
      Width = 143
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 15
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
    end
    object nvedtWorkunit: TNovaEdit
      Left = 99
      Top = 32
      Width = 143
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 15
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
    object dtpBegindate: TDateTimePicker
      Left = 350
      Top = 32
      Width = 99
      Height = 22
      Date = 18264.000000000000000000
      Time = 18264.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object dtpEnddate: TDateTimePicker
      Left = 350
      Top = 71
      Width = 99
      Height = 22
      Date = 40555.000000000000000000
      Time = 40555.000000000000000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 3
    end
    object mmoMeResume: TMemo
      Left = 99
      Top = 110
      Width = 350
      Height = 53
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 4
    end
  end
  inherited pnlOperation: TPanel
    Top = 212
    Width = 513
    ExplicitTop = 212
    ExplicitWidth = 513
    inherited bbtnSave: TBitBtn
      Left = 135
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 135
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 272
      Top = 6
      ExplicitLeft = 272
      ExplicitTop = 6
    end
  end
  object jcdsSaveWork: TjsonClientDataSet
    DataSourceName = 'entrancemap'
    QueryAddress = 'archive/saveStewardWork'
    SaveAddress = 'archive/saveStewardWork'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <
      item
        Visible = False
      end>
    Params = <
      item
        DataType = ftBCD
        Name = 'stewardworkexperience.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.stewardid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.position'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.workunit'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.resume'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stewardworkexperience.createtime'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 120
  end
end
