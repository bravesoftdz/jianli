inherited FrmPackArriveBalance: TFrmPackArriveBalance
  Caption = #20986#24211#32467#31639#21333
  ClientHeight = 379
  ClientWidth = 769
  OnShow = FormShow
  ExplicitWidth = 775
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 769
    Height = 334
    ExplicitWidth = 769
    ExplicitHeight = 334
    DesignSize = (
      769
      334)
    inherited Bevel1: TBevel
      Top = 326
      Width = 735
      ExplicitTop = 326
      ExplicitWidth = 735
    end
    object Label1: TLabel
      Left = 240
      Top = 24
      Width = 220
      Height = 20
      Caption = #23452#26124#20132#36816#20195#25910'('#20195#20184')'#32467#31639
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object shp1: TShape
      Left = 73
      Top = 123
      Width = 576
      Height = 96
    end
    object Label2: TLabel
      Left = 544
      Top = 169
      Width = 13
      Height = 24
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -24
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 104
      Top = 145
      Width = 56
      Height = 14
      Caption = #21333#25454#24352#25968
    end
    object Bevel3: TBevel
      Left = 74
      Top = 169
      Width = 575
      Height = 4
      Shape = bsBottomLine
    end
    object Bevel4: TBevel
      Left = 218
      Top = 123
      Width = 2
      Height = 96
    end
    object Bevel5: TBevel
      Left = 350
      Top = 123
      Width = 2
      Height = 96
    end
    object Label4: TLabel
      Left = 267
      Top = 145
      Width = 28
      Height = 14
      Caption = #36816#36153
    end
    object Label5: TLabel
      Left = 526
      Top = 145
      Width = 56
      Height = 14
      Caption = #23454#32467#37329#39069
    end
    object Label6: TLabel
      Left = 398
      Top = 145
      Width = 28
      Height = 14
      Caption = #36135#27454
    end
    object Bevel6: TBevel
      Left = 488
      Top = 123
      Width = 2
      Height = 96
    end
    object Label10: TLabel
      Left = 74
      Top = 98
      Width = 63
      Height = 14
      Caption = #32467#31639#21333#20301':'
    end
    object packbalancenum: TLabel
      Left = 104
      Top = 187
      Width = 44
      Height = 19
      Caption = '0456'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object packfee: TLabel
      Left = 262
      Top = 187
      Width = 33
      Height = 19
      Caption = '666'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object packprice: TLabel
      Left = 393
      Top = 187
      Width = 33
      Height = 19
      Caption = '666'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object packbalancemoney: TLabel
      Left = 544
      Top = 187
      Width = 33
      Height = 19
      Caption = '666'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object NovaHelpUnit: TNovaHelp
      Left = 143
      Top = 95
      Width = 170
      Height = 22
      CharCase = ecUpperCase
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
      HDBGColumns = <
        item
          Expanded = False
          FieldName = 'name'
          Title.Caption = #21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 80
          Visible = True
        end>
      HelpOptions.HelpHeight = 200
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'UnitHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
  end
  inherited pnlOperation: TPanel
    Top = 334
    Width = 769
    ExplicitTop = 334
    ExplicitWidth = 769
    inherited bbtnSave: TBitBtn
      Left = 167
      Caption = '&S '#32467#31639
      OnClick = bbtnSaveClick
      ExplicitLeft = 167
    end
    inherited bbtnClose: TBitBtn
      Left = 474
      ExplicitLeft = 474
    end
    object BtnPrint: TBitBtn
      Left = 326
      Top = 9
      Width = 83
      Height = 25
      Caption = '&P.'#25171#21360
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = BtnPrintClick
    end
  end
  inherited ImageList: TImageList
    Left = 16
    Top = 272
  end
  object jsonsavepackbalance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savePackBalance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'packbalance.ids'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.datatype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.packnos'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.pieces'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.packmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.packprice'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.packbalancemoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.packdeductmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.balanceip'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.balanceunitname'
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
        Name = 'packbalanceid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packbalanceno'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 416
    Top = 264
  end
end
