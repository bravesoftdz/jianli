inherited FrmBalanceEdit: TFrmBalanceEdit
  Caption = 'FrmBalanceEdit'
  ClientHeight = 471
  ClientWidth = 1122
  OnCreate = FormCreate
  ExplicitWidth = 1128
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 1122
    Height = 408
    ExplicitWidth = 1122
    ExplicitHeight = 408
    inherited Bevel1: TBevel
      Left = 0
      Top = 384
      Width = 1136
      ExplicitLeft = 0
      ExplicitTop = 384
      ExplicitWidth = 1185
    end
    object lbl6: TLabel
      Left = 38
      Top = 25
      Width = 56
      Height = 14
      Caption = #21457#36710#26085#26399
    end
    object Label1: TLabel
      Left = 264
      Top = 25
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#21495
    end
    object Label2: TLabel
      Left = 280
      Top = 65
      Width = 42
      Height = 14
      Caption = #29677#27425#21495
    end
    object Label3: TLabel
      Left = 38
      Top = 65
      Width = 56
      Height = 14
      Caption = #21457#36710#26102#38388
    end
    object Label4: TLabel
      Left = 36
      Top = 147
      Width = 56
      Height = 14
      Caption = #32467#31639#21333#20301
    end
    object Label5: TLabel
      Left = 264
      Top = 105
      Width = 56
      Height = 14
      Caption = #33829#36816#21333#20301
    end
    object Label6: TLabel
      Left = 35
      Top = 105
      Width = 56
      Height = 14
      Caption = #33829#36816#36710#36742
    end
    object Label7: TLabel
      Left = 290
      Top = 147
      Width = 28
      Height = 14
      Caption = #20154#25968
    end
    object Label8: TLabel
      Left = 49
      Top = 186
      Width = 42
      Height = 14
      Caption = #24635#31080#20215
    end
    object Label9: TLabel
      Left = 262
      Top = 186
      Width = 56
      Height = 14
      Caption = #32467#31639#37329#39069
    end
    object Label10: TLabel
      Left = 276
      Top = 224
      Width = 42
      Height = 14
      Caption = #31449#21153#36153
    end
    object Label11: TLabel
      Left = 38
      Top = 325
      Width = 56
      Height = 14
      Caption = #20854#23427#25187#36153
    end
    object Label12: TLabel
      Left = 24
      Top = 224
      Width = 70
      Height = 14
      Caption = #23458#36816#20195#29702#36153
    end
    object Label13: TLabel
      Left = 276
      Top = 265
      Width = 42
      Height = 14
      Caption = #29123#27833#36153
    end
    object Label14: TLabel
      Left = 24
      Top = 288
      Width = 70
      Height = 14
      Caption = #23458#20195#36153#27604#20363
    end
    object lbl1: TLabel
      Left = 24
      Top = 260
      Width = 70
      Height = 14
      Caption = #23458#20195#36153#27169#24335
    end
    object dtpdepartdate: TDateTimePicker
      Left = 102
      Top = 22
      Width = 121
      Height = 22
      Date = 40704.448885451390000000
      Time = 40704.448885451390000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
    end
    object nvedtdepartinvoicesno: TNovaEdit
      Left = 329
      Top = 22
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    end
    object nvedtschedulecode: TNovaEdit
      Left = 329
      Top = 62
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    end
    object nvedtdeparttime: TNovaEdit
      Left = 102
      Top = 62
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    object nvedtbalanceunit: TNovaEdit
      Left = 98
      Top = 144
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 6
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
    object nvedtworkunit: TNovaEdit
      Left = 329
      Top = 102
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
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
    object nvedtvehiclename: TNovaEdit
      Left = 100
      Top = 102
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
    end
    object nvedtticketnum: TNovaEdit
      Left = 329
      Top = 144
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 7
      OnChange = nvedtticketnumChange
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
    object nvedttotalamount: TNovaEdit
      Left = 98
      Top = 184
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 8
      OnChange = nvedtstationservicefeeChange
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
    object nvedtbalanceamount: TNovaEdit
      Left = 329
      Top = 184
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 9
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
    object nvedtstationservicefee: TNovaEdit
      Left = 329
      Top = 221
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 10
      OnChange = nvedtstationservicefeeChange
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
    object nvedtagentfee: TNovaEdit
      Left = 99
      Top = 221
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 11
      OnChange = nvedtstationservicefeeChange
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
    object nvedtfueladditionfee: TNovaEdit
      Left = 329
      Top = 262
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 13
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
    object nvedtothterfee: TNovaEdit
      Left = 99
      Top = 319
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 12
      OnChange = nvedtstationservicefeeChange
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
    object grp1: TGroupBox
      Left = 488
      Top = 3
      Width = 625
      Height = 353
      Caption = #21806#31080#26126#32454
      TabOrder = 14
      object nvdbgrdhdbgrdh1: TNvDbgridEh
        Left = 2
        Top = 58
        Width = 621
        Height = 293
        Align = alClient
        ColumnDefValues.Title.TitleButton = True
        DataGrouping.GroupLevels = <>
        DataSource = DataSource2
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = GB2312_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeMode = imDisable
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ReadOnly = True
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
        ParentName = 'FrmOrganization'
        TitleAlign = taLeftJustify
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
            Width = 37
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isselect'
            Footers = <>
            ImeMode = imClose
            ReadOnly = False
            TextEditing = True
            Title.Caption = #36873#25321
            Visible = False
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'schedulename'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'typename'
            Footers = <>
            Title.Caption = #36710#31080#31867#22411
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'price'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #31080#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'seatno'
            Footers = <>
            Title.Caption = #24231#20301#21495
            Visible = False
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'fromstationname'
            Footers = <>
            Title.Caption = #19978#36710#31449
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'departinvoicesid'
            Footers = <>
            Visible = False
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'fromstationid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'reachstationid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'tickettype'
            Footers = <>
            Visible = False
          end>
        object RowDetailData: TRowDetailPanelControlEh
          object mmo: TMemo
            Left = -185
            Top = -89
            Width = 185
            Height = 89
            ImeName = #20013#25991' - QQ'#20116#31508#36755#20837#27861
            Lines.Strings = (
              'Memo1')
            TabOrder = 0
          end
        end
      end
      object tlb1: TToolBar
        Left = 2
        Top = 16
        Width = 621
        Height = 42
        ButtonHeight = 41
        ButtonWidth = 33
        Caption = 'tlb1'
        Images = ImageList
        TabOrder = 1
        object btnInsertDep: TToolButton
          Left = 0
          Top = 0
          Hint = #21076#38500#21806#31080#20449#24687
          Caption = 'ToolButton1'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          OnClick = btnInsertDepClick
        end
      end
    end
    object NovaEdit1: TNovaEdit
      Left = 98
      Top = 285
      Width = 121
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 50
      TabOrder = 15
      OnChange = NovaEdit1Change
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
    object cbborgNovachkStatus: TNovaComboBox
      Left = 98
      Top = 257
      Width = 121
      Height = 22
      ImeMode = imClose
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 16
      Text = #24635#31080#20215'-'#25152#26377#25187#36153
      Items.Strings = (
        #24635#31080#20215'-'#25152#26377#25187#36153
        #24635#31080#20215'-'#20854#20182#25187#36153
        #24635#31080#20215'-'#31449#21153#36153
        #24635#31080#20215'-'#29123#27833#36153)
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
    end
  end
  inherited pnlOperation: TPanel
    Top = 408
    Width = 1122
    Height = 63
    ExplicitTop = 408
    ExplicitWidth = 1122
    ExplicitHeight = 63
    inherited bbtnSave: TBitBtn
      Left = 410
      Top = 5
      OnClick = bbtnSaveClick
      ExplicitLeft = 410
      ExplicitTop = 5
    end
    inherited bbtnClose: TBitBtn
      Left = 519
      Top = 5
      ExplicitLeft = 519
      ExplicitTop = 5
    end
  end
  inherited ImageList: TImageList
    Left = 776
    Top = 216
  end
  object jcdsQrydepartinvoicesdetail: TjsonClientDataSet
    DataSourceName = 'invoicesdetailMap'
    QueryAddress = 'checkticket/qrydeailBydepartinvoicesid'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 912
    Top = 192
  end
  object DataSource2: TDataSource
    DataSet = jcdsQrydepartinvoicesdetail
    Left = 640
    Top = 144
  end
  object jcdsSavedepartinvoicesdetail: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'balance/editDepartinvoices'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketsellid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'fromstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'reachstationid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tickettype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'price'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'ticketnum'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'totalamount'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'balanceamount'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'agentfee'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'stationservicefee'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'othterfee'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'fueladditionfee'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 816
    Top = 128
  end
  object packno1: TjsonClientDataSet
    DataSourceName = 'agentfee'
    SaveAddress = 'balance/saveagentfee'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'departinvoicesid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'deductmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'balanceamount'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 240
    Top = 296
  end
end
