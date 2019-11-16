inherited FrmUserAdd: TFrmUserAdd
  BorderIcons = [biSystemMenu]
  Caption = #29992#25143#25805#20316
  ClientHeight = 433
  ClientWidth = 707
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 713
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 707
    Height = 382
    ParentColor = True
    ParentShowHint = False
    ExplicitTop = -6
    ExplicitWidth = 707
    ExplicitHeight = 382
    inherited Bevel1: TBevel
      Left = 42
      Top = 372
      Width = 634
      ExplicitLeft = 42
      ExplicitTop = 375
      ExplicitWidth = 607
    end
    object Label1: TLabel
      Left = 345
      Top = 168
      Width = 45
      Height = 16
      Caption = #25240#25187#29575
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 345
      Top = 203
      Width = 45
      Height = 16
      Caption = #36523#20221#35777
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl11: TLabel
      Left = 332
      Top = 275
      Width = 58
      Height = 16
      Caption = #30005'       '#35805
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 348
      Top = 60
      Width = 42
      Height = 16
      Caption = #22995'   '#21517
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 28
      Top = 60
      Width = 60
      Height = 16
      Caption = #25152#23646#37096#38376
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 345
      Top = 137
      Width = 45
      Height = 16
      Caption = #21592#24037#21345
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 28
      Top = 24
      Width = 60
      Height = 16
      Caption = #25152#23646#26426#26500
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 330
      Top = 239
      Width = 60
      Height = 16
      Caption = #30005#23376#37038#20214
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 28
      Top = 132
      Width = 60
      Height = 16
      Caption = #25152#23646#35282#33394
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 330
      Top = 24
      Width = 60
      Height = 16
      Caption = #29992#25143#32534#30721
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 567
      Top = 24
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object Label2: TLabel
      Left = 567
      Top = 60
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object Label7: TLabel
      Left = 269
      Top = 24
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object Label8: TLabel
      Left = 269
      Top = 60
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object Label9: TLabel
      Left = 532
      Top = 95
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object lbl1: TLabel
      Left = 330
      Top = 311
      Width = 60
      Height = 16
      Caption = #22810#28857#30331#38470
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 567
      Top = 169
      Width = 7
      Height = 14
      Caption = '%'
    end
    object Label5: TLabel
      Left = 28
      Top = 96
      Width = 70
      Height = 14
      Caption = #25152#23646#21806#31080#28857
    end
    object cbbOrgid: TNovaHComboBox
      Left = 106
      Top = 21
      Width = 161
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = cbbOrgidChange
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'param'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Size = 1000
          Value = 'OrgHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!parentid'
          ParamType = ptInput
        end>
    end
    object cbbDepid: TNovaHComboBox
      Left = 106
      Top = 57
      Width = 161
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
      OnChange = cbbDepidChange
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'param'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Size = 1000
          Value = 'DepHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!parentid'
          ParamType = ptInput
        end>
    end
    object chklstrole: TCheckListBox
      Left = 106
      Top = 132
      Width = 161
      Height = 191
      ItemHeight = 14
      TabOrder = 2
    end
    object rgismultipoint: TRadioGroup
      Left = 402
      Top = 297
      Width = 161
      Height = 36
      Color = clWhite
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        #26159
        #21542)
      ParentColor = False
      TabOrder = 3
    end
    object edtcode: TNovaEdit
      Left = 402
      Top = 21
      Width = 161
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 4
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
    object edtname: TNovaEdit
      Left = 402
      Top = 57
      Width = 161
      Height = 22
      MaxLength = 10
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
    object BtnSetPass: TBitBtn
      Left = 409
      Top = 92
      Width = 120
      Height = 25
      Caption = '&I '#35774#32622#23494#30721
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5000555555555555577755555555555550B0555555555555F7F7555555555550
        00B05555555555577757555555555550B3B05555555555F7F557555555555000
        3B0555555555577755755555555500B3B0555555555577555755555555550B3B
        055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
        555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
        55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
        555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
        55555575FFFF7755555555570000755555555557777775555555}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = BtnSetPassClick
    end
    object edtcard: TNovaEdit
      Left = 402
      Top = 132
      Width = 161
      Height = 22
      MaxLength = 18
      TabOrder = 7
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
    object edtdiscount: TNovaEdit
      Left = 402
      Top = 166
      Width = 161
      Height = 22
      MaxLength = 50
      TabOrder = 8
      Text = '100'
      TextHint = #35831#36755#20837'0-100'#20043#20869#30340#25968
      OnExit = edtdiscountExit
      ValueTrim = '100'
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
    object edtIdcard: TNovaEdit
      Left = 402
      Top = 201
      Width = 161
      Height = 22
      MaxLength = 18
      TabOrder = 9
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
    object edtemail: TNovaEdit
      Left = 402
      Top = 236
      Width = 161
      Height = 22
      MaxLength = 25
      TabOrder = 10
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
    object edtphone: TNovaEdit
      Left = 402
      Top = 272
      Width = 161
      Height = 22
      MaxLength = 11
      NumbersOnly = True
      TabOrder = 11
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
    object nvhelpTicketoutlets: TNovaHelp
      Left = 106
      Top = 92
      Width = 161
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 12
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
          Title.Caption = #21517#31216
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 160
      HelpOptions.HelpWidth = 168
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'TicketoutletHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 382
    Width = 707
    Height = 51
    ExplicitTop = 382
    ExplicitWidth = 707
    ExplicitHeight = 51
    inherited bbtnSave: TBitBtn
      Left = 213
      Top = 14
      OnClick = bbtnSaveClick
      ExplicitLeft = 213
      ExplicitTop = 14
    end
    inherited bbtnClose: TBitBtn
      Left = 385
      Top = 14
      ExplicitLeft = 385
      ExplicitTop = 14
    end
  end
  inherited ImageList: TImageList
    Left = 600
  end
  object jsonCDSUserSave: TjsonClientDataSet
    DataSourceName = 'usermap'
    QueryAddress = 'system/saveuser'
    SaveAddress = 'system/saveuser'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <
      item
        Visible = False
      end>
    Params = <
      item
        DataType = ftString
        Name = 'user.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.departmentid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.roles'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.password'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.idcard'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.ticketdiscount'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.email'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.phone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.islock'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'user.ismultipoint'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'nResult'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'sResult'
        ParamType = ptOutput
      end
      item
        DataType = ftLongWord
        Name = 'userid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 616
    Top = 192
  end
  object jsonCDSOrgInit: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'OrgHelp'
      end>
    RemoteServer = DMPublic.jcon
    Left = 56
    Top = 240
  end
  object jsonCDSDepInit: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'DepHelp'
      end>
    RemoteServer = DMPublic.jcon
    Left = 616
    Top = 128
  end
  object jsonCDSRoleInit: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'RoleHelp'
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!orgid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 608
    Top = 264
  end
end
