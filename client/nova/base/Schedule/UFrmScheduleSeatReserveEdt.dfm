inherited FrmScheduleSeatReserveEdt: TFrmScheduleSeatReserveEdt
  Caption = 'FrmScheduleSeatReserveEdt'
  ClientHeight = 495
  ClientWidth = 718
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 724
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 718
    Height = 450
    ExplicitWidth = 718
    ExplicitHeight = 450
    inherited Bevel1: TBevel
      Top = 442
      Width = 684
      ExplicitTop = 318
      ExplicitWidth = 481
    end
    object lbl1: TLabel
      Left = 361
      Top = 19
      Width = 56
      Height = 14
      Caption = #33829#36816#21378#29260
    end
    object lbl2: TLabel
      Left = 45
      Top = 19
      Width = 56
      Height = 14
      Caption = #25805#20316#31867#22411
    end
    object lbl3: TLabel
      Left = 45
      Top = 52
      Width = 56
      Height = 14
      Caption = #24320#22987#26085#26399
    end
    object lbl4: TLabel
      Left = 363
      Top = 55
      Width = 56
      Height = 14
      Caption = #32467#26463#26085#26399
    end
    object lbl5: TLabel
      Left = 52
      Top = 385
      Width = 42
      Height = 14
      Caption = #24231#20301#21495
    end
    object lbl7: TLabel
      Left = 51
      Top = 417
      Width = 42
      Height = 14
      Caption = #39044#30041#25968
    end
    object lbl6: TLabel
      Left = 198
      Top = 417
      Width = 56
      Height = 14
      Caption = #30041#20301#21407#22240
    end
    object rbRoute: TRadioButton
      Left = 194
      Top = 16
      Width = 137
      Height = 17
      Caption = #21516#32447#36335#25152#26377#29677#27425
      TabOrder = 0
    end
    object rbSchedule: TRadioButton
      Left = 107
      Top = 16
      Width = 81
      Height = 17
      Caption = #26412#29677#27425
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object NovaCbbVehiclebrand: TNovaHComboBox
      Left = 425
      Top = 14
      Width = 145
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 2
      OnChange = NovaCbbVehiclebrandChange
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
      HelpOptions.HDataSourceName = 'brandlist'
      HelpOptions.HQueryAddress = 'base/qryVehiclebrandmodel'
      HelpOptions.AutoSelectFirst = True
      HelpOptions.displayFieldname = 'name'
      Params = <
        item
          DataType = ftString
          Name = 'scheduleid'
          ParamType = ptInput
        end>
    end
    object dtpStartdate: TDateTimePicker
      Left = 107
      Top = 47
      Width = 134
      Height = 22
      Date = 40765.810897893520000000
      Time = 40765.810897893520000000
      TabOrder = 3
    end
    object dtpEndstart: TDateTimePicker
      Left = 425
      Top = 47
      Width = 144
      Height = 22
      Date = 2958322.811350000000000000
      Time = 2958322.811350000000000000
      TabOrder = 4
    end
    object NovaEdtSeats: TNovaEdit
      Left = 100
      Top = 379
      Width = 563
      Height = 22
      Enabled = False
      MaxLength = 50
      ReadOnly = True
      TabOrder = 5
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
    object grp1: TGroupBox
      Left = 45
      Top = 76
      Width = 639
      Height = 297
      Caption = #24231#20301#22270'('#21487#29992#40736#26631#28857#20987')'
      TabOrder = 6
      object pnlseatplan: TPanel
        Left = 2
        Top = 16
        Width = 635
        Height = 279
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object NovaEdtSeatnum: TNovaEdit
      Left = 101
      Top = 412
      Width = 75
      Height = 24
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      MaxLength = 50
      ParentFont = False
      TabOrder = 7
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
    object edtRemark: TEdit
      Left = 260
      Top = 412
      Width = 403
      Height = 22
      TabOrder = 8
    end
  end
  inherited pnlOperation: TPanel
    Top = 450
    Width = 718
    ExplicitTop = 450
    ExplicitWidth = 718
    inherited bbtnSave: TBitBtn
      Left = 239
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 239
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 376
      Top = 6
      ExplicitLeft = 376
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 592
  end
  object jcsdQrySave: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'base/savescheduleseatreserve'
    SaveAddress = 'base/savescheduleseatreserve'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleseatreserve.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.startdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.enddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.seatnos'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.seatnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.createby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'scheduleseatreserve.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'issameroute'
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
      end
      item
        DataType = ftBCD
        Name = 'scheduleseatreserveid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 296
    Top = 296
  end
end
