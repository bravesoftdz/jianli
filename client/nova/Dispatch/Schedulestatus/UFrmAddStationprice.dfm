inherited FrmAddStationprice: TFrmAddStationprice
  Caption = 'FrmAddStationprice'
  ClientHeight = 322
  ClientWidth = 515
  OnShow = FormShow
  ExplicitWidth = 521
  ExplicitHeight = 354
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 515
    Height = 277
    ExplicitWidth = 515
    ExplicitHeight = 277
    inherited Bevel1: TBevel
      Top = 269
      Width = 481
      ExplicitTop = 322
      ExplicitWidth = 406
    end
    object Label1: TLabel
      Left = 42
      Top = 83
      Width = 56
      Height = 14
      Caption = #20572#38752#31449#28857
    end
    object Label2: TLabel
      Left = 42
      Top = 126
      Width = 56
      Height = 14
      Caption = #20840#31080#31080#20215
    end
    object Label3: TLabel
      Left = 42
      Top = 163
      Width = 56
      Height = 14
      Caption = #21322#31080#31080#20215
    end
    object Label4: TLabel
      Left = 278
      Top = 123
      Width = 56
      Height = 14
      Caption = #23398#29983#31080#20215
    end
    object Label5: TLabel
      Left = 278
      Top = 161
      Width = 56
      Height = 14
      Caption = #19978#38480#31080#20215
    end
    object Label6: TLabel
      Left = 271
      Top = 82
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
      Left = 217
      Top = 123
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
    object Label8: TLabel
      Left = 217
      Top = 158
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
    object Label9: TLabel
      Left = 454
      Top = 118
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
    object Label10: TLabel
      Left = 454
      Top = 163
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
    object Label11: TLabel
      Left = 56
      Top = 40
      Width = 42
      Height = 14
      Caption = #21457#36710#31449
    end
    object Label12: TLabel
      Left = 271
      Top = 38
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
    object Label13: TLabel
      Left = 70
      Top = 204
      Width = 28
      Height = 14
      Caption = #20215#24046
    end
    object Label14: TLabel
      Left = 309
      Top = 198
      Width = 28
      Height = 14
      Caption = #37324#31243
    end
    object Label15: TLabel
      Left = 417
      Top = 199
      Width = 56
      Height = 14
      Caption = #65288#20844#37324#65289
    end
    object NovaHStation: TNovaHelp
      Left = 104
      Top = 79
      Width = 153
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      OnIdChange = NovaHStationIdChange
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
          Title.Caption = #31449#28857#21517#31216' '
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object NovaEdtFullprice: TNovaEdit
      Left = 104
      Top = 120
      Width = 100
      Height = 22
      MaxLength = 50
      TabOrder = 2
      Text = '0'
      OnChange = NovaEdtFullpriceChange
      ValueTrim = '0'
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
    object NovaEdtHalfprice: TNovaEdit
      Left = 104
      Top = 160
      Width = 100
      Height = 22
      MaxLength = 50
      TabOrder = 3
      Text = '0'
      ValueTrim = '0'
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
    object NovaEdtStudentprice: TNovaEdit
      Left = 344
      Top = 117
      Width = 100
      Height = 22
      MaxLength = 50
      TabOrder = 4
      Text = '0'
      ValueTrim = '0'
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
    object NovaEdtTopprice: TNovaEdit
      Left = 344
      Top = 157
      Width = 100
      Height = 22
      MaxLength = 50
      TabOrder = 5
      Text = '0'
      ValueTrim = '0'
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
    object NovaChOrgStation: TNovaCheckedComboBox
      Left = 104
      Top = 37
      Width = 153
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'list'
      HelpOptions.HQueryAddress = 'dispatch/qryCurOrg'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object NovaEdtMoreprice: TNovaEdit
      Left = 104
      Top = 199
      Width = 65
      Height = 22
      MaxLength = 3
      TabOrder = 6
      Text = '0'
      ValueTrim = '0'
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
    object NovaEdtDistance: TNovaEdit
      Left = 343
      Top = 195
      Width = 70
      Height = 22
      MaxLength = 6
      TabOrder = 7
      Text = '0'
      ValueTrim = '0'
      ValueType = ssNumber
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
    Top = 277
    Width = 515
    ExplicitTop = 277
    ExplicitWidth = 515
    inherited bbtnSave: TBitBtn
      Left = 114
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 114
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 280
      Top = 6
      ExplicitLeft = 280
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 552
    Top = 400
  end
  object jscdSaveStatioinprice: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/addStationprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fullprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'halfprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'studentprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'moreprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'topprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'distance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 200
  end
  object jsonQryStationprice: TjsonClientDataSet
    DataSourceName = 'datamap'
    QueryAddress = 'dispatch/qryStationprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reachstationid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 32
  end
end
