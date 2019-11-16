inherited FrmTicketoutlet: TFrmTicketoutlet
  Caption = #21806#31080#28857#31649#29702
  ClientHeight = 468
  ClientWidth = 873
  OldCreateOrder = False
  ExplicitWidth = 889
  ExplicitHeight = 506
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 873
    Height = 87
    ExplicitWidth = 865
    ExplicitHeight = 87
    object lbl3: TLabel
      Left = 39
      Top = 56
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object lbl5: TLabel
      Left = 248
      Top = 56
      Width = 28
      Height = 14
      Caption = #32534#30721
    end
    object lbl1: TLabel
      Left = 221
      Top = 21
      Width = 56
      Height = 14
      Caption = #25152#23646#21306#22495
    end
    object lbl4: TLabel
      Left = 11
      Top = 21
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl2: TLabel
      Left = 428
      Top = 57
      Width = 28
      Height = 14
      Caption = #31616#25340
    end
    object edt_code: TNovaEdit
      Left = 288
      Top = 53
      Width = 130
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 30
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
    end
    object edt_name: TNovaEdit
      Left = 75
      Top = 53
      Width = 130
      Height = 22
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 30
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
    object nvhlpdistrictid: TNovaHelp
      Left = 287
      Top = 18
      Width = 128
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21306#22495
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'DistrictHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edtjianpin: TNovaEdit
      Left = 466
      Top = 53
      Width = 130
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      MaxLength = 30
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
    object cbborg: TNovaCheckedComboBox
      Left = 75
      Top = 18
      Width = 130
      Height = 22
      ColorNotFocus = clWhite
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/queryhelpcombox'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 873
    ExplicitWidth = 865
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
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
    inherited tbtn4: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 132
    Width = 873
    Height = 336
    ExplicitTop = 132
    ExplicitWidth = 865
    ExplicitHeight = 336
    inherited GroupBox1: TGroupBox
      Width = 873
      Height = 336
      ExplicitWidth = 865
      ExplicitHeight = 336
      inherited dbgrdhResult: TNvDbgridEh
        Width = 869
        Height = 318
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
            FieldName = 'name'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #21517#31216
            Width = 97
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #32534#30721
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'dictype'
            Footers = <>
            Title.Caption = #31867#22411
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'jianpin'
            Footers = <>
            Title.Caption = #31616#25340
            Width = 80
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 102
          end
          item
            EditButtons = <>
            FieldName = 'districtname'
            Footers = <>
            Title.Caption = #25152#23646#21306#22495
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'startstationname'
            Footers = <>
            Title.Caption = #23545#24212#21457#36710#31449#28857
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'dicgrade'
            Footers = <>
            Title.Caption = #32423#21035
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'isprint'
            Footers = <>
            Title.Caption = #21333#29420#25171#21360#32467#31639#21333
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'contactperson'
            Footers = <>
            Title.Caption = #32852#31995#20154
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'contactphone'
            Footers = <>
            Title.Caption = #32852#31995#20154#30005#35805
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'address'
            Footers = <>
            Title.Caption = #22320#22336
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'grade'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'type'
            Footers = <>
            Visible = False
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
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 176
    Top = 288
  end
  inherited ilToolBarDisable: TImageList
    Left = 304
    Top = 288
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'ticketoutletmap'
    QueryAddress = 'base/listticketoutlet'
    SaveAddress = 'base/listticketoutlet'
    Params = <
      item
        DataType = ftString
        Name = 'filter_LIKES_s!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!code'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_s!jianpin'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'flag'
        ParamType = ptOutput
        Value = 0.000000000000000000
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Value = 'null'
      end
      item
        DataType = ftString
        Name = 'filter_EQL_s!districtid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_s!orgid'
        ParamType = ptInput
      end>
    Left = 120
    Top = 288
  end
  inherited dsResult: TDataSource
    Left = 72
    Top = 288
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 240
    Top = 288
  end
  object jsonCDSDelTicketoutlet: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'base/listticketoutlet'
    SaveAddress = 'base/delteticketoutlet'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'ticketoutlet.id'
        ParamType = ptInput
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
    Left = 376
    Top = 288
  end
end
