inherited FrmOutStationFinger: TFrmOutStationFinger
  Tag = -99
  Caption = 'FrmScheduleFinger'
  ClientHeight = 356
  ClientWidth = 441
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 447
  ExplicitHeight = 384
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Tag = -99
    Width = 441
    Height = 311
    Color = clWhite
    ParentBackground = False
    ExplicitWidth = 441
    ExplicitHeight = 311
    inherited Bevel1: TBevel
      Top = 303
      Width = 407
      ExplicitTop = 403
      ExplicitWidth = 664
    end
    object Label7: TLabel
      Left = 49
      Top = 18
      Width = 56
      Height = 14
      Caption = #39550#39542#21592#65306
    end
    object LabInfo: TLabel
      Left = 105
      Top = 31
      Width = 180
      Height = 25
      Caption = #25351#32441#35774#22791#21021#22987#21270#25104#21151
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Image1: TImage
      Left = 105
      Top = 61
      Width = 265
      Height = 233
    end
    object LabDriver1: TLabel
      Left = 110
      Top = 12
      Width = 11
      Height = 20
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabDriver2: TLabel
      Left = 406
      Top = 11
      Width = 11
      Height = 20
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 311
    Width = 441
    ExplicitTop = 311
    ExplicitWidth = 441
    inherited bbtnSave: TBitBtn
      Left = 16
      Top = 6
      Width = 154
      Height = 30
      Caption = #20445#23384
      Visible = False
      ExplicitLeft = 16
      ExplicitTop = 6
      ExplicitWidth = 154
      ExplicitHeight = 30
    end
    inherited bbtnClose: TBitBtn
      Left = 176
      Top = 6
      Height = 30
      ExplicitLeft = 176
      ExplicitTop = 6
      ExplicitHeight = 30
    end
  end
  inherited ImageList: TImageList
    Left = 656
    Top = 424
  end
end
