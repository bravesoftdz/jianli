inherited FrmTicketoutletStrEdit: TFrmTicketoutletStrEdit
  Caption = 'FrmTicketoutletStrEdit'
  ClientHeight = 300
  ClientWidth = 535
  ExplicitWidth = 541
  ExplicitHeight = 328
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 535
    Height = 255
    ExplicitWidth = 535
    ExplicitHeight = 255
    inherited Bevel1: TBevel
      Top = 247
      Width = 501
      ExplicitTop = 247
      ExplicitWidth = 501
    end
    object lblticketoutlet: TLabel
      Left = 136
      Top = 53
      Width = 42
      Height = 14
      Caption = #21806#31080#28857
    end
    object Label1: TLabel
      Left = 94
      Top = 100
      Width = 84
      Height = 14
      Caption = #20813#31080#20799#31461#27604#20363
    end
    object Label2: TLabel
      Left = 94
      Top = 149
      Width = 84
      Height = 14
      Caption = #26368#22823#21806#31080#37329#39069
    end
    object Label3: TLabel
      Left = 310
      Top = 100
      Width = 7
      Height = 14
      Caption = '%'
    end
    object Label4: TLabel
      Left = 310
      Top = 149
      Width = 14
      Height = 14
      Caption = #20803
    end
    object Label5: TLabel
      Left = 330
      Top = 53
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 330
      Top = 100
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 330
      Top = 149
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object nvhlpticketoutlet: TNovaHelp
      Left = 184
      Top = 50
      Width = 140
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvhlpnvedtreceipt: TNovaEdit
      Left = 184
      Top = 97
      Width = 121
      Height = 32
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      ValueType = ssDouble
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
    object nvhlp1: TNovaEdit
      Left = 184
      Top = 145
      Width = 121
      Height = 32
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      ValueType = ssDouble
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
  inherited pnlOperation: TPanel
    Top = 255
    Width = 535
    ExplicitTop = 255
    ExplicitWidth = 535
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
  end
  inherited ImageList: TImageList
    Left = 80
    Top = 216
  end
  object jsnclntdtstResult: TjsonClientDataSet
    DataSourceName = 'ticketoutletsctrmap'
    QueryAddress = 'base/queryTicketoutletsctr'
    SaveAddress = 'base/saveTicketoutletsctr'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketoutletctr.ticketoutletsid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletctr.carrychildrate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletctr.maxsellmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutletctr.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 208
    Top = 208
  end
end
