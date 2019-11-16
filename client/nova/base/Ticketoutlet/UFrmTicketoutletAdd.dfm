inherited FrmTicketoutletAdd: TFrmTicketoutletAdd
  Caption = #21806#31080#28857#25805#20316
  ClientHeight = 315
  ClientWidth = 568
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  ExplicitWidth = 574
  ExplicitHeight = 343
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 568
    Height = 270
    ExplicitWidth = 568
    ExplicitHeight = 236
    inherited Bevel1: TBevel
      Left = 28
      Top = 262
      Width = 514
      ExplicitLeft = 28
      ExplicitTop = 349
      ExplicitWidth = 498
    end
    object lbl1: TLabel
      Left = 67
      Top = 27
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object lbl6: TLabel
      Left = 318
      Top = 27
      Width = 28
      Height = 14
      Caption = #31867#22411
    end
    object lbl12: TLabel
      Left = 235
      Top = 27
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl7: TLabel
      Left = 491
      Top = 27
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl8: TLabel
      Left = 39
      Top = 67
      Width = 56
      Height = 14
      Caption = #25152#23646#21306#22495
    end
    object lbl3: TLabel
      Left = 318
      Top = 67
      Width = 28
      Height = 14
      Caption = #32423#21035
    end
    object lbl10: TLabel
      Left = 235
      Top = 69
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl14: TLabel
      Left = 491
      Top = 69
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl2: TLabel
      Left = 290
      Top = 147
      Width = 56
      Height = 14
      Caption = #32852#31995#30005#35805
    end
    object lbl5: TLabel
      Left = 53
      Top = 147
      Width = 42
      Height = 14
      Caption = #32852#31995#20154
    end
    object lbl4: TLabel
      Left = 67
      Top = 220
      Width = 28
      Height = 14
      Caption = #22320#22336
    end
    object lbl9: TLabel
      Left = 39
      Top = 108
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl11: TLabel
      Left = 491
      Top = 220
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl13: TLabel
      Left = 235
      Top = 108
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl15: TLabel
      Left = 318
      Top = 108
      Width = 28
      Height = 14
      Caption = #31616#25340
    end
    object Label1: TLabel
      Left = 235
      Top = 147
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label2: TLabel
      Left = 11
      Top = 184
      Width = 84
      Height = 14
      Caption = #23545#24212#21457#36710#31449#28857
    end
    object Label3: TLabel
      Left = 235
      Top = 184
      Width = 7
      Height = 14
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object edtname: TNovaEdit
      Left = 99
      Top = 23
      Width = 129
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
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
    object cbbtype: TNovaComboBox
      Left = 356
      Top = 23
      Width = 129
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 1
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
      HelpOptions.TableName = 'ticketoutlets'
      HelpOptions.Columnname = 'type'
    end
    object cbbdistrictid: TNovaHelp
      Left = 99
      Top = 64
      Width = 129
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
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
          Width = 120
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'DistrictHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object cbbgrade: TNovaComboBox
      Left = 356
      Top = 64
      Width = 129
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
      TabOrder = 3
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
      HelpOptions.TableName = 'ticketoutlets'
      HelpOptions.Columnname = 'level'
    end
    object cbbOrgid: TNovaHComboBox
      Left = 99
      Top = 104
      Width = 129
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 4
      OnEnter = cbbOrgidEnter
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
          Name = 'filter_INS_t!type'
          ParamType = ptInput
          Value = '(0,1,2)'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!id'
          ParamType = ptInput
        end>
    end
    object edtjianpin: TNovaEdit
      Left = 356
      Top = 104
      Width = 129
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object edtperson: TNovaEdit
      Left = 99
      Top = 144
      Width = 129
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 6
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
      Left = 356
      Top = 144
      Width = 129
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 15
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
    object mmoaddress: TMemo
      Left = 99
      Top = 217
      Width = 386
      Height = 21
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 30
      TabOrder = 8
    end
    object Chkisprint: TCheckBox
      Left = 294
      Top = 184
      Width = 129
      Height = 17
      Caption = #21333#29420#25171#21360#32467#31639#21333
      TabOrder = 9
    end
    object cbbstartstation: TNovaHComboBox
      Left = 99
      Top = 181
      Width = 129
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 10
      OnEnter = cbbOrgidEnter
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
          Value = 'StationHelp'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 270
    Width = 568
    ExplicitTop = 236
    ExplicitWidth = 568
    inherited bbtnSave: TBitBtn
      Left = 126
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 126
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 294
      Top = 6
      ExplicitLeft = 294
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 48
    Top = 16
  end
  object jsonCDSTicketoutletSave: TjsonClientDataSet
    DataSourceName = 'ticketoutletlist'
    QueryAddress = 'base/listticketoutlet'
    SaveAddress = 'base/ticketoutlet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketoutlet.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.code'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'ticketoutlet.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'ticketoutlet.createby'
        ParamType = ptInput
      end
      item
        DataType = ftOraTimeStamp
        Name = 'ticketoutlet.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.grade'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.contactphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.address'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.contactperson'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'ticketoutlet.districtid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'ticketoutlet.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'ticketoutlet.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.isprint'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'ticketoutlet.jianpin'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'id'
        ParamType = ptOutput
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftBCD
        Name = 'ticketoutlet.startstation.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 88
  end
end
