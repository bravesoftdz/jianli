inherited FrmInsureReturnend: TFrmInsureReturnend
  Caption = #36864#20445#38505
  ClientHeight = 222
  ClientWidth = 545
  ExplicitWidth = 551
  ExplicitHeight = 250
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 545
    Height = 176
    ExplicitWidth = 545
    ExplicitHeight = 176
    inherited Bevel1: TBevel
      Top = 168
      Width = 511
      ExplicitTop = 139
      ExplicitWidth = 595
    end
    object bvlticketreceipt: TBevel
      Left = 0
      Top = 0
      Width = 545
      Height = 5
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Shape = bsTopLine
      ExplicitTop = 49
      ExplicitWidth = 451
    end
    object pnlinsurereceipt: TPanel
      Left = 0
      Top = 5
      Width = 545
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblinsurenum_: TLabel
        Left = 11
        Top = 21
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #36864#20445#38505#25968
      end
      object lblinsurenum: TLabel
        Left = 69
        Top = 8
        Width = 18
        Height = 39
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '3'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -29
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblinsurereceivablenum_: TLabel
        Left = 329
        Top = 21
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #20445#38505#24212#36864
      end
      object lblinsurereceivablenum: TLabel
        Left = 387
        Top = 8
        Width = 116
        Height = 39
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '1800.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -29
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 118
        Top = 21
        Width = 56
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #20445#38505#37329#39069
      end
      object lblinsuretotalnum: TLabel
        Left = 177
        Top = 8
        Width = 116
        Height = 39
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '1800.50'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -29
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlrr: TPanel
      Left = 0
      Top = 65
      Width = 545
      Height = 111
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object bvlrr: TBevel
        Left = 0
        Top = 0
        Width = 545
        Height = 5
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        Shape = bsTopLine
        ExplicitTop = 56
        ExplicitWidth = 451
      end
      object lblreason: TLabel
        Left = 14
        Top = 39
        Width = 56
        Height = 14
        Caption = #36864#20445#21407#22240
      end
      object mmoreason: TMemo
        Left = 81
        Top = 38
        Width = 422
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 176
    Width = 545
    Height = 46
    ExplicitTop = 176
    ExplicitWidth = 545
    ExplicitHeight = 46
    inherited bbtnSave: TBitBtn
      Left = 159
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 159
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 296
      Top = 6
      ExplicitLeft = 296
      ExplicitTop = 6
    end
  end
end
