object FrmPublicQry: TFrmPublicQry
  Left = 0
  Top = 0
  Align = alClient
  Caption = #20844#20849#26597#35810#27169#22359
  ClientHeight = 412
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 718
    Height = 412
    Align = alClient
    TabOrder = 0
  end
  object Chromium1: TChromium
    Left = 0
    Top = 0
    Width = 718
    Height = 412
    ParentCustomHint = False
    Align = alClient
    TabOrder = 1
    OnGetDownloadHandler = Chromium1GetDownloadHandler
    Options.AcceleratedPaintingDisabled = False
    Options.AcceleratedFiltersDisabled = False
    Options.AcceleratedPluginsDisabled = False
  end
  object SaveDialog: TSaveDialog
    Left = 304
    Top = 200
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 392
    Top = 72
  end
end
