inherited FrmInsuretypepriceEdt: TFrmInsuretypepriceEdt
  Caption = 'FrmInsuretypedistanceEdt'
  ClientHeight = 250
  ClientWidth = 295
  OnCreate = FormCreate
  ExplicitWidth = 301
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 295
    Height = 205
    ExplicitWidth = 295
    ExplicitHeight = 205
    inherited Bevel1: TBevel
      Top = 197
      Width = 261
      ExplicitTop = 197
      ExplicitWidth = 261
    end
    object Label1: TLabel
      Left = 48
      Top = 70
      Width = 56
      Height = 14
      Caption = #20445#38505#31867#22411
    end
    object Label2: TLabel
      Left = 48
      Top = 110
      Width = 42
      Height = 14
      Caption = #36215#22987#20215
    end
    object Label3: TLabel
      Left = 48
      Top = 150
      Width = 42
      Height = 14
      Caption = #25130#27490#20215
    end
    object lbl5: TLabel
      Left = 235
      Top = 70
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
    object lbl1: TLabel
      Left = 235
      Top = 110
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
      Left = 235
      Top = 150
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
    object lblorg: TLabel
      Left = 48
      Top = 30
      Width = 56
      Height = 14
      Caption = #25152#23646#36710#31449
    end
    object lbl3: TLabel
      Left = 235
      Top = 30
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
    object NovaHInsuranceType: TNovaHelp
      Left = 110
      Top = 67
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 0
      OnChange = NovaHInsuranceTypeChange
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
          Title.Caption = #20445#38505#31867#22411
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #20445#38505#32534#30721
          Width = 70
          Visible = True
        end>
      HelpOptions.HelpHeight = 140
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'InsuretypeHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_o!id'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object NovaEdtFromDistance: TNovaEdit
      Left = 110
      Top = 108
      Width = 121
      Height = 22
      MaxLength = 5
      TabOrder = 1
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
    object NovaEdtEndDistance: TNovaEdit
      Left = 110
      Top = 148
      Width = 121
      Height = 22
      MaxLength = 5
      TabOrder = 2
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
    object nvHcbborgid: TNovaHComboBox
      Left = 110
      Top = 27
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
      OnChange = nvHcbborgidChange
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
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 205
    Width = 295
    ExplicitTop = 205
    ExplicitWidth = 295
    inherited bbtnSave: TBitBtn
      Left = 39
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 39
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 168
      Top = 6
      ExplicitLeft = 168
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 256
    Top = 8
  end
  object jscdSaveinsuretypedistance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/saveinsuretypeprice'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'insuretypeticketprice.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.insuretypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.fromprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.endprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'insuretypeticketprice.updateby'
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
      end
      item
        DataType = ftBCD
        Name = 'id'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 184
    Top = 160
  end
end
