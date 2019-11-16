inherited FrmPacFrontkBalance: TFrmPacFrontkBalance
  Caption = #21069#21488#32467#31639#21333
  ClientHeight = 415
  ClientWidth = 682
  OnShow = FormShow
  ExplicitWidth = 688
  ExplicitHeight = 443
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 682
    Height = 370
    ExplicitWidth = 682
    ExplicitHeight = 370
    inherited Bevel1: TBevel
      Top = 362
      Width = 648
      ExplicitTop = 362
      ExplicitWidth = 648
    end
    object Label10: TLabel
      Left = 57
      Top = 114
      Width = 63
      Height = 14
      Caption = #32467#31639#21333#20301':'
    end
    object shp1: TShape
      Left = 57
      Top = 163
      Width = 576
      Height = 96
    end
    object Bevel6: TBevel
      Left = 445
      Top = 163
      Width = 2
      Height = 96
    end
    object Bevel4: TBevel
      Left = 246
      Top = 163
      Width = 2
      Height = 96
    end
    object Bevel3: TBevel
      Left = 57
      Top = 209
      Width = 576
      Height = 4
      Shape = bsBottomLine
    end
    object Label1: TLabel
      Left = 224
      Top = 40
      Width = 161
      Height = 23
      Caption = #36135#29289#25176#36816#32467#31639#21333
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 119
      Top = 184
      Width = 56
      Height = 14
      Caption = #21333#25454#24352#25968
    end
    object Label3: TLabel
      Left = 325
      Top = 184
      Width = 28
      Height = 14
      Caption = #20214#25968
    end
    object Label4: TLabel
      Left = 512
      Top = 184
      Width = 56
      Height = 14
      Caption = #32467#31639#37329#39069
    end
    object nvnos: TLabel
      Left = 109
      Top = 224
      Width = 55
      Height = 20
      Caption = 'nvnos'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object nvpieces: TLabel
      Left = 300
      Top = 224
      Width = 88
      Height = 20
      Caption = 'nvpieces'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object nvbalancemoney: TLabel
      Left = 479
      Top = 224
      Width = 154
      Height = 20
      Caption = 'nvbalancemoney'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object NovaHelpUnit: TNovaHelp
      Left = 126
      Top = 111
      Width = 187
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
    Top = 370
    Width = 682
    ExplicitTop = 370
    ExplicitWidth = 682
    inherited bbtnSave: TBitBtn
      Left = 126
      Top = 6
      Caption = '&S '#32467#31639
      OnClick = bbtnSaveClick
      ExplicitLeft = 126
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 445
      Top = 6
      ExplicitLeft = 445
      ExplicitTop = 6
    end
    object BtnPrint: TBitBtn
      Left = 283
      Top = 6
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
    Left = 24
    Top = 280
  end
  object jcdssavebalance: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'pack/savePackBalance'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'flag'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'msg'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'packbalance.packbalancemoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.packdeductmoney'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.balanceunitname'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'packbalance.balanceip'
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
        Name = 'packbalance.packnos'
        ParamType = ptInput
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
    Left = 520
    Top = 312
  end
end
