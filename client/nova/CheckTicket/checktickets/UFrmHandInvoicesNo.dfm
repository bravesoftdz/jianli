inherited FrmHandInvoicesNo: TFrmHandInvoicesNo
  Caption = #20445#23384#25163#24037#36816#37327
  ClientHeight = 204
  ClientWidth = 448
  ExplicitWidth = 454
  ExplicitHeight = 236
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 448
    Height = 159
    ExplicitWidth = 448
    ExplicitHeight = 159
    inherited Bevel1: TBevel
      Top = 151
      Width = 414
      ExplicitTop = 151
      ExplicitWidth = 414
    end
    object GroupBox1: TGroupBox
      Left = 56
      Top = 24
      Width = 337
      Height = 105
      Caption = #25163#24037#36816#37327#21333#21482#20445#23384#25968#25454#19981#25171#21360#21333#25454#65292#25968#25454#21442#19982#32467#31639
      TabOrder = 0
      object Label1: TLabel
        Left = 28
        Top = 48
        Width = 28
        Height = 14
        Caption = #21333#21495
      end
      object NovaEdtInvoicesNo: TNovaEdit
        Left = 64
        Top = 42
        Width = 175
        Height = 27
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = [fsBold]
        MaxLength = 12
        ParentFont = False
        TabOrder = 0
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
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 159
    Width = 448
    ExplicitTop = 159
    ExplicitWidth = 448
    inherited bbtnSave: TBitBtn
      Caption = '&S '#30830#23450
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 432
    Top = 304
  end
end
