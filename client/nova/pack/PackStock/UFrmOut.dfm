inherited FrmOutEdit: TFrmOutEdit
  Caption = #20986#24211#28165#21333
  ClientHeight = 444
  ClientWidth = 629
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 635
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 629
    Height = 399
    ExplicitWidth = 629
    ExplicitHeight = 399
    inherited Bevel1: TBevel
      Top = 391
      Width = 595
      ExplicitTop = 391
      ExplicitWidth = 595
    end
    object Label4: TLabel
      Left = 19
      Top = 31
      Width = 42
      Height = 14
      Caption = #20986#24211#20154
    end
    object Label16: TLabel
      Left = 200
      Top = 30
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 19
      Top = 61
      Width = 42
      Height = 14
      Caption = #36865#36135#20154
    end
    object Label12: TLabel
      Left = 199
      Top = 61
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 230
      Top = 29
      Width = 56
      Height = 14
      Caption = #20986#24211#26085#26399
    end
    object Label1: TLabel
      Left = 230
      Top = 62
      Width = 56
      Height = 14
      Caption = #36865#36135#26085#26399
    end
    object Label32: TLabel
      Left = 445
      Top = 60
      Width = 70
      Height = 14
      Caption = #36865#36135#26381#21153#36153
    end
    object Label2: TLabel
      Left = 459
      Top = 29
      Width = 56
      Height = 14
      Caption = #36865#36135#21333#21495
    end
    object Label3: TLabel
      Left = 606
      Top = 29
      Width = 7
      Height = 17
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object nvOutDbgridEh: TNvDbgridEh
      Left = 0
      Top = 104
      Width = 625
      Height = 225
      ColumnDefValues.Title.TitleButton = True
      DataGrouping.GroupLevels = <>
      DataSource = dsResult
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = GB2312_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -14
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      FooterRowCount = 1
      ImeMode = imDisable
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
      PrintInfo.TitleFont.Charset = GB2312_CHARSET
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
          EditButtons = <>
          FieldName = 'packid'
          Footers = <>
          Visible = False
        end
        item
          EditButtons = <>
          FieldName = 'packno'
          Footer.DisplayFormat = #21512#35745
          Footer.ValueType = fvtCount
          Footers = <>
          ReadOnly = True
          Title.Caption = #21333#21495
          Width = 215
        end
        item
          Alignment = taLeftJustify
          EditButtons = <>
          FieldName = 'weight'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = #37325#37327
          Width = 92
        end
        item
          Alignment = taLeftJustify
          EditButtons = <>
          FieldName = 'deliveryfee'
          Footer.ValueType = fvtSum
          Footers = <>
          Title.Caption = #36865#36135#26381#21153#36153
          Width = 92
        end
        item
          EditButtons = <>
          FieldName = 'id'
          Footers = <>
          Visible = False
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object nvedtoutbound: TNovaHelp
      Left = 73
      Top = 26
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
    object nvedtdiliver: TNovaHelp
      Left = 73
      Top = 58
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
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
    object outdate: TDateTimePicker
      Left = 299
      Top = 26
      Width = 111
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 3
    end
    object dilivedate: TDateTimePicker
      Left = 297
      Top = 58
      Width = 111
      Height = 22
      Date = 41494.639888414350000000
      Format = 'yyyy-MM-dd'
      Time = 41494.639888414350000000
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
      TabOrder = 4
    end
    object nvedtDiliveryFee: TNovaEdit
      Left = 526
      Top = 58
      Width = 75
      Height = 22
      MaxLength = 7
      ReadOnly = True
      TabOrder = 5
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
  end
  inherited pnlOperation: TPanel
    Top = 399
    Width = 629
    ExplicitTop = 399
    ExplicitWidth = 629
    inherited bbtnSave: TBitBtn
      OnClick = bbtnSaveClick
    end
    inherited bbtnClose: TBitBtn
      Left = 427
      ExplicitLeft = 427
    end
    object bbtnPrint: TBitBtn
      Left = 272
      Top = 9
      Width = 83
      Height = 25
      Caption = '&P '#25171#21360
      Glyph.Data = {
        8E050000424D8E05000000000000360000002800000018000000130000000100
        18000000000058050000C40E0000C40E00000000000000000000FCF9FBFBFAFA
        FCFBFBFAFAFBFCFDFBFEFFFDEEECEBCDCBC6B4AFABB3ADA8B7B1ADB6B0ACB3AD
        A8B1ACA9B3B0AEACABA7C4C2BFF1EFE9FEFBF6FFFCFAFBFAFBF7FAFEF6F8FEF8
        FAFDFBFCFBFBFBFBFAFBFBF9FAFAFBFAF9FFFFFED1CAC6D7D2CDDCD8D0D1CAC0
        D3CEC3D7D2C0D6D3BBD6D4C1D4D3C2E7E7DD6A6C64EEF3EDF6FAF5FBFFF8F9FB
        F5FCFEF8FAFDF6FAFBF9F6FAF7F9FBFAF9FBFCFAFCFCFEFDFCFFFFFFD9CFCAF3
        F0E8BCA294D2C1AFC9A894A57860C99277A87A66856052F7F0E97D6F6FF8F4F8
        FBFBFFFDFFFFFBFDFBFDFEF9FFFFF7FDFCF9FCFCFBFBFDFBF9FAF8F3F3F3F4F3
        F2FFFDF9D7CAC4F0EFE6BCA28ED7C9AFE8D7B8C69974E4C69ACDA67FD5B898F2
        ECD788766BFEF7F3F5F3F5F2F3F7F4F4F9F0EFF1F7F3F4FDFBFBFFFEFAE6E6E3
        A6A6A57D7D7E8080806C6A6988817AF7F7EECAB8A2F5DFC3E4CAAAFFF3D4DCCC
        AFFDF2D7BFB298F2F1DD6963546F6E64787A76808382797A7CAEACABEFEAE8FD
        FBFAFFFFFFB9B7B6908E8DA5A5A59A9A9A2525225B5851F7F5ECBCB4A2F8EDD5
        FDF0D4DAD6C9C9D0D7CCD0D4AAAAA7EFECE45E5750231E18787571A6A6A6A09E
        9F696565F9F4F1FDFAF9FFFFFFBDBBBC8E8C8C9797979F9E9F7271717B7A767F
        7E7682817684827284817080807D77798778767D867F7C8D80798B7E757B706B
        9B9494948F95918D94736F76F2EDF5FDFBFEFFFFFFB4B5B5BDBCBCCECECED5D3
        D3898787B2B1AFAAA9A6ADABA8ABAAA4AAA9A4AEADA6B0ADA4A79F8FB8A995BB
        AC95C0B19D998D82C0BAB9C3C1C8C3C0CB6C6873F5F0F8FBF9FCFCFFFFB4BAB9
        CDD0CFDFDFDFDCDCDC9D9899BDB7B9BDB9BABAB8BABAB9BDB8B7BBB5B4BCBAB6
        C0B9B1B5BFB5B2BDB1A9BEB6AE96948FCBCCCDCCD2D2D8DCDB74736DF6F2E9FE
        FCF9FEFFFFB4B7B7E6E9E9CCCCCCEEEDED969393D2D0D0CBC9C9CCCACAC6C5C7
        CAC9CBC6C8CBC8CACDC9C8CBCDCBCACCC7C7D2CFCE9A9897DEDEDEBFC0C0DDDD
        DC737270F4F1EFFDFBFBFFFFFFB8B9B9E6E6E6F7F7F7FCFBFB959393CCCACAC7
        C5C5CBCACAC6C7C6C4C4C4C7C7C7C5C8C7C1C3C3C8C9C9C3C4C4D4D2D2928F8F
        E5E1E2BEBCBCDCDADA716F6FF4F2F2FCFCFCFFFFFFB8B9B9ECECECFAFAFAFFFF
        FF969494D8D6D6D5D3D3CDCCCCD1D1D1D1D1D1CCCDCDCECFCFD1D2D2CECECED3
        D3D3D0CFCE9F9B9CE9E3E4D8D6D6EAE7E7727070F3F1F1FCFBFBFFFFFFC1C1C1
        E1E1E1F9F8F8FFFFFF999898DBD9D9D0CECECFCDCDD0D0D0C9CBCBD2D3D3CFCE
        CECCCCCCCFCECDCBC9C9E4E2E2A19D9DDEDADADAD9D9EEECEC747373F9FAFAFD
        FDFDFFFFFFFAF9F9D6D5D5CDCBCBD8D6D58C8887807E7DBCB9B8C1C2C0C2C3C1
        BBBDBBBCBEBCBCBCBBBFBDBCBEBBBACAC5C4686463787473B7B3B2BFBDBDBABA
        BAE5E5E5FEFEFEFEFEFEFBFBFBFFFEFEFFFFFFFFFFFFFFFFFFA9A5A4696564F4
        F2F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFF534F4E7A7675
        F2EFEEFFFFFFFFFFFFFFFFFFFDFFFFFDFEFEFDFDFDFDFCFCFDFDFDFEFCFCFFFF
        FFEAE8E7686363EFEFECFEFDF9FDFCF9FFFFFBFDFCF9FEFDFAFFFDFAFEFAF7FF
        FFFF4A4544B0ABAAFFFFFFFEFCFCFFFDFDFDFEFEFBFEFEFCFDFDFBFCFCFEFFFF
        FBFBFBFEFEFEFEFCFCFFFFFFDDDBD9E9E7E4FFFFFFFFFFFEFFFFFBFFFFFCFFFE
        F9FFFEFBFFFFFDFFFFFF77716FFFFBF9FFFCFCFFFFFFFDFDFDFAFBFBFCFEFEFD
        FEFEFBFEFEFAFCFCFDFFFFFCFAFAFFFEFDFFFFFFD0CBC7D5D4D1EBE9E5E9E5E0
        E9E7E2EAE9E4EAE8E4EAE6E1EBE6E2F2EEEB88837FFEF9F8FFFEFDFEFEFEFDFC
        FCFCFFFEFBFDFDFDFDFDF8FDFCFAFDFCFAFCFCFFFFFEFFFEFDFFFFFEF4F1EEDC
        D9D6DBD8D6DEDBD7D8D7D3DAD8D3DAD7D2DBD7D2DCD8D4D8D5D2E7E5E2FFFFFF
        FFFDFCFFFFFEFFFFFEFBFEFEF7FCFCFEFEFF}
      ModalResult = 1
      TabOrder = 2
      OnClick = bbtnPrintClick
    end
  end
  object nvedtDiliveno: TNovaEdit [2]
    Left = 526
    Top = 26
    Width = 75
    Height = 22
    ImeName = #20013#25991'('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
    MaxLength = 7
    TabOrder = 2
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
  inherited ImageList: TImageList
    Left = 24
    Top = 360
  end
  object dsResult: TDataSource
    DataSet = packdiliverydetaillist
    Left = 56
    Top = 200
  end
  object packdiliverydetaillist: TjsonClientDataSet
    DataSourceName = 'packdiliverydetaillist'
    UpdateDataSet = 'packdiliverydetails'
    QueryAddress = 'packdiliverydetail/listPackDiliveryDetail'
    SaveAddress = 'packdiliverydetail/savePackDiliveryDetails'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packids'
        ParamType = ptInput
        Size = 1000
      end
      item
        DataType = ftString
        Name = 'packdilivery.outbound'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packdilivery.diliver'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packdilivery.dilivedate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packdilivery.deliveryfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packdilivery.outdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packdilivery.diliveno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 1000
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
      end>
    RemoteServer = DMPublic.jcon
    Left = 552
    Top = 152
    object packdiliverydetaillistid: TLargeintField
      FieldName = 'id'
    end
    object packdiliverydetaillistpackid: TLargeintField
      FieldName = 'packid'
    end
    object packdiliverydetaillistweight: TFloatField
      FieldName = 'weight'
    end
    object packdiliverydetaillistdeliveryfee: TFloatField
      FieldName = 'deliveryfee'
      OnChange = packdiliverydetaillistdeliveryfeeChange
    end
    object packdiliverydetaillistpackno: TWideStringField
      FieldName = 'packno'
      Size = 0
    end
  end
  object jcdsExistdiliveno: TjsonClientDataSet
    DataSourceName = 'samepackdilivery'
    QueryAddress = 'packdiliverydetail/samediliveno'
    SaveAddress = 'packdiliverydetail/samediliveno'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    MergeLog = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packdilivery.diliveno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
        Size = 1000
      end
      item
        DataType = ftInteger
        Name = 'flag'
        ParamType = ptOutput
        Size = 10
      end>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 208
  end
end
