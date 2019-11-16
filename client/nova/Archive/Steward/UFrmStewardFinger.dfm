inherited FrmStewardFinger: TFrmStewardFinger
  Caption = 'FrmStewardFinger'
  ClientHeight = 494
  ClientWidth = 584
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 590
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 584
    Height = 449
    ExplicitWidth = 584
    ExplicitHeight = 449
    inherited Bevel1: TBevel
      Top = 441
      Width = 550
      ExplicitTop = 453
      ExplicitWidth = 615
    end
    object Label1: TLabel
      Left = 33
      Top = 26
      Width = 56
      Height = 14
      Caption = #20056#21153#21592#65306
    end
    object Label2: TLabel
      Left = 19
      Top = 64
      Width = 70
      Height = 14
      Caption = #25552#31034#20449#24687#65306
    end
    object LabInfo: TLabel
      Left = 95
      Top = 62
      Width = 144
      Height = 16
      Caption = #25351#32441#35774#22791#21021#22987#21270#25104#21151
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object GroupBox1: TGroupBox
      Left = 95
      Top = 86
      Width = 354
      Height = 334
      Caption = #25351#32441
      TabOrder = 0
      object Image1: TImage
        Left = 2
        Top = 16
        Width = 350
        Height = 316
        Align = alClient
        ExplicitTop = 15
        ExplicitWidth = 316
        ExplicitHeight = 270
      end
    end
    object ZKFPEngX1: TZKFPEngX
      Left = 480
      Top = 144
      Width = 24
      Height = 24
      OnFeatureInfo = ZKFPEngX1FeatureInfo
      OnImageReceived = ZKFPEngX1ImageReceived
      OnEnroll = ZKFPEngX1Enroll
      ControlData = {
        5450463008545A4B4650456E6700044C656674020003546F7002000557696474
        6802180648656967687402180B456E726F6C6C436F756E7402030B53656E736F
        72496E6465780200095468726573686F6C64020A114F6E65546F4F6E65546872
        6573686F6C64020A10466F7263655365636F6E644D61746368080C4175746F49
        64656E74696679080D4973496D6167654368616E6765080000}
    end
    object NovaHelpsteward: TNovaHelp
      Left = 95
      Top = 23
      Width = 111
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 2
      OnIdChange = NovaHelpstewardIdChange
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
          Title.Caption = #22995#21517
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #24037#21495
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StewardHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 449
    Width = 584
    ExplicitTop = 449
    ExplicitWidth = 584
    inherited bbtnSave: TBitBtn
      Left = 178
      Visible = False
      ExplicitLeft = 178
    end
    inherited bbtnClose: TBitBtn
      Left = 315
      ExplicitLeft = 315
    end
  end
  inherited ImageList: TImageList
    Left = 632
    Top = 472
  end
  object jscdSaveFinger: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'archive/saveStewardFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'steward.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'steward.fingerstr1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pictures'
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
    Left = 496
    Top = 264
  end
  object jsonSpcQry: TjsonClientDataSet
    DataSourceName = 'stewardpicture'
    QueryAddress = 'archive/queryStewardFinger'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <>
    RemoteServer = DMPublic.jcon
    Left = 504
    Top = 208
  end
end
