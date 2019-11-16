inherited FrmChangeTicket: TFrmChangeTicket
  Caption = 'FrmChangeTicket'
  OnCreate = FormCreate
  ExplicitWidth = 1294
  ExplicitHeight = 586
  PixelsPerInch = 96
  TextHeight = 16
  inherited pnlmain: TPanel
    inherited gbContextHit: TGroupBox
      inherited lblContextHint: TLabel
        Width = 1274
        Caption = 'F10'#20445#23384#21040#36141#29289#36710#65292#22238#36710#25171#21360
        ExplicitWidth = 166
      end
    end
    inherited pnlhint: TPanel
      inherited gbTicketnos: TGroupBox
        inherited lbl2: TLabel
          Height = 21
        end
        inherited lblleaveticketnum: TLabel
          Height = 21
        end
      end
      inherited gbinsureno: TGroupBox
        inherited lblinsureno: TLabel
          Height = 21
        end
        inherited lbl7: TLabel
          Height = 21
        end
        inherited lblleaveinsurenum: TLabel
          Height = 21
        end
        inherited lbl12: TLabel
          Height = 21
        end
      end
      inherited pnllastmoney: TPanel
        inherited lbl1: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
          ExplicitTop = 10
        end
        inherited lbllastmoney: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
          ExplicitTop = 10
        end
        inherited lbl4: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
          ExplicitTop = 10
        end
        inherited lblreceipt: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
          ExplicitTop = 10
        end
        inherited lbl5: TLabel
          Top = 10
          Height = 33
          Margins.Top = 10
          ExplicitTop = 10
        end
        inherited lblchange: TLabel
          Height = 43
        end
      end
    end
    inherited pnlinput: TPanel
      inherited gbamount: TGroupBox
        Left = 523
        ExplicitLeft = 523
      end
      inherited gbschedulecondition: TGroupBox
        Left = 393
        ExplicitLeft = 393
      end
      inherited gbTakeKid: TGroupBox
        Left = 721
        ExplicitLeft = 721
      end
      inherited gb3: TGroupBox
        Left = 103
        ExplicitLeft = 103
      end
      inherited gb7: TGroupBox
        Left = 253
        ExplicitLeft = 253
        inherited nvhlpdepartdistrict: TNovaHelp
          Width = 133
          ExplicitWidth = 133
        end
      end
      object gbTicketToBeChange: TGroupBox
        Left = 0
        Top = 0
        Width = 103
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #25913#31614#31080#21495
        TabOrder = 5
        object nvedtTicketToBeChange: TNovaEdit
          Left = 1
          Top = 21
          Width = 97
          Height = 28
          Hint = #36755#20837#22810#24352#31080#21495#35831#29992','#25110'-'#20998#38548#31526
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          MaxLength = 50
          TabOrder = 0
          OnChange = nvedtTicketToBeChangeChange
          OnExit = nvedtTicketToBeChangeExit
          OnKeyPress = nvedtTicketToBeChangeKeyPress
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
    end
    inherited pnlschedule: TPanel
      inherited nvdbgrdhschedule: TNvDbgridEh
        Height = 75
      end
      object nvdbgrdhTicketSelect: TNvDbgridEh
        Left = -2
        Top = 81
        Width = 620
        Height = 81
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsticketselect
        Flat = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imClose
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        RowDetailPanel.Color = clBtnFace
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = [fsBold]
        Visible = False
        OnExit = nvdbgrdhTicketSelectExit
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
        PrintInfo.TitleFont.Color = clWindowText
        PrintInfo.TitleFont.Height = -21
        PrintInfo.TitleFont.Name = #23435#20307
        PrintInfo.TitleFont.Style = [fsBold]
        PrintInfo.GridHeadFont.Charset = DEFAULT_CHARSET
        PrintInfo.GridHeadFont.Color = clWindowText
        PrintInfo.GridHeadFont.Height = -32
        PrintInfo.GridHeadFont.Name = #23435#20307
        PrintInfo.GridHeadFont.Style = [fsBold]
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
        jsonConnection = DMPublic.jcon
        ParentName = 'SimpleCRUDForm'
        TitleAlign = taLeftJustify
        Columns = <
          item
            AlwaysShowEditButton = True
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isselected'
            Footers = <>
            Title.Caption = #36873#25321
            Width = 30
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ischecked'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24050#26816
            Width = 28
          end
          item
            EditButtons = <>
            FieldName = 'ischanged'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24050#25913#31614
            Width = 38
          end
          item
            EditButtons = <>
            FieldName = 'ticketstatusname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#31080#29366#24577
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26085#26399
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#26102#38388
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21040#36798#31449
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#20215
            Width = 41
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #24231#20301#21495
            Width = 39
          end
          item
            EditButtons = <>
            FieldName = 'insuranceno'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#21333#21495
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            ReadOnly = True
            Title.Caption = #27969#27700#29677
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21457#36710#31449
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'premium'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#36153
            Width = 28
          end
          item
            EditButtons = <>
            FieldName = 'customername'
            Footers = <>
            ReadOnly = True
            Title.Caption = #23458#25143#22995#21517
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'tickettypeprintname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #36710#31080#31867#22411
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'paymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #31080#27454#25903#20184#26041#24335
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'insurancepaymethodname'
            Footers = <>
            ReadOnly = True
            Title.Caption = #20445#36153#25903#20184#26041#24335
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            ReadOnly = True
            Title.Caption = #21806#31080#26102#38388
            Width = 102
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  inherited pnlreceipt: TPanel
    Left = 597
    Top = 235
    ExplicitLeft = 597
    ExplicitTop = 235
    inherited pnlJJInsureHint: TPanel
      inherited lblJJInsureMoney: TLabel
        Height = 18
      end
    end
  end
  inherited tmrRefreshBill: TTimer
    Top = 144
  end
  object jcdsfindTicket: TjsonClientDataSet
    DataSourceName = 'ticketsellmap'
    QueryAddress = 'sell/findTicketChange'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQS_t!ticketno'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    AfterOpen = jcdsfindTicketAfterOpen
    Left = 168
    Top = 240
  end
  object dsticketselect: TDataSource
    DataSet = jcdsfindTicket
    OnDataChange = dsticketselectDataChange
    Left = 200
    Top = 192
  end
  object jcdslineworkIsdepart: TjsonClientDataSet
    DataSourceName = 'ticketsellmap'
    QueryAddress = 'sell/findlineworkIsdepart'
    SaveAddress = 'sell/findlineworkIsdepart'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'isexitlinework'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    AfterOpen = jcdsfindTicketAfterOpen
    Left = 512
    Top = 304
  end
end
