inherited FrmAddTempVehi: TFrmAddTempVehi
  Caption = #28155#21152#20020#26102#36710#36742
  ClientHeight = 237
  ExplicitWidth = 443
  ExplicitHeight = 265
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Height = 183
    ExplicitHeight = 183
    inherited Bevel1: TBevel
      Left = 40
      Top = 175
      Width = 350
      ExplicitLeft = 40
      ExplicitTop = 166
      ExplicitWidth = 350
    end
    object lblvehicleno: TLabel
      Left = 72
      Top = 38
      Width = 56
      Height = 14
      Caption = #36710#29260#21495#30721
    end
    object lblunitid: TLabel
      Left = 72
      Top = 77
      Width = 56
      Height = 14
      Caption = #25152#23646#21333#20301
    end
    object lblvehiclebrandmodelid: TLabel
      Left = 72
      Top = 123
      Width = 56
      Height = 14
      Caption = #21697#29260#22411#21495
    end
    object lbl5: TLabel
      Left = 297
      Top = 79
      Width = 6
      Height = 12
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 297
      Top = 126
      Width = 6
      Height = 12
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      Left = 297
      Top = 38
      Width = 6
      Height = 12
      Caption = '*'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object NovaHelpUnit: TNovaHelp
      Left = 137
      Top = 74
      Width = 150
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
          Title.Caption = #21333#20301#21517#31216
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jianpin'
          Title.Caption = #31616#25340
          Width = 60
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
    object nvhlpVehiclebrandmodel: TNovaHelp
      Left = 137
      Top = 120
      Width = 147
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      MaxLength = 50
      ParentFont = False
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
          FieldName = 'NAME'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Caption = #21378#29260#22411#21495
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'rationseatnum'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          Title.Caption = #24231#20301#25968
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'code'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'id'
          Visible = False
        end>
      HelpOptions.HelpHeight = 150
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'VehiclebrandmodelHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <>
      notFocusedShowHelp = False
    end
    object edtvehicleno: TEdit
      Left = 136
      Top = 33
      Width = 148
      Height = 22
      TabOrder = 2
    end
  end
  inherited pnlOperation: TPanel
    Top = 183
    Height = 54
    ExplicitTop = 183
    ExplicitHeight = 54
    inherited bbtnSave: TBitBtn
      Top = 12
      OnClick = bbtnSaveClick
      ExplicitTop = 12
    end
    inherited bbtnClose: TBitBtn
      Top = 12
      ExplicitTop = 12
    end
  end
  inherited ImageList: TImageList
    Left = 384
    Top = 32
  end
  object jsonCDSVehicleSave: TjsonClientDataSet
    DataSourceName = 'dataset'
    QueryAddress = 'base/savevehicle'
    SaveAddress = 'base/savevehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.createby'
        ParamType = ptInput
      end
      item
        DataType = ftOraTimeStamp
        Name = 'vehicle.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.color'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.grantdate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.rationseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.seatnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.loadamout'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.type'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contactperson'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contactphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.gprs'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contractno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.contractstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.contractenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.liabilityinsureno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.liabilityinsurestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.liabilityinsureenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.compulsoryinsureno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.compulsoryinsurestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.compulsoryinsureenddate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.licensestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.licenseenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.workno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.workstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.workenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'picture'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.islocaldelete'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'validdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.margin'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.stopfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.istempvehicle'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.makedate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.cardnoprintdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.checkfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.entercardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.auditroute'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.otherfee'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isneedfinger'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.vehiclenodate'
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
        Name = 'vehicleid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'vehicle.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.driverlicense'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.roadno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.maintainvaliddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.nextmaintaindistance'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 408
    Top = 360
  end
  object jsonClientDataSet1: TjsonClientDataSet
    DataSourceName = 'dataset'
    QueryAddress = 'base/savevehicle'
    SaveAddress = 'base/savevehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftBCD
        Name = 'vehicle.id'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.createby'
        ParamType = ptInput
      end
      item
        DataType = ftOraTimeStamp
        Name = 'vehicle.createtime'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.color'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.cardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.grantdate'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.rationseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.seatnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.loadamout'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.route.id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.type'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contactperson'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contactphone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.gprs'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.contractno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.contractstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.contractenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.liabilityinsureno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.liabilityinsurestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.liabilityinsureenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.compulsoryinsureno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.compulsoryinsurestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.compulsoryinsureenddate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.licensestartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.licenseenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.workno'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.workstartdate'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'vehicle.workenddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'picture'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.remarks'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.islocaldelete'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'synccode'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'validdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.margin'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.stopfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.istempvehicle'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.makedate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.cardnoprintdate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.checkfee'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.entercardno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.auditroute'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.otherfee'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isneedfinger'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.vehiclenodate'
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
        Name = 'vehicleid'
        ParamType = ptOutput
      end
      item
        DataType = ftString
        Name = 'vehicle.status'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.driverlicense'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.roadno'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.maintainvaliddate'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.nextmaintaindistance'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 408
    Top = 360
  end
  object jcsdAddTempVehiSave: TjsonClientDataSet
    DataSourceName = 'list'
    QueryAddress = 'base/savevehicle'
    SaveAddress = 'base/savevehicle'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
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
        DataType = ftString
        Name = 'vehicle.vehicleno'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.unitid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehicletypeid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.vehiclebrandmodelid'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.balanceunitid'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.rationseatnum'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicle.seatnum'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.type'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.color'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isaudited'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isauditpass'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.isactive'
        ParamType = ptInput
      end
      item
        DataType = ftBoolean
        Name = 'vehicle.islocaldelete'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.istempvehicle'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'vehicle.status'
        ParamType = ptInput
      end
      item
        DataType = ftBCD
        Name = 'vehicleid'
        ParamType = ptOutput
      end>
    RemoteServer = DMPublic.jcon
    Left = 344
    Top = 120
  end
end
