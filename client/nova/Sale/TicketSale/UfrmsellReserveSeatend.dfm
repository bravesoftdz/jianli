inherited FrmSellReserveSeatend: TFrmSellReserveSeatend
  Width = 617
  Height = 347
  ExplicitWidth = 617
  ExplicitHeight = 347
  inherited pnlticketreceipt: TPanel
    Width = 617
    ExplicitWidth = 452
    inherited bvlticketreceipt: TBevel
      Width = 617
      ExplicitWidth = 452
    end
  end
  inherited pnlrr: TPanel
    Top = 168
    Width = 617
    ExplicitTop = 168
    ExplicitWidth = 452
    inherited bvlrr: TBevel
      Width = 617
      ExplicitWidth = 452
    end
  end
  inherited pnlinsurereceipt: TPanel
    Width = 617
    ExplicitWidth = 452
  end
  inherited pnlnetservicefee: TPanel
    Width = 617
    TabOrder = 4
    ExplicitWidth = 452
  end
  object pnlservicefee: TPanel
    Left = 0
    Top = 126
    Width = 617
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 452
    object lblservicefee_: TLabel
      Left = 154
      Top = 5
      Width = 105
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = #35746#31080#26381#21153#36153#24212#25910
    end
    object lblservicefee: TLabel
      Left = 263
      Top = -4
      Width = 18
      Height = 39
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = '0'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -29
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object jcdsfindSeatReserve: TjsonClientDataSet
    DataSourceName = 'seatreservemap'
    QueryAddress = 'dispatch/querySingleTable'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_t!scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_t!sellstate'
        ParamType = ptInput
        Value = 'R'
      end
      item
        DataType = ftString
        Name = 'filter_INS_t!seatno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 216
    Top = 104
  end
end
