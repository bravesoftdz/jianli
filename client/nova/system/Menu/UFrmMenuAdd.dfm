inherited FrmMenuAdd: TFrmMenuAdd
  Caption = #31995#32479#33756#21333#32534#36753
  ClientHeight = 361
  ClientWidth = 394
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 400
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 394
    Height = 316
    ExplicitWidth = 394
    ExplicitHeight = 316
    DesignSize = (
      394
      316)
    inherited Bevel1: TBevel
      Top = 313
      Width = 353
      ExplicitTop = 290
      ExplicitWidth = 421
    end
    object lblparentmenu: TLabel
      Left = 99
      Top = 24
      Width = 28
      Height = 14
      Caption = 'Root'
    end
    object lbltype: TLabel
      Left = 61
      Top = 89
      Width = 28
      Height = 14
      Caption = #31867#22411
    end
    object lblfunction: TLabel
      Left = 61
      Top = 121
      Width = 28
      Height = 14
      Caption = #21151#33021
    end
    object lblparam: TLabel
      Left = 61
      Top = 153
      Width = 28
      Height = 14
      Caption = #21442#25968
    end
    object Label1: TLabel
      Left = 47
      Top = 24
      Width = 42
      Height = 14
      Caption = #29238#33756#21333
    end
    object Label2: TLabel
      Left = 61
      Top = 56
      Width = 28
      Height = 14
      Caption = #21517#31216
    end
    object lblfunctiondescribe: TLabel
      Left = 37
      Top = 183
      Width = 56
      Height = 14
      Caption = #21151#33021#35828#26126
    end
    object lblparameterdescribe: TLabel
      Left = 37
      Top = 245
      Width = 56
      Height = 14
      Caption = #21442#25968#35828#26126
    end
    object rbfolder: TRadioButton
      Left = 99
      Top = 85
      Width = 113
      Height = 17
      Caption = #33756#21333#22841
      TabOrder = 1
      OnClick = rbfunctionClick
    end
    object rbfunction: TRadioButton
      Left = 235
      Top = 81
      Width = 113
      Height = 17
      Caption = #33756#21333
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = rbfunctionClick
    end
    object nvhelpfunction: TNovaHelp
      Left = 99
      Top = 115
      Width = 240
      Height = 22
      HelpType = htKeyword
      MaxLength = 50
      TabOrder = 3
      OnIdChange = nvhelpfunctionIdChange
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'functiondescribe'
          Title.Caption = #25551#36848
          Width = 200
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'FunctionHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object mmofunctiondescribe: TMemo
      Left = 99
      Top = 183
      Width = 240
      Height = 49
      TabStop = False
      BorderStyle = bsNone
      Color = clBtnFace
      Lines.Strings = (
        #31449#28857#31649#29702#65292#25552#20379#22686#21024#25913#21151#33021
        'TTTTTTTTTTTTTTT')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 5
    end
    object nvedtname: TNovaEdit
      Left = 99
      Top = 51
      Width = 240
      Height = 22
      MaxLength = 50
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
    object nvedtparam: TNovaEdit
      Left = 99
      Top = 149
      Width = 240
      Height = 22
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
    object mmoparameterdescribe: TMemo
      Left = 99
      Top = 245
      Width = 240
      Height = 49
      TabStop = False
      BorderStyle = bsNone
      Color = clBtnFace
      Lines.Strings = (
        #31449#28857#31649#29702#65292#25552#20379#22686#21024#25913#21151#33021
        'TTTTTTTTTTTTTTT')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 6
    end
  end
  inherited pnlOperation: TPanel
    Top = 316
    Width = 394
    ExplicitTop = 316
    ExplicitWidth = 394
    inherited bbtnSave: TBitBtn
      Left = 103
      Top = 10
      OnClick = bbtnSaveClick
      ExplicitLeft = 103
      ExplicitTop = 10
    end
    inherited bbtnClose: TBitBtn
      Left = 240
      Top = 10
      ExplicitLeft = 240
      ExplicitTop = 10
    end
  end
end
