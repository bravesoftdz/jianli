object Form1: TForm1
  Left = 502
  Top = 143
  BorderStyle = bsDialog
  Caption = #22312#25968#25454#24211#20013#36827#34892#27169#26495#31649#29702'(ADO '#19987#29992#25509#21475')'
  ClientHeight = 395
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 48
    Height = 12
    Caption = #27169#26495#21015#34920
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 40
    Width = 297
    Height = 321
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FRptName'
        Title.Caption = #27169#26495#21517#31216
        Width = 230
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 344
    Top = 40
    Width = 75
    Height = 25
    Caption = #39044#35272#25253#34920
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 344
    Top = 80
    Width = 75
    Height = 25
    Caption = #35774#35745#25253#34920
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 344
    Top = 128
    Width = 75
    Height = 25
    Caption = #20174#25991#20214#23548#20837
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 344
    Top = 168
    Width = 75
    Height = 25
    Caption = #23548#20986#20026#25991#20214
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 344
    Top = 216
    Width = 75
    Height = 25
    Caption = #21024#38500#27169#26495
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 344
    Top = 272
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 6
    OnClick = Button6Click
  end
  object qryXueLi: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select *'
      '  From XueLi'
      'Order By Code')
    Left = 163
    Top = 344
    object qryXueLiCode: TStringField
      DisplayLabel = #32534#21495
      FieldName = 'Code'
      Size = 2
    end
    object qryXueLiName: TStringField
      DisplayLabel = #21517#31216
      FieldName = 'Name'
      Size = 12
    end
  end
  object qryDept: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select *'
      '  From ZlDept '
      'Order By Code')
    Left = 193
    Top = 344
    object qryDeptCode: TStringField
      DisplayLabel = #32534#21495
      FieldName = 'Code'
      Size = 10
    end
    object qryDeptName: TStringField
      DisplayLabel = #21517#31216
      FieldName = 'Name'
      Size = 16
    end
    object qryDeptManager: TStringField
      DisplayLabel = #32463#29702
      FieldName = 'Manager'
      Size = 10
    end
    object qryDeptTel: TStringField
      DisplayLabel = #30005#35805
      FieldName = 'Tel'
      Size = 18
    end
  end
  object qryXuLiHz: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select X.Code, X.Name, Count(*) As FAmount '
      '  From XueLi X'
      '   Inner Join ZlEmployee E On X.Code = E.XueLi'
      'Group By X.Code, X.Name'
      'Order By X.Code')
    Left = 222
    Top = 344
    object StringField9: TStringField
      DisplayLabel = #32534#21495
      FieldName = 'Code'
      Size = 2
    end
    object StringField10: TStringField
      DisplayLabel = #21517#31216
      FieldName = 'Name'
      Size = 12
    end
    object qryXuLiHzFAmount: TIntegerField
      DisplayLabel = #24635#20154#25968
      FieldName = 'FAmount'
    end
  end
  object qryRptList: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select FId, FRptName, FRptDoc from RptDoc')
    Left = 136
    Top = 136
    object qryRptListFID: TAutoIncField
      FieldName = 'FID'
      ReadOnly = True
    end
    object qryRptListFRptName: TWideStringField
      FieldName = 'FRptName'
      Size = 50
    end
    object qryRptListFRptDoc: TBlobField
      FieldName = 'FRptDoc'
    end
  end
  object qryPhoto: TADOQuery
    AutoCalcFields = False
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select S.* , D.Name As DptName'
      ' From Photo S'
      '   Left Join ZlDept D On S.Dept = D.Code')
    Left = 93
    Top = 312
    object qryPhotoDept: TStringField
      DisplayLabel = #37096#38376#32534#21495
      FieldName = 'Dept'
      Size = 10
    end
    object qryPhotoDptName: TStringField
      DisplayLabel = #37096#38376#21517#31216
      FieldName = 'DptName'
      Size = 16
    end
    object qryPhotoCode: TStringField
      DisplayLabel = #24037#21495
      FieldName = 'Code'
      Size = 8
    end
    object qryPhotoCardNo: TStringField
      DisplayLabel = #21345#21495
      FieldName = 'CardNo'
      Size = 12
    end
    object qryPhotoName: TStringField
      DisplayLabel = #22995#21517
      FieldName = 'Name'
      Size = 8
    end
    object qryPhotoBornDate: TDateTimeField
      DisplayLabel = #20986#29983#26085#26399
      FieldName = 'BornDate'
    end
    object qryPhotoSfz: TStringField
      DisplayLabel = #36523#20221#35777
      FieldName = 'Sfz'
      Size = 18
    end
    object qryPhotoSex: TBooleanField
      DisplayLabel = #22995#21035
      FieldName = 'Sex'
    end
    object qryPhotoPyDate: TDateTimeField
      DisplayLabel = #32856#29992#26085#26399
      FieldName = 'PyDate'
    end
    object qryPhotoSyMonths: TIntegerField
      DisplayLabel = #35797#29992#26399
      FieldName = 'SyMonths'
    end
    object qryPhotoZzDate: TDateTimeField
      DisplayLabel = #36716#27491#26085#26399
      FieldName = 'ZzDate'
    end
    object qryPhotoRoomBed: TStringField
      DisplayLabel = #24202#21495
      FieldName = 'RoomBed'
      Size = 9
    end
    object qryPhotoLzDate: TDateTimeField
      DisplayLabel = #31163#32844#26085#26399
      FieldName = 'LzDate'
    end
    object qryPhotoMemo: TStringField
      DisplayLabel = #22791#27880
      FieldName = 'Memo'
      Size = 60
    end
    object qryPhotoPhoto: TBlobField
      DisplayLabel = #29031#29255
      FieldName = 'Photo'
    end
  end
  object qryGoods: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select Code, Unit, Name, Spec, Stocks_1,Stocks_2'
      'From Goods'
      'Order By Code')
    Left = 128
    Top = 312
    object qryGoodsCode: TStringField
      DisplayLabel = #32534#21495
      DisplayWidth = 10
      FieldName = 'Code'
    end
    object qryGoodsUnit: TStringField
      DisplayLabel = #21333#20301
      FieldName = 'Unit'
      Size = 10
    end
    object qryGoodsName: TStringField
      DisplayLabel = #21517#31216
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 64
    end
    object qryGoodsSpec: TStringField
      DisplayLabel = #35268#26684
      FieldName = 'Spec'
    end
    object qryGoodsStocks_1: TFloatField
      DisplayLabel = #20179#24211'1'
      FieldName = 'Stocks_1'
    end
    object qryGoodsStocks_2: TFloatField
      DisplayLabel = #20179#24211'2'
      FieldName = 'Stocks_2'
    end
  end
  object qryDetail: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'sNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select D.*, G.Name, G.Spec, G.Unit, G.BarCode_1'
      '  From CheckDetail D Left Join Goods G ON D.Code =G.Code'
      'Where sNo = :sNo'
      'Order By sNo, D.Code ')
    Left = 160
    Top = 312
    object qryDetailsNo: TStringField
      DisplayLabel = #21333#21495
      FieldName = 'sNo'
      Size = 12
    end
    object qryDetailId: TIntegerField
      DisplayLabel = #24207#21495
      FieldName = 'Id'
    end
    object qryDetailCode: TStringField
      DisplayLabel = #21830#21697#32534#21495
      FieldName = 'Code'
    end
    object qryDetailName: TStringField
      DisplayLabel = #21830#21697#21517#31216
      FieldName = 'Name'
      Size = 64
    end
    object qryDetailUnit: TStringField
      DisplayLabel = #21333#20301
      FieldName = 'Unit'
      Size = 10
    end
    object qryDetailSpec: TStringField
      DisplayLabel = #35268#26684
      FieldName = 'Spec'
      Size = 30
    end
    object qryDetailBarCode_1: TStringField
      DisplayLabel = #26465#30721
      FieldName = 'BarCode_1'
    end
    object qryDetailNum: TFloatField
      DisplayLabel = #25968#37327
      FieldName = 'Num'
    end
    object qryDetailPrice_Sale: TFloatField
      DisplayLabel = #21806#20215
      FieldName = 'Price_Sale'
    end
    object qryDetailPrice: TFloatField
      DisplayLabel = #25104#26412
      FieldName = 'Price'
    end
    object qryDetailJe: TFloatField
      DisplayLabel = #37329#39069
      FieldName = 'Je'
    end
  end
  object qryMaster: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select M.*, S.Name'
      '  From CheckMaster M Left Join Storage S'
      '   On M.Storage = S.FieldName'
      'Order By sNo')
    Left = 192
    Top = 312
    object qryMastersNo: TStringField
      DisplayLabel = #21333#21495
      FieldName = 'sNo'
      Size = 12
    end
    object qryMasterDate: TDateTimeField
      DisplayLabel = #26085#26399
      FieldName = 'Date'
    end
    object qryMasterHandNo: TStringField
      DisplayLabel = #25163#24037#21333#21495
      FieldName = 'HandNo'
      Size = 12
    end
    object qryMasterOperator: TStringField
      DisplayLabel = #21046#21333#21592
      FieldName = 'Operator'
      Size = 10
    end
    object qryMasterEnterMan: TStringField
      DisplayLabel = #23457#26680#20154
      FieldName = 'EnterMan'
      Size = 10
    end
    object qryMasterpdNo: TStringField
      DisplayLabel = #30424#28857#25209#21495
      FieldName = 'pdNo'
      Size = 12
    end
    object qryMasterName: TStringField
      DisplayLabel = #20179#24211
      FieldName = 'Name'
    end
    object qryMasterJe: TFloatField
      DisplayLabel = #37329#39069
      FieldName = 'Je'
    end
    object qryMasterNote: TStringField
      DisplayLabel = #22791#27880
      FieldName = 'Note'
      Size = 50
    end
    object qryMasterkindcode: TStringField
      DisplayLabel = #31867#21035
      FieldName = 'kindcode'
      Size = 10
    end
  end
  object qryPerson: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select S.* , D.Name As DptName'
      ' From Photo S'
      '   Left Join ZlDept D On S.Dept = D.Code')
    Left = 226
    Top = 312
    object StringField11: TStringField
      DisplayLabel = #37096#38376#32534#21495
      FieldName = 'Dept'
      Size = 10
    end
    object StringField12: TStringField
      DisplayLabel = #37096#38376#21517#31216
      FieldName = 'DptName'
      Size = 16
    end
    object StringField13: TStringField
      DisplayLabel = #24037#21495
      FieldName = 'Code'
      Size = 8
    end
    object StringField14: TStringField
      DisplayLabel = #21345#21495
      FieldName = 'CardNo'
      Size = 12
    end
    object StringField15: TStringField
      DisplayLabel = #22995#21517
      FieldName = 'Name'
      Size = 8
    end
    object DateTimeField5: TDateTimeField
      DisplayLabel = #20986#29983#26085#26399
      FieldName = 'BornDate'
    end
    object StringField16: TStringField
      DisplayLabel = #36523#20221#35777
      FieldName = 'Sfz'
      Size = 18
    end
    object BooleanField2: TBooleanField
      DisplayLabel = #22995#21035
      FieldName = 'Sex'
    end
    object DateTimeField6: TDateTimeField
      DisplayLabel = #32856#29992#26085#26399
      FieldName = 'PyDate'
    end
    object IntegerField2: TIntegerField
      DisplayLabel = #35797#29992#26399
      FieldName = 'SyMonths'
    end
    object DateTimeField7: TDateTimeField
      DisplayLabel = #36716#27491#26085#26399
      FieldName = 'ZzDate'
    end
    object StringField17: TStringField
      DisplayLabel = #24202#21495
      FieldName = 'RoomBed'
      Size = 9
    end
    object DateTimeField8: TDateTimeField
      DisplayLabel = #31163#32844#26085#26399
      FieldName = 'LzDate'
    end
    object StringField18: TStringField
      DisplayLabel = #22791#27880
      FieldName = 'Memo'
      Size = 60
    end
  end
  object qryEmp: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select S.* , D.Name As DptName, X.Name as XueLiN'
      ' From ZlEmployee S, XueLi X ,ZlDept D '
      'Where S.XueLi = X.Code and S.Dept = D.Code')
    Left = 259
    Top = 312
    object StringField1: TStringField
      DisplayLabel = #37096#38376#32534#21495
      FieldName = 'Dept'
      Size = 10
    end
    object StringField2: TStringField
      DisplayLabel = #37096#38376#21517#31216
      FieldName = 'DptName'
      Size = 16
    end
    object StringField3: TStringField
      DisplayLabel = #24037#21495
      FieldName = 'Code'
      Size = 8
    end
    object StringField4: TStringField
      DisplayLabel = #21345#21495
      FieldName = 'CardNo'
      Size = 12
    end
    object StringField5: TStringField
      DisplayLabel = #22995#21517
      FieldName = 'Name'
      Size = 8
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = #20986#29983#26085#26399
      FieldName = 'BornDate'
    end
    object BooleanField1: TBooleanField
      DisplayLabel = #22995#21035
      FieldName = 'Sex'
    end
    object StringField6: TStringField
      DisplayLabel = #36523#20221#35777
      FieldName = 'Sfz'
      Size = 18
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = #32856#29992#26085#26399
      FieldName = 'PyDate'
    end
    object IntegerField1: TIntegerField
      DisplayLabel = #35797#29992#26399
      FieldName = 'SyMonths'
    end
    object DateTimeField3: TDateTimeField
      DisplayLabel = #36716#27491#26085#26399
      FieldName = 'ZzDate'
    end
    object StringField7: TStringField
      DisplayLabel = #24202#21495
      FieldName = 'RoomBed'
      Size = 9
    end
    object DateTimeField4: TDateTimeField
      DisplayLabel = #31163#32844#26085#26399
      FieldName = 'LzDate'
    end
    object StringField8: TStringField
      DisplayLabel = #22791#27880
      FieldName = 'Memo'
      Size = 60
    end
    object qryEmpXueLi: TStringField
      DisplayLabel = #23398#21382#32534#21495
      FieldName = 'XueLi'
      Size = 2
    end
    object qryEmpXueLiN: TStringField
      DisplayLabel = #23398#21382
      FieldName = 'XueLiN'
      Size = 12
    end
    object qryEmpG_email: TStringField
      DisplayLabel = #30005#23376#37038#20214
      FieldName = 'G_email'
      Size = 30
    end
  end
  object qryGzTotal: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select M.*, E.Code, E.Name, E.Sex'
      '  From GzTotal M Inner Join ZlEmployee E'
      '   On M.EmpID = E.ID'
      'Order By E.Code')
    Left = 292
    Top = 312
    object qryGzTotalEmpID: TIntegerField
      DisplayLabel = #38599#21592#21495
      FieldName = 'EmpID'
    end
    object qryGzTotalCode: TStringField
      DisplayLabel = #24037#21495
      FieldName = 'Code'
      Size = 8
    end
    object qryGzTotalName: TStringField
      DisplayLabel = #22995#21517
      FieldName = 'Name'
      Size = 8
    end
    object qryGzTotalSex: TBooleanField
      DisplayLabel = #22995#21035
      FieldName = 'Sex'
    end
    object qryGzTotalChiDaoSj: TIntegerField
      DisplayLabel = #36831#21040#26102#38388
      FieldName = 'ChiDaoSj'
    end
    object qryGzTotalChiDaoCs: TIntegerField
      DisplayLabel = #36831#21040#27425#25968
      FieldName = 'ChiDaoCs'
    end
    object qryGzTotalZaoTuiSj: TIntegerField
      DisplayLabel = #26089#36864#26102#38388
      FieldName = 'ZaoTuiSj'
    end
    object qryGzTotalZaoTuiCs: TIntegerField
      DisplayLabel = #26089#36864#27425#25968
      FieldName = 'ZaoTuiCs'
    end
    object qryGzTotalKgSj: TIntegerField
      DisplayLabel = #26103#24037#26102#38388
      FieldName = 'KgSj'
    end
    object qryGzTotalKgCs: TIntegerField
      DisplayLabel = #26103#24037#27425#25968
      FieldName = 'KgCs'
    end
    object qryGzTotalRcjb1: TIntegerField
      DisplayLabel = #26085#24120#21152#29677'1'
      FieldName = 'Rcjb1'
    end
    object qryGzTotalRcjb2: TIntegerField
      DisplayLabel = #26085#24120#21152#29677'2'
      FieldName = 'Rcjb2'
    end
    object qryGzTotalRcjbAll: TIntegerField
      DisplayLabel = #24635#21152#29677
      FieldName = 'RcjbAll'
    end
    object qryGzTotalYcqSj: TIntegerField
      DisplayLabel = #24212#20986#21220#26102#38388
      FieldName = 'YcqSj'
    end
    object qryGzTotalSjcqSj: TIntegerField
      DisplayLabel = #23454#20986#21220#26102#38388
      FieldName = 'SjcqSj'
    end
    object qryGzTotalKgSj_cd: TIntegerField
      DisplayLabel = #26103#24037#26102#38388'('#36831#21040')'
      FieldName = 'KgSj_cd'
    end
    object qryGzTotalKgCs_cd: TIntegerField
      DisplayLabel = #26103#24037#27425#25968'('#36831#21040')'
      FieldName = 'KgCs_cd'
    end
    object qryGzTotalKgSj_zt: TIntegerField
      DisplayLabel = #26103#24037#26102#38388'('#26089#36864')'
      FieldName = 'KgSj_zt'
    end
    object qryGzTotalKgCs_zt: TIntegerField
      DisplayLabel = #26103#24037#27425#25968'('#26089#36864')'
      FieldName = 'KgCs_zt'
    end
    object qryGzTotalJbKgSj: TIntegerField
      DisplayLabel = #21152#29677#26102#38388#26103#24037
      FieldName = 'JbKgSj'
    end
    object qryGzTotalG_gongJ: TFloatField
      DisplayLabel = #20844#20551
      FieldName = 'G_gongJ'
    end
    object qryGzTotalG_shiJ: TFloatField
      DisplayLabel = #31169#20551
      FieldName = 'G_shiJ'
    end
    object qryGzTotalG_bingJ: TFloatField
      DisplayLabel = #30149#20551
      FieldName = 'G_bingJ'
    end
    object qryGzTotalG_syyl: TFloatField
      DisplayLabel = #19978#26376#20313#38646
      FieldName = 'G_syyl'
    end
    object qryGzTotalG_bykl: TFloatField
      DisplayLabel = #26412#26376#25187#38646
      FieldName = 'G_bykl'
    end
    object qryGzTotalG_fangj: TFloatField
      DisplayLabel = #25918#20551
      FieldName = 'G_fangj'
    end
    object qryGzTotalG_dx: TFloatField
      DisplayLabel = #24213#34218
      FieldName = 'G_dx'
    end
    object qryGzTotalG_rx: TFloatField
      DisplayLabel = #26085#34218
      FieldName = 'G_rx'
    end
    object qryGzTotalG_gwjt: TFloatField
      DisplayLabel = #23703#20301#27941#36148
      FieldName = 'G_gwjt'
    end
    object qryGzTotalG_hsbc: TFloatField
      DisplayLabel = #20249#39135#34917#21161
      FieldName = 'G_hsbc'
    end
    object qryGzTotalG_sdbc: TFloatField
      DisplayLabel = #27700#30005#34917#21161
      FieldName = 'G_sdbc'
    end
    object qryGzTotalG_zfbc: TFloatField
      DisplayLabel = #20303#25151#34917#21161
      FieldName = 'G_zfbc'
    end
    object qryGzTotalG_gzj: TFloatField
      DisplayLabel = #24037#20316#22870
      FieldName = 'G_gzj'
    end
    object qryGzTotalG_khxs: TFloatField
      DisplayLabel = #32771#26680#31995#25968
      FieldName = 'G_khxs'
    end
    object qryGzTotalG_qtjl: TFloatField
      DisplayLabel = #20854#23427#22870#21169
      FieldName = 'G_qtjl'
    end
    object qryGzTotalG_qtbz: TFloatField
      DisplayLabel = #20854#23427#34917#21161
      FieldName = 'G_qtbz'
    end
    object qryGzTotalG_ksd: TFloatField
      DisplayLabel = #25187#27700#30005
      FieldName = 'G_ksd'
    end
    object qryGzTotalG_kqt: TFloatField
      DisplayLabel = #20854#23427#25187#27454
      FieldName = 'G_kqt'
    end
    object qryGzTotalG_cqts: TFloatField
      DisplayLabel = #20986#21220#22825#25968
      FieldName = 'G_cqts'
    end
    object qryGzTotalG_cqgz: TFloatField
      DisplayLabel = #20986#21220#24037#36164
      FieldName = 'G_cqgz'
    end
    object qryGzTotalG_jbsx: TFloatField
      DisplayLabel = #21152#29677#26102#34218
      FieldName = 'G_jbsx'
    end
    object qryGzTotalG_jbss: TFloatField
      DisplayLabel = #21152#29677#26102#25968
      FieldName = 'G_jbss'
    end
    object qryGzTotalG_jbgz: TFloatField
      DisplayLabel = #21152#29677#24037#36164
      FieldName = 'G_jbgz'
    end
    object qryGzTotalG_yfgz: TFloatField
      DisplayLabel = #24212#21457#24037#36164
      FieldName = 'G_yfgz'
    end
    object qryGzTotalG_sfgz: TFloatField
      DisplayLabel = #23454#21457#24037#36164
      FieldName = 'G_sfgz'
    end
    object qryGzTotalG_sfje: TFloatField
      DisplayLabel = #23454#21457#37329#39069
      FieldName = 'G_sfje'
    end
    object qryGzTotalG_ldgl: TFloatField
      DisplayLabel = #21171#21160#31649#29702#36153
      FieldName = 'G_ldgl'
    end
    object qryGzTotalG_fk: TFloatField
      DisplayLabel = #32602#27454
      FieldName = 'G_fk'
    end
    object qryGzTotalG_kszsd: TFloatField
      DisplayLabel = #25187#39135#20303
      FieldName = 'G_kszsd'
    end
    object qryGzTotalG_dhf: TFloatField
      DisplayLabel = #35805#36153#34917#36148
      FieldName = 'G_dhf'
    end
    object qryGzTotalG_qjts: TFloatField
      DisplayLabel = #35831#20551#22825#25968
      FieldName = 'G_qjts'
    end
    object qryGzTotalG_bhs: TFloatField
      DisplayLabel = #34917#20249#39135#36153
      FieldName = 'G_bhs'
    end
    object qryGzTotalG_cqts0: TFloatField
      DisplayLabel = #20986#21220#22825'1'
      FieldName = 'G_cqts0'
    end
    object qryGzTotalG_qqj: TFloatField
      DisplayLabel = #20840#21220#22870
      FieldName = 'G_qqj'
    end
    object qryGzTotalG_khgz: TFloatField
      DisplayLabel = #32771#26680#24037#36164
      FieldName = 'G_khgz'
    end
    object qryGzTotalG_qjkx: TFloatField
      DisplayLabel = #35831#20551#25187#34218
      FieldName = 'G_qjkx'
    end
    object qryGzTotalG_khsf: TFloatField
      DisplayLabel = #25187#20249#39135#36153
      FieldName = 'G_khsf'
    end
    object qryGzTotalG_khsf1: TFloatField
      DisplayLabel = #25187#20249#39135#36153'1'
      FieldName = 'G_khsf1'
    end
    object qryGzTotalG_bz: TStringField
      DisplayLabel = #22791#27880
      FieldName = 'G_bz'
      Size = 40
    end
    object qryGzTotalG_kfz: TFloatField
      DisplayLabel = #25187#25151#31199
      FieldName = 'G_kfz'
    end
    object qryGzTotalG_cdztsj: TFloatField
      DisplayLabel = #36831#21040#26089#36864#26102#38388
      FieldName = 'G_cdztsj'
    end
    object qryGzTotalG_kgts: TFloatField
      DisplayLabel = #26103#24037#22825#25968
      FieldName = 'G_kgts'
    end
    object qryGzTotalG_Bxin: TFloatField
      DisplayLabel = #26412#34218
      FieldName = 'G_Bxin'
    end
  end
  object AdoConn: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=E:\co' +
      'ntrols\ACreport\COM\demos\Data\ReportDemo.mdb;Mode=Share Deny No' +
      'ne;Extended Properties="";Persist Security Info=False;Jet OLEDB:' +
      'System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database' +
      ' Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking ' +
      'Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk' +
      ' Transactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Cre' +
      'ate System Database=False;Jet OLEDB:Encrypt Database=False;Jet O' +
      'LEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Withou' +
      't Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 58
    Top = 314
  end
  object DataSource1: TDataSource
    DataSet = qryRptList
    Left = 168
    Top = 136
  end
  object qryRptDoc: TADOQuery
    Connection = AdoConn
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'Select FId, FRptDoc From RptDoc Where FId = :Id'
      ' ')
    Left = 136
    Top = 192
    object qryRptDocFId: TAutoIncField
      FieldName = 'FId'
      ReadOnly = True
    end
    object qryRptDocFRptDoc: TBlobField
      FieldName = 'FRptDoc'
    end
  end
  object OpenDlg: TOpenDialog
    DefaultExt = '.apt'
    Filter = '*.apt|*.apt'
    Left = 232
    Top = 216
  end
  object SaveDlg: TSaveDialog
    DefaultExt = '.apt'
    Filter = '*.apt|*.apt'
    Left = 264
    Top = 216
  end
end
