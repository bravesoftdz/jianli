inherited FrmDeductitemApplyEdt: TFrmDeductitemApplyEdt
  Caption = 'FrmDeductitemApplyEdt'
  ClientHeight = 394
  ClientWidth = 692
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 698
  ExplicitHeight = 422
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 692
    Height = 349
    ExplicitWidth = 692
    ExplicitHeight = 349
    inherited Bevel1: TBevel
      Top = 341
      Width = 658
      ExplicitTop = 384
      ExplicitWidth = 626
    end
    object Label1: TLabel
      Left = 52
      Top = 43
      Width = 56
      Height = 14
      Caption = #25187#36153#23545#35937
    end
    object Label2: TLabel
      Left = 334
      Top = 45
      Width = 56
      Height = 14
      Caption = #25187#36153#39033#30446
    end
    object Label3: TLabel
      Left = 52
      Top = 90
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object Label4: TLabel
      Left = 330
      Top = 86
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object Label9: TLabel
      Left = 569
      Top = 41
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 299
      Top = 41
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 244
      Top = 88
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 522
      Top = 84
      Width = 8
      Height = 16
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object DTPBuildStartDay: TDateTimePicker
      Left = 118
      Top = 86
      Width = 120
      Height = 22
      Date = 40645.466286168980000000
      Time = 40645.466286168980000000
      TabOrder = 2
    end
    object DTPBuildEndDay: TDateTimePicker
      Left = 396
      Top = 82
      Width = 120
      Height = 22
      Date = 55123.466286168980000000
      Time = 55123.466286168980000000
      TabOrder = 3
    end
    object GroupBox1: TGroupBox
      Left = 36
      Top = 114
      Width = 610
      Height = 207
      Caption = #24212#29992#23545#35937
      TabOrder = 4
      object Label5: TLabel
        Left = 33
        Top = 66
        Width = 56
        Height = 14
        Caption = #33829#36816#32447#36335
      end
      object Label6: TLabel
        Left = 33
        Top = 140
        Width = 56
        Height = 14
        Caption = #33829#36816#29677#27425
      end
      object Label7: TLabel
        Left = 33
        Top = 103
        Width = 56
        Height = 14
        Caption = #33829#36816#21333#20301
      end
      object Label8: TLabel
        Left = 33
        Top = 177
        Width = 56
        Height = 14
        Caption = #33829#36816#36710#36742
      end
      object Label11: TLabel
        Left = 33
        Top = 30
        Width = 56
        Height = 14
        Caption = #29677#27425#26426#26500
      end
      object lbl1: TLabel
        Left = 290
        Top = 28
        Width = 56
        Height = 14
        Caption = #21806#31080#26426#26500
      end
      object NovaHelpRoute: TNovaHelp
        Left = 95
        Top = 65
        Width = 160
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #32447#36335#21517#31216
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 70
            Visible = True
          end>
        HelpOptions.HelpHeight = 170
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'RouteHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHelpSchedule: TNovaHelp
        Left = 95
        Top = 137
        Width = 160
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
            FieldName = 'endstationname'
            Title.Caption = #32456#28857#31449
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #29677#27425#21495
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'starttime'
            Title.Caption = #21457#36710#26102#38388
            Width = 70
            Visible = True
          end>
        HelpOptions.HelpHeight = 100
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'ScheduleRHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHelpUnit: TNovaHelp
        Left = 95
        Top = 101
        Width = 160
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
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
            FieldName = 'name'
            Title.Caption = #21517#31216
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'jianpin'
            Title.Caption = #31616#25340
            Width = 80
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'UnitHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHelpVehicle: TNovaHelp
        Left = 95
        Top = 173
        Width = 160
        Height = 22
        CharCase = ecUpperCase
        MaxLength = 50
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
        HDBGColumns = <
          item
            Expanded = False
            FieldName = 'name'
            Title.Caption = #36710#29260#21495#30721
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'rationseatnum'
            Title.Caption = #24231#20301#25968
            Width = 70
            Visible = True
          end>
        HelpOptions.HelpHeight = 200
        HelpOptions.HelpWidth = 126
        HelpOptions.EdtField = 'name'
        HelpOptions.HSkinData = DMPublic.SkinData1
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HelpType = 'VehiclenoHelp'
        HelpOptions.HQueryAddress = 'system/help'
        Params = <>
        notFocusedShowHelp = False
      end
      object NovaHCobOrg: TNovaHComboBox
        Left = 95
        Top = 30
        Width = 160
        Height = 22
        Style = csDropDownList
        ImeMode = imClose
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
            Value = 'OrgHelpStation'
          end>
      end
      object NvDbgridEh1: TNvDbgridEh
        Left = 287
        Top = 48
        Width = 304
        Height = 145
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = ds1
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        RowDetailPanel.Color = clBtnFace
        TabOrder = 5
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = GB2312_CHARSET
        PrintInfo.TitleFont.Color = clWindowText
        PrintInfo.TitleFont.Height = -19
        PrintInfo.TitleFont.Name = #23435#20307
        PrintInfo.TitleFont.Style = []
        PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
        PrintInfo.GridHeadFont.Color = clWindowText
        PrintInfo.GridHeadFont.Height = -11
        PrintInfo.GridHeadFont.Name = 'Tahoma'
        PrintInfo.GridHeadFont.Style = []
        PrintInfo.TitleNullLine = 0
        PrintInfo.PrintPageFooter = True
        PrintInfo.PrintPrintFooterTime = True
        PrintInfo.PageFooterRight = #21335#20940#31185#25216
        PrintInfo.PageSize.BottomMargin = 1.000000000000000000
        PrintInfo.PageSize.LeftMargin = 1.000000000000000000
        PrintInfo.PageSize.RightMargin = 1.000000000000000000
        PrintInfo.PageSize.TopMargin = 1.000000000000000000
        PrintOptions = [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]
        PrintAutoNewLine = False
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'isselect'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 40
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21333#20301
            Width = 139
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #31867#22411
            Width = 60
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object NovaCobTarget: TNovaHComboBox
      Left = 118
      Top = 40
      Width = 173
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = NovaCobTargetChange
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
          Value = 'BalancedeductTargetHelp'
        end>
    end
    object NovaEdtName: TNovaHComboBox
      Left = 396
      Top = 40
      Width = 167
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'BalancedeductitemHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
  end
  inherited pnlOperation: TPanel
    Top = 349
    Width = 692
    ExplicitTop = 349
    ExplicitWidth = 692
    inherited bbtnSave: TBitBtn
      Left = 208
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 208
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 377
      Top = 6
      ExplicitLeft = 377
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 64
  end
  object jcdsSaveApply: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/saveBalancedeductapply'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'balancedeductapply.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.balancedeductitemid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.balancededucttargetid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.schedule.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.unit.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.org.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.orgids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balancedeductapply.types'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'curid'
        ParamType = ptOutput
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
    Left = 592
    Top = 33
  end
  object jscdQryCheckOrg: TjsonClientDataSet
    DataSourceName = 'datemap'
    QueryAddress = 'balance/qryBalancedeductapplysell'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'curid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 592
    Top = 89
  end
  object ds1: TDataSource
    DataSet = jscdQryCheckOrg
    Left = 416
    Top = 200
  end
end
