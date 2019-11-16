inherited FrmPrintTemplateAdd: TFrmPrintTemplateAdd
  Caption = 'FrmPrintTemplateAdd'
  ClientHeight = 433
  ClientWidth = 587
  Font.Charset = ANSI_CHARSET
  ShowHint = True
  OnCreate = FormCreate
  ExplicitWidth = 593
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 587
    Height = 388
    ExplicitWidth = 587
    ExplicitHeight = 388
    DesignSize = (
      587
      388)
    inherited Bevel1: TBevel
      Top = 380
      Width = 553
      ExplicitTop = 342
      ExplicitWidth = 538
    end
    object lbltemplatetype: TLabel
      Left = 64
      Top = 33
      Width = 56
      Height = 14
      Caption = #27169#26495#31867#22411
    end
    object lblname: TLabel
      Left = 64
      Top = 79
      Width = 56
      Height = 14
      Caption = #27169#26495#21517#31216
    end
    object lblheight: TLabel
      Left = 377
      Top = 33
      Width = 28
      Height = 14
      Hint = #21333#20301#65306'0.1'#27627#31859
      Caption = #39640#24230
    end
    object lblheightcorrection: TLabel
      Left = 349
      Top = 78
      Width = 56
      Height = 14
      Hint = #21333#20301#65306'0.1'#27627#31859
      Caption = #39640#24230#20462#27491
    end
    object lblwidth: TLabel
      Left = 377
      Top = 123
      Width = 28
      Height = 14
      Hint = #21333#20301#65306'0.1'#27627#31859
      Caption = #23485#24230
    end
    object lblleft: TLabel
      Left = 377
      Top = 169
      Width = 28
      Height = 14
      Hint = #21333#20301#65306'0.1'#27627#31859
      Caption = #36317#24038
    end
    object lbltop: TLabel
      Left = 377
      Top = 214
      Width = 28
      Height = 14
      Hint = #21333#20301#65306'0.1'#27627#31859
      Caption = #36317#39030
    end
    object lblbackgroundimage: TLabel
      Left = 78
      Top = 306
      Width = 42
      Height = 14
      Caption = #32972#26223#22270
    end
    object lblrowspace: TLabel
      Left = 51
      Top = 169
      Width = 70
      Height = 14
      Caption = #25968#25454#38598#34892#36317
    end
    object lblprintername: TLabel
      Left = 78
      Top = 260
      Width = 42
      Height = 14
      Caption = #25171#21360#26426
    end
    object lblcolumnsperpage: TLabel
      Left = 22
      Top = 215
      Width = 98
      Height = 14
      Caption = #25968#25454#38598#25171#21360#21015#25968
    end
    object lblimagepath: TLabel
      Left = 156
      Top = 306
      Width = 182
      Height = 14
      Caption = 'image\ticketbackground.jpg'
    end
    object lbl1: TLabel
      Left = 306
      Top = 34
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 306
      Top = 78
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 306
      Top = 123
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 306
      Top = 214
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 546
      Top = 34
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 546
      Top = 78
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 546
      Top = 123
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 546
      Top = 169
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 546
      Top = 214
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblrowperpage: TLabel
      Left = 22
      Top = 124
      Width = 98
      Height = 14
      Caption = #25968#25454#38598#25171#21360#34892#25968
    end
    object lbl10: TLabel
      Left = 306
      Top = 169
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Nvhcbbtemplatetype: TNovaHComboBox
      Left = 129
      Top = 29
      Width = 170
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
      HelpOptions.HDataSourceName = 'printtemplatetypelist'
      HelpOptions.HQueryAddress = 'system/queryPrinttemplatetype'
      HelpOptions.displayFieldname = 'name'
      Params = <>
    end
    object nvedtname: TNovaEdit
      Left = 129
      Top = 74
      Width = 170
      Height = 22
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
    object nvedtheight: TNovaEdit
      Left = 416
      Top = 29
      Width = 121
      Height = 22
      Hint = #21333#20301#65306'0.1'#27627#31859
      MaxLength = 5
      TabOrder = 6
      Text = '1000'
      ValueTrim = '1000'
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
    object nvedtheightcorrection: TNovaEdit
      Left = 416
      Top = 74
      Width = 121
      Height = 22
      Hint = #21333#20301#65306'0.1'#27627#31859
      MaxLength = 5
      TabOrder = 7
      Text = '1000'
      ValueTrim = '1000'
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
    object nvedtwidth: TNovaEdit
      Left = 416
      Top = 119
      Width = 121
      Height = 22
      Hint = #21333#20301#65306'0.1'#27627#31859
      MaxLength = 5
      TabOrder = 8
      Text = '1000'
      ValueTrim = '1000'
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
    object nvedtleft: TNovaEdit
      Left = 416
      Top = 165
      Width = 121
      Height = 22
      Hint = #21333#20301#65306'0.1'#27627#31859
      MaxLength = 5
      TabOrder = 9
      Text = '0'
      ValueTrim = '0'
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
    object nvedttop: TNovaEdit
      Left = 416
      Top = 210
      Width = 121
      Height = 22
      Hint = #21333#20301#65306'0.1'#27627#31859
      MaxLength = 5
      TabOrder = 10
      Text = '0'
      ValueTrim = '0'
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
    object btnbackgroundimage: TButton
      Left = 129
      Top = 300
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 11
      OnClick = btnbackgroundimageClick
    end
    object nvedtrowspace: TNovaEdit
      Left = 129
      Top = 164
      Width = 170
      Height = 22
      MaxLength = 5
      TabOrder = 3
      Text = '50'
      ValueTrim = '50'
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
    object nvcbbprintername: TNovaComboBox
      Left = 129
      Top = 255
      Width = 170
      Height = 22
      ImeMode = imClose
      TabOrder = 5
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
    object nvedtcolumnsperpage: TNovaEdit
      Left = 129
      Top = 210
      Width = 170
      Height = 22
      MaxLength = 2
      TabOrder = 4
      Text = '1'
      ValueTrim = '1'
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
    object cbgeneratedetail: TCheckBox
      Left = 129
      Top = 348
      Width = 228
      Height = 17
      Caption = #26681#25454#27169#26495#31867#22411#33258#21160#29983#25104#25171#21360#39033#30446
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object nvedtrowperpage: TNovaEdit
      Left = 129
      Top = 119
      Width = 170
      Height = 22
      MaxLength = 2
      TabOrder = 2
      Text = '5'
      ValueTrim = '5'
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
    object ChkAutoPages: TCheckBox
      Left = 416
      Top = 258
      Width = 228
      Height = 17
      Caption = #25968#25454#38598#33258#21160#36208#32440
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
  end
  inherited pnlOperation: TPanel
    Top = 388
    Width = 587
    ExplicitTop = 388
    ExplicitWidth = 587
    inherited bbtnSave: TBitBtn
      Left = 176
      OnClick = bbtnSaveClick
      ExplicitLeft = 176
    end
    inherited bbtnClose: TBitBtn
      Left = 313
      ExplicitLeft = 313
    end
  end
  object jcdsSavePrinttemplate: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'system/savePrinttemplate'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'autoGenerateItem'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.printtemplatetypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.height'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.heightcorrection'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.width'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.left'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.top'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.backgroundimage'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.rowspace'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.rowperpage'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.printername'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.columnsperpage'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'printtemplate.autopages'
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
      end
      item
        DataType = ftLargeint
        Name = 'operationid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 392
    Top = 280
  end
  object dlgOpenPic: TOpenPictureDialog
    Left = 328
    Top = 200
  end
end
