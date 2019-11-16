inherited FrmTicketsellprint: TFrmTicketsellprint
  ActiveControl = edtticketno
  Caption = #37325#25171#36710#31080
  ClientHeight = 506
  ClientWidth = 826
  KeyPreview = True
  OnActivate = FormActivate
  OnShow = FormShow
  ExplicitWidth = 842
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 89
    Width = 826
    Height = 43
    ExplicitTop = 89
    ExplicitWidth = 826
    ExplicitHeight = 43
    object lbl1: TLabel
      Left = 14
      Top = 15
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object lbl2: TLabel
      Left = 226
      Top = 15
      Width = 14
      Height = 14
      Caption = #33267
    end
    object lbl6: TLabel
      Left = 393
      Top = 15
      Width = 28
      Height = 14
      Caption = #31080#21495
    end
    object lbl3: TLabel
      Left = 592
      Top = 17
      Width = 56
      Height = 14
      Caption = #25171#21360#26041#24335
    end
    object dtpstartdepartdate: TDateTimePicker
      Left = 78
      Top = 12
      Width = 121
      Height = 22
      Date = 40690.700826631960000000
      Time = 40690.700826631960000000
      TabOrder = 0
    end
    object dtpenddepartdate: TDateTimePicker
      Left = 255
      Top = 12
      Width = 121
      Height = 22
      Date = 40690.700826631960000000
      Time = 40690.700826631960000000
      TabOrder = 1
    end
    object edtticketno: TNovaEdit
      Left = 429
      Top = 12
      Width = 139
      Height = 22
      MaxLength = 50
      NumbersOnly = True
      TabOrder = 2
      OnExit = edtticketnoExit
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
    object CombPrintType: TComboBox
      Left = 659
      Top = 12
      Width = 111
      Height = 22
      TabOrder = 3
      Text = #21407#31080#21495#37325#25171
      Items.Strings = (
        #21407#31080#21495#37325#25171
        #26032#31080#21495#37325#25171)
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 826
    ButtonWidth = 77
    ExplicitWidth = 826
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 77
    end
    inherited tbtn1: TToolButton
      Left = 77
      ExplicitLeft = 77
    end
    inherited tbtnInsert: TToolButton
      Left = 85
      Caption = #21407#31080#21495#37325#25171
      OnClick = tbtnInsertClick
      ExplicitLeft = 85
      ExplicitWidth = 77
    end
    inherited tbtnEdit: TToolButton
      Left = 162
      Caption = #26032#31080#21495#37325#25171
      OnClick = tbtnInsertClick
      ExplicitLeft = 162
      ExplicitWidth = 77
    end
    inherited tbtnDelete: TToolButton
      Left = 239
      AutoSize = True
      Visible = False
      ExplicitLeft = 239
      ExplicitWidth = 39
    end
    inherited ToolButton50: TToolButton
      Left = 278
      ExplicitLeft = 278
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      Left = 296
      ExplicitLeft = 296
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Left = 314
      Visible = False
      ExplicitLeft = 314
    end
    inherited tbtnSave: TToolButton
      Left = 322
      AutoSize = True
      Caption = ' '#20445#23384' '
      Visible = False
      ExplicitLeft = 322
      ExplicitWidth = 53
    end
    inherited tbtnCancel: TToolButton
      Left = 375
      AutoSize = True
      Caption = '  '#21462#28040' '
      Visible = False
      ExplicitLeft = 375
      ExplicitWidth = 60
    end
    inherited ToolButton52: TToolButton
      Left = 435
      ExplicitLeft = 435
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      Left = 453
      ExplicitLeft = 453
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Left = 471
      ExplicitLeft = 471
    end
    inherited tbtnInfo: TToolButton
      Left = 479
      ExplicitLeft = 479
      ExplicitWidth = 77
    end
    inherited tbtn5: TToolButton
      Left = 556
      ExplicitLeft = 556
    end
    inherited tbtnExcel: TToolButton
      Left = 564
      AutoSize = True
      ExplicitLeft = 564
      ExplicitWidth = 74
    end
    inherited tbtnPrinter: TToolButton
      Left = 638
      ExplicitLeft = 638
      ExplicitWidth = 77
    end
    inherited tbtn6: TToolButton
      Left = 715
      ExplicitLeft = 715
    end
    inherited tbtnClose: TToolButton
      Left = 723
      ExplicitLeft = 723
      ExplicitWidth = 77
    end
  end
  inherited Panel1: TPanel
    Top = 132
    Width = 826
    Height = 374
    ExplicitTop = 132
    ExplicitWidth = 826
    ExplicitHeight = 374
    inherited GroupBox1: TGroupBox
      Width = 826
      Height = 374
      ExplicitWidth = 826
      ExplicitHeight = 374
      inherited dbgrdhResult: TNvDbgridEh
        Width = 822
        Height = 356
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        OnKeyUp = dbgrdhResultKeyUp
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            Footers = <>
            Visible = False
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #26426#26500
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #29677#27425
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vehicleno'
            Footers = <>
            Title.Caption = #36710#36742
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ticketname'
            Footers = <>
            Title.Caption = #21806#31080#28857
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reachname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'carrychildnum'
            Footers = <>
            Title.Caption = #20799#31461#25968#37327
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footers = <>
            Title.Caption = #23454#38469#36141#31080#20215
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'discountrate'
            Footers = <>
            Title.Caption = #31449#21153#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'stationservicefee'
            Footers = <>
            Title.Caption = #29123#27833#38468#21152#36153
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'sellname'
            Footers = <>
            Title.Caption = #21806#31080#20154
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #19982#21457#36710#31449#30340#36317#31163
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'selltime'
            Footers = <>
            Title.Caption = #21806#20986#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475#21517#31216
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 80
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
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end>
      end
    end
  end
  object grpticketno: TGroupBox [3]
    AlignWithMargins = True
    Left = 0
    Top = 48
    Width = 817
    Height = 41
    Margins.Left = 0
    Margins.Right = 9
    Margins.Bottom = 0
    Align = alTop
    Caption = #24403#21069#31080#21495
    TabOrder = 3
    object lblticketno: TLabel
      Left = 2
      Top = 16
      Width = 120
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = '012345678912'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 17
      ExplicitHeight = 20
    end
    object Label1: TLabel
      Left = 244
      Top = 16
      Width = 15
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taCenter
      Caption = #24352
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
    object Label2: TLabel
      Left = 122
      Top = 16
      Width = 14
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = #20313
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 96
      ExplicitTop = 15
      ExplicitHeight = 18
    end
    object lblleaveticketnum: TLabel
      Left = 136
      Top = 16
      Width = 108
      Height = 23
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      Alignment = taCenter
      Caption = '012345678912'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
  end
  inherited ilToolBar: TImageList
    Top = 232
  end
  inherited ilToolBarDisable: TImageList
    Top = 232
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketsellmap'
    QueryAddress = 'sell/qryticketsellprint'
    Params = <
      item
        DataType = ftString
        Name = 'filter_GED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_t!departdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_t!ticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQR_t!seatno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_ve!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_t!ticketoutletsid'
        ParamType = ptInput
      end>
    Top = 304
  end
  inherited dsResult: TDataSource
    Top = 232
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Top = 232
  end
  object tmrleaveticketnum: TTimer
    Enabled = False
    OnTimer = tmrleaveticketnumTimer
    Left = 632
    Top = 328
  end
  object tmrRefreshBill: TTimer
    OnTimer = tmrRefreshBillTimer
    Left = 496
    Top = 272
  end
end
