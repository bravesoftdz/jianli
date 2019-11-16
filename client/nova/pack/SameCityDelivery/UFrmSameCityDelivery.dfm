inherited FrmSameCityDeliveryForm: TFrmSameCityDeliveryForm
  Caption = #21516#22478#36865#36135
  ClientHeight = 449
  ClientWidth = 979
  ExplicitWidth = 995
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 979
    ExplicitWidth = 979
    object Label2: TLabel
      Left = 7
      Top = 22
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object Label3: TLabel
      Left = 205
      Top = 22
      Width = 56
      Height = 14
      Caption = #36865#36135#21333#21495
    end
    object lbl4: TLabel
      Left = 406
      Top = 22
      Width = 56
      Height = 14
      Caption = #20986#24211#26102#38388
    end
    object lbl3: TLabel
      Left = 590
      Top = 22
      Width = 14
      Height = 14
      Caption = #33267
    end
    object Label1: TLabel
      Left = 749
      Top = 22
      Width = 42
      Height = 14
      Caption = #20986#24211#20154
    end
    object nvcbborg: TNovaCheckedComboBox
      Left = 68
      Top = 18
      Width = 120
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryuserorgright'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvedtdiliveno: TNovaEdit
      Left = 267
      Top = 18
      Width = 120
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      MaxLength = 20
      ParentFont = False
      TabOrder = 1
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
    object outstartdate: TDateTimePicker
      Left = 468
      Top = 18
      Width = 111
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 2
    end
    object outenddate: TDateTimePicker
      Left = 617
      Top = 18
      Width = 111
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 3
    end
    object nvhlpoutbound: TNovaHelp
      Left = 797
      Top = 18
      Width = 120
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
      HelpOptions.HelpHeight = 100
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
    Width = 979
    ExplicitWidth = 979
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      Visible = False
    end
    inherited tbtnEdit: TToolButton
      OnClick = tbtnEditClick
    end
    inherited tbtnDelete: TToolButton
      OnClick = tbtnDeleteClick
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
    Width = 979
    Height = 346
    ExplicitWidth = 979
    ExplicitHeight = 346
    inherited GroupBox1: TGroupBox
      Width = 696
      Height = 346
      ExplicitWidth = 696
      ExplicitHeight = 346
      inherited dbgrdhResult: TNvDbgridEh
        Width = 692
        Height = 328
        FooterRowCount = 1
        ImeMode = imDisable
        ImeName = ''
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
            FieldName = 'packid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'diliveno'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #36865#36135#21333#21495
            Width = 120
          end
          item
            EditButtons = <>
            FieldName = 'outbound'
            Footers = <>
            Title.Caption = #20986#24211#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'outdate'
            Footers = <>
            Title.Caption = #20986#24211#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'dilivername'
            Footers = <>
            Title.Caption = #36865#36135#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'diliver'
            Footers = <>
            Title.Caption = #36865#36135#20154
            Visible = False
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'dilivedate'
            Footers = <>
            Title.Caption = #36865#36135#26085#26399
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'deliveryfee'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #36865#36135#36153' '
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 90
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
            FieldName = 'updateby'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 90
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
    object GroupBox2: TGroupBox
      Left = 696
      Top = 0
      Width = 283
      Height = 346
      Align = alRight
      Caption = #21516#22478#36865#36135#20449#24687#35814#32454
      TabOrder = 1
      object DBGridDetail: TDBGridEh
        Left = 2
        Top = 45
        Width = 279
        Height = 299
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = dsDetailResult
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        ImeMode = imDisable
        ReadOnly = True
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'packid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'packdiliveryid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'packno'
            Footers = <>
            ReadOnly = False
            Title.Caption = #34892#21253#21333#21495
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'weight'
            Footers = <>
            ReadOnly = False
            Title.Caption = #37325#37327
          end
          item
            EditButtons = <>
            FieldName = 'deliveryfee'
            Footers = <>
            ReadOnly = False
            Title.Caption = #36865#36135#26381#21153#36153
            Width = 100
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object ToolBar1: TToolBar
        Left = 2
        Top = 16
        Width = 279
        Height = 29
        ButtonHeight = 30
        ButtonWidth = 31
        Caption = 'ToolBar1'
        Images = ilToolBar
        TabOrder = 1
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'ToolButton6'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object TbtnAdd: TToolButton
          Left = 8
          Top = 0
          Hint = #28155#21152
          Caption = 'ToolButton1'
          ImageIndex = 8
          ParentShowHint = False
          ShowHint = True
          OnClick = TbtnAddClick
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 112
    Top = 240
  end
  inherited ilToolBarDisable: TImageList
    Left = 176
    Top = 224
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'packdiliverylist'
    QueryAddress = 'packdilivery/listPackDilivery'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_pd!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_GED_pd!outdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LED_pd!outdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQL_pd!outbound'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_pd!diliveno'
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
      end>
    AfterScroll = jcdsResultAfterScroll
    Left = 240
    Top = 272
  end
  inherited dsResult: TDataSource
    Left = 24
    Top = 200
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 312
    Top = 280
  end
  object jsondelpackdilivery: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'packdilivery/delPackDilivery'
    SaveAddress = 'packdilivery/delPackDilivery'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packdilivery.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 460
    Top = 296
  end
  object dsDetailResult: TDataSource
    DataSet = packdiliverydetaillist
    Left = 800
    Top = 360
  end
  object packdiliverydetaillist: TjsonClientDataSet
    DataSourceName = 'packdiliverydetaillist'
    QueryAddress = 'packdiliverydetail/listPackDiliveryDetailByPackdiliveryId'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_pdd!packdiliveryid'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 816
    Top = 272
  end
  object pacdiliverydetailprint: TjsonClientDataSet
    DataSourceName = 'packdiliverydetaillist'
    QueryAddress = 'packdiliverydetail/listPackDiliveryDetailPrint'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'filter_EQL_pdd!packdiliveryid'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 760
    Top = 232
  end
end
