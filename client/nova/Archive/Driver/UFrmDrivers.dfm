inherited frmDriver: TfrmDriver
  Caption = #39550#39542#21592#26723#26696#31649#29702
  ClientHeight = 619
  ClientWidth = 1164
  ParentFont = False
  Font.Charset = ANSI_CHARSET
  Font.Height = -14
  Font.Name = #23435#20307
  ExplicitWidth = 1172
  ExplicitHeight = 653
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlQuery: TPanel
    Top = 45
    Width = 1164
    Height = 79
    ExplicitTop = 45
    ExplicitWidth = 1164
    ExplicitHeight = 79
    object lbl1: TLabel
      Left = 286
      Top = 20
      Width = 28
      Height = 14
      Caption = #22995#21517
    end
    object lbl2: TLabel
      Left = 41
      Top = 55
      Width = 28
      Height = 14
      Caption = #24037#21495
    end
    object lbl3: TLabel
      Left = 13
      Top = 20
      Width = 56
      Height = 14
      Caption = #25152#23646#21333#20301
    end
    object lbl4: TLabel
      Left = 258
      Top = 65
      Width = 56
      Height = 14
      Caption = #39550#39542#35777#21495
    end
    object lbl5: TLabel
      Left = 484
      Top = 20
      Width = 84
      Height = 14
      Caption = #20174#19994#36164#26684#35777#21495
    end
    object lbl6: TLabel
      Left = 512
      Top = 65
      Width = 56
      Height = 14
      Caption = #20934#39550#31867#22411
    end
    object lbl7: TLabel
      Left = 744
      Top = 20
      Width = 28
      Height = 14
      Caption = #29366#24577
    end
    object chk1: TCheckBox
      Left = 778
      Top = 62
      Width = 97
      Height = 17
      Caption = #35777#20214#24050#36807#26399
      TabOrder = 0
    end
    object nvhlpOrg: TNovaHelp
      Left = 75
      Top = 17
      Width = 143
      Height = 22
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
      HDBGColumns = <>
      HelpOptions.HelpHeight = 300
      HelpOptions.HelpWidth = 126
      HelpOptions.EdtField = 'name'
      HelpOptions.HDataSourceName = 'helpmap'
      HelpOptions.HQueryAddress = 'system/help'
    end
    object nvedtCode: TNovaEdit
      Left = 75
      Top = 57
      Width = 143
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
    object nvedtName: TNovaEdit
      Left = 320
      Top = 17
      Width = 144
      Height = 22
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
    object nvedtDrivinglicense: TNovaEdit
      Left = 320
      Top = 57
      Width = 144
      Height = 22
      MaxLength = 50
      TabOrder = 4
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
    object nvedtQualification: TNovaEdit
      Left = 574
      Top = 17
      Width = 145
      Height = 22
      MaxLength = 50
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
    object nvcbbDrivertype: TNovaComboBox
      Left = 574
      Top = 57
      Width = 145
      Height = 22
      ImeMode = imClose
      TabOrder = 6
      Text = #35831#36873#25321'...'
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
    end
    object nvcbbState: TNovaComboBox
      Left = 778
      Top = 17
      Width = 145
      Height = 22
      ImeMode = imClose
      TabOrder = 7
      Text = #35831#36873#25321'...'
      OnEnterColor = clGradientActiveCaption
      OnExitColot = clWindow
      DisEnableFont.Charset = DEFAULT_CHARSET
      DisEnableFont.Color = clWindowText
      DisEnableFont.Height = -11
      DisEnableFont.Name = 'Tahoma'
      DisEnableFont.Style = []
      DisEnableColor = clRed
      OnChangeColor = 4901849
      HelpOptions.HDataSourceName = 'diclist'
      HelpOptions.HQueryAddress = 'system/querydictionary'
    end
  end
  inherited tlbShortCut: TToolBar
    Width = 1164
    Height = 45
    ButtonHeight = 45
    ButtonWidth = 70
    ExplicitWidth = 1164
    ExplicitHeight = 45
    inherited tbtnFilter: TToolButton
      OnClick = tbtnFilterClick
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtn1: TToolButton
      Left = 70
      ExplicitLeft = 70
      ExplicitHeight = 45
    end
    inherited tbtnInsert: TToolButton
      Left = 78
      OnClick = tbtnInsertClick
      ExplicitLeft = 78
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtnEdit: TToolButton
      Left = 148
      ExplicitLeft = 148
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtnDelete: TToolButton
      Left = 218
      ExplicitLeft = 218
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtn3: TToolButton
      Left = 288
      ExplicitLeft = 288
      ExplicitHeight = 45
    end
    inherited tbtnSave: TToolButton
      Left = 296
      ExplicitLeft = 296
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtnCancel: TToolButton
      Left = 366
      ExplicitLeft = 366
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtn4: TToolButton
      Left = 436
      ExplicitLeft = 436
      ExplicitHeight = 45
    end
    inherited tbtnInfo: TToolButton
      Left = 444
      ExplicitLeft = 444
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtn5: TToolButton
      Left = 514
      ExplicitLeft = 514
      ExplicitHeight = 45
    end
    inherited tbtnExcel: TToolButton
      Left = 522
      ExplicitLeft = 522
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtnPrinter: TToolButton
      Left = 592
      ExplicitLeft = 592
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
    inherited tbtn6: TToolButton
      Left = 662
      ExplicitLeft = 662
      ExplicitHeight = 45
    end
    inherited tbtnClose: TToolButton
      Left = 670
      ExplicitLeft = 670
      ExplicitWidth = 70
      ExplicitHeight = 45
    end
  end
  inherited Panel1: TPanel
    Top = 124
    Width = 1164
    Height = 495
    ExplicitTop = 124
    ExplicitWidth = 1164
    ExplicitHeight = 495
    inherited GroupBox1: TGroupBox
      Top = 6
      Width = 1164
      Height = 489
      Align = alBottom
      ExplicitTop = 6
      ExplicitWidth = 1164
      ExplicitHeight = 489
      object splLine: TSplitter [0]
        Left = 1162
        Top = 201
        Width = 0
        Height = 6
        Align = alRight
        ExplicitLeft = 688
        ExplicitTop = 15
        ExplicitHeight = 396
      end
      inherited dbgrdhResult: TDBGridEh
        Top = 16
        Width = 1160
        Height = 185
        Align = alTop
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Height = -14
        FooterFont.Name = #23435#20307
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Height = -14
        TitleFont.Name = #23435#20307
        Columns = <
          item
            EditButtons = <>
            FieldName = 'archiveno'
            Footers = <>
            Width = 84
          end
          item
            EditButtons = <>
            FieldName = 'id'
            Footers = <>
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'birthday'
            Footers = <>
            Width = 88
          end
          item
            EditButtons = <>
            FieldName = 'cardno'
            Footers = <>
            Width = 66
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'createby'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'createtime'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicense'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicenseenddate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'drivinglicensestartdate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'education'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'familyaddress'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'familyphone'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'idcard'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'initialkm'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'istemporary'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'mobilephone'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'name'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'nativeplace'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'orgid'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'picture'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'politicsstatus'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'qualification'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'qualificationenddate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'qualificationstartdate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'qualificationtype'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'recruitmentdate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'salary'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'sex'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'subunit'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'unitid'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'updateby'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'updatetime'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'vehicleid'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'workenddate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'workno'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'workstartdate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'workstatus'
            Footers = <>
          end>
      end
      object grp3: TGroupBox
        Left = 2
        Top = 207
        Width = 1160
        Height = 280
        Align = alBottom
        TabOrder = 1
        object grp8: TGroupBox
          Left = 2
          Top = 16
          Width = 362
          Height = 262
          Align = alLeft
          Caption = #24037#20316#32463#21382#20449#24687
          TabOrder = 0
          object tlb1: TToolBar
            Left = 2
            Top = 16
            Width = 358
            Height = 29
            Caption = 'ToolBar1'
            TabOrder = 0
            object btn1: TToolButton
              Left = 0
              Top = 0
              Width = 8
              Caption = 'ToolButton6'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object btn2: TToolButton
              Left = 8
              Top = 0
              Hint = #28155#21152
              Caption = 'ToolButton1'
              ImageIndex = 9
              ParentShowHint = False
              ShowHint = True
              OnClick = btn2Click
            end
            object btn3: TToolButton
              Left = 31
              Top = 0
              Width = 8
              Caption = 'ToolButton4'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object btn4: TToolButton
              Left = 39
              Top = 0
              Hint = #20462#25913
              Caption = 'ToolButton2'
              ImageIndex = 0
              ParentShowHint = False
              ShowHint = True
            end
            object btn5: TToolButton
              Left = 62
              Top = 0
              Width = 8
              Caption = 'ToolButton5'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object btn6: TToolButton
              Left = 70
              Top = 0
              Hint = #27880#38144
              Caption = 'ToolButton8'
              ImageIndex = 7
              ParentShowHint = False
              ShowHint = True
            end
          end
          object dbgrdh6: TDBGridEh
            Left = 2
            Top = 45
            Width = 358
            Height = 215
            Align = alClient
            DataGrouping.GroupLevels = <>
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            RowDetailPanel.Color = clBtnFace
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 70
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
        object grp1: TGroupBox
          Left = 364
          Top = 16
          Width = 412
          Height = 262
          Align = alClient
          Caption = #23478#24237#25104#21592#20449#24687
          TabOrder = 1
          object tlb2: TToolBar
            Left = 2
            Top = 16
            Width = 408
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
              OnClick = btn8Click
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
          object dbgrdh1: TDBGridEh
            Left = 2
            Top = 45
            Width = 408
            Height = 215
            Align = alClient
            DataGrouping.GroupLevels = <>
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            RowDetailPanel.Color = clBtnFace
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'stationname'
                Footers = <>
                Title.Caption = #20572#38752#28857
                Width = 106
              end
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'isdepart'
                Footers = <>
                KeyList.Strings = (
                  'true'
                  'false')
                Title.Caption = #26159#21542#19978#36710#28857
                Width = 88
              end
              item
                EditButtons = <>
                FieldName = 'departtime'
                Footers = <>
                Title.Caption = #21457#36710#26102#38388
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'runtime'
                Footers = <>
                Title.Caption = #36816#34892#26102#38388
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'ticketentrance'
                Footers = <>
                Title.Caption = #26816#31080#21475
                Width = 85
              end
              item
                EditButtons = <>
                FieldName = 'vehiclepark'
                Footers = <>
                Title.Caption = #19978#20256#21345#20301
                Width = 99
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
        object grp2: TGroupBox
          Left = 776
          Top = 16
          Width = 382
          Height = 262
          Align = alRight
          Caption = #22870#24809#35760#24405
          TabOrder = 2
          object tlb3: TToolBar
            Left = 2
            Top = 16
            Width = 378
            Height = 29
            Caption = 'tlb2'
            TabOrder = 0
            object btn13: TToolButton
              Left = 0
              Top = 0
              Width = 8
              Caption = 'ToolButton6'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object btn14: TToolButton
              Left = 8
              Top = 0
              Hint = #28155#21152
              Caption = 'ToolButton1'
              ImageIndex = 9
              ParentShowHint = False
              ShowHint = True
              OnClick = btn14Click
            end
            object btn15: TToolButton
              Left = 31
              Top = 0
              Width = 8
              Caption = 'ToolButton4'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object btn16: TToolButton
              Left = 39
              Top = 0
              Hint = #20462#25913
              Caption = 'ToolButton2'
              ImageIndex = 0
              ParentShowHint = False
              ShowHint = True
            end
            object btn17: TToolButton
              Left = 62
              Top = 0
              Width = 8
              Caption = 'btn11'
              ImageIndex = 3
              Style = tbsSeparator
            end
            object btn18: TToolButton
              Left = 70
              Top = 0
              Hint = #27880#38144
              Caption = 'ToolButton8'
              ImageIndex = 7
              ParentShowHint = False
              ShowHint = True
            end
          end
          object dbgrdh2: TDBGridEh
            Left = 2
            Top = 45
            Width = 378
            Height = 215
            Align = alClient
            DataGrouping.GroupLevels = <>
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = ANSI_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -14
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            RowDetailPanel.Color = clBtnFace
            TabOrder = 1
            TitleFont.Charset = ANSI_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -14
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            Columns = <
              item
                EditButtons = <>
                FieldName = 'orderno'
                Footers = <>
                Title.Caption = #24207#21495
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'stationname'
                Footers = <>
                Title.Caption = #20572#38752#28857
                Width = 106
              end
              item
                Checkboxes = True
                EditButtons = <>
                FieldName = 'isdepart'
                Footers = <>
                KeyList.Strings = (
                  'true'
                  'false')
                Title.Caption = #26159#21542#19978#36710#28857
                Width = 88
              end
              item
                EditButtons = <>
                FieldName = 'departtime'
                Footers = <>
                Title.Caption = #21457#36710#26102#38388
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'runtime'
                Footers = <>
                Title.Caption = #36816#34892#26102#38388
                Width = 70
              end
              item
                EditButtons = <>
                FieldName = 'ticketentrance'
                Footers = <>
                Title.Caption = #26816#31080#21475
                Width = 85
              end
              item
                EditButtons = <>
                FieldName = 'vehiclepark'
                Footers = <>
                Title.Caption = #19978#20256#21345#20301
                Width = 99
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
  end
  inherited ilToolBar: TImageList
    Left = 112
    Top = 216
  end
  inherited ilToolBarDisable: TImageList
    Left = 184
    Top = 216
  end
  inherited jcdsResult: TjsonClientDataSet
    DataSourceName = 'driverlmap'
    QueryAddress = 'archive/listDriver'
    SaveAddress = 'archive/listDriver'
    Params = <
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftBCD
        Name = 'driver.orgid'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        ParamType = ptUnknown
      end>
    Left = 256
    Top = 224
    object jcdsResultid: TIntegerField
      FieldName = 'id'
    end
    object jcdsResultarchiveno: TStringField
      FieldName = 'archiveno'
      Size = 30
    end
    object jcdsResultbirthday: TStringField
      FieldName = 'birthday'
    end
    object jcdsResultcardno: TStringField
      FieldName = 'cardno'
    end
    object jcdsResultcode: TStringField
      FieldName = 'code'
      Size = 30
    end
    object jcdsResultcreateby: TIntegerField
      FieldName = 'createby'
    end
    object jcdsResultcreatetime: TStringField
      FieldName = 'createtime'
    end
    object jcdsResultdrivinglicense: TStringField
      FieldName = 'drivinglicense'
      Size = 30
    end
    object jcdsResultdrivinglicenseenddate: TStringField
      FieldName = 'drivinglicenseenddate'
    end
    object jcdsResultdrivinglicensestartdate: TStringField
      FieldName = 'drivinglicensestartdate'
    end
    object jcdsResulteducation: TStringField
      FieldName = 'education'
      Size = 10
    end
    object jcdsResultfamilyaddress: TStringField
      FieldName = 'familyaddress'
      Size = 50
    end
    object jcdsResultfamilyphone: TStringField
      FieldName = 'familyphone'
    end
    object jcdsResultidcard: TStringField
      FieldName = 'idcard'
    end
    object jcdsResultinitialkm: TIntegerField
      FieldName = 'initialkm'
    end
    object jcdsResultistemporary: TBooleanField
      FieldName = 'istemporary'
    end
    object jcdsResultmobilephone: TStringField
      FieldName = 'mobilephone'
    end
    object jcdsResultname: TStringField
      FieldName = 'name'
    end
    object jcdsResultnativeplace: TStringField
      FieldName = 'nativeplace'
      Size = 50
    end
    object jcdsResultorgid: TIntegerField
      FieldName = 'orgid'
    end
    object jcdsResultpicture: TBytesField
      FieldName = 'picture'
    end
    object jcdsResultpoliticsstatus: TStringField
      FieldName = 'politicsstatus'
    end
    object jcdsResultqualification: TStringField
      FieldName = 'qualification'
    end
    object jcdsResultqualificationenddate: TStringField
      FieldName = 'qualificationenddate'
    end
    object jcdsResultqualificationstartdate: TStringField
      FieldName = 'qualificationstartdate'
    end
    object jcdsResultqualificationtype: TStringField
      FieldName = 'qualificationtype'
    end
    object jcdsResultrecruitmentdate: TStringField
      FieldName = 'recruitmentdate'
    end
    object jcdsResultsalary: TStringField
      FieldName = 'salary'
    end
    object jcdsResultsex: TStringField
      FieldName = 'sex'
      Size = 10
    end
    object jcdsResultsubunit: TStringField
      FieldName = 'subunit'
      Size = 30
    end
    object jcdsResultunitid: TIntegerField
      FieldName = 'unitid'
    end
    object jcdsResultupdateby: TIntegerField
      FieldName = 'updateby'
    end
    object jcdsResultupdatetime: TStringField
      FieldName = 'updatetime'
    end
    object jcdsResultvehicleid: TIntegerField
      FieldName = 'vehicleid'
    end
    object jcdsResultworkenddate: TStringField
      FieldName = 'workenddate'
      Size = 30
    end
    object jcdsResultworkno: TStringField
      FieldName = 'workno'
      Size = 30
    end
    object jcdsResultworkstartdate: TStringField
      FieldName = 'workstartdate'
      Size = 30
    end
    object jcdsResultworkstatus: TStringField
      FieldName = 'workstatus'
      Size = 10
    end
  end
  inherited dsResult: TDataSource
    Left = 32
    Top = 216
  end
end
