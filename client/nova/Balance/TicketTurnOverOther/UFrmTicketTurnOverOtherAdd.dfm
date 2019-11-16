inherited FrmTicketTurnOverOtherAdd: TFrmTicketTurnOverOtherAdd
  Caption = ''
  ClientHeight = 354
  ClientWidth = 595
  OnCreate = FormCreate
  ExplicitWidth = 601
  ExplicitHeight = 382
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 595
    Height = 309
    ExplicitWidth = 595
    ExplicitHeight = 309
    inherited Bevel1: TBevel
      Top = 301
      Width = 561
      ExplicitTop = 301
      ExplicitWidth = 561
    end
    object lbl4: TLabel
      Left = 32
      Top = 51
      Width = 56
      Height = 14
      Caption = #31080#27454#26085#26399
    end
    object Label3: TLabel
      Left = 296
      Top = 51
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label9: TLabel
      Left = 310
      Top = 105
      Width = 42
      Height = 14
      Caption = #21806#31080#21592
    end
    object Label2: TLabel
      Left = 32
      Top = 105
      Width = 56
      Height = 14
      Caption = #32564#27454#37329#39069
    end
    object lbl19: TLabel
      Left = 60
      Top = 216
      Width = 28
      Height = 14
      Caption = #22791#27880
    end
    object dtpdate: TDateTimePicker
      Left = 98
      Top = 48
      Width = 131
      Height = 22
      Date = 40763.639888414350000000
      Time = 40763.639888414350000000
      TabOrder = 0
    end
    object nvhcbbOrg: TNovaHComboBox
      Left = 370
      Top = 48
      Width = 137
      Height = 22
      ImeMode = imClose
      TabOrder = 1
      Items.Strings = (
        #21806#31080#28857
        #33258#21161#26426
        #32852#32593)
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
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'SYSTEM/QRYALLORG'
      HelpOptions.displayFieldname = 'name'
      Params = <>
    end
    object nvhelpUserid: TNovaHelp
      Left = 370
      Top = 102
      Width = 137
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 3
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
          FieldName = 'name'
          Title.Caption = #22995#21517
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #20195#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object mmo1: TMemo
      Left = 94
      Top = 213
      Width = 413
      Height = 40
      TabOrder = 5
    end
    object chkautoprint: TCheckBox
      Left = 98
      Top = 159
      Width = 207
      Height = 17
      Caption = #32564#27454#21518#33258#21160#25171#21360#32564#27454#21333
      TabOrder = 4
      OnClick = chkautoprintClick
    end
    object nvedtMoney: TNovaEdit
      Left = 94
      Top = 102
      Width = 135
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 100
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
  end
  inherited pnlOperation: TPanel
    Top = 309
    Width = 595
    ExplicitTop = 309
    ExplicitWidth = 595
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
    inherited bbtnClose: TBitBtn
      Left = 296
      Top = 6
      ExplicitLeft = 296
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 536
    Top = 248
  end
  object jcdsSave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/seveTicketTurnOverOther'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketTurnOverOther.tickettime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketTurnOverOther.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketTurnOverOther.money'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketTurnOverOther.seller'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketTurnOverOther.remarks'
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
    Left = 40
    Top = 256
  end
end
