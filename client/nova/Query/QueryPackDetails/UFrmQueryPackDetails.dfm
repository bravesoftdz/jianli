inherited frmQueryPackDetails: TfrmQueryPackDetails
  Caption = #21069#21488#26126#32454#32479#35745
  ClientHeight = 507
  ClientWidth = 1093
  OnShow = FormShow
  ExplicitWidth = 1109
  ExplicitHeight = 545
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1093
    ExplicitWidth = 1093
    object lbl4: TLabel
      Left = 14
      Top = 21
      Width = 56
      Height = 14
      Caption = #21457#36135#26085#26399
    end
    object Label1: TLabel
      Left = 193
      Top = 21
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label2: TLabel
      Left = 700
      Top = 21
      Width = 42
      Height = 14
      Caption = #30446#30340#22320
    end
    object Label3: TLabel
      Left = 497
      Top = 21
      Width = 42
      Height = 14
      Caption = #21463#29702#21592
    end
    object sendstartdate: TDateTimePicker
      Left = 76
      Top = 17
      Width = 111
      Height = 22
      Date = 41502.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41502.639888414350000000
      TabOrder = 0
    end
    object sendenddate: TDateTimePicker
      Left = 213
      Top = 17
      Width = 111
      Height = 22
      Date = 41502.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41502.639888414350000000
      TabOrder = 1
    end
    object nvhelptostation: TNovaHelp
      Left = 748
      Top = 17
      Width = 117
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
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
      HelpOptions.HelpHeight = 300
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
    object nvhelpuser: TNovaHelp
      Left = 545
      Top = 17
      Width = 117
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 8
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
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'code'
          Title.Caption = #32534#30721
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UserHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1093
    ExplicitWidth = 1093
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
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
    Width = 1093
    Height = 404
    ExplicitWidth = 1093
    ExplicitHeight = 404
    inherited GroupBox1: TGroupBox
      Width = 1093
      Height = 404
      ExplicitWidth = 1093
      ExplicitHeight = 404
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1089
        Height = 386
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36135#26085#26399
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
            Title.Caption = #21463#29702#21333#21495
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'singbillno'
            Footers = <>
            Title.Caption = #32467#31639#21333#21495
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'name1'
            Footers = <>
            Title.Caption = #21463#29702#21592
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'pieces'
            Footers = <>
            Title.Caption = #20214#25968
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'shipprice'
            Footers = <>
            Title.Caption = #36816#36153
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'handfee'
            Footers = <>
            Title.Caption = #35013#21368#36153
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'transitfee'
            Footers = <>
            Title.Caption = #20013#36716#36153
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footers = <>
            Title.Caption = #20854#20182#36153
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'totalfee'
            Footers = <>
            Title.Caption = #21512#35745#36153#29992
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'name2'
            Footers = <>
            Title.Caption = #30446#30340#22320
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'chepaihao'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #34892#21253#29366#24577
            Width = 70
          end>
        inherited RowDetailData: TRowDetailPanelControlEh
          object NvDbgridEh1: TNvDbgridEh
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsResult
            Flat = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -15
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ParentFont = False
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 0
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = #23435#20307
            TitleFont.Style = [fsBold]
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
            ParentName = 'SimpleCRUDForm'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'id'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'orgname'
                Footers = <>
                Title.Caption = #26426#26500
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'sendstationname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21457#36135#31449
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'certificatetypevalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #35777#20214#31867#22411
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'tostationname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #30446#30340#22320
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'name'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36135#29289#21517#31216
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'goodtypevalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36135#29289#31867#21035
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'sender'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'schedulecode'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #29677#27425
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'vehiclecode'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36710#29260#21495
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'departdate'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21457#36135#26085#26399
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'statusvalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #29366#24577
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'packno'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #34892#21253#21333#21495
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'invoiceno'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21457#31080#21495
                Visible = False
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'sellbyname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21150#29702#21592
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'pieces'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20214#25968
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'weight'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #37325#37327'(kg)'
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'volume'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20307#31215
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'packedvalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21253#35013
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'shipprice'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'packfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21253#35013#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'handfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #35013#21368#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'custodial'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#31649#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'transitfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20013#36716#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'insuredamount'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#20215#37329#39069
                Width = 73
              end
              item
                EditButtons = <>
                FieldName = 'insurancefee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#20215#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'insurance'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#38505#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'deliveryfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36865#36135#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'otherfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20854#20182#36153#29992
                Width = 69
              end
              item
                EditButtons = <>
                FieldName = 'totalfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21512#35745#37329#39069
              end
              item
                EditButtons = <>
                FieldName = 'location'
                Footers = <>
                Title.Caption = #23384#25918#20301#32622
                Visible = False
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'packprice'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20195#25910#36135#27454
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'senderphone'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#20154#30005#35805
                Width = 90
              end
              item
                EditButtons = <>
                FieldName = 'senderaddress'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#20154#22320#22336
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'consignee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'consigneephone'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154#30005#35805
                Width = 90
              end
              item
                EditButtons = <>
                FieldName = 'consigneeaddress'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154#22320#22336
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'certificateno'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154#35777#20214#21495#30721
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'shiptypevalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25552#36135#26041#24335
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'paymethodvalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20184#27454#26041#24335
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'valuables'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #26159#21542#36149#37325#29289#21697
                Width = 101
              end
              item
                EditButtons = <>
                FieldName = 'remak'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36135#29289#25551#36848
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'createtime'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21019#24314#26102#38388
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'sellbyname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21019#24314#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'packtypevalue'
                Footers = <>
                Title.Caption = #25968#25454#31867#22411
                Visible = False
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'collectstatusname'
                Footers = <>
                Title.Caption = #20195#25910#29366#24577
              end
              item
                EditButtons = <>
                FieldName = 'recyclestatusname'
                Footers = <>
                Title.Caption = #22238#25910#29366#24577
              end>
            object RowDetailData: TRowDetailPanelControlEh
              object NvDbgridEh2: TNvDbgridEh
                Left = 0
                Top = 0
                Width = 0
                Height = 0
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsResult
                Flat = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = #23435#20307
                Font.Style = []
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -15
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ParentFont = False
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -15
                TitleFont.Name = #23435#20307
                TitleFont.Style = [fsBold]
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
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'id'
                    Footers = <>
                    Visible = False
                  end
                  item
                    EditButtons = <>
                    FieldName = 'orgname'
                    Footers = <>
                    Title.Caption = #26426#26500
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sendstationname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21457#36135#31449
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'certificatetypevalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #35777#20214#31867#22411
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'tostationname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #30446#30340#22320
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'name'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36135#29289#21517#31216
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'goodtypevalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36135#29289#31867#21035
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sender'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'schedulecode'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #29677#27425
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehiclecode'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36710#29260#21495
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departdate'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21457#36135#26085#26399
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'statusvalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #29366#24577
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packno'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #34892#21253#21333#21495
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'invoiceno'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21457#31080#21495
                    Visible = False
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sellbyname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21150#29702#21592
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'pieces'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20214#25968
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'weight'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #37325#37327'(kg)'
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'volume'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20307#31215
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packedvalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21253#35013
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'shipprice'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21253#35013#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'handfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #35013#21368#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'custodial'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#31649#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'transitfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20013#36716#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'insuredamount'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#20215#37329#39069
                    Width = 73
                  end
                  item
                    EditButtons = <>
                    FieldName = 'insurancefee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#20215#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'insurance'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#38505#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'deliveryfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36865#36135#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'otherfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20854#20182#36153#29992
                    Width = 69
                  end
                  item
                    EditButtons = <>
                    FieldName = 'totalfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21512#35745#37329#39069
                  end
                  item
                    EditButtons = <>
                    FieldName = 'location'
                    Footers = <>
                    Title.Caption = #23384#25918#20301#32622
                    Visible = False
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packprice'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20195#25910#36135#27454
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'senderphone'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#20154#30005#35805
                    Width = 90
                  end
                  item
                    EditButtons = <>
                    FieldName = 'senderaddress'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#20154#22320#22336
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'consignee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'consigneephone'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154#30005#35805
                    Width = 90
                  end
                  item
                    EditButtons = <>
                    FieldName = 'consigneeaddress'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154#22320#22336
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'certificateno'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154#35777#20214#21495#30721
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'shiptypevalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25552#36135#26041#24335
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'paymethodvalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20184#27454#26041#24335
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'valuables'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #26159#21542#36149#37325#29289#21697
                    Width = 101
                  end
                  item
                    EditButtons = <>
                    FieldName = 'remak'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36135#29289#25551#36848
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'createtime'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21019#24314#26102#38388
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sellbyname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21019#24314#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packtypevalue'
                    Footers = <>
                    Title.Caption = #25968#25454#31867#22411
                    Visible = False
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'collectstatusname'
                    Footers = <>
                    Title.Caption = #20195#25910#29366#24577
                  end
                  item
                    EditButtons = <>
                    FieldName = 'recyclestatusname'
                    Footers = <>
                    Title.Caption = #22238#25910#29366#24577
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                  object NvDbgridEh3: TNvDbgridEh
                    Left = 0
                    Top = 0
                    Width = 0
                    Height = 0
                    Align = alClient
                    ColumnDefValues.Title.TitleButton = True
                    DataGrouping.GroupLevels = <>
                    DataSource = dsResult
                    Flat = False
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -14
                    Font.Name = #23435#20307
                    Font.Style = []
                    FooterColor = clWindow
                    FooterFont.Charset = ANSI_CHARSET
                    FooterFont.Color = clWindowText
                    FooterFont.Height = -15
                    FooterFont.Name = #23435#20307
                    FooterFont.Style = []
                    FooterRowCount = 1
                    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                    ParentFont = False
                    ReadOnly = True
                    RowDetailPanel.Color = clBtnFace
                    SumList.Active = True
                    TabOrder = 0
                    TitleFont.Charset = ANSI_CHARSET
                    TitleFont.Color = clWindowText
                    TitleFont.Height = -15
                    TitleFont.Name = #23435#20307
                    TitleFont.Style = [fsBold]
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
                    ParentName = 'SimpleCRUDForm'
                    TitleAlign = taLeftJustify
                    Columns = <
                      item
                        EditButtons = <>
                        FieldName = 'id'
                        Footers = <>
                        Visible = False
                      end
                      item
                        EditButtons = <>
                        FieldName = 'orgname'
                        Footers = <>
                        Title.Caption = #26426#26500
                        Width = 100
                      end
                      item
                        EditButtons = <>
                        FieldName = 'sendstationname'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21457#36135#31449
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'certificatetypevalue'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #35777#20214#31867#22411
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'tostationname'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #30446#30340#22320
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'name'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #36135#29289#21517#31216
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'goodtypevalue'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #36135#29289#31867#21035
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'sender'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25176#36816#20154
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'schedulecode'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #29677#27425
                        Width = 80
                      end
                      item
                        EditButtons = <>
                        FieldName = 'vehiclecode'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #36710#29260#21495
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'departdate'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21457#36135#26085#26399
                        Width = 100
                      end
                      item
                        EditButtons = <>
                        FieldName = 'statusvalue'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #29366#24577
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'packno'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #34892#21253#21333#21495
                        Width = 120
                      end
                      item
                        EditButtons = <>
                        FieldName = 'invoiceno'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21457#31080#21495
                        Visible = False
                        Width = 120
                      end
                      item
                        EditButtons = <>
                        FieldName = 'sellbyname'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21150#29702#21592
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'pieces'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20214#25968
                        Width = 40
                      end
                      item
                        EditButtons = <>
                        FieldName = 'weight'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #37325#37327'(kg)'
                        Width = 80
                      end
                      item
                        EditButtons = <>
                        FieldName = 'volume'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20307#31215
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'packedvalue'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21253#35013
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'shipprice'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25176#36816#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'packfee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21253#35013#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'handfee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #35013#21368#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'custodial'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20445#31649#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'transitfee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20013#36716#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'insuredamount'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20445#20215#37329#39069
                        Width = 73
                      end
                      item
                        EditButtons = <>
                        FieldName = 'insurancefee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20445#20215#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'insurance'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20445#38505#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'deliveryfee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #36865#36135#36153
                        Width = 60
                      end
                      item
                        EditButtons = <>
                        FieldName = 'otherfee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20854#20182#36153#29992
                        Width = 69
                      end
                      item
                        EditButtons = <>
                        FieldName = 'totalfee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21512#35745#37329#39069
                      end
                      item
                        EditButtons = <>
                        FieldName = 'location'
                        Footers = <>
                        Title.Caption = #23384#25918#20301#32622
                        Visible = False
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'packprice'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20195#25910#36135#27454
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'senderphone'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25176#36816#20154#30005#35805
                        Width = 90
                      end
                      item
                        EditButtons = <>
                        FieldName = 'senderaddress'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25176#36816#20154#22320#22336
                        Width = 150
                      end
                      item
                        EditButtons = <>
                        FieldName = 'consignee'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25910#36135#20154
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'consigneephone'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25910#36135#20154#30005#35805
                        Width = 90
                      end
                      item
                        EditButtons = <>
                        FieldName = 'consigneeaddress'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25910#36135#20154#22320#22336
                        Width = 150
                      end
                      item
                        EditButtons = <>
                        FieldName = 'certificateno'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25910#36135#20154#35777#20214#21495#30721
                        Width = 100
                      end
                      item
                        EditButtons = <>
                        FieldName = 'shiptypevalue'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #25552#36135#26041#24335
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'paymethodvalue'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #20184#27454#26041#24335
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'valuables'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #26159#21542#36149#37325#29289#21697
                        Width = 101
                      end
                      item
                        EditButtons = <>
                        FieldName = 'remak'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #36135#29289#25551#36848
                        Width = 120
                      end
                      item
                        EditButtons = <>
                        FieldName = 'createtime'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21019#24314#26102#38388
                        Width = 120
                      end
                      item
                        EditButtons = <>
                        FieldName = 'sellbyname'
                        Footers = <>
                        ImeMode = imClose
                        Title.Caption = #21019#24314#20154
                        Width = 70
                      end
                      item
                        EditButtons = <>
                        FieldName = 'packtypevalue'
                        Footers = <>
                        Title.Caption = #25968#25454#31867#22411
                        Visible = False
                        Width = 80
                      end
                      item
                        EditButtons = <>
                        FieldName = 'collectstatusname'
                        Footers = <>
                        Title.Caption = #20195#25910#29366#24577
                      end
                      item
                        EditButtons = <>
                        FieldName = 'recyclestatusname'
                        Footers = <>
                        Title.Caption = #22238#25910#29366#24577
                      end>
                    object RowDetailData: TRowDetailPanelControlEh
                      object NvDbgridEh4: TNvDbgridEh
                        Left = 0
                        Top = 0
                        Width = 0
                        Height = 0
                        Align = alClient
                        ColumnDefValues.Title.TitleButton = True
                        DataGrouping.GroupLevels = <>
                        DataSource = dsResult
                        Flat = False
                        Font.Charset = ANSI_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -14
                        Font.Name = #23435#20307
                        Font.Style = []
                        FooterColor = clWindow
                        FooterFont.Charset = ANSI_CHARSET
                        FooterFont.Color = clWindowText
                        FooterFont.Height = -15
                        FooterFont.Name = #23435#20307
                        FooterFont.Style = []
                        FooterRowCount = 1
                        ImeMode = imDisable
                        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                        ParentFont = False
                        ReadOnly = True
                        RowDetailPanel.Color = clBtnFace
                        SumList.Active = True
                        TabOrder = 0
                        TitleFont.Charset = ANSI_CHARSET
                        TitleFont.Color = clWindowText
                        TitleFont.Height = -15
                        TitleFont.Name = #23435#20307
                        TitleFont.Style = [fsBold]
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
                        ParentName = 'SimpleCRUDForm'
                        TitleAlign = taLeftJustify
                        Columns = <
                          item
                            EditButtons = <>
                            FieldName = 'id'
                            Footers = <>
                            Visible = False
                          end
                          item
                            EditButtons = <>
                            FieldName = 'orgname'
                            Footers = <>
                            Title.Caption = #26426#26500
                            Width = 100
                          end
                          item
                            EditButtons = <>
                            FieldName = 'sendstationname'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21457#36135#31449
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'certificatetypevalue'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #35777#20214#31867#22411
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'tostationname'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #30446#30340#22320
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'name'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #36135#29289#21517#31216
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'goodtypevalue'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #36135#29289#31867#21035
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'sender'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25176#36816#20154
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'schedulecode'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #29677#27425
                            Width = 80
                          end
                          item
                            EditButtons = <>
                            FieldName = 'vehiclecode'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #36710#29260#21495
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'departdate'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21457#36135#26085#26399
                            Width = 100
                          end
                          item
                            EditButtons = <>
                            FieldName = 'statusvalue'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #29366#24577
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'packno'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #34892#21253#21333#21495
                            Width = 120
                          end
                          item
                            EditButtons = <>
                            FieldName = 'invoiceno'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21457#31080#21495
                            Visible = False
                            Width = 120
                          end
                          item
                            EditButtons = <>
                            FieldName = 'sellbyname'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21150#29702#21592
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'pieces'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20214#25968
                            Width = 40
                          end
                          item
                            EditButtons = <>
                            FieldName = 'weight'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #37325#37327'(kg)'
                            Width = 80
                          end
                          item
                            EditButtons = <>
                            FieldName = 'volume'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20307#31215
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'packedvalue'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21253#35013
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'shipprice'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25176#36816#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'packfee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21253#35013#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'handfee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #35013#21368#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'custodial'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20445#31649#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'transitfee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20013#36716#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'insuredamount'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20445#20215#37329#39069
                            Width = 73
                          end
                          item
                            EditButtons = <>
                            FieldName = 'insurancefee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20445#20215#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'insurance'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20445#38505#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'deliveryfee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #36865#36135#36153
                            Width = 60
                          end
                          item
                            EditButtons = <>
                            FieldName = 'otherfee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20854#20182#36153#29992
                            Width = 69
                          end
                          item
                            EditButtons = <>
                            FieldName = 'totalfee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21512#35745#37329#39069
                          end
                          item
                            EditButtons = <>
                            FieldName = 'location'
                            Footers = <>
                            Title.Caption = #23384#25918#20301#32622
                            Visible = False
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'packprice'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20195#25910#36135#27454
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'senderphone'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25176#36816#20154#30005#35805
                            Width = 90
                          end
                          item
                            EditButtons = <>
                            FieldName = 'senderaddress'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25176#36816#20154#22320#22336
                            Width = 150
                          end
                          item
                            EditButtons = <>
                            FieldName = 'consignee'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25910#36135#20154
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'consigneephone'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25910#36135#20154#30005#35805
                            Width = 90
                          end
                          item
                            EditButtons = <>
                            FieldName = 'consigneeaddress'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25910#36135#20154#22320#22336
                            Width = 150
                          end
                          item
                            EditButtons = <>
                            FieldName = 'certificateno'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25910#36135#20154#35777#20214#21495#30721
                            Width = 100
                          end
                          item
                            EditButtons = <>
                            FieldName = 'shiptypevalue'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #25552#36135#26041#24335
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'paymethodvalue'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #20184#27454#26041#24335
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'valuables'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #26159#21542#36149#37325#29289#21697
                            Width = 101
                          end
                          item
                            EditButtons = <>
                            FieldName = 'remak'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #36135#29289#25551#36848
                            Width = 120
                          end
                          item
                            EditButtons = <>
                            FieldName = 'createtime'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21019#24314#26102#38388
                            Width = 120
                          end
                          item
                            EditButtons = <>
                            FieldName = 'sellbyname'
                            Footers = <>
                            ImeMode = imClose
                            Title.Caption = #21019#24314#20154
                            Width = 70
                          end
                          item
                            EditButtons = <>
                            FieldName = 'packtypevalue'
                            Footers = <>
                            Title.Caption = #25968#25454#31867#22411
                            Visible = False
                            Width = 80
                          end
                          item
                            EditButtons = <>
                            FieldName = 'collectstatusname'
                            Footers = <>
                            Title.Caption = #20195#25910#29366#24577
                          end
                          item
                            EditButtons = <>
                            FieldName = 'recyclestatusname'
                            Footers = <>
                            Title.Caption = #22238#25910#29366#24577
                          end>
                        object RowDetailData: TRowDetailPanelControlEh
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          object NvDbgridEh5: TNvDbgridEh
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            Align = alClient
            ColumnDefValues.Title.TitleButton = True
            DataGrouping.GroupLevels = <>
            DataSource = dsResult
            Flat = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -15
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
            ParentFont = False
            ReadOnly = True
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = #23435#20307
            TitleFont.Style = [fsBold]
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
            ParentName = 'SimpleCRUDForm'
            TitleAlign = taLeftJustify
            Columns = <
              item
                EditButtons = <>
                FieldName = 'id'
                Footers = <>
                Visible = False
              end
              item
                EditButtons = <>
                FieldName = 'orgname'
                Footers = <>
                Title.Caption = #26426#26500
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'sendstationname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21457#36135#31449
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'certificatetypevalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #35777#20214#31867#22411
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'tostationname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #30446#30340#22320
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'name'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36135#29289#21517#31216
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'goodtypevalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36135#29289#31867#21035
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'sender'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'schedulecode'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #29677#27425
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'vehiclecode'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36710#29260#21495
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'departdate'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21457#36135#26085#26399
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'statusvalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #29366#24577
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'packno'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #34892#21253#21333#21495
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'invoiceno'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21457#31080#21495
                Visible = False
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'sellbyname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21150#29702#21592
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'pieces'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20214#25968
                Width = 40
              end
              item
                EditButtons = <>
                FieldName = 'weight'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #37325#37327'(kg)'
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'volume'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20307#31215
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'packedvalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21253#35013
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'shipprice'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'packfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21253#35013#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'handfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #35013#21368#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'custodial'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#31649#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'transitfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20013#36716#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'insuredamount'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#20215#37329#39069
                Width = 73
              end
              item
                EditButtons = <>
                FieldName = 'insurancefee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#20215#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'insurance'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20445#38505#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'deliveryfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36865#36135#36153
                Width = 60
              end
              item
                EditButtons = <>
                FieldName = 'otherfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20854#20182#36153#29992
                Width = 69
              end
              item
                EditButtons = <>
                FieldName = 'totalfee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21512#35745#37329#39069
              end
              item
                EditButtons = <>
                FieldName = 'location'
                Footers = <>
                Title.Caption = #23384#25918#20301#32622
                Visible = False
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'packprice'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20195#25910#36135#27454
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'senderphone'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#20154#30005#35805
                Width = 90
              end
              item
                EditButtons = <>
                FieldName = 'senderaddress'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25176#36816#20154#22320#22336
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'consignee'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'consigneephone'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154#30005#35805
                Width = 90
              end
              item
                EditButtons = <>
                FieldName = 'consigneeaddress'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154#22320#22336
                Width = 150
              end
              item
                EditButtons = <>
                FieldName = 'certificateno'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25910#36135#20154#35777#20214#21495#30721
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'shiptypevalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #25552#36135#26041#24335
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'paymethodvalue'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #20184#27454#26041#24335
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'valuables'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #26159#21542#36149#37325#29289#21697
                Width = 101
              end
              item
                EditButtons = <>
                FieldName = 'remak'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #36135#29289#25551#36848
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'createtime'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21019#24314#26102#38388
                Width = 120
              end
              item
                EditButtons = <>
                FieldName = 'sellbyname'
                Footers = <>
                ImeMode = imClose
                Title.Caption = #21019#24314#20154
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'packtypevalue'
                Footers = <>
                Title.Caption = #25968#25454#31867#22411
                Visible = False
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'collectstatusname'
                Footers = <>
                Title.Caption = #20195#25910#29366#24577
              end
              item
                EditButtons = <>
                FieldName = 'recyclestatusname'
                Footers = <>
                Title.Caption = #22238#25910#29366#24577
              end>
            object RowDetailData: TRowDetailPanelControlEh
              object NvDbgridEh6: TNvDbgridEh
                Left = 0
                Top = 0
                Width = 0
                Height = 0
                Align = alClient
                ColumnDefValues.Title.TitleButton = True
                DataGrouping.GroupLevels = <>
                DataSource = dsResult
                Flat = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clWindowText
                Font.Height = -14
                Font.Name = #23435#20307
                Font.Style = []
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -15
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FooterRowCount = 1
                ImeMode = imDisable
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
                ParentFont = False
                ReadOnly = True
                RowDetailPanel.Color = clBtnFace
                SumList.Active = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -15
                TitleFont.Name = #23435#20307
                TitleFont.Style = [fsBold]
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
                ParentName = 'SimpleCRUDForm'
                TitleAlign = taLeftJustify
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'id'
                    Footers = <>
                    Visible = False
                  end
                  item
                    EditButtons = <>
                    FieldName = 'orgname'
                    Footers = <>
                    Title.Caption = #26426#26500
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sendstationname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21457#36135#31449
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'certificatetypevalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #35777#20214#31867#22411
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'tostationname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #30446#30340#22320
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'name'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36135#29289#21517#31216
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'goodtypevalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36135#29289#31867#21035
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sender'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'schedulecode'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #29677#27425
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'vehiclecode'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36710#29260#21495
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'departdate'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21457#36135#26085#26399
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'statusvalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #29366#24577
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packno'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #34892#21253#21333#21495
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'invoiceno'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21457#31080#21495
                    Visible = False
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sellbyname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21150#29702#21592
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'pieces'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20214#25968
                    Width = 40
                  end
                  item
                    EditButtons = <>
                    FieldName = 'weight'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #37325#37327'(kg)'
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'volume'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20307#31215
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packedvalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21253#35013
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'shipprice'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21253#35013#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'handfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #35013#21368#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'custodial'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#31649#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'transitfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20013#36716#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'insuredamount'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#20215#37329#39069
                    Width = 73
                  end
                  item
                    EditButtons = <>
                    FieldName = 'insurancefee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#20215#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'insurance'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20445#38505#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'deliveryfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36865#36135#36153
                    Width = 60
                  end
                  item
                    EditButtons = <>
                    FieldName = 'otherfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20854#20182#36153#29992
                    Width = 69
                  end
                  item
                    EditButtons = <>
                    FieldName = 'totalfee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21512#35745#37329#39069
                  end
                  item
                    EditButtons = <>
                    FieldName = 'location'
                    Footers = <>
                    Title.Caption = #23384#25918#20301#32622
                    Visible = False
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packprice'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20195#25910#36135#27454
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'senderphone'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#20154#30005#35805
                    Width = 90
                  end
                  item
                    EditButtons = <>
                    FieldName = 'senderaddress'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25176#36816#20154#22320#22336
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'consignee'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'consigneephone'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154#30005#35805
                    Width = 90
                  end
                  item
                    EditButtons = <>
                    FieldName = 'consigneeaddress'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154#22320#22336
                    Width = 150
                  end
                  item
                    EditButtons = <>
                    FieldName = 'certificateno'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25910#36135#20154#35777#20214#21495#30721
                    Width = 100
                  end
                  item
                    EditButtons = <>
                    FieldName = 'shiptypevalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #25552#36135#26041#24335
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'paymethodvalue'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #20184#27454#26041#24335
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'valuables'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #26159#21542#36149#37325#29289#21697
                    Width = 101
                  end
                  item
                    EditButtons = <>
                    FieldName = 'remak'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #36135#29289#25551#36848
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'createtime'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21019#24314#26102#38388
                    Width = 120
                  end
                  item
                    EditButtons = <>
                    FieldName = 'sellbyname'
                    Footers = <>
                    ImeMode = imClose
                    Title.Caption = #21019#24314#20154
                    Width = 70
                  end
                  item
                    EditButtons = <>
                    FieldName = 'packtypevalue'
                    Footers = <>
                    Title.Caption = #25968#25454#31867#22411
                    Visible = False
                    Width = 80
                  end
                  item
                    EditButtons = <>
                    FieldName = 'collectstatusname'
                    Footers = <>
                    Title.Caption = #20195#25910#29366#24577
                  end
                  item
                    EditButtons = <>
                    FieldName = 'recyclestatusname'
                    Footers = <>
                    Title.Caption = #22238#25910#29366#24577
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 104
    Top = 272
  end
  inherited ilToolBarDisable: TImageList
    Left = 80
    Top = 168
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'packdetails'
    QueryAddress = 'query/queryPackDetails'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_p!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_u!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_s!id'
        ParamType = ptInput
      end>
    Left = 208
    Top = 200
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object jcdsResultpackno: TWideStringField
      FieldName = 'packno'
    end
    object jcdsResultsingbillno: TWideStringField
      FieldName = 'singbillno'
    end
    object jcdsResultname1: TWideStringField
      FieldName = 'name1'
    end
    object jcdsResultpieces: TWideStringField
      FieldName = 'pieces'
    end
    object jcdsResultshipprice: TFloatField
      FieldName = 'shipprice'
    end
    object jcdsResulthandfee: TFloatField
      FieldName = 'handfee'
    end
    object jcdsResulttransitfee: TFloatField
      FieldName = 'transitfee'
    end
    object jcdsResultotherfee: TFloatField
      FieldName = 'otherfee'
    end
    object jcdsResulttotalfee: TFloatField
      FieldName = 'totalfee'
    end
    object jcdsResultshishoujine: TFloatField
      FieldName = 'shishoujine'
    end
    object jcdsResultjiesuanjine: TFloatField
      FieldName = 'jiesuanjine'
    end
    object jcdsResultname2: TWideStringField
      FieldName = 'name2'
    end
    object jcdsResultchepaihao: TWideStringField
      FieldName = 'chepaihao'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
    end
    object jcdsResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsstatusname
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Lookup = True
    end
  end
  inherited dsResult: TDataSource
    Top = 208
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 384
    Top = 224
  end
  object jcdsstatusname: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'pack'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 312
  end
end
