inherited FrmScheduleBatchEdt: TFrmScheduleBatchEdt
  Caption = #25209#37327#20462#25913
  ClientHeight = 568
  ClientWidth = 716
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 722
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 716
    Height = 523
    ExplicitWidth = 716
    ExplicitHeight = 523
    inherited Bevel1: TBevel
      Top = 515
      Width = 682
      ExplicitTop = 515
      ExplicitWidth = 746
    end
    object Label2: TLabel
      Left = 53
      Top = 22
      Width = 56
      Height = 14
      Caption = #36816#33829#32447#36335
    end
    object Label4: TLabel
      Left = 53
      Top = 57
      Width = 56
      Height = 14
      Caption = #36816#33829#31867#21035
    end
    object Label6: TLabel
      Left = 53
      Top = 91
      Width = 56
      Height = 14
      Caption = #36816#34892#21306#22495
    end
    object Label7: TLabel
      Left = 227
      Top = 58
      Width = 56
      Height = 14
      Caption = #33829#36816#26041#24335
    end
    object Label13: TLabel
      Left = 227
      Top = 91
      Width = 56
      Height = 14
      Caption = #29677#27425#31867#22411
    end
    object Label11: TLabel
      Left = 24
      Top = 196
      Width = 84
      Height = 14
      Caption = #31080#38754#25171#21360#20449#24687
    end
    object Label14: TLabel
      Left = 186
      Top = 126
      Width = 28
      Height = 14
      Caption = #23567#26102
    end
    object Label9: TLabel
      Left = 53
      Top = 126
      Width = 56
      Height = 14
      Caption = #36816#34892#26102#38388
    end
    object Label24: TLabel
      Left = 237
      Top = 126
      Width = 42
      Height = 14
      Caption = #26816#31080#21475
    end
    object Label25: TLabel
      Left = 65
      Top = 161
      Width = 42
      Height = 14
      Caption = #20056#36710#24211
    end
    object Label8: TLabel
      Left = 255
      Top = 162
      Width = 28
      Height = 14
      Caption = #23450#21592
    end
    object lblendstation: TLabel
      Left = 45
      Top = 228
      Width = 56
      Height = 14
      Caption = #32456#21040#36710#31449
    end
    object lblstartstationprice: TLabel
      Left = 327
      Top = 232
      Width = 70
      Height = 14
      Caption = #22987#21457#31449#31080#20215
    end
    object NHelpRoute: TNovaHelp
      Left = 116
      Top = 19
      Width = 255
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 0
      OnIdChange = NHelpRouteIdChange
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
          FieldName = 'NAME'
          Title.Caption = #32447#36335#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'RouteHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object CobWORKTYPE: TNovaComboBox
      Left = 116
      Top = 54
      Width = 90
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'worktype'
    end
    object CobWORKWAYS: TNovaComboBox
      Left = 289
      Top = 55
      Width = 85
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'workways'
    end
    object CobDISTRICTTYPE: TNovaComboBox
      Left = 116
      Top = 87
      Width = 90
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.TableName = 'route'
      HelpOptions.Columnname = 'districttype'
    end
    object CobTYPE: TNovaComboBox
      Left = 289
      Top = 87
      Width = 82
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 4
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
      HelpOptions.TableName = 'schedule'
      HelpOptions.Columnname = 'scheduletype'
    end
    object NEdtPRINTINFO: TNovaEdit
      Left = 115
      Top = 192
      Width = 208
      Height = 22
      MaxLength = 25
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
    object NEdtRuntime: TNovaEdit
      Left = 116
      Top = 122
      Width = 64
      Height = 22
      MaxLength = 3
      TabOrder = 6
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
    object NHccbTicketEntrance: TNovaHComboBox
      Left = 289
      Top = 122
      Width = 82
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'TicketEntranceHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object NHccbVehiclepark: TNovaHComboBox
      Left = 116
      Top = 157
      Width = 90
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
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
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'VehicleparkHelp'
        end
        item
          DataType = ftString
          Name = 'filter_EQL_t!orgid'
          ParamType = ptInput
        end>
    end
    object ChkISPROPRIETARY: TCheckBox
      Left = 114
      Top = 296
      Width = 100
      Height = 17
      Caption = #26412#31449#19987#33829
      TabOrder = 9
    end
    object ChkISSELLRETURNTICKET: TCheckBox
      Left = 305
      Top = 269
      Width = 79
      Height = 17
      Caption = #21452#31243#29677#27425
      TabOrder = 10
    end
    object ChkISORIGINATOR: TCheckBox
      Left = 114
      Top = 269
      Width = 83
      Height = 17
      Caption = #36807#36335#29677#27425
      TabOrder = 11
    end
    object ChkISSALEAFTERREPORT: TCheckBox
      Left = 208
      Top = 270
      Width = 91
      Height = 17
      Caption = #25253#21040#21806#31080
      TabOrder = 12
    end
    object ChkISCANMIXCHECK: TCheckBox
      Left = 209
      Top = 297
      Width = 81
      Height = 17
      Caption = #20801#35768#28151#26816
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
    object ChkPrintSeatno: TCheckBox
      Left = 304
      Top = 297
      Width = 100
      Height = 17
      Caption = #25171#21360#24231#20301#21495
      Checked = True
      State = cbChecked
      TabOrder = 14
    end
    object GroupBox1: TGroupBox
      Left = 24
      Top = 320
      Width = 416
      Height = 172
      Caption = #29677#27425#20572#38752#28857
      TabOrder = 15
      object nvdbgrdh1: TNvDbgridEh
        Left = 2
        Top = 16
        Width = 412
        Height = 154
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DsTicketprices
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        PopupMenu = pmMenu
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 0
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
        PrintOptions = [pghOptimalColWidths]
        PrintAutoNewLine = False
        ParentName = 'FrmTicketpriceEdit'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'stationname'
            Footer.ValueType = fvtCount
            Footers = <>
            ReadOnly = True
            Title.Caption = #31449#28857
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'issellable'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = #23435#20307
            Font.Style = []
            Footer.DisplayFormat = #21512#35745
            Footers = <>
            Title.Caption = #26159#21542#21806#31080
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'remark1'
            Footers = <>
            Title.Caption = #22791#27880'1'
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'remark2'
            Footers = <>
            Title.Caption = #22791#27880'2'
            Width = 183
          end
          item
            EditButtons = <>
            FieldName = 'stationid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'routeid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 464
      Top = 19
      Width = 234
      Height = 481
      Caption = #21516#32447#36335#20854#20182#29677#27425
      TabOrder = 16
      object NovaListSchedule: TNovaListView
        Left = 2
        Top = 16
        Width = 230
        Height = 463
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            MaxWidth = 20
            MinWidth = 20
            Width = 20
          end
          item
            Caption = #29677#27425#21495
            Width = 100
          end
          item
            Caption = #21457#36710#26102#38388
            Width = 100
          end>
        TabOrder = 0
        ViewStyle = vsReport
        HelpOptions.HJSONConnection = DMPublic.jcon
        HelpOptions.HDataSourceName = 'helpmap'
        HelpOptions.HQueryAddress = 'ticketprice/qrySameRouteSchedules'
        HelpOptions.FieldNames.Strings = (
          'id'
          'name'
          'starttime'
          'code')
        HelpOptions.HSkinData = DMPublic.SkinData1
        Params = <
          item
            DataType = ftString
            Name = 'routeid'
            ParamType = ptInput
          end>
      end
    end
    object NEdtPLANSEATNUM: TNovaEdit
      Left = 289
      Top = 157
      Width = 65
      Height = 22
      MaxLength = 4
      TabOrder = 17
      Text = '0'
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
    object NEdtEndStation: TNovaEdit
      Left = 116
      Top = 227
      Width = 207
      Height = 22
      MaxLength = 50
      TabOrder = 18
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
    object NEdtStartstationprice: TNovaEdit
      Left = 399
      Top = 228
      Width = 52
      Height = 22
      MaxLength = 50
      TabOrder = 19
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
    Top = 523
    Width = 716
    ExplicitTop = 523
    ExplicitWidth = 716
    inherited bbtnSave: TBitBtn
      Left = 186
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 186
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 416
      Top = 6
      ExplicitLeft = 416
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 432
    Top = 384
  end
  object jsonSchedulestation: TjsonClientDataSet
    DataSourceName = 'etallschedulestoplist'
    UpdateDataSet = 'stationlist'
    QueryAddress = 'base/qryschedulestopTwo'
    SaveAddress = 'base/updateScheduleAll'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'schedule.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.code'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.starttime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.runtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.planseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.islinework'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isproprietary'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.issellreturnticket'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.iscanmixcheck'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.issaleafterreport'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isoriginator'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.printinfo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.viastation'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.ticketentranceid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.vehcileparkid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.spacinginterval'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.endtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'schedule.isfixseat'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.isEditOtherSchedule'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.endstation'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.startstationprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'stationids'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 1000
        Value = '0'
      end>
    RemoteServer = DMPublic.jcon
    Left = 144
    Top = 328
  end
  object jcdsGenScheduleplan: TjsonClientDataSet
    DataSourceName = 'scheduleplanloglist'
    QueryAddress = 'ticketprice/genScheduleplan'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplanlog.typeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.scheduleids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.operationtype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.ip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleplanlog.userid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 576
    Top = 216
  end
  object DsTicketprices: TDataSource
    DataSet = jsonSchedulestation
    Left = 192
    Top = 392
  end
  object pmMenu: TPopupMenu
    Left = 256
    Top = 392
    object N1: TMenuItem
      Caption = #20840#36873
    end
    object N2: TMenuItem
      Caption = #21453#36873
    end
    object N3: TMenuItem
      Caption = #21462#28040
    end
  end
  object jsonSaveSchedule: TjsonClientDataSet
    DataSourceName = 'dataSet'
    UpdateDataSet = 'stationlist'
    QueryAddress = 'base/query'
    SaveAddress = 'base/updateScheduleAll'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'schedule.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.code'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.worktype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.workways'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.districttype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.starttime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.runtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.planseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.islinework'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isproprietary'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.issellreturnticket'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.iscanmixcheck'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isovertime'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.issaleafterreport'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isoriginator'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'schedule.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.printinfo'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.viastation'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.ticketentranceid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'schedule.vehcileparkid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.spacinginterval'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.endtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.isfixseat'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.isEditOtherSchedule'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.endstation'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'schedule.startstationprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleids'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'scheduleid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'sellstationids'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 1000
        Value = '0'
      end>
    RemoteServer = DMPublic.jcon
    Left = 504
    Top = 96
  end
end
