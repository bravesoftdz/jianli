inherited FrmCarryControl: TFrmCarryControl
  Caption = #36827#20301#35268#21017#31649#29702
  ClientHeight = 396
  ClientWidth = 768
  OnCreate = FormCreate
  ExplicitWidth = 776
  ExplicitHeight = 423
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 768
    Height = 44
    ExplicitTop = 45
    ExplicitWidth = 768
    ExplicitHeight = 44
    object lbl: TLabel
      Left = 12
      Top = 22
      Width = 66
      Height = 14
      AutoSize = False
      Caption = #24212#29992#27169#22359
    end
    object Nvcbbdescribe: TNovaHComboBox
      Left = 73
      Top = 16
      Width = 145
      Height = 22
      Style = csOwnerDrawFixed
      ImeMode = imClose
      TabOrder = 0
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'helpType'
          ParamType = ptInput
          Value = 'CarryHelp'
        end>
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 768
    ExplicitWidth = 768
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtn1: TToolButton
      Visible = False
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
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited tbtnInfo: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 89
    Width = 768
    Height = 307
    ExplicitTop = 89
    ExplicitWidth = 768
    ExplicitHeight = 307
    inherited GroupBox1: TGroupBox
      Width = 768
      Height = 307
      Caption = #35814#32454#20449#24687
      ExplicitWidth = 768
      ExplicitHeight = 307
      inherited dbgrdhResult: TNvDbgridEh
        Top = 16
        Width = 764
        Height = 289
        ImeMode = imDisable
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'describe'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #24212#29992#27169#22359
            Width = 100
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'formula'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36827#20301#35268#21017
            Width = 400
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20462#25913#26102#38388
            Width = 140
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20462#25913#20154
            Width = 80
          end>
      end
    end
  end
  inherited ilToolBar: TImageList
    Top = 184
  end
  inherited ilToolBarDisable: TImageList
    Top = 184
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'carrymap'
    QueryAddress = 'system/qrycarry'
    Params = <
      item
        DataType = ftLongWord
        Name = 'carrycontrol.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'carrycontrol.modulecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'carrycontrol.describe'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'carrycontrol.formula'
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
    Left = 88
    Top = 136
    object jcdsReultid: TLargeintField
      FieldName = 'id'
    end
    object jcdsReultmodulecode: TWideStringField
      FieldName = 'modulecode'
    end
    object jcdsReultdescribe: TWideStringField
      FieldName = 'describe'
      Size = 100
    end
    object jcdsReultformula: TWideStringField
      FieldName = 'formula'
      Size = 500
    end
    object jcdsReultname: TWideStringField
      FieldName = 'name'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
  end
  inherited dsResult: TDataSource
    Top = 184
  end
  object jcdsCarryControlDel: TjsonClientDataSet
    DataSourceName = 'carrymap'
    SaveAddress = 'system/deletecarry'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'carrycontrol.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftLongWord
        Name = 'flag'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 176
    Top = 144
    object jcdsCarryControlDelid: TLargeintField
      FieldName = 'id'
    end
    object jcdsCarryControlDelmodulecode: TWideStringField
      FieldName = 'modulecode'
    end
    object jcdsCarryControlDeldescribe: TWideStringField
      FieldName = 'describe'
      Size = 100
    end
    object jcdsCarryControlDelformula: TWideStringField
      FieldName = 'formula'
      Size = 500
    end
  end
end
