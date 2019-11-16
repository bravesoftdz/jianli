inherited FrmPrintTemplateItemAdd: TFrmPrintTemplateItemAdd
  Caption = 'FrmPrintTemplateItemAdd'
  ClientHeight = 530
  ClientWidth = 470
  Font.Charset = ANSI_CHARSET
  OnCreate = FormCreate
  ExplicitWidth = 476
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 470
    Height = 485
    ExplicitWidth = 470
    ExplicitHeight = 485
    inherited Bevel1: TBevel
      Left = 18
      Top = 481
      Width = 434
      ExplicitLeft = 18
      ExplicitTop = 300
      ExplicitWidth = 400
    end
    object lbltypeitem: TLabel
      Left = 44
      Top = 27
      Width = 42
      Height = 14
      Caption = #25968#25454#28304
    end
    object lblTitle: TLabel
      Left = 30
      Top = 70
      Width = 56
      Height = 14
      Caption = #26174#31034#26631#31614
    end
    object lblfontname: TLabel
      Left = 58
      Top = 200
      Width = 28
      Height = 14
      Caption = #23383#20307
    end
    object lblfontsize: TLabel
      Left = 30
      Top = 243
      Width = 56
      Height = 14
      Caption = #23383#20307#22823#23567
    end
    object lbltop: TLabel
      Left = 258
      Top = 27
      Width = 28
      Height = 14
      Caption = #36317#39030
    end
    object lblleft: TLabel
      Left = 258
      Top = 71
      Width = 28
      Height = 14
      Caption = #36317#24038
    end
    object lblwidth: TLabel
      Left = 272
      Top = 114
      Width = 14
      Height = 14
      Caption = #23485
    end
    object lblheight: TLabel
      Left = 272
      Top = 158
      Width = 14
      Height = 14
      Caption = #39640
    end
    object lblvaluetype: TLabel
      Left = 30
      Top = 113
      Width = 56
      Height = 14
      Caption = #25171#21360#31867#22411
    end
    object lblparameter: TLabel
      Left = 58
      Top = 157
      Width = 28
      Height = 14
      Caption = #21442#25968
      Visible = False
    end
    object lbl1: TLabel
      Left = 219
      Top = 28
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
      Left = 219
      Top = 70
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
      Left = 219
      Top = 113
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
    object lblparameterhint: TLabel
      Left = 219
      Top = 157
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbl5: TLabel
      Left = 219
      Top = 200
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
      Left = 219
      Top = 243
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
      Left = 421
      Top = 27
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
      Left = 421
      Top = 71
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
      Left = 421
      Top = 114
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
    object lbl10: TLabel
      Left = 421
      Top = 158
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
      Left = 453
      Top = 276
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object cbisprint: TCheckBox
      Left = 58
      Top = 314
      Width = 97
      Height = 17
      Caption = #26159#21542#25171#21360
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object Nvhcbbtypeitem: TNovaHComboBox
      Left = 92
      Top = 23
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 0
      OnChange = NvhcbbtypeitemChange
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
      HelpOptions.HDataSourceName = 'printtemplatetypeitemlist'
      HelpOptions.HQueryAddress = 'system/queryPrinttemplatetypeitemAddDefault'
      HelpOptions.displayFieldname = 'itemname'
      Params = <
        item
          DataType = ftString
          Name = 'printtemplatetype.id'
          ParamType = ptInput
        end>
    end
    object nvedtTitle: TNovaEdit
      Left = 93
      Top = 66
      Width = 121
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
    object nvcbbvaluetype: TNovaComboBox
      Left = 93
      Top = 109
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
      OnChange = nvcbbvaluetypeChange
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
    object nvedtparameter: TNovaEdit
      Left = 93
      Top = 153
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 3
      Visible = False
      OnEnterColor = clSkyBlue
      OnExitColot = clWindow
      StopErrorKey = False
      OnFocusSelectAll = False
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
    end
    object nvcbbparameter: TNovaComboBox
      Left = 93
      Top = 153
      Width = 121
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 4
      Visible = False
      Items.Strings = (
        'bcCode_2_5_interleaved'
        'bcCode_2_5_industrial'
        'bcCode_2_5_matrix'
        'bcCode39'
        'bcCode39Extended'
        'bcCode128A'
        'bcCode128B'
        'bcCode128C'
        'bcCode93'
        'bcCode93Extended'
        'bcCodeMSI'
        'bcCodePostNet'
        'bcCodeCodabar'
        'bcCodeEAN8'
        'bcCodeEAN13'
        'bcCodeUPC_A'
        'bcCodeUPC_E0'
        'bcCodeUPC_E1'
        'bcCodeUPC_Supp2'
        'bcCodeUPC_Supp5'
        'bcCodeEAN128A'
        'bcCodeEAN128B'
        'bcCodeEAN128C')
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
    object nvcbbFontname: TNovaComboBox
      Left = 93
      Top = 196
      Width = 121
      Height = 22
      Style = csDropDownList
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
    object nvedtFontsize: TNovaEdit
      Left = 93
      Top = 239
      Width = 121
      Height = 22
      ImeMode = imClose
      MaxLength = 50
      TabOrder = 6
      Text = '11'
      ValueTrim = '11'
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
      Left = 294
      Top = 23
      Width = 121
      Height = 22
      ImeMode = imClose
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 7
      Text = '0'
      ValueTrim = '0'
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
    object nvedtleft: TNovaEdit
      Left = 294
      Top = 67
      Width = 121
      Height = 22
      ImeMode = imClose
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 8
      Text = '0'
      ValueTrim = '0'
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
    object nvedtwidth: TNovaEdit
      Left = 294
      Top = 110
      Width = 121
      Height = 22
      ImeMode = imClose
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 9
      Text = '100'
      ValueTrim = '100'
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
    object nvedtheight: TNovaEdit
      Left = 294
      Top = 154
      Width = 121
      Height = 22
      ImeMode = imClose
      MaxLength = 5
      NumbersOnly = True
      TabOrder = 10
      Text = '40'
      ValueTrim = '40'
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
    object grpPicture: TGroupBox
      Left = 258
      Top = 178
      Width = 185
      Height = 230
      Caption = #30456#29255
      TabOrder = 12
      Visible = False
      object btn2: TSpeedButton
        Left = 101
        Top = 196
        Width = 69
        Height = 26
        Caption = #28165#38500#22270#29255
        OnClick = btn2Click
      end
      object btn1: TSpeedButton
        Left = 8
        Top = 196
        Width = 69
        Height = 26
        Caption = #27983#35272
        OnClick = btn1Click
      end
      object pnl1: TPanel
        Left = 2
        Top = 16
        Width = 181
        Height = 174
        Align = alTop
        TabOrder = 0
        object imgImg_Picture1: TImage
          Left = 1
          Top = 1
          Width = 179
          Height = 172
          Hint = #20056#21153#21592#22836#20687
          Align = alClient
          ParentShowHint = False
          ShowHint = True
          ExplicitTop = 2
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 485
    Width = 470
    ExplicitTop = 485
    ExplicitWidth = 470
    inherited bbtnSave: TBitBtn
      Left = 118
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 118
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 255
      Top = 10
      ExplicitLeft = 255
      ExplicitTop = 10
    end
  end
  object dlgOpenPicPictrue: TOpenPictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg'
    Left = 316
    Top = 232
  end
  object pmpicture: TPopupMenu
    Left = 400
    Top = 232
    object N1: TMenuItem
      Caption = #36873#25321#22270#29255
    end
    object N2: TMenuItem
      Caption = #28165#31354#22270#29255
    end
  end
end
