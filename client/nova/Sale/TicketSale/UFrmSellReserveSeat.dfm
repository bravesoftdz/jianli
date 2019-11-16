inherited FrmSellReserveSeat: TFrmSellReserveSeat
  Caption = 'FrmSellReserveSeat'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  inherited pnlmain: TPanel
    inherited pnlinput: TPanel
      inherited gbamount: TGroupBox
        Left = 653
        TabOrder = 4
        ExplicitLeft = 653
      end
      inherited gbTakeKid: TGroupBox
        Left = 901
        TabOrder = 5
        ExplicitLeft = 901
      end
      object grpcustomer: TGroupBox
        Left = 397
        Top = 0
        Width = 256
        Height = 56
        Align = alLeft
        Caption = #35746#31080#20154
        TabOrder = 3
        object nvedtCERTIFICATENO: TNovaEdit
          Left = 119
          Top = 20
          Width = 133
          Height = 31
          MaxLength = 50
          TabOrder = 1
          OnKeyDown = nvedtCERTIFICATENOKeyDown
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
        object nvcbbCERTIFICATETYPE: TNovaComboBox
          Left = 4
          Top = 20
          Width = 111
          Height = 31
          ImeMode = imClose
          TabOrder = 0
          OnChange = nvcbbCERTIFICATETYPEChange
          OnEnterColor = clGradientActiveCaption
          OnExitColot = clWindow
          DisEnableFont.Charset = DEFAULT_CHARSET
          DisEnableFont.Color = clWindowText
          DisEnableFont.Height = -11
          DisEnableFont.Name = 'Tahoma'
          DisEnableFont.Style = []
          DisEnableColor = clRed
          OnChangeColor = 4901849
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'diclist'
          HelpOptions.HQueryAddress = 'system/querydictionary'
          HelpOptions.TableName = 'customer'
          HelpOptions.Columnname = 'certificatetype'
          HelpOptions.IsDebug = True
        end
      end
    end
  end
  object jcdsqryBookTicket: TjsonClientDataSet
    DataSourceName = 'seatreservemap'
    QueryAddress = 'dispatch/qryseatreserve'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_t!seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!scheduleplanid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 200
  end
  object jsoncdsquerycustomer: TjsonClientDataSet
    DataSourceName = 'customermap'
    UpdateDataSet = 'customerlist'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/saveCustomerlist'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    refreshAfterApplyUpdates = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_c!certificateno'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftWideString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 456
    Top = 264
  end
end
