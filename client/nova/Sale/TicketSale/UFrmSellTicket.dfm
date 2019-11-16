object FrmSellTicket: TFrmSellTicket
  Left = 0
  Top = 0
  Caption = #21806#31080
  ClientHeight = 548
  ClientWidth = 1278
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object shpbackround: TShape
    Left = 320
    Top = 275
    Width = 42
    Height = 42
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Brush.Color = clRed
    Visible = False
  end
  object splbufferticket: TSplitter
    Left = 0
    Top = 422
    Width = 1278
    Height = 4
    Cursor = crVSplit
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Beveled = True
    ResizeStyle = rsUpdate
    Visible = False
  end
  object gbticketbuffer: TGroupBox
    Left = 0
    Top = 426
    Width = 1278
    Height = 122
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Caption = #36141#29289#36710'(F10)'
    TabOrder = 1
    Visible = False
    object spl1: TSplitter
      Left = 983
      Top = 18
      Width = 2
      Height = 102
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
    end
    object nvdbgrdhticketbuffer: TNvDbgridEh
      Left = 2
      Top = 18
      Width = 981
      Height = 102
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      AllowedOperations = [alopDeleteEh]
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsTicketBuffer
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = #24494#36719#38597#40657
      FooterFont.Style = []
      FooterRowCount = 1
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      PopupMenu = pmbufferticket
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = #24494#36719#38597#40657
      TitleFont.Style = []
      OnKeyDown = nvdbgrdhticketbufferKeyDown
      ExpOpenType = AutoOpen
      AutoSetMultiSelect = False
      AutoSetCtrlKey = True
      PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
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
      ParentName = 'FrmSellTicket'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'departdate'
          Footer.Value = #21512#35745
          Footer.ValueType = fvtStaticText
          Footers = <>
          Title.Caption = #21457#36710#26085#26399
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'departtime'
          Footer.ValueType = fvtCount
          Footers = <>
          Title.Caption = #21457#36710#26102#38388
          Width = 49
        end
        item
          EditButtons = <>
          FieldName = 'schedulecode'
          Footers = <>
          Title.Caption = #29677#27425#21495
          Width = 38
        end
        item
          EditButtons = <>
          FieldName = 'departstationname'
          Footers = <>
          Title.Caption = #21457#36710#31449
          Width = 47
        end
        item
          EditButtons = <>
          FieldName = 'reachstationname'
          Footers = <>
          Title.Caption = #21040#31449
          Width = 47
        end
        item
          EditButtons = <>
          FieldName = 'seatno'
          Footers = <>
          Title.Caption = #24231#20301#21495
          Width = 39
        end
        item
          EditButtons = <>
          FieldName = 'seattypename'
          Footers = <>
          Title.Caption = #24231#20301#31867#22411
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'price'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #31080#20215
          Width = 37
        end
        item
          EditButtons = <>
          FieldName = 'carrychildnum'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #24102#20799#31461#25968
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'ticketentrance'
          Footers = <>
          Title.Caption = #26816#31080#21475
          Width = 77
        end
        item
          EditButtons = <>
          FieldName = 'buspark'
          Footers = <>
          Title.Caption = #19978#36710#21345#20301
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'isovertime'
          Footers = <>
          Title.Caption = #21152#29677
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'islinework'
          Footers = <>
          Title.Caption = #27969#27700#29677
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'workwaysname'
          Footers = <>
          Title.Caption = #33829#36816#26041#24335
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'planbrandmodel'
          Footers = <>
          Title.Caption = #36710#36742#21697#29260
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'planunitname'
          Footers = <>
          Title.Caption = #36710#23646#21333#20301
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'planvehicleno'
          Footers = <>
          Title.Caption = #36710#29260
          Width = 52
        end
        item
          EditButtons = <>
          FieldName = 'planvehicletypecustomname'
          Footers = <>
          Title.Caption = #36710#22411
          Width = 47
        end
        item
          EditButtons = <>
          FieldName = 'tickettypeprintname'
          Footers = <>
          Title.Caption = #36710#31080#31867#22411
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'ticketno'
          Footers = <>
          Title.Caption = #31080#21495
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'paymethod'
          Footers = <>
          Title.Caption = #25903#20184#26041#24335
          Width = 51
        end>
      object RowDetailData: TRowDetailPanelControlEh
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
      end
    end
    object nvdbgrdhInsureBuffer: TNvDbgridEh
      Left = 985
      Top = 18
      Width = 291
      Height = 102
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      AllowedOperations = [alopUpdateEh]
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsInsureBuffer
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = #24494#36719#38597#40657
      FooterFont.Style = []
      FooterRowCount = 1
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      PopupMenu = pmbufferticket
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SumList.Active = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = #24494#36719#38597#40657
      TitleFont.Style = []
      OnKeyDown = nvdbgrdhticketbufferKeyDown
      ExpOpenType = AutoOpen
      AutoSetMultiSelect = False
      AutoSetCtrlKey = True
      PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
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
      ParentName = 'FrmSellTicket'
      TitleAlign = taLeftJustify
      Columns = <
        item
          EditButtons = <>
          FieldName = 'seatno'
          Footers = <>
          Title.Caption = #24231#20301#21495
          Width = 36
        end
        item
          EditButtons = <>
          FieldName = 'tickettypeprintname'
          Footers = <>
          Title.Caption = #36710#31080#31867#22411
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'issell'
          Footers = <>
          Title.Caption = #21806#20445#38505
          Width = 38
        end
        item
          EditButtons = <>
          FieldName = 'insuretypename'
          Footers = <>
          Title.Caption = #20445#38505#31867#22411
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'customername'
          Footers = <>
          Title.Caption = #22995#21517
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'certificatetypename'
          Footers = <>
          Title.Caption = #35777#20214
          Width = 40
        end
        item
          EditButtons = <>
          FieldName = 'certificateno'
          Footers = <>
          Title.Caption = #35777#20214#21495
          Width = 103
        end>
      object RowDetailData: TRowDetailPanelControlEh
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
      end
    end
  end
  object pnlmain: TPanel
    Left = 0
    Top = 0
    Width = 1278
    Height = 422
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object gbContextHit: TGroupBox
      Left = 0
      Top = 222
      Width = 1278
      Height = 40
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      Caption = #19978#19979#25991#25805#20316#25552#31034
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblContextHint: TLabel
        Left = 2
        Top = 19
        Width = 1274
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        Caption = 
          'F1'#65306#26597#30475#24212#32564#27454#12289'F2'#65306#37325#32622#12289'F3'#65306#21806#31080#12289'F4'#65306#36864#31080#12289'F5'#65306#21806#20445#38505#12289'F6'#65306#24102#20799#31461#12289'F7'#65306#32852#32593#31080#12289'F8'#65306#25913#31614#12289'F9'#65306#37325#21806#12289'F10'#65306 +
          #36141#31080#36710#12289'F11'#65306#34917#31080#12289'F12'#65306#37325#25171#12289'Ctrl+S'#65306#36884#32463#31449#12289'+'#65306#21152#20837#36141#31080#36710
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 1114
      end
    end
    object gbseatplan: TGroupBox
      Left = 0
      Top = 262
      Width = 1278
      Height = 160
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      Caption = #36873#20301'(F9)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object pnlvip: TPanel
        Left = 2
        Top = 22
        Width = 265
        Height = 136
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        OnResize = pnlvipResize
        object lbl10: TLabel
          Left = 4
          Top = 71
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #21345#20869#31215#20998
        end
        object lblviplastamount: TLabel
          Left = 64
          Top = 72
          Width = 52
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '1800.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl11: TLabel
          Left = 4
          Top = 90
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #26412#27425#31215#20998
        end
        object lbl13: TLabel
          Left = 111
          Top = 71
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #21345#20869#20313#39069
        end
        object lblvipamount: TLabel
          Left = 64
          Top = 91
          Width = 16
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '20'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 113
          Top = 84
          Width = 75
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #36141#31080#21518#20313#39069
          Visible = False
        end
        object lblviplastmoney: TLabel
          Left = 174
          Top = 72
          Width = 52
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '1800.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl8: TLabel
          Left = 110
          Top = 96
          Width = 75
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #36141#31080#21518#31215#20998
          Visible = False
        end
        object lblvipnewamount: TLabel
          Left = 174
          Top = 92
          Width = 20
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '20'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblvipnewmoney: TLabel
          Left = 176
          Top = 81
          Width = 65
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '1800.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object bvlvip: TBevel
          Left = 2
          Top = 66
          Width = 256
          Height = 2
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Shape = bsTopLine
        end
        object lbl14: TLabel
          Left = 127
          Top = 25
          Width = 44
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'IC'#21345#21495
        end
        object lbl15: TLabel
          Left = 5
          Top = 25
          Width = 59
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'IC'#21345#31867#22411
        end
        object lbl16: TLabel
          Left = 4
          Top = 44
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #39038#23458#22995#21517
        end
        object lbl17: TLabel
          Left = 111
          Top = 43
          Width = 60
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #39038#23458#30005#35805
        end
        object lblvipname: TLabel
          Left = 71
          Top = 45
          Width = 26
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #24352#19977
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblvipcardno: TLabel
          Left = 174
          Top = 26
          Width = 64
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '88888888'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblvipcardtype: TLabel
          Left = 71
          Top = 26
          Width = 26
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #37329#21345
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblviptel: TLabel
          Left = 173
          Top = 44
          Width = 88
          Height = 19
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '13812345678'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnclearvipinfo: TBitBtn
          Left = 5
          Top = 2
          Width = 118
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '&C'#28165#31354'VIP'#20449#24687
          NumGlyphs = 2
          TabOrder = 0
          TabStop = False
          OnClick = btnclearvipinfoClick
        end
      end
      object pnlseatplan: TPanel
        Left = 267
        Top = 22
        Width = 1009
        Height = 136
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        OnResize = pnlseatplanResize
        object scrlbxSeatPlan: TScrollBox
          Left = 0
          Top = 0
          Width = 1009
          Height = 136
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object pnlhint: TPanel
      Left = 0
      Top = 0
      Width = 1278
      Height = 45
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object gb1: TGroupBox
        Left = 617
        Top = 0
        Width = 100
        Height = 45
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'F5'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object cbautosellinsure: TCheckBox
          Left = 2
          Top = 22
          Width = 96
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Caption = #33258#21160#21806#20445#38505
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = checkBoxClick
        end
      end
      object gbTicketnos: TGroupBox
        Left = 0
        Top = 0
        Width = 287
        Height = 45
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #31080#21495
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblticketno: TLabel
          Left = 2
          Top = 22
          Width = 119
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Alignment = taCenter
          AutoSize = False
          Caption = ' 012345678912'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl2: TLabel
          Left = 259
          Top = 22
          Width = 19
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Alignment = taCenter
          Caption = ' '#24352
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 19
        end
        object lbl3: TLabel
          Left = 121
          Top = 22
          Width = 30
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = '  '#20313'  '
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblleaveticketnum: TLabel
          Left = 151
          Top = 22
          Width = 108
          Height = 21
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
      object gb4: TGroupBox
        Left = 717
        Top = 0
        Width = 100
        Height = 45
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'F6'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
        object cbautoreceipt: TCheckBox
          Left = 2
          Top = 22
          Width = 96
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Caption = #33258#21160#23454#25910
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = checkBoxClick
        end
      end
      object gbinsureno: TGroupBox
        Left = 287
        Top = 0
        Width = 330
        Height = 45
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #20445#21333#21495
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object lblinsureno: TLabel
          Left = 2
          Top = 22
          Width = 108
          Height = 21
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
        object lbl7: TLabel
          Left = 110
          Top = 22
          Width = 39
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Alignment = taRightJustify
          Caption = '   '#20313'   '
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 19
        end
        object lblleaveinsurenum: TLabel
          Left = 149
          Top = 22
          Width = 108
          Height = 21
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
        object lbl12: TLabel
          Left = 257
          Top = 22
          Width = 15
          Height = 21
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
        object btnresetInsureNo: TButton
          AlignWithMargins = True
          Left = 274
          Top = 22
          Width = 90
          Height = 21
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = #37325#32622#20445#38505#21333#35777#21495
          TabOrder = 0
          Visible = False
          OnClick = btnresetInsureNoClick
        end
        object btnprintinsure: TButton
          AlignWithMargins = True
          Left = 366
          Top = 22
          Width = 59
          Height = 21
          Margins.Left = 2
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = #25171#21360#20445#21333
          TabOrder = 1
          Visible = False
          OnClick = btnprintinsureClick
        end
      end
      object grpSellNet: TGroupBox
        Left = 817
        Top = 0
        Width = 100
        Height = 45
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'F7'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object chkSellNet: TCheckBox
          Left = 2
          Top = 22
          Width = 96
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Caption = #21806#32852#32593#31080
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = checkBoxClick
        end
      end
      object pnllastmoney: TPanel
        Left = 958
        Top = 0
        Width = 320
        Height = 45
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Visible = False
        object lbl1: TLabel
          AlignWithMargins = True
          Left = 0
          Top = 12
          Width = 30
          Height = 31
          Margins.Left = 0
          Margins.Top = 12
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alLeft
          Caption = #24212#25910
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 19
        end
        object lbllastmoney: TLabel
          AlignWithMargins = True
          Left = 30
          Top = 12
          Width = 65
          Height = 31
          Margins.Left = 0
          Margins.Top = 12
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alLeft
          Caption = '1050.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 24
        end
        object lbl4: TLabel
          AlignWithMargins = True
          Left = 95
          Top = 12
          Width = 30
          Height = 31
          Margins.Left = 0
          Margins.Top = 12
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alLeft
          Caption = #23454#25910
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 19
        end
        object lblreceipt: TLabel
          AlignWithMargins = True
          Left = 125
          Top = 12
          Width = 65
          Height = 31
          Margins.Left = 0
          Margins.Top = 12
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alLeft
          Caption = '1050.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 24
        end
        object lbl5: TLabel
          AlignWithMargins = True
          Left = 190
          Top = 12
          Width = 30
          Height = 31
          Margins.Left = 0
          Margins.Top = 12
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alLeft
          Caption = #25214#38646
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 19
        end
        object lblchange: TLabel
          AlignWithMargins = True
          Left = 220
          Top = 0
          Width = 110
          Height = 43
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 2
          Align = alLeft
          Caption = '1050.50'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -28
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitHeight = 37
        end
      end
    end
    object pnlinput: TPanel
      Left = 0
      Top = 164
      Width = 1278
      Height = 58
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object gbamount: TGroupBox
        Left = 420
        Top = 0
        Width = 198
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #36141#31080#25968#37327
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object gbschedulecondition: TGroupBox
        Left = 290
        Top = 0
        Width = 130
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #21040#31449'/'#29677#27425'F2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object nvhelpSchedule: TNovaHelp
          Left = 4
          Top = 22
          Width = 120
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabStop = False
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          OnIdChange = nvhelpreachstationIdChange
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
              Title.Caption = #29677#27425#21495
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'starttime'
              Title.Caption = #22987#21457#26102#38388
              Width = 60
              Visible = True
            end>
          HelpOptions.HelpHeight = 200
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'ScheduleHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
        object nvhelpreachstation: TNovaHelp
          Left = 4
          Top = 22
          Width = 120
          Height = 35
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          CharCase = ecUpperCase
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          Text = #21513#26519#30465#31449#21513#26519
          OnChange = nvhelpreachstationChange
          OnIdChange = nvhelpreachstationIdChange
          ValueTrim = #21513#26519#30465#31449#21513#26519
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
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              Title.Caption = #21517#31216
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'helpcode'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #25805#20316#30721
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'jianpin'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #31616#25340
              Width = 50
              Visible = True
            end>
          HelpOptions.HelpHeight = 200
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'StationHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <
            item
              DataType = ftString
              Name = 'cityid'
              ParamType = ptInput
            end>
          notFocusedShowHelp = False
        end
      end
      object gbTakeKid: TGroupBox
        Left = 618
        Top = 0
        Width = 125
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'F6'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object cbtakekid: TCheckBox
          Left = 5
          Top = 24
          Width = 78
          Height = 22
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = #24102#20799#31461
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = checkBoxClick
        end
        object sekid: TSpinEdit
          Left = 79
          Top = 18
          Width = 38
          Height = 34
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          MaxLength = 2
          MaxValue = 99
          MinValue = 0
          ParentFont = False
          TabOrder = 1
          Value = 0
        end
      end
      object gb3: TGroupBox
        Tag = -1
        Left = 0
        Top = 0
        Width = 150
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #26085#26399
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        object dtpdepartdate: TDateTimePicker
          Left = 4
          Top = 23
          Width = 140
          Height = 35
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Date = 40645.642132337960000000
          Time = 40645.642132337960000000
          Color = clWhite
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          ParentFont = False
          TabOrder = 0
          OnChange = dtpdepartdateChange
        end
      end
      object gb7: TGroupBox
        Left = 150
        Top = 0
        Width = 140
        Height = 58
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = #21457#36710#31449
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object nvhlpdepartdistrict: TNovaHelp
          Left = 4
          Top = 22
          Width = 107
          Height = 35
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          TabStop = False
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          OnIdChange = nvhelpreachstationIdChange
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
          HelpOptions.HelpHeight = 100
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'NetStartDistrictHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
        object nvhelpdepartstation: TNovaHelp
          Left = 4
          Top = 22
          Width = 133
          Height = 35
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          CharCase = ecUpperCase
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #24494#36719#38597#40657
          Font.Style = [fsBold]
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          Text = #21513#26519#30465#31449#21513#26519#30465#31449
          OnChange = nvhelpdepartstationChange
          OnIdChange = nvhelpreachstationIdChange
          ValueTrim = #21513#26519#30465#31449#21513#26519#30465#31449
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
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #21517#31216
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'helpcode'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #25805#20316#30721
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'jianpin'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              Title.Caption = #31616#25340
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'isnet'
              Visible = False
            end>
          HelpOptions.HelpHeight = 100
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'StartStationHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
      end
    end
    object pnlschedule: TPanel
      Left = 0
      Top = 45
      Width = 1278
      Height = 119
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 4
      OnResize = pnlscheduleResize
      object nvdbgrdhschedule: TNvDbgridEh
        AlignWithMargins = True
        Left = 59
        Top = 0
        Width = 982
        Height = 160
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = dsSchedule
        Flat = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        FooterColor = clWhite
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = #24494#36719#38597#40657
        FooterFont.Style = []
        ImeMode = imClose
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        RowHeight = 28
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -17
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = [fsBold]
        OnDblClick = nvdbgrdhscheduleDblClick
        OnDrawColumnCell = nvdbgrdhscheduleDrawColumnCell
        OnGetCellParams = nvdbgrdhscheduleGetCellParams
        OnKeyDown = nvdbgrdhscheduleKeyDown
        OnKeyUp = nvdbgrdhscheduleKeyUp
        ExpOpenType = AutoOpen
        AutoSetMultiSelect = False
        AutoSetCtrlKey = False
        AutoFocusKey = True
        PrintInfo.TitleFont.Charset = DEFAULT_CHARSET
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
        jsonConnection = DMPublic.jcon
        AutoGridAdject = True
        AutoGridSave = True
        AutoAPPPopuMenu = True
        ParentName = 'FrmSellTicket'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 119
          end
          item
            EditButtons = <>
            FieldName = 'schedulecode'
            Footers = <>
            Title.Caption = #29677#27425#21495
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'startstationname'
            Footers = <>
            Title.Caption = #22987#21457#31449
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'endstationname'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departtime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'seatnum'
            Footers = <>
            Title.Caption = #24635#24231#20301
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'RESIDUESEATNUM'
            Footers = <>
            Title.Caption = #21487#21806
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'residuecarrychildnum'
            Footers = <>
            Title.Caption = #21487#21806#20799#31461
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'soldeatnum'
            Footers = <>
            Title.Caption = #24050#21806
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'fullprice'
            Footers = <>
            Title.Caption = #20840#31080#20215
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'halfprice'
            Footers = <>
            Title.Caption = #21322#31080#20215
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'studentprice'
            Footers = <>
            Title.Caption = #23398#29983#31080#20215
            Width = 81
          end
          item
            EditButtons = <>
            FieldName = 'distance'
            Footers = <>
            Title.Caption = #37324#31243
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'runtime'
            Footers = <>
            Title.Caption = #36816#34892#26102#38388
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'endstation'
            Footers = <>
            Title.Caption = #32456#21040#36710#31449
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrance'
            Footers = <>
            Title.Caption = #26816#31080#21475
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'planbrandmodel'
            Footers = <>
            Title.Caption = #36710#36742#21697#29260
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'startstationprice'
            Footers = <>
            Title.Caption = #22987#21457#31449#31080#20215
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'starttime'
            Footers = <>
            Title.Caption = #22987#21457#26102#38388
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'moreprice'
            Footers = <>
            Title.Caption = #31080#20215#24046
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'departstationname'
            Footers = <>
            Title.Caption = #21457#36710#31449
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'issaleafterreport'
            Footers = <>
            Title.Caption = #25253#21040#21806#31080
          end
          item
            EditButtons = <>
            FieldName = 'islinework'
            Footers = <>
            Title.Caption = #27969#27700#29677
            Width = 50
          end
          item
            EditButtons = <>
            FieldName = 'isovertime'
            Footers = <>
            Title.Caption = #21152#29677
            Width = 36
          end
          item
            EditButtons = <>
            FieldName = 'seattypename'
            Footers = <>
            Title.Caption = #24231#20301#31867#22411
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'workwaysname'
            Footers = <>
            Title.Caption = #33829#36816#26041#24335
          end
          item
            EditButtons = <>
            FieldName = 'planunitname'
            Footers = <>
            Title.Caption = #36710#23646#21333#20301
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'planvehicleno'
            Footers = <>
            Title.Caption = #36710#29260
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'planvehicletypecustomname'
            Footers = <>
            Title.Caption = #36710#22411
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'isroundtrip'
            Footers = <>
            Title.Caption = #24448#36820#31080
            Width = 48
            WordWrap = True
          end
          item
            EditButtons = <>
            FieldName = 'scheduleremarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'returntripvaliddays'
            Footers = <>
            Title.Caption = #22238#31243#31080#26377#25928#22825#25968
            Width = 94
          end
          item
            EditButtons = <>
            FieldName = 'isdeparted'
            Footers = <>
            Title.Caption = #24050#21457#29677
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'ticketentrancename'
            Footers = <>
            Title.Caption = #26816#31080#21475#21517#31216
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'discountprice'
            Footers = <>
            Title.Caption = #25240#25187#31080#20215
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'discountpriceticket'
            Footers = <>
            Title.Caption = #21487#21806#25240#25187#31080#25968
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'vcleseattypename'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'isreported'
            Footers = <>
            Title.Caption = #26159#21542#25253#21040
            Width = 70
          end>
        object RowDetailData: TRowDetailPanelControlEh
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
        end
      end
    end
  end
  object pnlreceipt: TPanel
    Left = 265
    Top = 116
    Width = 529
    Height = 306
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    BevelInner = bvRaised
    BevelKind = bkSoft
    BevelOuter = bvLowered
    BevelWidth = 3
    TabOrder = 0
    Visible = False
    OnMouseDown = pnlreceiptMouseDown
    object pnlsellwayend: TPanel
      Left = 6
      Top = 281
      Width = 513
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlseatnos: TPanel
      Left = 6
      Top = 222
      Width = 513
      Height = 59
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblseatnos: TLabel
        Left = 63
        Top = 5
        Width = 434
        Height = 49
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        AutoSize = False
        Caption = '7'#12289'8'#12289'10'#12289'11'#12289'12'#12289'20'#12289'21'#12289'22'#12289'23'#12289'24'
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        OnMouseDown = pnlreceiptMouseDown
      end
      object lbl9: TLabel
        Left = 35
        Top = 0
        Width = 26
        Height = 19
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = #24231#20301
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        OnMouseDown = pnlreceiptMouseDown
      end
    end
    object pnlJJInsureHint: TPanel
      Left = 6
      Top = 6
      Width = 513
      Height = 36
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object lblJJInsureMoney: TLabel
        AlignWithMargins = True
        Left = 164
        Top = 0
        Width = 27
        Height = 32
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = '3'#20803
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -17
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        OnMouseDown = pnlreceiptMouseDown
        ExplicitHeight = 24
      end
      object lbl19: TLabel
        AlignWithMargins = True
        Left = 96
        Top = 2
        Width = 64
        Height = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Alignment = taCenter
        Caption = #24212#25910#20445#36153
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        OnMouseDown = pnlreceiptMouseDown
        ExplicitHeight = 21
      end
      object bvl1: TBevel
        Left = 0
        Top = 34
        Width = 513
        Height = 2
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        Shape = bsBottomLine
        ExplicitTop = 21
        ExplicitWidth = 514
      end
      object lbl20: TLabel
        AlignWithMargins = True
        Left = 195
        Top = 2
        Width = 202
        Height = 30
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Alignment = taCenter
        Caption = '('#26412#36153#29992#19981#21253#21547#22312#21512#35745#24212#25910#20013')'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        OnMouseDown = pnlreceiptMouseDown
        ExplicitHeight = 21
      end
      object cbsellinsure: TCheckBox
        Left = 0
        Top = 0
        Width = 94
        Height = 34
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'F5'#21806#20445#38505
        Checked = True
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = checkBoxClick
      end
    end
    object pnlreciptSchedule: TPanel
      Left = 6
      Top = 42
      Width = 513
      Height = 180
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
    end
  end
  object dsSchedule: TDataSource
    Left = 48
    Top = 72
  end
  object dsTicketBuffer: TDataSource
    Left = 208
    Top = 520
  end
  object tmrunlockseat: TTimer
    Enabled = False
    OnTimer = tmrunlockseatTimer
    Left = 200
    Top = 272
  end
  object pmbufferticket: TPopupMenu
    Left = 280
    Top = 520
    object NBufferTicketDelete: TMenuItem
      Caption = #21024#38500
      OnClick = NBufferTicketDeleteClick
    end
  end
  object dsInsureBuffer: TDataSource
    Left = 552
    Top = 520
  end
  object tmrleaveticketnum: TTimer
    Enabled = False
    OnTimer = tmrleaveticketnumTimer
    Left = 72
    Top = 120
  end
  object tmrleaveinsurenum: TTimer
    Enabled = False
    OnTimer = tmrleaveinsurenumTimer
    Left = 160
    Top = 96
  end
  object tmrRefreshBill: TTimer
    OnTimer = tmrRefreshBillTimer
    Left = 240
    Top = 104
  end
  object jcdsCanSaleTicketType: TjsonClientDataSet
    DataSourceName = 'selltickettypelist'
    QueryAddress = 'base/findCanSaleTicketType'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'scheduleid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 544
    Top = 384
  end
  object jcdsvipinfo: TjsonClientDataSet
    DataSourceName = 'helpmap'
    QueryAddress = 'system/help'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'helpType'
        ParamType = ptInput
        Value = 'VipHelp'
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_v!vipcardno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_EQS_v!status'
        ParamType = ptInput
        Value = '0'
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 64
  end
  object jcdsParameters: TjsonClientDataSet
    DataSourceName = 'paramlistmap'
    QueryAddress = 'system/findParametersValue'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'orgid'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 424
    Top = 424
  end
  object jcdsisrealnameticket: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'sell/findisrealnameticket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'schedule.id'
        ParamType = ptInput
      end
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
    Left = 880
    Top = 88
  end
end
