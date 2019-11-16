inherited FrmSeatstatuspictureEdit: TFrmSeatstatuspictureEdit
  Caption = #40664#35748#24231#20301#29366#24577#22270#29255
  ClientHeight = 288
  ClientWidth = 383
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 389
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 383
    Height = 243
    ExplicitWidth = 383
    ExplicitHeight = 243
    inherited Bevel1: TBevel
      Top = 235
      Width = 349
      ExplicitTop = 321
      ExplicitWidth = 461
    end
    object lblseatstatus: TLabel
      Left = 57
      Top = 38
      Width = 70
      Height = 14
      Caption = #24231#20301#22270#29366#24577
    end
    object lbl1: TLabel
      Left = 283
      Top = 38
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object Label1: TLabel
      Left = 99
      Top = 77
      Width = 28
      Height = 14
      Caption = #22270#29255
    end
    object lbl2: TLabel
      Left = 293
      Top = 77
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = False
    end
    object cbbseatstatus: TNovaComboBox
      Left = 133
      Top = 35
      Width = 145
      Height = 22
      Style = csDropDownList
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'scheduleseats'
      HelpOptions.Columnname = 'status'
    end
    object pnlpicture: TPanel
      Left = 133
      Top = 74
      Width = 157
      Height = 111
      BevelKind = bkFlat
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 1
      object imgpicture: TImage
        Left = 1
        Top = 1
        Width = 151
        Height = 105
        Align = alClient
        PopupMenu = pmpicture
        OnDblClick = imgpictureDblClick
        ExplicitWidth = 208
        ExplicitHeight = 176
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 243
    Width = 383
    ExplicitTop = 243
    ExplicitWidth = 383
    inherited bbtnSave: TBitBtn
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitTop = 6
    end
  end
  object dlgOpenPic: TOpenPictureDialog
    Left = 236
    Top = 184
  end
  object pmpicture: TPopupMenu
    Left = 296
    Top = 184
    object N1: TMenuItem
      Caption = #36873#25321#22270#29255
      OnClick = imgpictureDblClick
    end
    object N2: TMenuItem
      Caption = #28165#31354#22270#29255
      OnClick = N2Click
    end
  end
  object jsonCDSSeatstatuspictureSave: TjsonClientDataSet
    DataSourceName = 'seatstatuspicturelist'
    QueryAddress = 'base/qryseatstatuspicture'
    SaveAddress = 'base/saveseatstatuspicture'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'seatstatuspicture.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatstatuspicture.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatstatuspicture.islocaldelete'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatstatuspicture.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatstatuspicture.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatstatuspicture.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'seatstatuspicture.seatstatus'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'picture'
        ParamType = ptInput
      end
      item
        DataType = ftLongWord
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 152
    Top = 192
  end
end
