object FrmNovaTakeTicket: TFrmNovaTakeTicket
  Left = 0
  Top = 0
  Caption = #30005#23376#31080#21462#31080
  ClientHeight = 696
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 15
  object pnl1: TPanel
    Left = 0
    Top = 39
    Width = 756
    Height = 657
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object grpticketinfo: TGroupBox
      Left = 0
      Top = 265
      Width = 756
      Height = 392
      Align = alClient
      Caption = #30005#23376#31080#20449#24687
      TabOrder = 0
      object pnl4: TPanel
        Left = 2
        Top = 62
        Width = 752
        Height = 328
        Align = alClient
        TabOrder = 0
        object NvDbgridEh1: TNvDbgridEh
          Left = 1
          Top = 1
          Width = 750
          Height = 326
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          DataSource = ds1
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = DEFAULT_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -15
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          RowDetailPanel.Color = clBtnFace
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -15
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          ExpOpenType = AutoOpen
          AutoSetMultiSelect = False
          AutoSetCtrlKey = False
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
          PrintOptions = [pghFitGridToPageWidth, pghColored, pghOptimalColWidths]
          PrintAutoNewLine = False
          TitleAlign = taLeftJustify
          Columns = <
            item
              Checkboxes = True
              EditButtons = <>
              FieldName = 'isselected'
              Footers = <>
              Title.Caption = #36873#25321
              Width = 33
            end
            item
              Checkboxes = True
              EditButtons = <>
              FieldName = 'istaked'
              Footers = <>
              ReadOnly = True
              Title.Caption = #21462#31080
              Width = 37
            end
            item
              EditButtons = <>
              FieldName = 'departdate'
              Footers = <>
              ReadOnly = True
              Title.Caption = #21457#36710#26085#26399
              Width = 86
            end
            item
              EditButtons = <>
              FieldName = 'schedulecode'
              Footers = <>
              ReadOnly = True
              Title.Caption = #29677#27425#21495
              Width = 58
            end
            item
              EditButtons = <>
              FieldName = 'departtime'
              Footers = <>
              ReadOnly = True
              Title.Caption = #21457#36710#26102#38388
              Width = 62
            end
            item
              EditButtons = <>
              FieldName = 'departstationname'
              Footers = <>
              ReadOnly = True
              Title.Caption = #19978#36710#31449#28857
              Width = 69
            end
            item
              EditButtons = <>
              FieldName = 'reachstationname'
              Footers = <>
              ReadOnly = True
              Title.Caption = #21040#36798#31449
              Width = 78
            end
            item
              EditButtons = <>
              FieldName = 'tickettypename'
              Footers = <>
              ReadOnly = True
              Title.Caption = #31080#31181
              Width = 52
            end
            item
              EditButtons = <>
              FieldName = 'seatno'
              Footers = <>
              ReadOnly = True
              Title.Caption = #24231#20301#21495
              Width = 51
            end
            item
              EditButtons = <>
              FieldName = 'price'
              Footers = <>
              ReadOnly = True
              Title.Caption = #31080#20215
              Width = 46
            end
            item
              EditButtons = <>
              FieldName = 'orderno'
              Footers = <>
              ReadOnly = True
              Title.Caption = #35746#21333#21495
              Width = 98
            end
            item
              EditButtons = <>
              FieldName = 'mobilephone'
              Footers = <>
              ReadOnly = True
              Title.Caption = #25163#26426#21495
              Width = 97
            end
            item
              EditButtons = <>
              FieldName = 'selltime'
              Footers = <>
              ReadOnly = True
              Title.Caption = #36141#31080#26102#38388
              Width = 165
            end
            item
              EditButtons = <>
              FieldName = 'taketime'
              Footers = <>
              ReadOnly = True
              Title.Caption = #21462#31080#26102#38388
              Width = 159
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
      end
      object btnprint: TBitBtn
        Left = 2
        Top = 17
        Width = 752
        Height = 45
        Align = alTop
        Caption = 'F12.'#21462#31080#25171#21360
        Enabled = False
        TabOrder = 1
        OnClick = btnprintClick
      end
    end
    object pgcquery: TPageControl
      Left = 0
      Top = 0
      Width = 756
      Height = 265
      ActivePage = tsscan
      Align = alTop
      TabOrder = 1
      OnChange = pgcqueryChange
      object tsscan: TTabSheet
        Caption = #25195#25551#36523#20221#35777'('#24038#21491#38190#20999#25442')'
        object pnlidinfo: TPanel
          Left = 0
          Top = 0
          Width = 514
          Height = 234
          Align = alLeft
          BevelOuter = bvLowered
          TabOrder = 0
          object lbl1: TLabel
            Left = 236
            Top = 46
            Width = 38
            Height = 15
            Caption = #27665' '#26063
          end
          object lbl4: TLabel
            Left = 18
            Top = 18
            Width = 38
            Height = 15
            Caption = #22995' '#21517
          end
          object lbl5: TLabel
            Left = 236
            Top = 19
            Width = 38
            Height = 15
            Caption = #24615' '#21035
          end
          object lbl6: TLabel
            Left = 18
            Top = 45
            Width = 38
            Height = 15
            Caption = #20986' '#29983
          end
          object lbl7: TLabel
            Left = 18
            Top = 74
            Width = 38
            Height = 15
            Caption = #20303' '#22336
          end
          object lbl8: TLabel
            Left = 16
            Top = 102
            Width = 105
            Height = 15
            Caption = #20844#27665#36523#20221#35777#21495#30721
          end
          object lbl9: TLabel
            Left = 18
            Top = 160
            Width = 60
            Height = 15
            Caption = #26377#25928#26399#38480
          end
          object lbl10: TLabel
            Left = 18
            Top = 130
            Width = 60
            Height = 15
            Caption = #31614#21457#26426#20851
          end
          object lbl11: TLabel
            Left = 18
            Top = 190
            Width = 60
            Height = 15
            Caption = #26368#26032#20303#22336
            Visible = False
          end
          object edtName: TEdit
            Left = 64
            Top = 15
            Width = 133
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 0
          end
          object edtSex: TEdit
            Left = 282
            Top = 16
            Width = 103
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 1
          end
          object edtBday: TEdit
            Left = 64
            Top = 42
            Width = 133
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 2
          end
          object edtAddr: TEdit
            Left = 64
            Top = 72
            Width = 321
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 3
          end
          object edtMZ: TEdit
            Left = 282
            Top = 43
            Width = 103
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 4
          end
          object edtID: TEdit
            Left = 128
            Top = 99
            Width = 257
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeMode = imClose
            ParentCtl3D = False
            TabOrder = 5
          end
          object edtDep: TEdit
            Left = 88
            Top = 128
            Width = 297
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 6
          end
          object edtVld: TEdit
            Left = 88
            Top = 158
            Width = 297
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 7
          end
          object edtNewAddr: TEdit
            Left = 88
            Top = 187
            Width = 297
            Height = 21
            TabStop = False
            Ctl3D = False
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#26234#33021' ABC'
            ParentCtl3D = False
            TabOrder = 8
            Visible = False
          end
          object pnl2: TPanel
            Left = 402
            Top = 15
            Width = 106
            Height = 120
            BevelOuter = bvLowered
            Ctl3D = True
            ParentCtl3D = False
            TabOrder = 9
            object img1: TImage
              Left = 1
              Top = 1
              Width = 104
              Height = 118
              Align = alClient
              AutoSize = True
            end
          end
        end
        object mmo1: TMemo
          Left = 514
          Top = 0
          Width = 234
          Height = 234
          Align = alClient
          Lines.Strings = (
            'mmo1')
          ReadOnly = True
          TabOrder = 1
        end
      end
      object tsinput: TTabSheet
        Caption = #36755#20837#35746#21333#21495#12289#25163#26426#21495
        ImageIndex = 1
        object lbledtorderno: TLabeledEdit
          Left = 63
          Top = 14
          Width = 172
          Height = 23
          CharCase = ecUpperCase
          EditLabel.Width = 45
          EditLabel.Height = 15
          EditLabel.Caption = #35746#21333#21495
          LabelPosition = lpLeft
          TabOrder = 0
          OnKeyPress = lbledtordernoKeyPress
        end
        object btnquey: TBitBtn
          Left = 529
          Top = 15
          Width = 82
          Height = 22
          Caption = '&F.'#26597#35810
          TabOrder = 1
          OnClick = btnqueyClick
        end
        object lbledttelno: TLabeledEdit
          Left = 346
          Top = 14
          Width = 138
          Height = 23
          EditLabel.Width = 90
          EditLabel.Height = 15
          EditLabel.Caption = #20056#36710#20154#25163#26426#21495
          LabelPosition = lpLeft
          TabOrder = 2
          OnKeyPress = lbledtordernoKeyPress
        end
      end
      object tsidcardinput: TTabSheet
        Caption = #36755#20837#36523#20221#35777
        ImageIndex = 2
        object lbl12: TLabel
          Left = 20
          Top = 22
          Width = 105
          Height = 15
          Caption = #20844#27665#36523#20221#35777#21495#30721
        end
        object edtidcardinput: TEdit
          Left = 132
          Top = 19
          Width = 257
          Height = 21
          TabStop = False
          Ctl3D = False
          ImeMode = imClose
          ParentCtl3D = False
          TabOrder = 0
          OnKeyPress = edtIDKeyPress
        end
        object btnquerybyidno: TBitBtn
          Left = 529
          Top = 18
          Width = 82
          Height = 22
          Caption = '&F.'#26597#35810
          TabOrder = 1
          OnClick = btnquerybyidnoClick
        end
      end
      object tspasswordinput: TTabSheet
        Caption = #21462#31080#23494#30721#21462#31080
        ImageIndex = 3
        object lbledtpassword: TLabeledEdit
          Left = 93
          Top = 14
          Width = 172
          Height = 23
          EditLabel.Width = 90
          EditLabel.Height = 15
          EditLabel.Caption = #30005#23376#31080#26657#39564#30721
          LabelPosition = lpLeft
          TabOrder = 0
          OnKeyPress = lbledtpasswordKeyPress
        end
        object btnquerybypassword: TBitBtn
          Left = 279
          Top = 13
          Width = 82
          Height = 22
          Caption = #26597#35810
          TabOrder = 1
          OnClick = btnquerybypasswordClick
        end
      end
      object tstianyacode: TTabSheet
        Caption = 'F5.'#22825#38597#20108#32500#30721#25195#25551
        ImageIndex = 4
        object btnstartscan: TButton
          Left = 0
          Top = 0
          Width = 748
          Height = 34
          Align = alTop
          Caption = 'F12.'#24320#22987#25195#25551
          Enabled = False
          TabOrder = 0
          OnClick = btnstartscanClick
        end
        object pnlview: TPanel
          Left = 0
          Top = 34
          Width = 320
          Height = 200
          Align = alLeft
          BevelOuter = bvLowered
          TabOrder = 1
        end
        object mmo2: TMemo
          Left = 320
          Top = 34
          Width = 428
          Height = 200
          Align = alClient
          Lines.Strings = (
            'mmo1')
          ReadOnly = True
          TabOrder = 2
        end
      end
    end
  end
  object grpticketno: TGroupBox
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 747
    Height = 39
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 9
    Margins.Bottom = 0
    Align = alTop
    Caption = #24403#21069#31080#21495
    TabOrder = 1
    object lblticketno: TLabel
      Left = 2
      Top = 17
      Width = 120
      Height = 20
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
    end
    object lbl2: TLabel
      Left = 244
      Top = 17
      Width = 15
      Height = 20
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
    object lbl3: TLabel
      Left = 122
      Top = 17
      Width = 14
      Height = 20
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
      Top = 17
      Width = 108
      Height = 20
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
  object tmrleaveticketnum: TTimer
    Enabled = False
    OnTimer = tmrleaveticketnumTimer
    Left = 616
    Top = 192
  end
  object tmrRefreshBill: TTimer
    OnTimer = tmrRefreshBillTimer
    Left = 544
    Top = 256
  end
  object jcdsResult: TjsonClientDataSet
    DataSourceName = 'eticketinfo'
    QueryAddress = 'sell/findETicketByCustomer'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'idcardno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'orderno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'mobilephone'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'eticketno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'epassword'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 224
    Top = 232
  end
  object jcdstaketicket: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'sell/takeTicket'
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
        DataType = ftWideString
        Name = 'tsoid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'takeway'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'ticketsellid'
        ParamType = ptOutput
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
    Left = 408
    Top = 208
  end
  object tmrreadidcard: TTimer
    Enabled = False
    Left = 300
    Top = 128
  end
  object ds1: TDataSource
    DataSet = jcdsResult
    OnDataChange = ds1DataChange
    Left = 128
    Top = 360
  end
  object jcds1: TjsonClientDataSet
    DataSourceName = 'eticketinfo'
    QueryAddress = 'sell/findETicket'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'eticketno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'epassword'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 104
    Top = 184
  end
end
