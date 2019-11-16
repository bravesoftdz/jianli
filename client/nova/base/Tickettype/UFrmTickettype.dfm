inherited FrmTickettype: TFrmTickettype
  Caption = #31080#31181#31649#29702
  ClientHeight = 460
  ClientWidth = 901
  Font.Charset = GB2312_CHARSET
  OldCreateOrder = False
  ExplicitWidth = 917
  ExplicitHeight = 498
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 901
    Height = 69
    ExplicitWidth = 901
    ExplicitHeight = 69
    object lbl3: TLabel
      Left = 12
      Top = 28
      Width = 56
      Height = 14
      Caption = #31080#31181#21517#31216
    end
    object lbl5: TLabel
      Left = 218
      Top = 29
      Width = 56
      Height = 14
      Caption = #31080#31181#20195#30721
    end
    object rb_isdefault: TRadioButton
      Left = 519
      Top = 24
      Width = 90
      Height = 17
      Caption = #40664#35748#31080#31181
      TabOrder = 0
    end
    object rball: TRadioButton
      Left = 435
      Top = 24
      Width = 78
      Height = 17
      Caption = #20840#37096#31080#31181
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object edt_name: TNovaEdit
      Left = 76
      Top = 24
      Width = 121
      Height = 22
      MaxLength = 10
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
    object edt_code: TNovaEdit
      Left = 288
      Top = 24
      Width = 121
      Height = 22
      CharCase = ecUpperCase
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
  end
  inherited tlbShortCut: TToolBar
    Width = 901
    ExplicitWidth = 901
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
      Caption = #19978#31227
      ImageIndex = 9
      OnClick = tbtnSaveClick
    end
    inherited tbtnCancel: TToolButton
      Caption = #19979#31227
      ImageIndex = 10
      OnClick = tbtnCancelClick
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtnExcel: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 114
    Width = 901
    Height = 346
    ExplicitTop = 114
    ExplicitWidth = 901
    ExplicitHeight = 346
    inherited GroupBox1: TGroupBox
      Width = 901
      Height = 346
      ExplicitWidth = 901
      ExplicitHeight = 346
      inherited dbgrdhResult: TNvDbgridEh
        Width = 897
        Height = 328
        DrawGraphicData = True
        DrawMemoText = True
        FooterFont.Charset = GB2312_CHARSET
        FooterRowCount = 1
        ImeMode = imDisable
        RowHeight = 40
        SumList.Active = True
        TitleFont.Charset = GB2312_CHARSET
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'orderno'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #26174#31034#24207#21495
            Width = 67
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #31080#31181#21517#31216
            Width = 75
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #31080#31181#20195#30721
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'soldpicture'
            Footers = <>
            Title.Caption = #26174#31034#22270#26631
            Width = 90
            OnAdvDrawDataCell = dbgrdhResultColumns11AdvDrawDataCell
          end
          item
            EditButtons = <>
            FieldName = 'printname'
            Footers = <>
            Title.Caption = #25171#21360#21517#31216
            Width = 72
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isdefault'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#40664#35748#31080#31181
            Width = 100
          end
          item
            Checkboxes = True
            EditButtons = <>
            FieldName = 'isscore'
            Footers = <>
            KeyList.Strings = (
              'true'
              'false')
            Title.Caption = #26159#21542#21442#19982#31215#20998
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 150
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 150
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 312
    Top = 200
  end
  inherited ilToolBarDisable: TImageList
    Left = 544
    Top = 200
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'tickettypemap'
    QueryAddress = 'base/querytickettype'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_t!orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQB_t!isdefault'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_t!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_t!code'
        ParamType = ptInput
      end>
    Left = 248
    Top = 168
  end
  inherited dsResult: TDataSource
    Left = 184
    Top = 208
  end
  inherited prntdbgrdhResult: TNvPrintDBGridEh
    Left = 448
    Top = 200
  end
  object jsonCDSDelTickettype: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'base/deltickettype'
    SaveAddress = 'base/deltickettype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'tickettype.id'
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
    Left = 368
    Top = 280
  end
  object jcdsPrior: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/priortickettype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tickettype.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tickettype.updateby'
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
    Left = 120
    Top = 168
  end
  object jcdsNext: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'base/nexttickettype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tickettype.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'tickettype.updateby'
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
    Left = 112
    Top = 232
  end
end
