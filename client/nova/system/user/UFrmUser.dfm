inherited FrmUser: TFrmUser
  Caption = #29992#25143#31649#29702
  ClientHeight = 479
  ClientWidth = 845
  OnShow = FormShow
  ExplicitWidth = 861
  ExplicitHeight = 517
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 845
    Height = 94
    ExplicitWidth = 845
    ExplicitHeight = 94
    object lbl2: TLabel
      Left = 536
      Top = 66
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object lbl3: TLabel
      Left = 13
      Top = 26
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl1: TLabel
      Left = 264
      Top = 26
      Width = 56
      Height = 14
      Caption = #25152#23646#37096#38376
    end
    object lbl4: TLabel
      Left = 27
      Top = 66
      Width = 42
      Height = 14
      Caption = #29992#25143#21517
    end
    object lbl5: TLabel
      Left = 264
      Top = 66
      Width = 56
      Height = 14
      Caption = #21592#24037#21345#21495
    end
    object lblrole: TLabel
      Left = 508
      Top = 26
      Width = 56
      Height = 14
      Caption = #25152#23646#35282#33394
    end
    object cbb_depid: TNovaHComboBox
      Left = 326
      Top = 22
      Width = 127
      Height = 22
      ImeMode = imClose
      TabOrder = 0
      OnEnter = cbb_depidEnter
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
          Name = 'filter_INS_t!parentid'
          ParamType = ptInput
        end>
    end
    object edt_name: TNovaEdit
      Left = 574
      Top = 63
      Width = 127
      Height = 22
      MaxLength = 30
      TabOrder = 1
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
    object edt_code: TNovaEdit
      Left = 78
      Top = 64
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 30
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
    object edtcardno: TNovaEdit
      Left = 324
      Top = 64
      Width = 127
      Height = 22
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
    end
    object cbborg: TNovaCheckedComboBox
      Left = 78
      Top = 22
      Width = 130
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nhcbbrole: TNovaHComboBox
      Left = 574
      Top = 23
      Width = 127
      Height = 22
      ImeMode = imClose
      TabOrder = 5
      OnEnter = cbb_depidEnter
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
          Size = 1000
          Value = 'RoleHelp'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 845
    ExplicitWidth = 845
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      OnClick = tbtnEditClick
    end
    inherited tbtnDelete: TToolButton
      OnClick = tbtnDeleteClick
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
  end
  inherited Panel1: TPanel
    Top = 139
    Width = 845
    Height = 340
    ExplicitTop = 139
    ExplicitWidth = 845
    ExplicitHeight = 340
    inherited GroupBox1: TGroupBox
      Width = 845
      Height = 200
      ExplicitWidth = 845
      ExplicitHeight = 200
      inherited dbgrdhResult: TNvDbgridEh
        Width = 841
        Height = 182
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29992#25143#21517
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'depname'
            Footers = <>
            Title.Caption = #25152#23646#37096#38376
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketoutlet'
            Footers = <>
            Title.Caption = #25152#23646#21806#31080#28857
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'email'
            Footers = <>
            Title.Caption = #30005#23376#37038#31665
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'cardno'
            Footers = <>
            Title.Caption = #21592#24037#21345#21495
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'idcard'
            Footers = <>
            Title.Caption = #36523#20221#35777
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ismultipoint'
            Footers = <>
            Title.Caption = #33021#21542#22810#28857#30331#38470
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'phone'
            Footers = <>
            Title.Caption = #32852#31995#30005#35805
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketdiscount'
            Footers = <>
            Title.Caption = #21806#31080#25240#25187#29575
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'password'
            Footers = <>
            Visible = False
          end>
      end
    end
    object grp2: TGroupBox
      Left = 0
      Top = 200
      Width = 845
      Height = 140
      Align = alBottom
      Caption = #29992#25143#35282#33394#21015#34920
      TabOrder = 1
      object dbgrdh1: TDBGridEh
        Left = 2
        Top = 16
        Width = 841
        Height = 122
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = dsuserrole
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imDisable
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #35282#33394#21517
            Width = 126
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32452#32455#26426#26500
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 96
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Left = 152
    Top = 232
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'usermap'
    QueryAddress = 'system/listuser'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_u!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_u!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_u!cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_r!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_u!departmentid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_r!id'
        ParamType = ptInput
      end>
    AfterOpen = jcdsResultAfterOpen
    AfterScroll = jcdsResultAfterScroll
    Top = 232
  end
  inherited dsResult: TDataSource
    Left = 48
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Top = 232
  end
  object dsuserrole: TDataSource
    DataSet = jsonCDSRoleResult
    Left = 752
    Top = 200
  end
  object jsonCDSUserDel: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'system/deluser'
    SaveAddress = 'system/deluser'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'user.id'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 184
  end
  object jsonCDSRoleResult: TjsonClientDataSet
    DataSourceName = 'rolemap'
    QueryAddress = 'system/queryRole'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    ObjectView = False
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_a!id.userid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 640
    Top = 200
  end
end
