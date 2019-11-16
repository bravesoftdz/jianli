inherited frmPCticketentrnceEdit: TfrmPCticketentrnceEdit
  Caption = #32534#36753#26816#31080#30005#33041#25511#21046#20449#24687
  ClientHeight = 345
  ClientWidth = 506
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  ExplicitWidth = 512
  ExplicitHeight = 377
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 506
    Height = 300
    ExplicitWidth = 506
    ExplicitHeight = 300
    inherited Bevel1: TBevel
      Top = 288
      Width = 472
      ExplicitTop = 299
      ExplicitWidth = 549
    end
    object lblIP: TLabel
      Left = 16
      Top = 46
      Width = 70
      Height = 14
      Caption = #26816#31080#30005#33041'IP'
    end
    object lblOrgid: TLabel
      Left = 30
      Top = 91
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl28: TLabel
      Left = 255
      Top = 91
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
      Transparent = True
    end
    object lbl1: TLabel
      Left = 255
      Top = 46
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
      Transparent = True
    end
    object nvedtIP: TNovaEdit
      Left = 103
      Top = 43
      Width = 146
      Height = 22
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
    end
    object nvlvEntrance: TNovaListView
      Left = 279
      Top = 23
      Width = 178
      Height = 242
      Checkboxes = True
      Columns = <
        item
          MaxWidth = 20
          MinWidth = 20
          Width = 20
        end
        item
          Caption = #26816#31080#21475#20301#32622
          Width = 180
        end>
      GridLines = True
      TabOrder = 2
      ViewStyle = vsReport
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'ticketentrancename'
      HelpOptions.HQueryAddress = 'base/findTicketentrancename'
      HelpOptions.FieldNames.Strings = (
        'id'
        'name')
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object nvhcbbOrg: TNovaHComboBox
      Left = 103
      Top = 88
      Width = 146
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 1
      OnChange = nvhcbbOrgChange
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
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'OrgHelp'
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 300
    Width = 506
    ExplicitTop = 300
    ExplicitWidth = 506
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 288
      Top = 6
      ExplicitLeft = 288
      ExplicitTop = 6
    end
  end
  object jcdsSaveEntrance: TjsonClientDataSet
    DataSourceName = 'entrancemap'
    QueryAddress = 'base/findpcentrance'
    SaveAddress = 'base/savepcentrance'
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
        Name = 'pcticketentrance.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pcticketentrance.ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pcticketentrance.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pcticketentrance.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ticketentranceids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isupdate'
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
    Left = 168
    Top = 136
  end
end
