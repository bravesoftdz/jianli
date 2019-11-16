object Formpause: TFormpause
  Left = 181
  Top = 108
  BorderStyle = bsNone
  Caption = 'Formpause'
  ClientHeight = 768
  ClientWidth = 1024
  Color = 13488334
  Font.Charset = ANSI_CHARSET
  Font.Color = clWhite
  Font.Height = -53
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 53
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 768
    Align = alClient
    BevelOuter = bvNone
    Color = 13488334
    TabOrder = 0
    ExplicitLeft = -24
    ExplicitTop = 224
    object Label1: TLabel
      Left = 218
      Top = 160
      Width = 596
      Height = 107
      Caption = #26242' '#20572' '#21806' '#31080
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -107
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 353
      Top = 433
      Width = 265
      Height = 53
      Alignment = taCenter
      Caption = #35874#35874#21512#20316#65281
      Font.Charset = ANSI_CHARSET
      Font.Color = 13311232
      Font.Height = -53
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 218
      Top = 359
      Width = 536
      Height = 47
      Alignment = taCenter
      Caption = #35831#24744#21040#20854#23427#31383#21475#25490#38431#36141#31080
      Font.Charset = ANSI_CHARSET
      Font.Color = 13311232
      Font.Height = -47
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 205
      Top = 578
      Width = 561
      Height = 40
      Caption = '2009'#24180'12'#26376'12'#26085' '#26143#26399#20116' 12:12'
      Color = 13320221
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -40
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 104
    Top = 120
  end
end
