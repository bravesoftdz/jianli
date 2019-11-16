inherited FrmInfo: TFrmInfo
  Caption = 'FrmInfo'
  ClientHeight = 500
  ClientWidth = 648
  OnShow = FormShow
  ExplicitWidth = 654
  ExplicitHeight = 532
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 648
    Height = 498
    ExplicitWidth = 648
    ExplicitHeight = 498
    inherited Bevel1: TBevel
      Top = 490
      Width = 614
      ExplicitTop = 316
      ExplicitWidth = 614
    end
    object grp3: TGroupBox
      Left = 0
      Top = 0
      Width = 648
      Height = 498
      Align = alClient
      TabOrder = 0
      object wb1: TWebBrowser
        Left = 2
        Top = 16
        Width = 644
        Height = 480
        Align = alClient
        TabOrder = 0
        OnDocumentComplete = wb1DocumentComplete
        ExplicitLeft = 1
        ExplicitTop = 12
        ControlData = {
          4C0000008F4200009C3100000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 498
    Width = 648
    Height = 2
    Visible = False
    ExplicitTop = 498
    ExplicitWidth = 648
    ExplicitHeight = 2
  end
  object jscdQryFunInfo: TjsonClientDataSet
    DataSourceName = 'functionregmap'
    QueryAddress = 'system/qryFuncInfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'key'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 96
  end
end
