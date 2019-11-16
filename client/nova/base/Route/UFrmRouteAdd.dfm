inherited FrmRouteAdd: TFrmRouteAdd
  Caption = 'FrmRouteAdd'
  ClientHeight = 431
  ClientWidth = 559
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 565
  ExplicitHeight = 461
  PixelsPerInch = 106
  TextHeight = 15
  inherited pnlEditBox: TPanel
    Width = 559
    Height = 383
    ExplicitWidth = 559
    ExplicitHeight = 383
    DesignSize = (
      559
      383)
    inherited Bevel1: TBevel
      Top = 376
      Width = 523
      ExplicitTop = 376
      ExplicitWidth = 523
    end
    object lblname: TLabel
      Left = 60
      Top = 160
      Width = 60
      Height = 15
      Caption = #32447#36335#21517#31216
    end
    object lbldistricttype: TLabel
      Left = 303
      Top = 29
      Width = 60
      Height = 15
      Caption = #21306#22495#31867#21035
    end
    object lblendstation: TLabel
      Left = 75
      Top = 117
      Width = 45
      Height = 15
      Caption = #32456#28857#31449
    end
    object lblstartstation: TLabel
      Left = 75
      Top = 74
      Width = 45
      Height = 15
      Caption = #22987#21457#31449
    end
    object lbltype: TLabel
      Left = 303
      Top = 74
      Width = 60
      Height = 15
      Caption = #32447#36335#31867#22411
    end
    object lblgrade: TLabel
      Left = 303
      Top = 117
      Width = 60
      Height = 15
      Caption = #32447#36335#31561#32423
    end
    object lbldirection: TLabel
      Left = 303
      Top = 160
      Width = 60
      Height = 15
      Caption = #32447#36335#26041#21521
    end
    object lblremarks: TLabel
      Left = 333
      Top = 201
      Width = 30
      Height = 15
      Caption = #22791#27880
    end
    object lbl1: TLabel
      Left = 260
      Top = 75
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 260
      Top = 118
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 260
      Top = 161
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 528
      Top = 31
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 528
      Top = 75
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 528
      Top = 118
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 531
      Top = 161
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 60
      Top = 206
      Width = 60
      Height = 15
      Caption = #32447#36335#37324#31243
    end
    object Label2: TLabel
      Left = 260
      Top = 207
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 90
      Top = 244
      Width = 30
      Height = 15
      Caption = #31616#25340
    end
    object Label5: TLabel
      Left = 260
      Top = 29
      Width = 9
      Height = 18
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -18
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 60
      Top = 30
      Width = 60
      Height = 15
      Caption = #25152#23646#26426#26500
    end
    object lbldays: TLabel
      Left = 15
      Top = 285
      Width = 105
      Height = 15
      Caption = #22238#31243#31080#26377#25928#22825#25968
    end
    object lbl9: TLabel
      Left = 260
      Top = 286
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 224
      Top = 324
      Width = 30
      Height = 15
      Caption = #23567#26102
    end
    object lbl10: TLabel
      Left = 30
      Top = 324
      Width = 90
      Height = 15
      Caption = #25253#29677#26102#38388#38388#38548
    end
    object lbl11: TLabel
      Left = 260
      Top = 327
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object nvedtname: TNovaEdit
      Left = 124
      Top = 155
      Width = 130
      Height = 23
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 20
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
    end
    object NvCbbdistricttype: TNovaComboBox
      Left = 366
      Top = 26
      Width = 156
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 7
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
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'districttype'
    end
    object nvhelpendstation: TNovaHelp
      Left = 124
      Top = 113
      Width = 130
      Height = 23
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 2
      OnIdChange = nvhelpstartstationIdChange
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'distance'
          Title.Caption = #37324#31243
          Width = 40
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
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
    object nvhelpstartstation: TNovaHelp
      Left = 124
      Top = 70
      Width = 130
      Height = 23
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 10
      TabOrder = 1
      OnIdChange = nvhelpstartstationIdChange
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'helpcode'
          Title.Caption = #25805#20316#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 50
          Visible = True
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'StartStationHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object nvcbbtype: TNovaComboBox
      Left = 366
      Top = 70
      Width = 156
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 8
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
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'type'
    end
    object nvcbbgrade: TNovaComboBox
      Left = 366
      Top = 113
      Width = 156
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 9
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
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'grade'
    end
    object nvcbbdirection: TNovaComboBox
      Left = 366
      Top = 155
      Width = 156
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 10
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
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'direction'
    end
    object memremarks: TMemo
      Left = 366
      Top = 201
      Width = 156
      Height = 138
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 11
    end
    object nvedtdistance: TNovaEdit
      Left = 124
      Top = 201
      Width = 130
      Height = 23
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 4
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
    object nvedtjianpin: TNovaEdit
      Left = 124
      Top = 241
      Width = 130
      Height = 23
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
    object NovaCbbOrg: TNovaHComboBox
      Left = 124
      Top = 26
      Width = 130
      Height = 23
      Style = csDropDownList
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
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
          DataType = ftWideString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end
        item
          DataType = ftString
          Name = 'filter_INS_t!id'
          ParamType = ptInput
        end
        item
          DataType = ftString
          Name = 'filter_INS_t!type'
          ParamType = ptInput
        end>
    end
    object nvedtdays: TNovaEdit
      Left = 124
      Top = 281
      Width = 130
      Height = 23
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 6
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
    object nvedtReportinterval: TNovaEdit
      Left = 124
      Top = 319
      Width = 96
      Height = 23
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 12
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
    object chkisRealnameticketing: TCheckBox
      Left = 124
      Top = 349
      Width = 130
      Height = 19
      Caption = #26159#21542#23454#21517#21046#21806#31080
      TabOrder = 13
    end
  end
  inherited pnlOperation: TPanel
    Top = 383
    Width = 559
    ExplicitTop = 383
    ExplicitWidth = 559
    inherited bbtnSave: TBitBtn
      Left = 143
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 143
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 289
      ExplicitLeft = 289
    end
  end
  inherited ImageList: TImageList
    Left = 8
    Top = 48
  end
  object jcdsroutesave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveRoute'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.jianpin'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.startstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.endstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.distance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.highdistance'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.grade'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.direction'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.updatetime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.returntripvaliddays'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'route.reportinterval'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'routeid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'route.isrealnameticket'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 256
    Top = 248
  end
end
