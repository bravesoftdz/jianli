inherited FrmNetScheduleEdt: TFrmNetScheduleEdt
  Caption = 'FrmNetScheduleEdt'
  ClientHeight = 421
  ClientWidth = 618
  ExplicitWidth = 624
  ExplicitHeight = 453
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 618
    Height = 376
    ExplicitTop = 3
    ExplicitWidth = 618
    ExplicitHeight = 376
    inherited Bevel1: TBevel
      Top = 368
      Width = 584
    end
    object Label1: TLabel
      Left = 40
      Top = 32
      Width = 56
      Height = 14
      Caption = #29677#27425#26426#26500
    end
    object NovaHelp1: TNovaHelp
      Left = 102
      Top = 29
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 0
      Text = 'NovaHelp1'
      ValueTrim = 'NovaHelp1'
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
      HDBGColumns = <>
      HelpOptions.HelpHeight = 0
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 376
    Width = 618
  end
  inherited ImageList: TImageList
    Left = 600
    Top = 400
  end
end
