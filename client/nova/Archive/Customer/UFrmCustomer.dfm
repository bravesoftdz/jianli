inherited frmCustomer: TfrmCustomer
  Caption = #39038#23458#26723#26696#31649#29702
  ClientHeight = 589
  ClientWidth = 1076
  ExplicitWidth = 1092
  ExplicitHeight = 627
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Width = 1076
    Height = 68
    ExplicitWidth = 1076
    ExplicitHeight = 68
    object lbl1: TLabel
      Left = 424
      Top = 17
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object lbl5: TLabel
      Left = 577
      Top = 47
      Width = 56
      Height = 14
      Caption = #31227#21160#30005#35805
    end
    object lbl2: TLabel
      Left = 420
      Top = 46
      Width = 28
      Height = 14
      Caption = #21345#21495
    end
    object lbl6: TLabel
      Left = 27
      Top = 48
      Width = 42
      Height = 14
      Caption = #21345#31561#32423
    end
    object lbl15: TLabel
      Left = 210
      Top = 48
      Width = 56
      Height = 14
      Caption = #30005#23376#37038#20214
    end
    object lbl4: TLabel
      Left = 210
      Top = 17
      Width = 56
      Height = 14
      Caption = #25152#23646#26426#26500
    end
    object lbl7: TLabel
      Left = 28
      Top = 17
      Width = 42
      Height = 14
      Caption = #20998#20844#21496
    end
    object lbl3: TLabel
      Left = 577
      Top = 17
      Width = 56
      Height = 14
      Caption = #35777#20214#31867#22411
    end
    object lbl14: TLabel
      Left = 797
      Top = 17
      Width = 42
      Height = 14
      Caption = #35777#20214#21495
    end
    object nvedtName: TNovaEdit
      Left = 455
      Top = 13
      Width = 95
      Height = 22
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
    object nvedtPhone: TNovaEdit
      Left = 647
      Top = 45
      Width = 132
      Height = 22
      MaxLength = 50
      TabOrder = 3
      OnKeyPress = nvedtPhoneKeyPress
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
    object edtEmail: TNovaEdit
      Left = 270
      Top = 44
      Width = 126
      Height = 22
      MaxLength = 20
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
    object nvcbbvipgrade: TNovaCheckedComboBox
      Left = 75
      Top = 45
      Width = 122
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/queryCheckcombox'
      HelpOptions.SelectAll = False
      Params = <
        item
          DataType = ftString
          Name = 'tablename'
          ParamType = ptInput
          Value = 'vip'
        end
        item
          DataType = ftWideString
          Name = 'columnname'
          ParamType = ptInput
          Value = 'grade'
        end>
    end
    object nvhlpcardno: TNovaHelp
      Left = 455
      Top = 44
      Width = 95
      Height = 22
      MaxLength = 12
      TabOrder = 6
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
          Title.Caption = #21345#31867#22411
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cardno'
          Title.Caption = #21345#21495
          Width = 100
          Visible = True
        end>
      HelpOptions.HelpHeight = 100
      HelpOptions.HelpWidth = 200
      HelpOptions.EdtField = 'cardno'
      HelpOptions.HSkinData = DMPublic.SkinData1
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HelpType = 'InitcardHelp'
      HelpOptions.HQueryAddress = 'system/help'
      Params = <
        item
          DataType = ftString
          Name = 'filter_EQS_i!cardtype'
          ParamType = ptInput
        end>
      notFocusedShowHelp = False
    end
    object chkhascard: TCheckBox
      Left = 797
      Top = 47
      Width = 69
      Height = 17
      Caption = #24050#21457#21345
      TabOrder = 7
    end
    object nvcbbOrgid: TNovaCheckedComboBox
      Left = 270
      Top = 13
      Width = 126
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Version = '1.2'
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryOrgbyParentOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <
        item
          DataType = ftString
          Name = 'orgids'
          ParamType = ptInput
        end>
    end
    object nvcbbPorg: TNovaCheckedComboBox
      Left = 75
      Top = 13
      Width = 122
      Height = 22
      ColorNotFocus = clWhite
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Version = '1.2'
      OnCheckClick = nvcbbPorgCheckClick
      HelpOptions.HJSONConnection = DMPublic.jcon
      HelpOptions.HDataSourceName = 'datalist'
      HelpOptions.HQueryAddress = 'system/qryAllSubOrg'
      HelpOptions.HelpType = 'OrgHelp'
      HelpOptions.SelectAll = True
      Params = <>
    end
    object nvcbbCertificatetypeQuery: TNovaComboBox
      Left = 647
      Top = 13
      Width = 132
      Height = 22
      Style = csDropDownList
      ImeMode = imClose
      TabOrder = 8
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
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
      HelpOptions.TableName = 'customer'
      HelpOptions.Columnname = 'certificatetype'
    end
    object nvedtCertificateNOQuey: TNovaEdit
      Left = 849
      Top = 13
      Width = 132
      Height = 22
      MaxLength = 20
      TabOrder = 9
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
  inherited tlbShortCut: TToolBar
    Width = 1076
    ExplicitWidth = 1076
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
    end
    inherited tbtnInsert: TToolButton
      OnClick = tbtnInsertClick
    end
    inherited tbtnEdit: TToolButton
      OnClick = tbtnEditClick
    end
    inherited tbtnDelete: TToolButton
      OnClick = tbtnDeleteClick
    end
    inherited ToolButton50: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton51: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn3: TToolButton
      Visible = False
    end
    inherited tbtnSave: TToolButton
      Visible = False
    end
    inherited tbtnCancel: TToolButton
      Visible = False
    end
    inherited ToolButton52: TToolButton
      ExplicitWidth = 18
    end
    inherited ToolButton53: TToolButton
      ExplicitWidth = 18
    end
    inherited tbtn4: TToolButton
      Visible = False
    end
    inherited tbtnInfo: TToolButton
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 113
    Width = 1076
    Height = 476
    ExplicitTop = 113
    ExplicitWidth = 1076
    ExplicitHeight = 476
    inherited GroupBox1: TGroupBox
      Width = 1076
      Height = 470
      ExplicitWidth = 1076
      ExplicitHeight = 470
      inherited dbgrdhResult: TNvDbgridEh
        Width = 1072
        Height = 452
        FooterRowCount = 1
        ImeMode = imDisable
        SumList.Active = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'orgname'
            Footer.DisplayFormat = #21512#35745
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #25152#23646#26426#26500
            Width = 104
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #22995#21517
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
            Title.Caption = #24615#21035
            Width = 37
          end
          item
            EditButtons = <>
            FieldName = 'birthday'
            Footers = <>
            Title.Caption = #29983#26085
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'certificatetypename'
            Footers = <>
            Title.Caption = #35777#20214#31867#22411
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Title.Caption = #35777#20214#21495#30721
            Width = 156
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
            Title.Caption = #31227#21160#30005#35805
            Width = 92
          end
          item
            EditButtons = <>
            FieldName = 'inputwayname'
            Footers = <>
            Title.Caption = #20449#24687#24405#20837#28304
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'gradename'
            Footers = <>
            Title.Caption = #21345#31867#21035
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'vipcardno'
            Footers = <>
            Title.Caption = #21345#21495
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'statusname'
            Footers = <>
            Title.Caption = #21345#29366#24577
            Width = 51
          end
          item
            EditButtons = <>
            FieldName = 'money'
            Footers = <>
            Title.Caption = #20313#39069
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'vipamount'
            Footers = <>
            Title.Caption = #31215#20998
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'email'
            Footers = <>
            Title.Caption = #30005#23376#37038#20214
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'educationname'
            Footers = <>
            Title.Caption = #23398#21382
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'familyphone'
            Footers = <>
            Title.Caption = #23478#24237#30005#35805
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'familyaddress'
            Footers = <>
            Title.Caption = #23478#24237#22320#22336
            Width = 129
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'education'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'reachstationname'
            Footers = <>
            Title.Caption = #21040#36798#31449
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'endstationname'
            Footers = <>
            Title.Caption = #32456#28857#31449
            Width = 93
          end
          item
            EditButtons = <>
            FieldName = 'ticketno'
            Footers = <>
            Title.Caption = #31080#21495
            Width = 113
          end
          item
            EditButtons = <>
            FieldName = 'schcode'
            Footers = <>
            Title.Caption = #29677#27425
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'departdate'
            Footers = <>
            Title.Caption = #21457#36710#26085#26399
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'tsdeparttime'
            Footers = <>
            Title.Caption = #21457#36710#26102#38388
            Width = 72
          end
          item
            EditButtons = <>
            FieldName = 'planvehicleno'
            Footers = <>
            Title.Caption = #36710#29260#21495
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'remarks'
            Footers = <>
            Title.Caption = #22791#27880
            Width = 164
          end
          item
            EditButtons = <>
            FieldName = 'createname'
            Footers = <>
            Title.Caption = #21019#24314#20154
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
            Title.Caption = #21019#24314#26102#38388
            Width = 140
          end
          item
            EditButtons = <>
            FieldName = 'updatename'
            Footers = <>
            Title.Caption = #20462#25913#20154
            Width = 79
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
            Title.Caption = #20462#25913#26102#38388
            Width = 141
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'certificateno'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'certificatetype'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'inputway'
            Footers = <>
            Visible = False
          end>
      end
    end
    object grp3: TGroupBox
      Left = 0
      Top = 470
      Width = 1076
      Height = 6
      Align = alBottom
      TabOrder = 1
      Visible = False
      object grp8: TGroupBox
        Left = 2
        Top = 16
        Width = 1072
        Height = 6
        Align = alClient
        Caption = #39038#23458#36141#31080#20449#24687
        TabOrder = 0
        object nvdbgrdhTicke: TNvDbgridEh
          Left = 2
          Top = 16
          Width = 1068
          Height = 4
          Align = alClient
          ColumnDefValues.Title.TitleButton = True
          DataGrouping.GroupLevels = <>
          Flat = False
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -14
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          FooterRowCount = 1
          ImeMode = imDisable
          RowDetailPanel.Color = clBtnFace
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -14
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          ExpOpenType = AutoOpen
          AutoSetMultiSelect = False
          AutoSetCtrlKey = False
          PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
          PrintOptions = [pghOptimalColWidths]
          PrintAutoNewLine = False
          ParentName = 'frmDriver'
          TitleAlign = taLeftJustify
          Columns = <
            item
              EditButtons = <>
              FieldName = 'ticketoutname'
              Footer.DisplayFormat = #21512#35745
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #36141#31080#28857
              Width = 70
            end
            item
              EditButtons = <>
              FieldName = 'selltime'
              Footer.ValueType = fvtCount
              Footers = <>
              Title.Caption = #36141#31080#26085#26399
              Width = 92
            end
            item
              EditButtons = <>
              FieldName = 'ischecked'
              Footers = <>
              Title.Caption = #26159#21542#24050#26816#31080
              Width = 81
            end
            item
              EditButtons = <>
              FieldName = 'fullprice'
              Footer.ValueType = fvtSum
              Footers = <>
              Title.Caption = #31080#20215
              Width = 51
            end
            item
              EditButtons = <>
              FieldName = 'departdate'
              Footers = <>
              Title.Caption = #21457#36710#26085#26399
              Width = 100
            end
            item
              EditButtons = <>
              FieldName = 'departtime'
              Footers = <>
              Title.Caption = #21457#36710#26102#38388
              Width = 100
            end
            item
              EditButtons = <>
              FieldName = 'seatno'
              Footers = <>
              Title.Caption = #24231#20301#21495
              Width = 100
            end
            item
              EditButtons = <>
              FieldName = 'ticketentrance'
              Footers = <>
              Title.Caption = #26816#31080#21475
              Width = 121
            end
            item
              EditButtons = <>
              FieldName = 'schedulename'
              Footers = <>
              Title.Caption = #29677#27425
              Width = 115
            end
            item
              EditButtons = <>
              FieldName = 'reachname'
              Footers = <>
              Title.Caption = #36798#21040#31449
              Width = 100
            end>
          object RowDetailData: TRowDetailPanelControlEh
            object grp1: TGroupBox
              Left = 0
              Top = -197
              Width = 0
              Height = 197
              Align = alBottom
              TabOrder = 0
              object grp2: TGroupBox
                Left = 2
                Top = 16
                Width = 1037
                Height = 179
                Align = alClient
                Caption = #24037#20316#32463#21382#20449#24687
                TabOrder = 0
                object tlb2: TToolBar
                  Left = 2
                  Top = 16
                  Width = 1033
                  Height = 29
                  Caption = 'tlb2'
                  TabOrder = 0
                  object btn7: TToolButton
                    Left = 0
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton6'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn8: TToolButton
                    Left = 8
                    Top = 0
                    Hint = #28155#21152
                    Caption = 'ToolButton1'
                    ImageIndex = 9
                    ParentShowHint = False
                    ShowHint = True
                  end
                  object btn9: TToolButton
                    Left = 31
                    Top = 0
                    Width = 8
                    Caption = 'ToolButton4'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn10: TToolButton
                    Left = 39
                    Top = 0
                    Hint = #20462#25913
                    Caption = 'ToolButton2'
                    ImageIndex = 0
                    ParentShowHint = False
                    ShowHint = True
                  end
                  object btn11: TToolButton
                    Left = 62
                    Top = 0
                    Width = 8
                    Caption = 'btn11'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object btn12: TToolButton
                    Left = 70
                    Top = 0
                    Hint = #27880#38144
                    Caption = 'ToolButton8'
                    ImageIndex = 7
                    ParentShowHint = False
                    ShowHint = True
                  end
                end
                object nvdbgrdh1: TNvDbgridEh
                  Left = 2
                  Top = 45
                  Width = 1033
                  Height = 132
                  Align = alClient
                  ColumnDefValues.Title.TitleButton = True
                  DataGrouping.GroupLevels = <>
                  Flat = False
                  FooterColor = clWindow
                  FooterFont.Charset = ANSI_CHARSET
                  FooterFont.Color = clWindowText
                  FooterFont.Height = -14
                  FooterFont.Name = #23435#20307
                  FooterFont.Style = []
                  ImeMode = imDisable
                  RowDetailPanel.Color = clBtnFace
                  TabOrder = 1
                  TitleFont.Charset = ANSI_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -14
                  TitleFont.Name = #23435#20307
                  TitleFont.Style = []
                  ExpOpenType = AutoOpen
                  AutoSetMultiSelect = False
                  AutoSetCtrlKey = False
                  PrintInfo.TitleFont.Charset = ANSI_CHARSET
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
                  PrintOptions = [pghOptimalColWidths]
                  PrintAutoNewLine = False
                  ParentName = 'frmDriver'
                  TitleAlign = taLeftJustify
                  Columns = <
                    item
                      EditButtons = <>
                      FieldName = 'id'
                      Footers = <>
                      Visible = False
                      Width = 36
                    end
                    item
                      EditButtons = <>
                      FieldName = 'workunit'
                      Footers = <>
                      Title.Caption = #24037#20316#21333#20301
                      Width = 110
                    end
                    item
                      EditButtons = <>
                      FieldName = 'position'
                      Footers = <>
                      Title.Caption = #32844#20301
                      Width = 136
                    end
                    item
                      EditButtons = <>
                      FieldName = 'startdate'
                      Footers = <>
                      Title.Caption = #24037#20316#24320#22987#26085#26399
                      Width = 108
                    end
                    item
                      EditButtons = <>
                      FieldName = 'enddate'
                      Footers = <>
                      Title.Caption = #24037#20316#32467#26463#26085#26399
                      Width = 101
                    end
                    item
                      EditButtons = <>
                      FieldName = 'remarks'
                      Footers = <>
                      Title.Caption = #22791#27880
                      Width = 228
                    end
                    item
                      EditButtons = <>
                      FieldName = 'createby'
                      Footers = <>
                      Visible = False
                      Width = 67
                    end
                    item
                      EditButtons = <>
                      FieldName = 'createname'
                      Footers = <>
                      Title.Caption = #21019#24314#20154
                      Width = 60
                    end
                    item
                      EditButtons = <>
                      FieldName = 'createtime'
                      Footers = <>
                      Title.Caption = #21019#24314#26102#38388
                      Width = 120
                    end
                    item
                      EditButtons = <>
                      FieldName = 'updateby'
                      Footers = <>
                      Title.Caption = 'upadateby'
                      Visible = False
                      Width = 65
                    end
                    item
                      EditButtons = <>
                      FieldName = 'updatename'
                      Footers = <>
                      Title.Caption = #26356#26032#20154
                      Width = 57
                    end
                    item
                      EditButtons = <>
                      FieldName = 'updatetime'
                      Footers = <>
                      Title.Caption = #26356#26032#26102#38388
                      Width = 146
                    end
                    item
                      EditButtons = <>
                      FieldName = 'driverid'
                      Footers = <>
                      Visible = False
                    end>
                  object RowDetailData: TRowDetailPanelControlEh
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 80
    Top = 256
  end
  inherited ilToolBarDisable: TImageList
    Left = 136
    Top = 264
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'customermap'
    QueryAddress = 'archive/findCustomer'
    SaveAddress = 'archive/findCustomer'
    Params = <
      item
        DataType = ftString
        Name = 'filter_INS_o!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_c!name'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_c!familyphone_OR_c!mobilephone'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_c!email'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_INS_v!vipgrade'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_v!vipcardno'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'filter_GTL_v!id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_EQS_c!certificatetype'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'filter_LIKES_c!certificateno'
        ParamType = ptInput
      end>
    Left = 184
    Top = 208
    object lrgntfldResultid: TLargeintField
      FieldName = 'id'
    end
    object lrgntfldResultcreateby: TLargeintField
      FieldName = 'createby'
    end
    object wdstrngfldResulteducation: TWideStringField
      FieldName = 'education'
    end
    object wdstrngfldResultfamilyaddress: TWideStringField
      FieldName = 'familyaddress'
      Size = 300
    end
    object wdstrngfldResultfamilyphone: TWideStringField
      FieldName = 'familyphone'
      Size = 30
    end
    object wdstrngfldResultmobilephone: TWideStringField
      FieldName = 'mobilephone'
      Size = 30
    end
    object wdstrngfldResultname: TWideStringField
      FieldName = 'name'
      Size = 30
    end
    object wdstrngfldResultsex: TWideStringField
      FieldName = 'sex'
      Size = 10
    end
    object lrgntfldResultupdateby: TLargeintField
      FieldName = 'updateby'
    end
    object wdstrngfldResultcreatename: TWideStringField
      FieldName = 'createname'
      Size = 50
    end
    object wdstrngfldResultupdatename: TWideStringField
      FieldName = 'updatename'
      Size = 50
    end
    object wdstrngfldResultcertificateno: TWideStringField
      FieldName = 'certificateno'
      Size = 60
    end
    object wdstrngfldResultcertificatetype: TWideStringField
      FieldName = 'certificatetype'
    end
    object wdstrngfldResultinputway: TWideStringField
      FieldName = 'inputway'
    end
    object wdstrngfldResultremarks: TWideStringField
      FieldName = 'remarks'
      Size = 200
    end
    object wdstrngfldResulteducationname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'educationname'
      LookupDataSet = jcdsEducation
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'education'
      Size = 30
      Lookup = True
    end
    object wdstrngfldResultinputwayname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'inputwayname'
      LookupDataSet = jcdsInputway
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'inputway'
      Size = 30
      Lookup = True
    end
    object wdstrngfldResultcertificatetypename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'certificatetypename'
      LookupDataSet = jcdsCertificatetype
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'certificatetype'
      Size = 30
      Lookup = True
    end
    object wdstrngfldResultorgname: TWideStringField
      FieldName = 'orgname'
    end
    object jcdsResultupdatetime: TDateTimeField
      FieldName = 'updatetime'
    end
    object jcdsResultcreatetime: TDateTimeField
      FieldName = 'createtime'
    end
    object jcdsResultbirthday: TDateField
      FieldName = 'birthday'
    end
    object lrgntfldResultorgid: TLargeintField
      FieldName = 'orgid'
    end
    object wdstrngfldResultemail: TWideStringField
      FieldName = 'email'
      Size = 50
    end
    object wdstrngfldResultvipgrade: TWideStringField
      FieldName = 'vipgrade'
      Size = 10
    end
    object wdstrngfldResultvipcardno: TWideStringField
      FieldName = 'vipcardno'
      Size = 30
    end
    object wdstrngfldResultgradename: TWideStringField
      FieldKind = fkLookup
      FieldName = 'gradename'
      LookupDataSet = jcdsVipgrade
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'vipgrade'
      Lookup = True
    end
    object jcdsResultmoney: TCurrencyField
      FieldName = 'money'
    end
    object jcdsResultvipamount: TCurrencyField
      FieldName = 'vipamount'
    end
    object jcdsResultstatus: TWideStringField
      FieldName = 'status'
      Size = 0
    end
    object jcdsResultstatusname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'statusname'
      LookupDataSet = jcdsvipstatus
      LookupKeyFields = 'code'
      LookupResultField = 'value'
      KeyFields = 'status'
      Size = 0
      Lookup = True
    end
    object wdstrngfldResultreachstationname: TWideStringField
      FieldName = 'reachstationname'
    end
    object wdstrngfldResultendstationname: TWideStringField
      FieldName = 'endstationname'
      Size = 0
    end
    object wdstrngfldResultticketno: TWideStringField
      FieldName = 'ticketno'
      Size = 0
    end
    object wdstrngfldResultschcode: TWideStringField
      FieldName = 'schcode'
      Size = 0
    end
    object jcdsResultdepartdate: TDateField
      FieldName = 'departdate'
    end
    object wdstrngfldResultplanvehicleno: TWideStringField
      FieldName = 'planvehicleno'
      Size = 0
    end
    object wdstrngfldResulttsdeparttime: TWideStringField
      FieldName = 'tsdeparttime'
      Size = 0
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 264
  end
  object jcdsEducation: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'employee'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'education'
      end>
    RemoteServer = DMPublic.jcon
    Left = 368
    Top = 264
  end
  object jcdsDelete: TjsonClientDataSet
    DataSourceName = 'dataSet'
    QueryAddress = 'archive/delCustomer'
    SaveAddress = 'archive/delCustomer'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'delid'
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
      end>
    RemoteServer = DMPublic.jcon
    Left = 448
    Top = 176
  end
  object jcdsCertificatetype: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'certificatetype'
      end>
    RemoteServer = DMPublic.jcon
    Left = 272
    Top = 264
  end
  object jcdsInputway: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'customer'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'inputway'
      end>
    RemoteServer = DMPublic.jcon
    Left = 480
    Top = 264
  end
  object jcdsVipgrade: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'vip'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'grade'
      end>
    RemoteServer = DMPublic.jcon
    Left = 552
    Top = 264
  end
  object jcdsvipstatus: TjsonClientDataSet
    DataSourceName = 'diclist'
    QueryAddress = 'system/querydictionary'
    AutoActive = False
    AutoCopyRecord = False
    AutoCloneData = False
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'tablename'
        ParamType = ptInput
        Value = 'card'
      end
      item
        DataType = ftString
        Name = 'columnname'
        ParamType = ptInput
        Value = 'status'
      end>
    RemoteServer = DMPublic.jcon
    Left = 360
    Top = 232
  end
end
