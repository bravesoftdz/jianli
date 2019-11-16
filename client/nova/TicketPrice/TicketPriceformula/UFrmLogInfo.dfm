object FrmLogInfo: TFrmLogInfo
  Left = 0
  Top = 0
  Caption = #20449#24687#25552#31034
  ClientHeight = 339
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 387
    Height = 339
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 288
      Width = 387
      Height = 51
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object bbtnClose: TBitBtn
        Left = 144
        Top = 14
        Width = 83
        Height = 25
        Caption = '&Q '#20851#38381
        DoubleBuffered = True
        Kind = bkClose
        ParentDoubleBuffered = False
        TabOrder = 0
      end
    end
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 387
      Height = 288
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ReadOnly = True
      TabOrder = 1
    end
  end
end
