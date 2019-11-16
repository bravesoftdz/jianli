inherited FrmTicketFundsCheck: TFrmTicketFundsCheck
  Caption = #31080#27454#23545#20184#34920
  ClientHeight = 496
  ClientWidth = 882
  UseDockManager = True
  OldCreateOrder = False
  OnShow = FormShow
  ExplicitWidth = 898
  ExplicitHeight = 534
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 882
    ExplicitWidth = 882
    object lbl1: TLabel
      Left = 16
      Top = 24
      Width = 56
      Height = 14
      Caption = #36710#29260#21495#30721
    end
    object Label6: TLabel
      Left = 432
      Top = 24
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label4: TLabel
      Left = 232
      Top = 24
      Width = 56
      Height = 14
      Caption = #32467#24080#26102#38388
    end
    object nvhlpcode: TNovaHelp
      Left = 84
      Top = 20
      Width = 121
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'unitname'
          Title.Caption = #36710#23646#21333#20301
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #36710#29260#21495
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclenoHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object balanceStartDate: TDateTimePicker
      Left = 306
      Top = 20
      Width = 103
      Height = 22
      Date = 40544.000000000000000000
      Time = 40544.000000000000000000
      TabOrder = 1
    end
    object balanceEndDate: TDateTimePicker
      Left = 469
      Top = 20
      Width = 103
      Height = 22
      Date = 40413.000000000000000000
      Time = 40413.000000000000000000
      TabOrder = 2
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 882
    ExplicitWidth = 882
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
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Width = 882
    Height = 393
    ExplicitWidth = 882
    ExplicitHeight = 393
    inherited GroupBox1: TGroupBox
      Width = 882
      Height = 393
      ExplicitWidth = 882
      ExplicitHeight = 393
      inherited dbgrdhResult: TNvDbgridEh
        Width = 878
        Height = 375
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
            FieldName = 'contactperson'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36710#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ditotalnum'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #23458#36816#37327#21512#35745
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'ditotalmoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#27454#21512#35745
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'diagentfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20195#29702#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'healthfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #21355#29983#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'parkfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20572#36710#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'packagefee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #34892#21253#25187#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'otherfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #20854#20182
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'balancemoney'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #24212#20184#31080#27454
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'signature'
            Footers = <>
            Title.Caption = #31614#21517
            Width = 80
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
                FieldName = 'contactperson'
                Footer.DisplayFormat = #21512#35745
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #22995#21517
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'vehicleno'
                Footer.ValueType = fvtCount
                Footers = <>
                Title.Caption = #36710#21495
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'ditotalnum'
                Footers = <>
                Title.Caption = #23458#36816#37327#21512#35745
                Width = 82
              end
              item
                EditButtons = <>
                FieldName = 'dibalancemoney'
                Footers = <>
                Title.Caption = #31080#27454#21512#35745
                Width = 102
              end
              item
                EditButtons = <>
                FieldName = 'diagentfee'
                Footers = <>
                Title.Caption = #20195#29702#36153
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'healthfee'
                Footers = <>
                Title.Caption = #21355#29983#36153
                Width = 100
              end
              item
                EditButtons = <>
                FieldName = 'parkfee'
                Footers = <>
                Title.Caption = #20572#36710#36153
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'otherfee'
                Footers = <>
                Title.Caption = #20854#23427
                Width = 140
              end
              item
                EditButtons = <>
                FieldName = 'packagefee'
                Footers = <>
                Title.Caption = #34892#21253#25187#36153
                Width = 365
              end
              item
                EditButtons = <>
                FieldName = 'balancemony'
                Footers = <>
                Title.Caption = #24212#20184#31080#27454
                Width = 80
              end
              item
                EditButtons = <>
                FieldName = 'signiture'
                Footers = <>
                Title.Caption = #31614#21517
                Width = 80
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 176
  end
  inherited ilToolBarDisable: TImageList
    Top = 176
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'resultmap'
    QueryAddress = 'balance/queryTicketFundsCheck'
    Params = <
      item
        DataType = ftString
        Name = 'vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceStartDate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceEndDate'
        ParamType = ptInput
      end>
    Left = 216
    Top = 184
  end
  inherited dsResult: TDataSource
    Top = 176
  end
end
