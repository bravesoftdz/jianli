inherited FrmInitBillNo: TFrmInitBillNo
  Caption = #31080#21495#21021#22987#21270
  ClientHeight = 177
  ClientWidth = 343
  OnShow = FormShow
  ExplicitWidth = 349
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 343
    Height = 132
    ExplicitWidth = 343
    ExplicitHeight = 132
    inherited Bevel1: TBevel
      Top = 124
      Width = 309
      ExplicitTop = 124
      ExplicitWidth = 309
    end
    object lbl1: TLabel
      Left = 75
      Top = 28
      Width = 56
      Height = 14
      Caption = #24403#21069#31080#21495
    end
    object lbl2: TLabel
      Left = 47
      Top = 84
      Width = 84
      Height = 14
      Caption = #37325#22797#24403#21069#31080#21495
    end
    object lbl3: TLabel
      Left = 266
      Top = 28
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 266
      Top = 84
      Width = 7
      Height = 14
      Caption = '*'
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object nvedtbillNo: TNovaEdit
      Left = 139
      Top = 25
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 0
      Text = '1000000000'
      ValueTrim = '1000000000'
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
    object nvedtBillNoRepeat: TNovaEdit
      Left = 140
      Top = 80
      Width = 121
      Height = 22
      MaxLength = 50
      TabOrder = 1
      Text = '1000000000'
      ValueTrim = '1000000000'
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
    Top = 132
    Width = 343
    ExplicitTop = 132
    ExplicitWidth = 343
    inherited bbtnSave: TBitBtn
      Left = 59
      Caption = '&S '#30830#35748
      OnClick = bbtnSaveClick
      ExplicitLeft = 59
    end
    inherited bbtnClose: TBitBtn
      Left = 196
      Caption = '&Q '#21462#28040
      ExplicitLeft = 196
    end
  end
  object jcdscurbillinuse: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'bill/initBillNo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'billtypecode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'billinuse.nextno'
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
        Name = 'curbillno'
        ParamType = ptOutput
      end
      item
        DataType = ftLargeint
        Name = 'curbillnum'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'billlength'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 160
    Top = 88
  end
  object jsoncdsbilltype: TjsonClientDataSet
    DataSourceName = 'billtypemap'
    QueryAddress = 'bill/listbilltype'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'filter_EQS_b!code'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 280
    Top = 96
  end
end
