inherited FrmPackacceptReport: TFrmPackacceptReport
  Caption = #34892#21253#21463#29702#21333
  ClientHeight = 133
  ClientWidth = 439
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 445
  ExplicitHeight = 161
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 439
    Height = 88
    ExplicitWidth = 439
    ExplicitHeight = 88
    inherited Bevel1: TBevel
      Top = 80
      Width = 405
      ExplicitTop = 280
      ExplicitWidth = 404
    end
    object lbl1: TLabel
      Left = 59
      Top = 31
      Width = 340
      Height = 19
      Caption = #35831#36827#20837#39044#35272#30028#38754#65292#28982#21518#20877#25171#21360#32564#27454#21333#65281
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 88
    Width = 439
    ExplicitTop = 88
    ExplicitWidth = 439
    inherited bbtnSave: TBitBtn
      Left = 16
      Top = 6
      Caption = '&S '#26597#30475
      Visible = False
      OnClick = bbtnSaveClick
      ExplicitLeft = 16
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 232
      Top = 6
      ExplicitLeft = 232
      ExplicitTop = 6
    end
    object btn1: TButton
      Left = 132
      Top = 6
      Width = 75
      Height = 25
      Caption = #39044#35272
      TabOrder = 2
      OnClick = btn1Click
    end
  end
  inherited ImageList: TImageList
    Left = 128
    Top = 65528
  end
  object ds1: TDataSource
    Left = 32
  end
  object ds2: TDataSource
    Left = 320
  end
end
