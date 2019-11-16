object FrmSchedulestatusLog: TFrmSchedulestatusLog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #29677#27425#20572#29677#22788#29702#26085#24535
  ClientHeight = 449
  ClientWidth = 574
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
    Width = 574
    Height = 449
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 398
      Width = 574
      Height = 51
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object bbtnClose: TBitBtn
        Left = 232
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
      Width = 574
      Height = 398
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
end
