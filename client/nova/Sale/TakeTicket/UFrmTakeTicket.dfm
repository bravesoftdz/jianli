object FrmTakeTicket: TFrmTakeTicket
  Left = 0
  Top = 0
  Caption = #30005#23376#31080#21462#31080
  ClientHeight = 568
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 15
  object pnl1: TPanel
    Left = 0
    Top = 39
    Width = 715
    Height = 529
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object grpticketinfo: TGroupBox
      Left = 0
      Top = 271
      Width = 715
      Height = 258
      Align = alClient
      Caption = #30005#23376#31080#20449#24687
      Enabled = False
      TabOrder = 0
      object bvl1: TBevel
        AlignWithMargins = True
        Left = 11
        Top = 88
        Width = 693
        Height = 1
        Margins.Left = 9
        Margins.Top = 43
        Margins.Right = 9
        Align = alTop
        ExplicitLeft = 10
        ExplicitTop = 87
        ExplicitWidth = 629
      end
      object btnprint: TBitBtn
        Left = 2
        Top = 17
        Width = 711
        Height = 28
        Align = alTop
        Caption = 'F12.'#21462#31080#25171#21360
        DoubleBuffered = True
        Enabled = False
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnprintClick
      end
      object lbledtdepartstation: TLabeledEdit
        Left = 288
        Top = 132
        Width = 132
        Height = 23
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = #21457#36710#31449
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 1
      end
      object lbledtreachstation: TLabeledEdit
        Left = 508
        Top = 131
        Width = 132
        Height = 23
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = #21040#36798#31449
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 2
      end
      object lbledtschedule: TLabeledEdit
        Left = 288
        Top = 97
        Width = 132
        Height = 23
        EditLabel.Width = 30
        EditLabel.Height = 15
        EditLabel.Caption = #29677#27425
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 3
      end
      object lbledtdepartdate: TLabeledEdit
        Left = 82
        Top = 97
        Width = 133
        Height = 23
        EditLabel.Width = 60
        EditLabel.Height = 15
        EditLabel.Caption = #21457#36710#26085#26399
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 4
      end
      object lbledttickettype: TLabeledEdit
        Left = 288
        Top = 169
        Width = 132
        Height = 23
        EditLabel.Width = 30
        EditLabel.Height = 15
        EditLabel.Caption = #31080#31181
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 5
      end
      object lbledtprice: TLabeledEdit
        Left = 508
        Top = 169
        Width = 132
        Height = 23
        EditLabel.Width = 30
        EditLabel.Height = 15
        EditLabel.Caption = #31080#20215
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 6
      end
      object lbledtseatno: TLabeledEdit
        Left = 82
        Top = 169
        Width = 133
        Height = 23
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = #24231#20301#21495
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 7
      end
      object chkhastaketicket: TCheckBox
        Left = 24
        Top = 58
        Width = 63
        Height = 15
        Caption = #24050#21462#31080
        Enabled = False
        TabOrder = 8
      end
      object lbledttaketickettime: TLabeledEdit
        Left = 215
        Top = 55
        Width = 204
        Height = 23
        EditLabel.Width = 60
        EditLabel.Height = 15
        EditLabel.Caption = #21462#31080#26102#38388
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 9
      end
      object lbledtticketno: TLabeledEdit
        Left = 508
        Top = 55
        Width = 132
        Height = 23
        EditLabel.Width = 60
        EditLabel.Height = 15
        EditLabel.Caption = #21462#31080#31080#21495
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 10
      end
      object lbledtselltime: TLabeledEdit
        Left = 82
        Top = 133
        Width = 133
        Height = 23
        EditLabel.Width = 60
        EditLabel.Height = 15
        EditLabel.Caption = #21806#31080#26102#38388
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 11
      end
      object lbledtdeparttime: TLabeledEdit
        Left = 508
        Top = 97
        Width = 132
        Height = 23
        EditLabel.Width = 60
        EditLabel.Height = 15
        EditLabel.Caption = #21457#36710#26102#38388
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 12
      end
    end
    object pgcquery: TPageControl
      Left = 0
      Top = 0
      Width = 715
      Height = 271
      ActivePage = tsmultiinput
      Align = alTop
      TabOrder = 1
      OnChange = pgcqueryChange
      object tsscan: TTabSheet
        Caption = 'F1.'#20108#32500#30721#25195#25551
        object pnlview: TPanel
          Left = 0
          Top = 25
          Width = 320
          Height = 215
          Align = alLeft
          BevelOuter = bvLowered
          TabOrder = 0
        end
        object mmo1: TMemo
          Left = 320
          Top = 25
          Width = 387
          Height = 215
          Align = alClient
          Lines.Strings = (
            'mmo1')
          ReadOnly = True
          TabOrder = 1
        end
        object btnstartscan: TButton
          Left = 0
          Top = 0
          Width = 707
          Height = 25
          Align = alTop
          Caption = 'F1.'#24320#22987#25195#25551
          Enabled = False
          TabOrder = 2
          OnClick = btnstartscanClick
        end
      end
      object tsinput: TTabSheet
        Caption = 'F2.'#39564#35777#30721#36755#20837
        ImageIndex = 1
        object lbledtpassword: TLabeledEdit
          Left = 93
          Top = 14
          Width = 172
          Height = 23
          EditLabel.Width = 90
          EditLabel.Height = 15
          EditLabel.Caption = #30005#23376#31080#26657#39564#30721
          LabelPosition = lpLeft
          TabOrder = 0
          OnKeyPress = lbledtpasswordKeyPress
        end
        object btnquey: TBitBtn
          Left = 279
          Top = 13
          Width = 82
          Height = 22
          Caption = #26597#35810
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = btnqueyClick
        end
      end
      object tsmultiinput: TTabSheet
        Caption = 'F3.'#22810#35760#24405#39564#35777#30721#36755#20837
        ImageIndex = 2
        object LabeledEdit1: TLabeledEdit
          Left = 93
          Top = 14
          Width = 172
          Height = 23
          EditLabel.Width = 90
          EditLabel.Height = 15
          EditLabel.Caption = #30005#23376#31080#26657#39564#30721
          LabelPosition = lpLeft
          TabOrder = 0
          OnKeyPress = lbledtpasswordKeyPress
        end
        object BitBtn1: TBitBtn
          Left = 279
          Top = 13
          Width = 82
          Height = 22
          Caption = #26597#35810
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = btnqueyClick
        end
      end
    end
  end
  object grpticketno: TGroupBox
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 706
    Height = 39
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 9
    Margins.Bottom = 0
    Align = alTop
    Caption = #24403#21069#31080#21495
    TabOrder = 1
    object lblticketno: TLabel
      Left = 2
      Top = 17
      Width = 120
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = '012345678912'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 244
      Top = 17
      Width = 15
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taCenter
      Caption = #24352
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
    object lbl3: TLabel
      Left = 122
      Top = 17
      Width = 14
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = #20313
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 96
      ExplicitTop = 15
      ExplicitHeight = 18
    end
    object lblleaveticketnum: TLabel
      Left = 136
      Top = 17
      Width = 108
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taCenter
      Caption = '012345678912'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
  end
  object tmrleaveticketnum: TTimer
    Enabled = False
    OnTimer = tmrleaveticketnumTimer
    Left = 632
    Top = 328
  end
  object tmrRefreshBill: TTimer
    OnTimer = tmrRefreshBillTimer
    Left = 496
    Top = 272
  end
  object jcdsResult: TjsonClientDataSet
    DataSourceName = 'eticketinfo'
    QueryAddress = 'sell/findETicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'eticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'epassword'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 232
  end
  object jcdstaketicket: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'sell/takeTicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tsoid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'takeway'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'ticketsellid'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 408
    Top = 208
  end
end
