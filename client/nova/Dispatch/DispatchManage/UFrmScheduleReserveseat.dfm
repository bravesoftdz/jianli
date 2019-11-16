inherited FrmScheduleReserveseat: TFrmScheduleReserveseat
  Caption = 'FrmScheduleReserveseat'
  ClientHeight = 447
  ClientWidth = 749
  OnShow = FormShow
  ExplicitWidth = 755
  ExplicitHeight = 479
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 749
    Height = 402
    ExplicitWidth = 749
    ExplicitHeight = 402
    inherited Bevel1: TBevel
      Top = 394
      Width = 715
      ExplicitTop = 394
      ExplicitWidth = 715
    end
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 749
      Height = 122
      Align = alTop
      TabOrder = 0
      object lblroute: TLabel
        Left = 301
        Top = 19
        Width = 28
        Height = 14
        Caption = #32447#36335
      end
      object lblschedule: TLabel
        Left = 514
        Top = 18
        Width = 28
        Height = 14
        Caption = #29677#27425
      end
      object lbldepartdate: TLabel
        Left = 69
        Top = 17
        Width = 56
        Height = 14
        Caption = #21457#36710#26085#26399
      end
      object lblautocanceltime: TLabel
        Left = 267
        Top = 87
        Width = 56
        Height = 14
        Caption = #21462#28040#26102#38388
      end
      object Label1: TLabel
        Left = 288
        Top = 52
        Width = 42
        Height = 14
        Caption = #24231#20301#25968
      end
      object edtroute: TNovaEdit
        Left = 336
        Top = 14
        Width = 121
        Height = 22
        Enabled = False
        MaxLength = 50
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
      object edtstartdate: TNovaEdit
        Left = 131
        Top = 14
        Width = 125
        Height = 22
        Enabled = False
        MaxLength = 50
        TabOrder = 1
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
      object edtschedule: TNovaEdit
        Left = 548
        Top = 14
        Width = 121
        Height = 22
        Enabled = False
        MaxLength = 50
        TabOrder = 2
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
      object dtpautocanceltime: TDateTimePicker
        Left = 336
        Top = 82
        Width = 145
        Height = 22
        Date = 40668.723932465270000000
        Format = 'yyyy-MM-dd  HH:mm:ss'
        Time = 40668.723932465270000000
        Kind = dtkTime
        TabOrder = 3
      end
      object chkcheck: TCheckBox
        Left = 127
        Top = 87
        Width = 84
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = #33258#21160#21462#28040
        Checked = True
        ParentBiDiMode = False
        State = cbChecked
        TabOrder = 4
      end
      object NovaEdtNum: TNovaEdit
        Left = 336
        Top = 48
        Width = 121
        Height = 22
        MaxLength = 50
        TabOrder = 5
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
      object rbReserveSeat: TRadioButton
        Left = 56
        Top = 54
        Width = 65
        Height = 17
        Caption = #30041#20301
        Checked = True
        TabOrder = 6
        TabStop = True
      end
      object rbCancelReserveSeat: TRadioButton
        Left = 127
        Top = 54
        Width = 81
        Height = 17
        Caption = #21462#28040#30041#20301
        TabOrder = 7
      end
    end
    object pnlseatplan: TPanel
      Left = 0
      Top = 122
      Width = 749
      Height = 280
      Align = alClient
      Caption = 'pnlseatplan'
      TabOrder = 1
    end
  end
  inherited pnlOperation: TPanel
    Top = 402
    Width = 749
    ExplicitTop = 402
    ExplicitWidth = 749
    inherited bbtnSave: TBitBtn
      Left = 240
      ExplicitLeft = 240
    end
    inherited bbtnClose: TBitBtn
      Left = 377
      ExplicitLeft = 377
    end
  end
  inherited ImageList: TImageList
    Left = 432
    Top = 256
  end
end
