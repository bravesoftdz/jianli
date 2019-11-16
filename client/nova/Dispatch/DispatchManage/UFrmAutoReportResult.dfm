inherited FrmAutoReportResult: TFrmAutoReportResult
  Caption = #33258#21160#25253#29677
  ClientHeight = 622
  ClientWidth = 894
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -24
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 900
  ExplicitHeight = 651
  PixelsPerInch = 96
  TextHeight = 29
  inherited pnlEditBox: TPanel
    Width = 894
    Height = 592
    ExplicitWidth = 894
    ExplicitHeight = 592
    inherited Bevel1: TBevel
      Top = 584
      Width = 860
      ExplicitTop = 469
      ExplicitWidth = 860
    end
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 894
      Height = 592
      Align = alClient
      TabOrder = 0
      object grp1: TGroupBox
        Left = 1
        Top = 1
        Width = 892
        Height = 100
        Align = alTop
        TabOrder = 0
        object lbl1: TLabel
          Left = 25
          Top = 14
          Width = 96
          Height = 29
          Caption = #25253#29677#21345#21495
        end
        object lbl2: TLabel
          Left = 283
          Top = 14
          Width = 72
          Height = 29
          Caption = #36710#29260#21495
        end
        object lbl3: TLabel
          Left = 550
          Top = 14
          Width = 72
          Height = 29
          Caption = #29677#27425#21495
        end
        object NovaEdtCardNo: TNovaEdit
          Left = 25
          Top = 47
          Width = 184
          Height = 37
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
        object nvhlpVehicleNo: TNovaHelp
          Left = 283
          Top = 47
          Width = 184
          Height = 37
          CharCase = ecUpperCase
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
              Title.Caption = #36710#29260#21495#30721
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'seatnum'
              Title.Caption = #24231#20301#25968
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'brandname'
              Title.Caption = #21378#29260
              Width = 60
              Visible = True
            end>
          HelpOptions.HelpHeight = 150
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'VehiclenoHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
        object nvhlpSchedule: TNovaHelp
          Left = 550
          Top = 47
          Width = 184
          Height = 37
          CharCase = ecUpperCase
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#24555#25171#25340#38899#36755#20837#27861
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
              Title.Caption = #29677#27425#21495
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'starttime'
              Title.Caption = #21457#36710#26102#38388
              Width = 60
              Visible = True
            end>
          HelpOptions.HelpHeight = 300
          HelpOptions.HelpWidth = 126
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'ScheduleHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
      end
      object grp2: TGroupBox
        Left = 1
        Top = 101
        Width = 892
        Height = 100
        Align = alTop
        TabOrder = 1
        object lbl4: TLabel
          Left = 25
          Top = 14
          Width = 72
          Height = 29
          Caption = #21040#36798#31449
        end
        object lbl5: TLabel
          Left = 283
          Top = 14
          Width = 72
          Height = 29
          Caption = #24231#20301#25968
        end
        object lbl6: TLabel
          Left = 550
          Top = 14
          Width = 96
          Height = 29
          Caption = #21457#36710#26102#38388
        end
        object nvhlpRoute: TNovaHelp
          Left = 25
          Top = 47
          Width = 184
          Height = 37
          CharCase = ecUpperCase
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 20
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
              FieldName = 'NAME'
              Title.Caption = #32456#28857#31449
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'code'
              Title.Caption = #25805#20316#30721
              Width = 60
              Visible = True
            end>
          HelpOptions.HelpHeight = 200
          HelpOptions.HelpWidth = 200
          HelpOptions.EdtField = 'name'
          HelpOptions.HSkinData = DMPublic.SkinData1
          HelpOptions.HJSONConnection = DMPublic.jcon
          HelpOptions.HDataSourceName = 'helpmap'
          HelpOptions.HelpType = 'RouteEndHelp'
          HelpOptions.HQueryAddress = 'system/help'
          Params = <>
          notFocusedShowHelp = False
        end
        object NovaEdtSeatnum: TNovaEdit
          Left = 283
          Top = 47
          Width = 184
          Height = 37
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        object NovaEdtDeparttime: TNovaEdit
          Left = 550
          Top = 47
          Width = 184
          Height = 37
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
      end
      object grp3: TGroupBox
        Left = 1
        Top = 201
        Width = 892
        Height = 100
        Align = alTop
        TabOrder = 2
        object lbl7: TLabel
          Left = 25
          Top = 16
          Width = 96
          Height = 29
          Caption = #36710#23646#21333#20301
        end
        object lbl8: TLabel
          Left = 550
          Top = 16
          Width = 96
          Height = 29
          Caption = #25253#29677#26102#38388
        end
        object NovaEdtReportDateTime: TNovaEdit
          Left = 550
          Top = 51
          Width = 310
          Height = 37
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
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
        object nvhlpUnit: TNovaHelp
          Left = 25
          Top = 48
          Width = 442
          Height = 37
          CharCase = ecUpperCase
          Enabled = False
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          MaxLength = 20
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
              Title.Caption = #32447#36335#21517#31216
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
          HelpOptions.HelpHeight = 300
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
      object grp4: TGroupBox
        Left = 1
        Top = 301
        Width = 892
        Height = 290
        Align = alClient
        TabOrder = 3
        object lbl9: TLabel
          Left = 25
          Top = 24
          Width = 96
          Height = 29
          Caption = #25253#29677#32467#26524
        end
        object mmoResult: TMemo
          Left = 127
          Top = 25
          Width = 733
          Height = 222
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = []
          ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
  end
  inherited pnlOperation: TPanel
    Top = 592
    Width = 894
    Height = 30
    ExplicitTop = 592
    ExplicitWidth = 894
    ExplicitHeight = 30
    inherited bbtnClose: TBitBtn [0]
      Left = 398
      Top = 6
      Visible = False
      ExplicitLeft = 398
      ExplicitTop = 6
    end
    inherited bbtnSave: TBitBtn [1]
      Left = 480
      Top = 6
      Caption = '&S '#30830#35748
      Visible = False
      OnClick = bbtnSaveClick
      ExplicitLeft = 480
      ExplicitTop = 6
    end
  end
  inherited ImageList: TImageList
    Left = 746
    Top = 478
  end
end
