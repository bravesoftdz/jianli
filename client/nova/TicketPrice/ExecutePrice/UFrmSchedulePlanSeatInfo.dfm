inherited FrmSchedulePlanSeatInfo: TFrmSchedulePlanSeatInfo
  Caption = 'FrmSchedulePlanSeatInfo'
  ClientHeight = 450
  ClientWidth = 731
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = nil
  OnShow = FormShow
  ExplicitWidth = 737
  ExplicitHeight = 482
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlEditBox: TPanel
    Width = 731
    Height = 405
    ExplicitWidth = 731
    ExplicitHeight = 405
    inherited Bevel1: TBevel
      Top = 397
      Width = 697
      ExplicitTop = 389
      ExplicitWidth = 536
    end
    object pnlseatplan: TPanel
      Left = 0
      Top = 49
      Width = 731
      Height = 356
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 731
      Height = 49
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 15
        Top = 19
        Width = 42
        Height = 14
        Caption = #29677#27425#21495
      end
      object Label2: TLabel
        Left = 156
        Top = 19
        Width = 56
        Height = 14
        Caption = #33829#36816#32447#36335
      end
      object Label3: TLabel
        Left = 358
        Top = 19
        Width = 56
        Height = 14
        Caption = #35745#21010#36710#36742
      end
      object Label4: TLabel
        Left = 526
        Top = 17
        Width = 56
        Height = 14
        Caption = #21378#29260#22411#21495
      end
      object NovaEdtSchedule: TNovaEdit
        Left = 63
        Top = 14
        Width = 79
        Height = 22
        Enabled = False
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
      object NovaEdtRoute: TNovaEdit
        Left = 219
        Top = 14
        Width = 130
        Height = 22
        Enabled = False
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
      object NovaEdtPlanVehicle: TNovaEdit
        Left = 420
        Top = 14
        Width = 90
        Height = 22
        Enabled = False
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
      end
      object NovaEdtBrand: TNovaEdit
        Left = 588
        Top = 14
        Width = 104
        Height = 22
        Enabled = False
        MaxLength = 50
        TabOrder = 3
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
  end
  inherited pnlOperation: TPanel
    Top = 405
    Width = 731
    ExplicitTop = 405
    ExplicitWidth = 731
    inherited bbtnSave: TBitBtn
      Left = 247
      Top = 6
      Visible = False
      ExplicitLeft = 247
      ExplicitTop = 6
    end
    inherited bbtnClose: TBitBtn
      Left = 392
      Top = 6
      ExplicitLeft = 392
      ExplicitTop = 6
    end
  end
  object jcdsQryScheduleSeat: TjsonClientDataSet
    DataSourceName = 'scheduleseatlist'
    QueryAddress = 'ticketprice/qryScheduleseatinfo'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'scheduleplan.id'
        ParamType = ptInput
      end>
    RemoteServer = DMPublic.jcon
    Left = 112
    Top = 120
  end
end
