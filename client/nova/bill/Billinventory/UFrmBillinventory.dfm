inherited FrmBillinventory: TFrmBillinventory
  Left = 374
  Top = 166
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #31080#25454#20837#24211
  ClientHeight = 403
  ClientWidth = 405
  Font.Charset = GREEK_CHARSET
  Font.Pitch = fpFixed
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 411
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 405
    Height = 358
    ExplicitWidth = 405
    ExplicitHeight = 358
    inherited Bevel1: TBevel
      Top = 340
      Width = 372
      ExplicitTop = 355
      ExplicitWidth = 390
    end
    object Label1: TLabel
      Left = 82
      Top = 74
      Width = 56
      Height = 14
      Caption = #31080#24211#21517#31216
    end
    object Label2: TLabel
      Left = 82
      Top = 112
      Width = 56
      Height = 14
      Caption = #31080#25454#31867#22411
    end
    object Label3: TLabel
      Left = 82
      Top = 193
      Width = 56
      Height = 14
      Caption = #36215#22987#21495#30721
    end
    object Label5: TLabel
      Left = 64
      Top = 304
      Width = 84
      Height = 14
      Caption = #30830#23450#32467#26463#21495#30721
    end
    object lbl1: TLabel
      Left = 64
      Top = 226
      Width = 84
      Height = 14
      Caption = #30830#23450#36215#22987#21495#30721
    end
    object lbl2: TLabel
      Left = 82
      Top = 264
      Width = 56
      Height = 14
      Caption = #32467#26463#21495#30721
    end
    object lbl8: TLabel
      Left = 305
      Top = 77
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl3: TLabel
      Left = 305
      Top = 115
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl4: TLabel
      Left = 305
      Top = 153
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl5: TLabel
      Left = 305
      Top = 191
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl6: TLabel
      Left = 305
      Top = 229
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl7: TLabel
      Left = 305
      Top = 267
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl10: TLabel
      Left = 305
      Top = 39
      Width = 6
      Height = 11
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = #23435#20307
      Font.Pitch = fpFixed
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object lbl9: TLabel
      Left = 40
      Top = 36
      Width = 98
      Height = 14
      Caption = #20837#24211#25805#20316#25209#27425#21495
    end
    object lblparvalue: TLabel
      Left = 82
      Top = 150
      Width = 56
      Height = 14
      Caption = #31080#38754#20215#20540
    end
    object Label4: TLabel
      Left = 317
      Top = 150
      Width = 14
      Height = 14
      Caption = #20803
    end
    object edtstartno: TNovaEdit
      Left = 154
      Top = 185
      Width = 145
      Height = 22
      MaxLength = 10
      TabOrder = 3
      ValueType = ssTicket
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
    object edtreendno: TNovaEdit
      Left = 154
      Top = 301
      Width = 145
      Height = 22
      MaxLength = 10
      TabOrder = 6
      ValueType = ssTicket
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
    object edtrestartno: TNovaEdit
      Left = 154
      Top = 223
      Width = 145
      Height = 22
      MaxLength = 10
      TabOrder = 4
      ValueType = ssTicket
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
    object edtendno: TNovaEdit
      Left = 154
      Top = 261
      Width = 145
      Height = 22
      MaxLength = 10
      TabOrder = 5
      ValueType = ssTicket
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
    object edtbatchno: TNovaEdit
      Left = 154
      Top = 33
      Width = 145
      Height = 22
      MaxLength = 30
      TabOrder = 0
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
    object novahcbbstorage: TNovaHComboBox
      Left = 154
      Top = 71
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
      Items.Strings = (
        '111')
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
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BillstorageHelp'
        end>
    end
    object novahcbbtype: TNovaHComboBox
      Left = 154
      Top = 109
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
      OnClick = novahcbbtypeChange
      OnSelect = novahcbbtypeSelect
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
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BilltypeHelp'
        end>
    end
    object edtparvalue: TNovaEdit
      Left = 154
      Top = 147
      Width = 145
      Height = 22
      MaxLength = 10
      TabOrder = 7
      Text = '0'
      value = '0'
      ValueTrim = '0'
      ValueType = ssTicket
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
    Top = 358
    Width = 405
    ExplicitTop = 358
    ExplicitWidth = 405
    inherited bbtnSave: TBitBtn
      Left = 106
      Top = 6
      Caption = '&S '#20837#24211
      OnClick = bbtnSaveClick
      ExplicitLeft = 106
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 224
      Top = 6
      Caption = '&Q '#21462#28040
      ExplicitLeft = 224
      ExplicitTop = 6
    end
  end
  object jsonBillinventorySave: TjsonClientDataSet
    DataSourceName = 'billstoragemap'
    QueryAddress = 'bill/savebillinventory'
    SaveAddress = 'bill/savebillinventory'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'billinventory.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.storageid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.billtypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.description'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'billinventory.createby'
        ParamType = ptInput
      end
      item
        DataType = ftOraTimeStamp
        Name = 'billinventory.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.putinendno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.putinstartno'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'billinventory.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.batchno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinventory.parvalue'
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
      end
      item
        DataType = ftLongWord
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 344
    Top = 264
  end
  object qryValue: TjsonClientDataSet
    DataSourceName = 'billtypemap'
    QueryAddress = 'bill/qryvalue'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'name'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 352
    Top = 184
  end
end
