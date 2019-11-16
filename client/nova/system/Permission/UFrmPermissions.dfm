inherited FrmPermissions: TFrmPermissions
  Caption = #26435#38480#31649#29702
  ClientHeight = 468
  ClientWidth = 904
  ExplicitWidth = 920
  ExplicitHeight = 506
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 904
    Height = 52
    ExplicitWidth = 904
    ExplicitHeight = 52
    object lblname: TLabel
      Left = 389
      Top = 23
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object lblrole: TLabel
      Left = 211
      Top = 23
      Width = 28
      Height = 14
      Caption = #35282#33394
    end
    object Label3: TLabel
      Left = 14
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object nvedtname: TNovaEdit
      Left = 423
      Top = 19
      Width = 171
      Height = 22
      MaxLength = 50
      TabOrder = 0
      OnChange = nvedtnameChange
      OnKeyDown = nvedtnameKeyDown
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
    object btnlocate: TBitBtn
      Left = 605
      Top = 18
      Width = 75
      Height = 25
      Caption = #23450#20301
      TabOrder = 1
      OnClick = btnlocateClick
    end
    object nvhelpcbbrole: TNovaHComboBox
      Left = 246
      Top = 19
      Width = 134
      Height = 22
      ImeMode = imClose
      TabOrder = 2
      OnChange = nvhelpcbbroleChange
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
      HelpOptions.AutoSelectFirst = True
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
          Value = 'RoleHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object NovaCbbOrg: TNovaHComboBox
      Left = 76
      Top = 18
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 3
      OnChange = NovaCbbOrgChange
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
        end
        item
          DataType = ftString
          Name = 'filter_EQB_t!isactive'
          ParamType = ptInput
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 904
    ExplicitWidth = 904
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
    end
    inherited tbtnEdit: TToolButton
      Visible = False
    end
    inherited tbtnDelete: TToolButton
      Visible = False
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
      OnClick = tbtnSaveClick
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
    inherited tbtn4: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 97
    Width = 904
    Height = 371
    ExplicitTop = 97
    ExplicitWidth = 904
    ExplicitHeight = 371
    inherited GroupBox1: TGroupBox
      Left = 423
      Width = 481
      Height = 371
      Align = alRight
      ExplicitLeft = 423
      ExplicitWidth = 481
      ExplicitHeight = 371
      inherited dbgrdhResult: TNvDbgridEh
        Top = 45
        Width = 477
        Height = 324
        ReadOnly = False
        Columns = <
          item
            EditButtons = <>
            FieldName = 'haspermission'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #26426#26500
            Width = 142
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25480#26435#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'createbyname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #25480#26435#20154
            Width = 70
          end
          item
            EditButtons = <>
            Footers = <>
            ReadOnly = True
            Visible = False
            Width = 70
          end>
      end
      object tlbstop: TToolBar
        Left = 2
        Top = 16
        Width = 477
        Height = 29
        Images = ilsmalltools
        TabOrder = 1
        Visible = False
        object btnSaveOrgpermission: TToolButton
          Left = 0
          Top = 0
          Hint = #20445#23384
          Caption = 'ToolButton2'
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          OnClick = btnSaveOrgpermissionClick
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 423
      Height = 371
      Align = alClient
      Caption = #33756#21333#26435#38480
      TabOrder = 1
      object vstreePermission: TVirtualStringTree
        Left = 2
        Top = 16
        Width = 419
        Height = 353
        Align = alClient
        DragOperations = []
        DragType = dtVCL
        Header.AutoSizeIndex = 2
        Header.DefaultHeight = 17
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -15
        Header.Font.Name = #23435#20307
        Header.Font.Style = []
        Header.Height = 21
        Header.Options = [hoColumnResize, hoDblClickResize, hoDrag, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        RootNodeCount = 1
        TabOrder = 0
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSort, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
        OnChecked = vstreePermissionChecked
        OnFreeNode = vstreePermissionFreeNode
        OnGetText = vstreePermissionGetText
        OnGetNodeDataSize = vstreePermissionGetNodeDataSize
        Columns = <
          item
            Position = 0
            Width = 200
            WideText = #21517#31216
          end
          item
            Position = 1
            Width = 80
            WideText = #31867#22411
          end
          item
            Position = 2
            Width = 100
            WideText = #21442#25968
          end
          item
            Position = 3
            Width = 150
            WideText = #25480#26435#26102#38388
          end
          item
            Position = 4
            Width = 65
            WideText = #25480#26435#20154
          end>
      end
    end
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'orgpermissionMap'
    QueryAddress = 'system/queryOrgpermission'
    Params = <
      item
        DataType = ftString
        Name = 'roleid'
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
  end
  object jcdsMenuPermissionQry: TjsonClientDataSet
    DataSourceName = 'menupermissionMap'
    QueryAddress = 'system/queryMenupermission'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'roleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 232
    Top = 232
  end
  object jcdsMenuPermissionSave: TjsonClientDataSet
    DataSourceName = 'menupermissionMap'
    UpdateDataSet = 'menupermissions'
    QueryAddress = 'system/queryEmptyMenupermission'
    SaveAddress = 'system/saveMenupermission'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 384
    Top = 216
  end
  object jcdsOrgpermissionSave: TjsonClientDataSet
    DataSourceName = 'orgpermissionMap'
    UpdateDataSet = 'orgpermissions'
    QueryAddress = 'system/queryEmptyOrgpermission'
    SaveAddress = 'system/saveOrgpermission'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 560
    Top = 224
  end
  object ilsmalltools: TImageList
    DrawingStyle = dsSelected
    Left = 560
    Top = 328
    Bitmap = {
      494C010102000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B007B7B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F0000000000000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00007F7F7F007F7F7F0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      00007F7F7F0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000BDBDBD0000000000FF000000FF000000FF00
      00000000FF00FF000000FF0000000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000000000000000FFFFFF0000000000000000000000
      00000000FF0000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00000000000000
      00000000000000000000FFFFFF0000000000FFFFFF00000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BDBD
      BD00FFFFFF0000000000FFFFFF000000000000000000000000007B7B7B000000
      FF000000FF000000FF00000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF000000000000000000000000007F7F7F000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF00FC0000000000FF00FC0000000000
      FF00FC0000000000FF00FC000000000000000000000000000000000000000000
      0000000000000000000000000000000000230023000000000001000100000000
      00000000000000000023002300000000006300630000000000C300C300000000
      010701070000000003FF03FF0000000000000000000000000000000000000000
      000000000000}
  end
end
