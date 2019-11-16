inherited FrmCancelReport: TFrmCancelReport
  Caption = #21462#28040#25253#21040#35760#24405
  ClientHeight = 134
  ClientWidth = 354
  OnShow = FormShow
  ExplicitWidth = 360
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 354
    Height = 89
    ExplicitWidth = 335
    ExplicitHeight = 104
    inherited Bevel1: TBevel
      Top = 81
      Width = 320
      ExplicitTop = 323
      ExplicitWidth = 572
    end
    object Label2: TLabel
      Left = 45
      Top = 35
      Width = 60
      Height = 18
      Caption = #21462#28040#21407#22240
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CobCancelReason: TComboBox
      Left = 114
      Top = 35
      Width = 151
      Height = 22
      ItemIndex = 0
      TabOrder = 0
      Text = #25253#21040#36710#36742#26377#35823
      Items.Strings = (
        #25253#21040#36710#36742#26377#35823
        #25805#20316#22833#35823
        #20854#20182)
    end
  end
  inherited pnlOperation: TPanel
    Top = 89
    Width = 354
    ExplicitTop = 104
    ExplicitWidth = 335
    inherited bbtnSave: TBitBtn
      Left = 61
      Top = 6
      OnClick = bbtnSaveClick
      ExplicitLeft = 61
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 182
      Top = 6
      ExplicitLeft = 182
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 288
    Top = 40
  end
  object jcdsCancelReport: TjsonClientDataSet
    DataSourceName = 'dataSet'
    SaveAddress = 'dispatch/cancelvehicleReport'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'vehiclereport.scheduleplanid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.updateby'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.reportorgid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.scheduleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.vehicleid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehiclereport.reason'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'departstationid'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 288
    Top = 8
  end
end
